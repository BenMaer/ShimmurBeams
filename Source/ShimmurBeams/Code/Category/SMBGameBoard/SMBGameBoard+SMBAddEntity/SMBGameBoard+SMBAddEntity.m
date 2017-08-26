//
//  SMBGameBoard+SMBAddEntity.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/5/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoard+SMBAddEntity.h"
#import "SMBGameBoardTile.h"
#import "SMBGameBoardTilePosition.h"
#import "SMBLevelExitTileEntity.h"
#import "SMBWallTileEntity.h"
#import "SMBPowerButtonTileEntity.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@implementation SMBGameBoard (SMBAddEntity)

#pragma mark - gameBoardTileEntity
-(void)gameBoardTileEntity_add:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
					entityType:(SMBGameBoardTile__entityType)entityType
	  to_gameBoardTilePosition:(nonnull SMBGameBoardTilePosition*)gameBoardTilePosition
{
	kRUConditionalReturn(gameBoardTileEntity == nil, YES);
	kRUConditionalReturn(gameBoardTilePosition == nil, YES);
	
	SMBGameBoardTile* const gameBoardTile =
	[self gameBoardTile_at_position:gameBoardTilePosition];

	kRUConditionalReturn(gameBoardTile == nil, YES);
	
	[gameBoardTile gameBoardTileEntities_add:gameBoardTileEntity
								  entityType:entityType];
}

-(void)gameBoardTileEntities_add:(nonnull SMBGameBoard_addEntity_createTileEntityAtPosition_block)createTileEntityAtPosition_block
					  entityType:(SMBGameBoardTile__entityType)entityType
		  gameBoardTilePositions:(nonnull NSArray<SMBGameBoardTilePosition*>*)gameBoardTilePositions
{
	kRUConditionalReturn(createTileEntityAtPosition_block == nil, YES);
	kRUConditionalReturn(gameBoardTilePositions == nil, YES);

	[gameBoardTilePositions enumerateObjectsUsingBlock:^(SMBGameBoardTilePosition * _Nonnull gameBoardTilePosition, NSUInteger idx, BOOL * _Nonnull stop) {
		SMBGameBoardTileEntity* const gameBoardTileEntity = createTileEntityAtPosition_block(gameBoardTilePosition);
		kRUConditionalReturn(gameBoardTileEntity == nil, NO);

		[self gameBoardTileEntity_add:gameBoardTileEntity
						   entityType:entityType
			 to_gameBoardTilePosition:gameBoardTilePosition];
	}];
}

-(void)gameBoardTileEntity_add:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
	  to_gameBoardTilePosition:(nonnull SMBGameBoardTilePosition*)gameBoardTilePosition
{
	[self gameBoardTileEntity_add:gameBoardTileEntity
					   entityType:SMBGameBoardTile__entityType_many
		 to_gameBoardTilePosition:gameBoardTilePosition];
}

-(void)gameBoardTileEntity_for_beamInteractions_set:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
						   to_gameBoardTilePosition:(nonnull SMBGameBoardTilePosition*)gameBoardTilePosition
{
	[self gameBoardTileEntity_add:gameBoardTileEntity
					   entityType:SMBGameBoardTile__entityType_beamInteractions
		 to_gameBoardTilePosition:gameBoardTilePosition];
}

-(void)gameBoardTileEntities_add:(nonnull SMBGameBoard_addEntity_createTileEntityAtPosition_block)createTileEntityAtPosition_block
					  entityType:(SMBGameBoardTile__entityType)entityType
						fillRect:(BOOL)fillRect
						 columns:(NSRange)columns
							rows:(NSRange)rows
{
	kRUConditionalReturn(createTileEntityAtPosition_block == nil, YES);

	NSMutableArray<SMBGameBoardTilePosition*>* const gameBoardTilePositions = [NSMutableArray<SMBGameBoardTilePosition*> array];

	if (fillRect)
	{
		[[NSIndexSet indexSetWithIndexesInRange:columns] enumerateIndexesUsingBlock:^(NSUInteger column, BOOL * _Nonnull column_stop) {
			[[NSIndexSet indexSetWithIndexesInRange:rows] enumerateIndexesUsingBlock:^(NSUInteger row, BOOL * _Nonnull row_stop) {
				[gameBoardTilePositions addObject:[[SMBGameBoardTilePosition alloc] init_with_column:column row:row]];
			}];
		}];
	}
	else
	{
		[[NSIndexSet indexSetWithIndexesInRange:rows] enumerateIndexesUsingBlock:^(NSUInteger row, BOOL * _Nonnull row_stop) {
			[gameBoardTilePositions addObject:[[SMBGameBoardTilePosition alloc] init_with_column:columns.location
																							 row:row]];

			if (columns.length > 0)
			{
				[gameBoardTilePositions addObject:[[SMBGameBoardTilePosition alloc] init_with_column:columns.location + columns.length - 1
																								 row:row]];
			}
		}];

		[[NSIndexSet indexSetWithIndexesInRange:columns] enumerateIndexesUsingBlock:^(NSUInteger column, BOOL * _Nonnull column_stop) {
			[gameBoardTilePositions addObject:[[SMBGameBoardTilePosition alloc] init_with_column:column
																							 row:rows.location]];

			if (rows.length > 0)
			{
				[gameBoardTilePositions addObject:[[SMBGameBoardTilePosition alloc] init_with_column:column
																								 row:rows.location + rows.length - 1]];
			}
		}];
	}

	[self gameBoardTileEntities_add:createTileEntityAtPosition_block
						 entityType:entityType
			 gameBoardTilePositions:[NSArray<SMBGameBoardTilePosition*> arrayWithArray:gameBoardTilePositions]];
}

#pragma mark - levelExit
-(void)gameBoardTileEntity_add_levelExit_to_gameBoardTilePosition:(nonnull SMBGameBoardTilePosition*)gameBoardTilePosition
{
	[self gameBoardTileEntity_for_beamInteractions_set:[SMBLevelExitTileEntity new]
							  to_gameBoardTilePosition:gameBoardTilePosition];
}

#pragma mark - wall
-(void)gameBoardTileEntity_add_wall_to_gameBoardTilePosition:(nonnull SMBGameBoardTilePosition*)gameBoardTilePosition
{
	[self gameBoardTileEntity_for_beamInteractions_set:[SMBWallTileEntity new]
							  to_gameBoardTilePosition:gameBoardTilePosition];
}

#pragma mark - powerButtonTileEntity
-(void)gameBoardTileEntity_add_powerButtonTileEntity_with_gameBoardTilePosition_toPower:(nonnull SMBGameBoardTilePosition*)gameBoardTilePosition_toPower
															   to_gameBoardTilePosition:(nonnull SMBGameBoardTilePosition*)gameBoardTilePosition
{
	[self gameBoardTileEntity_add:[[SMBPowerButtonTileEntity alloc] init_with_gameBoardTilePosition_toPower:gameBoardTilePosition_toPower]
					   entityType:SMBGameBoardTile__entityType_beamInteractions
		 to_gameBoardTilePosition:gameBoardTilePosition];
}

@end
