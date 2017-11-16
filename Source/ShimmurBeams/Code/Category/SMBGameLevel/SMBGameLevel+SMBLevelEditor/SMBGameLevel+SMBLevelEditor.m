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
#import "SMBWallTileEntity.h"
#import "SMBBeamRotateTileEntity.h"
#import "SMBDeathBlockTileEntity.h"
#import "SMBGameBoardTileEntitySpawner+SMBInitMethods.h"
#import "SMBDiagonalMirrorTileEntity.h"
#import "SMBMeltableWallTileEntity.h"





@implementation SMBGameLevel (SMBLevelEditor)

#pragma mark - forcedRedirectsAndWalls
+(nonnull instancetype)smb_levelEditor
{
	/* Game board. */
	SMBGameBoard* const gameBoard =
	[[SMBGameBoard alloc] init_with_numberOfColumns:11
									   numberOfRows:11];

	/* Entity spawners. */
	NSMutableArray<SMBGameBoardTileEntitySpawner*>* const gameBoardTileEntitySpawners = [NSMutableArray<SMBGameBoardTileEntitySpawner*> array];

	NSMutableArray<SMBGameBoardTileEntitySpawner_spawnEntityBlock>* const gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse = [NSMutableArray<SMBGameBoardTileEntitySpawner_spawnEntityBlock> array];
	
	/* SMBBeamCreatorTileEntity */
	SMBGameBoardTile__directions_enumerate(^(SMBGameBoardTile__direction direction) {
		[gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse addObject:^SMBGameBoardTileEntity * _Nullable{
			SMBBeamCreatorTileEntity* const beamCreatorTileEntity = [SMBBeamCreatorTileEntity new];
			[beamCreatorTileEntity setBeamDirection:direction];
			
			return beamCreatorTileEntity;
		}];
	});

	/* SMBForcedBeamRedirectTileEntity */
	SMBGameBoardTile__directions_enumerate(^(SMBGameBoardTile__direction direction) {
		[gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse addObject:^SMBGameBoardTileEntity * _Nullable{
			return [[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:direction];
		}];
	});

	/* SMBWallTileEntity */
	[gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse addObject:^SMBGameBoardTileEntity * _Nullable{
		return [SMBWallTileEntity new];
	}];

	/* SMBBeamRotateTileEntity */
	SMBGameBoardTile__direction_rotations_enumerate(^(SMBGameBoardTile__direction_rotation direction_rotation) {
		[gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse addObject:^SMBGameBoardTileEntity * _Nullable{
			return [[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:direction_rotation];
		}];
	});

	/* SMBDeathBlockTileEntity */
	[gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse addObject:^SMBGameBoardTileEntity * _Nullable{
		return [SMBDeathBlockTileEntity new];
	}];

	/* SMBDiagonalMirrorTileEntity */
	SMBDiagonalMirrorTileEntity__mirrorTypes_enumerate(^(SMBDiagonalMirrorTileEntity__mirrorType mirrorType) {
		[gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse addObject:^SMBGameBoardTileEntity * _Nullable{
			return [[SMBDiagonalMirrorTileEntity alloc] init_with_mirrorType:mirrorType];
		}];
	});

	/* SMBMeltableWallTileEntity */
	[gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse addObject:^SMBGameBoardTileEntity * _Nullable{
		return [[SMBMeltableWallTileEntity alloc] init_with_meltableBeamEnterDirections:SMBGameBoardTile__directions_all()];
	}];

	SMBGameBoardTile__directions_enumerate(^(SMBGameBoardTile__direction direction) {
		[gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse addObject:^SMBGameBoardTileEntity * _Nullable{
			return [[SMBMeltableWallTileEntity alloc] init_with_meltableBeamEnterDirections:direction];
		}];
	});

	[gameBoardTileEntitySpawners addObjectsFromArray:
	 [SMBGameBoardTileEntitySpawner smb_gameBoardTileEntitySpawners_with_spawnedGameBoardTileEntities_tracked_maximum:0
																									spawnEntityBlocks:gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse]];

	/* Game level. */
	return
	[[self alloc] init_with_gameBoard:gameBoard
	gameBoardTileEntitySpawnerManager:
	 [[SMBGameBoardTileEntitySpawnerManager alloc] init_with_gameBoardTileEntitySpawners:gameBoardTileEntitySpawners]];
}

@end
