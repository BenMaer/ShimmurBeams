//
//  SMBGameBoardTile.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/3/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardTile.h"
#import "SMBGameBoardTileEntity.h"
#import "SMBGameBoard.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/NSMutableArray+RUAddObjectIfNotNil.h>
#import <ResplendentUtilities/RUConstants.h>





@interface SMBGameBoardTile ()

#pragma mark - gameBoardTileEntities
@property (nonatomic, copy, nullable) NSArray<SMBGameBoardTileEntity*>* gameBoardTileEntities;

@end





@implementation SMBGameBoardTile

#pragma mark - NSObject
-(instancetype)init
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wno-nullability-completeness"
	return [self init_with_gameBoardTilePosition:nil
									   gameBoard:nil];
#pragma clang diagnostic pop
}

-(nonnull NSString*)description
{
	NSMutableArray<NSString*>* const description_lines = [NSMutableArray<NSString*> array];
	[description_lines ru_addObjectIfNotNil:[super description]];
	[description_lines ru_addObjectIfNotNil:RUStringWithFormat(@"gameBoardTilePosition: %@",self.gameBoardTilePosition)];

	return [description_lines componentsJoinedByString:@"\n"];
}

#pragma mark - init
-(nullable instancetype)init_with_gameBoardTilePosition:(nonnull SMBGameBoardTilePosition*)gameBoardTilePosition
											  gameBoard:(nonnull SMBGameBoard*)gameBoard
{
	kRUConditionalReturn_ReturnValueNil(gameBoardTilePosition == nil, YES);
	kRUConditionalReturn_ReturnValueNil(gameBoard == nil, YES);

	if (self = [super init])
	{
		_gameBoardTilePosition = gameBoardTilePosition;
		_gameBoard = gameBoard;
	}

	return self;
}

#pragma mark - gameBoardTileEntity_for_beamInteractions
-(void)setGameBoardTileEntity_for_beamInteractions:(nullable SMBGameBoardTileEntity*)gameBoardTileEntity_for_beamInteractions
{
	kRUConditionalReturn(self.gameBoardTileEntity_for_beamInteractions == gameBoardTileEntity_for_beamInteractions, NO);

	_gameBoardTileEntity_for_beamInteractions = gameBoardTileEntity_for_beamInteractions;

	if (self.gameBoardTileEntity_for_beamInteractions)
	{
		if (self.gameBoardTileEntity_for_beamInteractions.gameBoardTile != self)
		{
			[self.gameBoardTileEntity_for_beamInteractions setGameBoardTile:self];
		}
	}
}

#pragma mark - gameBoardTileEntities
-(void)gameBoardTileEntities_add:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
{
	kRUConditionalReturn(gameBoardTileEntity == nil, YES);

	NSArray<SMBGameBoardTileEntity*>* const gameBoardTileEntities_old = self.gameBoardTileEntities;
	kRUConditionalReturn([gameBoardTileEntities_old containsObject:gameBoardTileEntity], YES);

	NSMutableArray<SMBGameBoardTileEntity*>* const gameBoardTileEntities_new = [NSMutableArray<SMBGameBoardTileEntity*> array];

	if (gameBoardTileEntities_old)
	{
		[gameBoardTileEntities_new addObjectsFromArray:gameBoardTileEntities_old];
	}

	[gameBoardTileEntities_new addObject:gameBoardTileEntity];

	[self setGameBoardTileEntities:[NSArray<SMBGameBoardTileEntity*> arrayWithArray:gameBoardTileEntities_new]];
}

-(void)gameBoardTileEntities_remove:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
{
	kRUConditionalReturn(gameBoardTileEntity == nil, YES);

	NSArray<SMBGameBoardTileEntity*>* const gameBoardTileEntities_old = self.gameBoardTileEntities;
	kRUConditionalReturn(gameBoardTileEntities_old == nil, YES);

	NSInteger const gameBoardTileEntity_index = [gameBoardTileEntities_old indexOfObject:gameBoardTileEntity];
	kRUConditionalReturn(gameBoardTileEntity_index == NSNotFound, YES);

	NSMutableArray<SMBGameBoardTileEntity*>* const gameBoardTileEntities_new = [NSMutableArray<SMBGameBoardTileEntity*> arrayWithArray:gameBoardTileEntities_old];
	[gameBoardTileEntities_new removeObjectAtIndex:gameBoardTileEntity_index];

	[self setGameBoardTileEntities:[NSArray<SMBGameBoardTileEntity*> arrayWithArray:gameBoardTileEntities_new]];
}

#pragma mark - gameBoardTile
-(nullable SMBGameBoardTile*)gameBoardTile_next_with_direction:(SMBGameBoardTile__direction)direction
{
	SMBGameBoard* const gameBoard = self.gameBoard;
	kRUConditionalReturn_ReturnValueNil(gameBoard == nil, YES);

	return [gameBoard gameBoardTile_next_from_gameBoardTile:self
												  direction:direction];
}

@end





@implementation SMBGameBoardTile_PropertiesForKVO

+(nonnull NSString*)gameBoardTileEntity_for_beamInteractions{return NSStringFromSelector(_cmd);}
+(nonnull NSString*)gameBoardTileEntities{return NSStringFromSelector(_cmd);}

@end
