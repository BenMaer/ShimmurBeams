//
//  SMBRemoveAllEntitiesFromBoardGameBoardMove.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 1/11/18.
//  Copyright © 2018 Shimmur. All rights reserved.
//

#import "SMBRemoveAllEntitiesFromBoardGameBoardMove.h"
#import "SMBGameBoard.h"
#import "SMBGameLevel.h"
#import "SMBGameBoardTileEntitySpawnerManager.h"
#import "SMBGameBoardTileEntitySpawner.h"
#import "SMBRemoveEntityFromTileGameBoardMove.h"
#import "SMBGameBoardTileEntity.h"
#import "SMBGameBoardTile.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@implementation SMBRemoveAllEntitiesFromBoardGameBoardMove

#pragma mark - SMBGameBoardMove
-(BOOL)move_perform_on_gameBoard:(nonnull SMBGameBoard*)gameBoard
{
	kRUConditionalReturn_ReturnValueFalse(gameBoard == nil, YES);

	SMBGameLevel* const gameLevel = gameBoard.gameLevel;
	kRUConditionalReturn_ReturnValueFalse(gameLevel == nil, YES);

	__block BOOL failure = NO;
	[gameLevel.gameBoardTileEntitySpawnerManager.gameBoardTileEntitySpawners enumerateObjectsUsingBlock:^(SMBGameBoardTileEntitySpawner * _Nonnull gameBoardTileEntitySpawner, NSUInteger idx, BOOL * _Nonnull gameBoardTileEntitySpawner_stop) {
		[[gameBoardTileEntitySpawner spawnedGameBoardTileEntities_tracked] enumerateObjectsUsingBlock:^(SMBGameBoardTileEntity * _Nonnull gameBoardTileEntity, NSUInteger idx, BOOL * _Nonnull gameBoardTileEntity_stop) {
			/* In case levels have more than one board. */
			kRUConditionalReturn(gameBoard != gameBoardTileEntity.gameBoardTile.gameBoard, NO);
			SMBGameBoardTile* const gameBoardTileEntity_gameBoardTile = gameBoardTileEntity.gameBoardTile;
			kRUConditionalReturn([gameBoard gameBoardTile_at_position:gameBoardTileEntity_gameBoardTile.gameBoardTilePosition] != gameBoardTileEntity_gameBoardTile, NO);

			SMBRemoveEntityFromTileGameBoardMove* const removeEntityFromTileGameBoardMove =
			[[SMBRemoveEntityFromTileGameBoardMove alloc] init_with_gameBoardTileEntity:gameBoardTileEntity];

			BOOL const success = [removeEntityFromTileGameBoardMove move_perform_on_gameBoard:gameBoard];
			if (success == false)
			{
				*gameBoardTileEntitySpawner_stop = YES;
				*gameBoardTileEntity_stop = YES;
				failure = YES;
			}
		}];
	}];

	return (failure == false);
}

@end
