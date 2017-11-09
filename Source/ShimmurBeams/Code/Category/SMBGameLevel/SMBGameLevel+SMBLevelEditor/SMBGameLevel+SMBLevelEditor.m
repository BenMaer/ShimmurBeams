//
//  SMBGameLevel+SMBLevelEditor.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 11/8/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameLevel+SMBLevelEditor.h"
#import "SMBGameBoard.h"
#import "SMBGameBoardTileEntitySpawner.h"
#import "SMBGameBoardTileEntitySpawnerManager.h"
#import "SMBBeamCreatorTileEntity.h"
#import "SMBForcedBeamRedirectTileEntity.h"





@implementation SMBGameLevel (SMBLevelEditor)

#pragma mark - forcedRedirectsAndWalls
+(nonnull instancetype)smb_levelEditor
{
	/* Game Board. */
	SMBGameBoard* const gameBoard = [[SMBGameBoard alloc] init_with_numberOfColumns:11
																	   numberOfRows:11];

	NSMutableArray<SMBGameBoardTileEntitySpawner*>* const gameBoardTileEntitySpawners = [NSMutableArray<SMBGameBoardTileEntitySpawner*> array];

	SMBGameBoardTile__directions_enumerate(^(SMBGameBoardTile__direction direction) {

		/* SMBBeamCreatorTileEntity */
		[gameBoardTileEntitySpawners addObject:
		 [[SMBGameBoardTileEntitySpawner alloc] init_with_spawnedGameBoardTileEntities_tracked_maximum:0
																					  spawnEntityBlock:
		  ^SMBGameBoardTileEntity * _Nullable{
			  SMBBeamCreatorTileEntity* const beamCreatorTileEntity = [SMBBeamCreatorTileEntity new];
			  [beamCreatorTileEntity setBeamDirection:direction];

			  return beamCreatorTileEntity;
		  }]
		 ];

		/* SMBForcedBeamRedirectTileEntity */
		[gameBoardTileEntitySpawners addObject:
		 [[SMBGameBoardTileEntitySpawner alloc] init_with_spawnedGameBoardTileEntities_tracked_maximum:0
																					  spawnEntityBlock:
		  ^SMBGameBoardTileEntity * _Nullable{
			  return [[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:direction];
		  }]
		 ];
	});

	return
	[[self alloc] init_with_gameBoard:gameBoard
	gameBoardTileEntitySpawnerManager:
	 [[SMBGameBoardTileEntitySpawnerManager alloc] init_with_gameBoardTileEntitySpawners:gameBoardTileEntitySpawners]];
}

@end
