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

#import <ResplendentUtilities/RUConditionalReturn.h>





@implementation SMBGameBoard (SMBAddEntity)

#pragma mark - gameBoardTileEntity
-(void)gameBoardTileEntities_add:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
					  entityType:(SMBGameBoardTile__entityType)entityType
		   gameBoardTilePosition:(nonnull SMBGameBoardTilePosition*)gameBoardTilePosition
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
		[self gameBoardTileEntities_add:createTileEntityAtPosition_block(gameBoardTilePosition)
							 entityType:entityType
				  gameBoardTilePosition:gameBoardTilePosition];
	}];
}

-(void)gameBoardTileEntity_add:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
					entityType:(SMBGameBoardTile__entityType)entityType
					 to_column:(NSUInteger)column
						   row:(NSUInteger)row
{
	[self gameBoardTileEntities_add:gameBoardTileEntity
						 entityType:entityType
			  gameBoardTilePosition:[[SMBGameBoardTilePosition alloc] init_with_column:column row:row]];
}

-(void)gameBoardTileEntity_add:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
					 to_column:(NSUInteger)column
						   row:(NSUInteger)row
{
	[self gameBoardTileEntity_add:gameBoardTileEntity
					   entityType:SMBGameBoardTile__entityType_many
						to_column:column
							  row:row];
}

-(void)gameBoardTileEntity_for_beamInteractions_set:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
										  to_column:(NSUInteger)column
												row:(NSUInteger)row
{
	[self gameBoardTileEntity_add:gameBoardTileEntity
					   entityType:SMBGameBoardTile__entityType_beamInteractions
						to_column:column
							  row:row];
}

//-(void)gameBoardTileEntities_add:(nonnull SMBGameBoard_addEntity_createTileEntityAtPosition_block)createTileEntityAtPosition_block
//					  entityType:(SMBGameBoardTile__entityType)entityType
//					  to_columns:(nonnull NSIndexSet*)columns
//							rows:(nonnull NSIndexSet*)rows
//{
//	kRUConditionalReturn(createTileEntityAtPosition_block == nil, YES);
//	kRUConditionalReturn(columns == nil, YES);
//	kRUConditionalReturn(rows == nil, YES);
//
//	[columns enumerateIndexesUsingBlock:^(NSUInteger column, BOOL * _Nonnull stop) {
//		[rows enumerateIndexesUsingBlock:^(NSUInteger row, BOOL * _Nonnull stop) {
//			SMBGameBoardTileEntity* const gameBoardTileEntity = createTileEntityAtPosition_block(column, row);
//			if (gameBoardTileEntity)
//			{
//				[self gameBoardTileEntity_add:gameBoardTileEntity
//								   entityType:entityType
//									to_column:column
//										  row:row];
//			}
//		}];
//	}];
//}

-(void)gameBoardTileEntities_add:(nonnull SMBGameBoard_addEntity_createTileEntityAtPosition_block)createTileEntityAtPosition_block
					  entityType:(SMBGameBoardTile__entityType)entityType
						fillRect:(BOOL)fillRect
						 columns:(NSRange)columns
							rows:(NSRange)rows
{
	kRUConditionalReturn(createTileEntityAtPosition_block == nil, YES);
//	kRUConditionalReturn(columns.length == 0, YES);
//	kRUConditionalReturn(rows.length == 0, YES);

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
-(void)gameBoardTileEntity_add_levelExit_to_column:(NSUInteger)column
											   row:(NSUInteger)row
{
	[self gameBoardTileEntity_add:[SMBLevelExitTileEntity new]
					   entityType:SMBGameBoardTile__entityType_beamInteractions
						to_column:column
							  row:row];
}

#pragma mark - wall
-(void)gameBoardTileEntity_add_wall_to_column:(NSUInteger)column
										  row:(NSUInteger)row
{
	[self gameBoardTileEntity_add:[SMBWallTileEntity new]
					   entityType:SMBGameBoardTile__entityType_beamInteractions
						to_column:column
							  row:row];
}

@end
