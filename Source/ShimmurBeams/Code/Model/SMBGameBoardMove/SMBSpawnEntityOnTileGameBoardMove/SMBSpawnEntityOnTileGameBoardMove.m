//
//  SMBSpawnEntityOnTileGameBoardMove.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 12/20/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBSpawnEntityOnTileGameBoardMove.h"
#import "SMBGameBoardTileEntitySpawner.h"
#import "SMBGameBoard.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@interface SMBSpawnEntityOnTileGameBoardMove ()

#pragma mark - gameBoardTile
@property (nonatomic, readonly, strong, nullable) SMBGameBoardTilePosition* gameBoardTilePosition;

#pragma mark - gameBoardTileEntitySpawner
@property (nonatomic, readonly, strong, nullable) SMBGameBoardTileEntitySpawner* gameBoardTileEntitySpawner;

@end





@implementation SMBSpawnEntityOnTileGameBoardMove

#pragma mark - NSObject
-(nonnull instancetype)init
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);

#if __has_feature(nullability)
#pragma clang diagnostic push
#pragma GCC diagnostic ignored "-Wnullability-completeness"
#endif
	return [self init_with_gameBoardTilePosition:nil
					  gameBoardTileEntitySpawner:nil];
#if __has_feature(nullability)
#pragma clang diagnostic pop
#endif
}

#pragma mark - init
-(nullable instancetype)init_with_gameBoardTilePosition:(nonnull SMBGameBoardTilePosition*)gameBoardTilePosition
							 gameBoardTileEntitySpawner:(nonnull SMBGameBoardTileEntitySpawner*)gameBoardTileEntitySpawner
{
	kRUConditionalReturn_ReturnValueNil(gameBoardTilePosition == nil, YES);
	kRUConditionalReturn_ReturnValueNil(gameBoardTileEntitySpawner == nil, YES);

	if (self = [super init])
	{
		_gameBoardTilePosition = gameBoardTilePosition;
		_gameBoardTileEntitySpawner = gameBoardTileEntitySpawner;
	}

	return self;
}

#pragma mark - SMBGameBoardMove
-(BOOL)move_perform_on_gameBoard:(nonnull SMBGameBoard*)gameBoard
{
	kRUConditionalReturn_ReturnValueFalse(gameBoard == nil, YES);

	SMBGameBoardTilePosition* const gameBoardTilePosition = self.gameBoardTilePosition;
	kRUConditionalReturn_ReturnValueFalse(gameBoardTilePosition == nil, YES);

	SMBGameBoardTileEntitySpawner* const gameBoardTileEntitySpawner = self.gameBoardTileEntitySpawner;
	kRUConditionalReturn_ReturnValueFalse(gameBoardTileEntitySpawner == nil, YES);

	SMBGameBoardTile* const gameBoardTile = [gameBoard gameBoardTile_at_position:gameBoardTilePosition];
	kRUConditionalReturn_ReturnValueFalse(gameBoardTile == nil, YES);

	SMBGameBoardTileEntity* const gameBoardTileEntity =
	[gameBoardTileEntitySpawner gameBoardTileEntity_spawnNew_tracked_on_gameBoardTile:gameBoardTile];

	return (gameBoardTileEntity != nil);
}

@end
