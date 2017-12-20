//
//  SMBGameLevel+SMBMirrorsAndMeltableBlocks.m
//  ShimmurBeams
//
//  Created by Jordan Langsam on 8/15/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameLevel+SMBMirrorsAndMeltableBlocks.h"
#import "SMBDiagonalMirrorTileEntity.h"
#import "SMBGameBoardTilePosition.h"
#import "SMBBeamCreatorTileEntity.h"
#import "SMBGameBoard.h"
#import "SMBGameBoardTile.h"
#import "SMBGameBoard+SMBAddEntity.h"
#import "SMBForcedBeamRedirectTileEntity.h"
#import "SMBMeltableWallTileEntity.h"
#import "SMBBeamRotateTileEntity.h"
#import "SMBWallTileEntity.h"
#import "SMBGameBoardTileEntitySpawner.h"
#import "SMBGameBoardTileEntitySpawnerManager.h"
#import "SMBGameBoardTileEntitySpawner+SMBInitMethods.h"





@implementation SMBGameLevel (SMBMirrorsAndMeltableBlocks)

//+(nonnull instancetype)smb_mirrors_introduction
//{
//	/* Game board. */
//	SMBGameBoard* const gameBoard =
//	[[SMBGameBoard alloc] init_with_numberOfColumns:5
//									   numberOfRows:5];
//
//	/* Initial beam creator. */
//	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
//	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_up];
//	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
//								   to_gameBoardTilePosition:[[SMBGameBoardTilePosition alloc] init_with_column:1
//																										   row:3]];
//
//	/* Level exit. */
//	[gameBoard gameBoardTileEntity_add_levelExit_to_gameBoardTilePosition:
//	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 2
//													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 2]];
//
//	/* Entity spawners. */
//	NSMutableArray<SMBGameBoardTileEntitySpawner*>* const gameBoardTileEntitySpawners = [NSMutableArray<SMBGameBoardTileEntitySpawner*> array];
//	NSMutableArray<SMBGameBoardTileEntitySpawner_spawnEntityBlock>* const gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse = [NSMutableArray<SMBGameBoardTileEntitySpawner_spawnEntityBlock> array];
//	[gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse addObject:^SMBGameBoardTileEntity * _Nullable{
//		return [[SMBDiagonalMirrorTileEntity alloc] init_with_mirrorType:SMBDiagonalMirrorTileEntity__mirrorType_bottomLeft_to_topRight];
//	}];
//	
//	[gameBoardTileEntitySpawners addObjectsFromArray:
//	 [SMBGameBoardTileEntitySpawner smb_gameBoardTileEntitySpawners_with_spawnedGameBoardTileEntities_tracked_maximum:1
//																									spawnEntityBlocks:gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse]];
//
//	/* Game level. */
//	return
//	[[self alloc] init_with_gameBoard:gameBoard
//	gameBoardTileEntitySpawnerManager:
//	 [[SMBGameBoardTileEntitySpawnerManager alloc] init_with_gameBoardTileEntitySpawners:gameBoardTileEntitySpawners]];
//}
//
//+(nonnull instancetype)smb_mirror_man_in_the_mirror
//{
//	/* Game board. */
//	SMBGameBoard* const gameBoard =
//	[[SMBGameBoard alloc] init_with_numberOfColumns:4
//									   numberOfRows:4];
//
//	/* Initial beam creator. */
//	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
//	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_up];
//	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
//								   to_gameBoardTilePosition:[[SMBGameBoardTilePosition alloc] init_with_column:2
//																										   row:3]];
//
//	/* Diagonal mirrors. */
//	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[[SMBDiagonalMirrorTileEntity alloc]init_with_mirrorType:SMBDiagonalMirrorTileEntity__mirrorType_bottomLeft_to_topRight]
//								   to_gameBoardTilePosition:[[SMBGameBoardTilePosition alloc]
//															 init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column
//															 row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 1]];
//
//	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[[SMBDiagonalMirrorTileEntity alloc]init_with_mirrorType:SMBDiagonalMirrorTileEntity__mirrorType_topLeft_to_bottomRight]
//								   to_gameBoardTilePosition:[[SMBGameBoardTilePosition alloc]
//															 init_with_column:gameBoard.gameBoardTiles_numberOfColumns - 1
//															 row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 3]];
//
//	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[[SMBDiagonalMirrorTileEntity alloc]init_with_mirrorType:SMBDiagonalMirrorTileEntity__mirrorType_bottomLeft_to_topRight]
//								   to_gameBoardTilePosition:[[SMBGameBoardTilePosition alloc]
//															 init_with_column:0
//															 row:0]];
//
//	/* Walls. */
//	[gameBoard gameBoardTileEntity_add_wall_to_gameBoardTilePosition:
//	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column - 1
//													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 2]];
//
//	/* Level exit. */
//	[gameBoard gameBoardTileEntity_add_levelExit_to_gameBoardTilePosition:
//	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column
//													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 2]];
//
//	/* Entity spawners. */
//	NSMutableArray<SMBGameBoardTileEntitySpawner*>* const gameBoardTileEntitySpawners = [NSMutableArray<SMBGameBoardTileEntitySpawner*> array];
//	NSMutableArray<SMBGameBoardTileEntitySpawner_spawnEntityBlock>* const gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse = [NSMutableArray<SMBGameBoardTileEntitySpawner_spawnEntityBlock> array];
//	[gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse addObject:^SMBGameBoardTileEntity * _Nullable{
//		return [[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_up];
//	}];
//	[gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse addObject:^SMBGameBoardTileEntity * _Nullable{
//		return [[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_right];
//	}];
//
//	[gameBoardTileEntitySpawners addObjectsFromArray:
//	 [SMBGameBoardTileEntitySpawner smb_gameBoardTileEntitySpawners_with_spawnedGameBoardTileEntities_tracked_maximum:1
//																									spawnEntityBlocks:gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse]];
//
//	/* Game level. */
//	return
//	[[self alloc] init_with_gameBoard:gameBoard
//	gameBoardTileEntitySpawnerManager:
//	 [[SMBGameBoardTileEntitySpawnerManager alloc] init_with_gameBoardTileEntitySpawners:gameBoardTileEntitySpawners]];
//}
//
//#pragma mark - meltableWall
//+(nonnull instancetype)smb_meltableWall_introduction
//{
//	/*
//	 Entities:
//	 Bc[x]	Beam Creator
//	 Exi	Level Exit
//	 Mw[x]	Meltable Wall
//
//	 Entity Notes:
//	 - Bc1
//	 *- direction: up
//	 - Mw1
//	 *- meltableBeamEnterDirections: all
//
//	 Usable:
//	 Diagonal Mirror (mirrorType: bottomLeft)
//
//	 Sections and entities:
//	 [   ] [   ] [   ] [   ] [   ]
//	 [   ] [   ] [Mw1] [Exi] [   ]
//	 [   ] [   ] [   ] [   ] [   ]
//	 [   ] [Bc1] [   ] [   ] [   ]
//	 [   ] [   ] [   ] [   ] [   ]
//
//	 */
//
//	/* Game board. */
//	SMBGameBoard* const gameBoard =
//	[[SMBGameBoard alloc] init_with_numberOfColumns:5
//									   numberOfRows:5];
//
//	/* Initial beam creator. */
//	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
//	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_up];
//
//	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
//								   to_gameBoardTilePosition:[[SMBGameBoardTilePosition alloc] init_with_column:1
//																										   row:3]];
//
//	/* Meltable Wall. */
//
//	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[[SMBMeltableWallTileEntity alloc] init_with_meltableBeamEnterDirections:SMBGameBoardTile__directions_all()]
//								   to_gameBoardTilePosition:[[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 1
//																										   row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 2]];
//
//	/* Level exit. */
//	[gameBoard gameBoardTileEntity_add_levelExit_to_gameBoardTilePosition:
//	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 2
//													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 2]];
//
//	/* Entity spawners. */
//	NSMutableArray<SMBGameBoardTileEntitySpawner*>* const gameBoardTileEntitySpawners = [NSMutableArray<SMBGameBoardTileEntitySpawner*> array];
//	NSMutableArray<SMBGameBoardTileEntitySpawner_spawnEntityBlock>* const gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse = [NSMutableArray<SMBGameBoardTileEntitySpawner_spawnEntityBlock> array];
//	[gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse addObject:^SMBGameBoardTileEntity * _Nullable{
//		return [[SMBDiagonalMirrorTileEntity alloc] init_with_mirrorType:SMBDiagonalMirrorTileEntity__mirrorType_bottomLeft_to_topRight];
//	}];
//	
//	[gameBoardTileEntitySpawners addObjectsFromArray:
//	 [SMBGameBoardTileEntitySpawner smb_gameBoardTileEntitySpawners_with_spawnedGameBoardTileEntities_tracked_maximum:1
//																									spawnEntityBlocks:gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse]];
//
//	/* Game level. */
//	return
//	[[self alloc] init_with_gameBoard:gameBoard
//	gameBoardTileEntitySpawnerManager:
//	 [[SMBGameBoardTileEntitySpawnerManager alloc] init_with_gameBoardTileEntitySpawners:gameBoardTileEntitySpawners]];
//}
//
//+(nonnull instancetype)smb_meltableWall_oneDirection
//{
//	/*
//	 Entities:
//	 Bc[x]	Beam Creator
//	 Exi	Level Exit
//	 Dm[x]	Diagonal Mirror
//	 Mw[x]	Meltable Wall
//
//	 Entity Notes:
//	 - Bc1
//	 *- direction: up
//	 - Dm1
//	 *- mirrorType: bottomLeft
//	 - Dm2
//	 *- mirrorType: bottomLeft
//	 - Dm3
//	 *- mirrorType: bottomLeft
//	 - Dm4
//	 *- mirrorType: bottomLeft
//	 - Mw1
//	 *- meltableBeamEnterDirections: bottom
//
//	 Usable:
//	 Diagonal Mirror (mirrorType: bottomLeft)
//
//	 Sections and entities:
//	 [   ] [   ] [Dm4] [Exi] [   ]
//	 [   ] [Dm1] [Mw1] [Dm2] [   ]
//	 [   ] [   ] [Dm3] [   ] [   ]
//	 [   ] [Bc1] [   ] [   ] [   ]
//	 [   ] [   ] [   ] [   ] [   ]
//
//	 */
//
//	/* Game board. */
//	SMBGameBoard* const gameBoard =
//	[[SMBGameBoard alloc] init_with_numberOfColumns:5
//									   numberOfRows:5];
//
//	/* Initial beam creator. */
//	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
//	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_up];
//
//	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
//								   to_gameBoardTilePosition:[[SMBGameBoardTilePosition alloc] init_with_column:1
//																										   row:3]];
//
//	/* Meltable Wall. */
//
//	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[[SMBMeltableWallTileEntity alloc] init_with_meltableBeamEnterDirections:SMBGameBoardTile__direction_down]
//								   to_gameBoardTilePosition:[[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 1
//																										   row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 2]];
//
//	/* Diagonal Mirrors */
//
//	/* Dm1, 1x1 */
//	[gameBoard gameBoardTileEntity_add:[[SMBDiagonalMirrorTileEntity alloc] init_with_mirrorType:SMBDiagonalMirrorTileEntity__mirrorType_bottomLeft_to_topRight]
//							entityType:SMBGameBoardTile__entityType_beamInteractions
//			  to_gameBoardTilePosition:
//	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column
//													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 2]];
//
//	/* Dm2, 3x1 */
//	[gameBoard gameBoardTileEntity_add:[[SMBDiagonalMirrorTileEntity alloc] init_with_mirrorType:SMBDiagonalMirrorTileEntity__mirrorType_bottomLeft_to_topRight]
//							entityType:SMBGameBoardTile__entityType_beamInteractions
//			  to_gameBoardTilePosition:
//	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 2
//													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 2]];
//
//	/* Dm3, 2x2 */
//	[gameBoard gameBoardTileEntity_add:[[SMBDiagonalMirrorTileEntity alloc] init_with_mirrorType:SMBDiagonalMirrorTileEntity__mirrorType_bottomLeft_to_topRight]
//							entityType:SMBGameBoardTile__entityType_beamInteractions
//			  to_gameBoardTilePosition:
//	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 1
//													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 1]];
//
//	/* Dm4, 2x0 */
//	[gameBoard gameBoardTileEntity_add:[[SMBDiagonalMirrorTileEntity alloc] init_with_mirrorType:SMBDiagonalMirrorTileEntity__mirrorType_bottomLeft_to_topRight]
//							entityType:SMBGameBoardTile__entityType_beamInteractions
//			  to_gameBoardTilePosition:
//	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 1
//													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 3]];
//
//	/* Level exit. */
//	[gameBoard gameBoardTileEntity_add_levelExit_to_gameBoardTilePosition:
//	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 2
//													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 3]];
//
//	/* Entity spawners. */
//	NSMutableArray<SMBGameBoardTileEntitySpawner*>* const gameBoardTileEntitySpawners = [NSMutableArray<SMBGameBoardTileEntitySpawner*> array];
//	NSMutableArray<SMBGameBoardTileEntitySpawner_spawnEntityBlock>* const gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse = [NSMutableArray<SMBGameBoardTileEntitySpawner_spawnEntityBlock> array];
//	[gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse addObject:^SMBGameBoardTileEntity * _Nullable{
//		return [[SMBDiagonalMirrorTileEntity alloc] init_with_mirrorType:SMBDiagonalMirrorTileEntity__mirrorType_bottomLeft_to_topRight];
//	}];
//
//	[gameBoardTileEntitySpawners addObjectsFromArray:
//	 [SMBGameBoardTileEntitySpawner smb_gameBoardTileEntitySpawners_with_spawnedGameBoardTileEntities_tracked_maximum:1
//																									spawnEntityBlocks:gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse]];
//
//	/* Game level. */
//	return
//	[[self alloc] init_with_gameBoard:gameBoard
//	gameBoardTileEntitySpawnerManager:
//	 [[SMBGameBoardTileEntitySpawnerManager alloc] init_with_gameBoardTileEntitySpawners:gameBoardTileEntitySpawners]];
//}
//
//+(nonnull instancetype)smb_meltableWall_inTheWay
//{
//	/*
//	 Entities:
//	 Bc[x]	Beam Creator
//	 Exi	Level Exit
//	 Wal	Wall
//	 Br[x]	Beam rotation
//	 Dm[x]	Diagonal Mirror
//	 Mw[x]	Meltable Wall
//
//	 Entity Notes:
//	 - Bc1
//	 *- direction: up
//	 - Br1
//	 *- direction_rotation: right
//	 - Br2
//	 *- direction_rotation: right
//	 - Br3
//	 *- direction_rotation: left
//	 - Fr1
//	 *- direction: right
//	 - Fr2
//	 *- direction: left
//	 - Fr3
//	 *- direction: right
//	 - Fr4
//	 *- direction: down
//	 - Fr5
//	 *- direction: right
//	 - Fr6
//	 *- direction: up
//	 - Fr7
//	 *- direction: left
//	 - Dm1
//	 *- mirrorType: bottomLeft
//	 - Dm2
//	 *- mirrorType: topLeft
//	 - Dm3
//	 *- mirrorType: bottomLeft
//	 - Dm4
//	 *- mirrorType: topLeft
//	 - Mw1
//	 *- meltableBeamEnterDirections: up
//	 - Mw2
//	 *- meltableBeamEnterDirections: right
//	 - Mw3
//	 *- meltableBeamEnterDirections: up
//	 - Mw4
//	 *- meltableBeamEnterDirections: right
//
//	 Usable:
//	 Diagonal Mirror (mirrorType: bottomLeft)
//	 Beam Rotation (direction_rotation: right)
//	 Forced Redirect (direction: down)
//
//	 Sections and entities:
//	 [Dm3] [Dm4] [   ] [   ] [   ] [   ] [   ]
//	 [Dm2] [   ] [   ] [   ] [Fr5] [   ] [   ]
//	 [Fr1] [Br1] [Fr2] [   ] [   ] [Mw3] [Dm1]
//	 [Fr6] [   ] [   ] [Wal] [   ] [Br3] [Fr7]
//	 [   ] [Mw1] [   ] [Wal] [Mw4] [   ] [Exi]
//	 [   ] [   ] [   ] [Mw2] [Br2] [Fr4] [   ]
//	 [   ] [Bc1] [   ] [   ] [Fr3] [   ] [   ]
//
//	 */
//
//	/* Game board. */
//	SMBGameBoard* const gameBoard =
//	[[SMBGameBoard alloc] init_with_numberOfColumns:7
//									   numberOfRows:7];
//
//	/* Initial beam creator. */
//	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
//	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_up];
//	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
//								   to_gameBoardTilePosition:[[SMBGameBoardTilePosition alloc] init_with_column:1
//																										   row:[gameBoard gameBoardTiles_numberOfRows] - 1]];
//
//	/* Walls. */
//	[gameBoard gameBoardTileEntity_add_wall_to_gameBoardTilePosition:
//	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 2
//													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 3]];
//
//	[gameBoard gameBoardTileEntity_add_wall_to_gameBoardTilePosition:
//	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 2
//													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 2]];
//
//	/* Meltable Wall. */
//
//	/* Mw1 */
//	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[[SMBMeltableWallTileEntity alloc] init_with_meltableBeamEnterDirections:SMBGameBoardTile__direction_up]
//								   to_gameBoardTilePosition:
//	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column
//													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 2]];
//
//	/* Mw2 */
//	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[[SMBMeltableWallTileEntity alloc] init_with_meltableBeamEnterDirections:SMBGameBoardTile__direction_right]
//								   to_gameBoardTilePosition:
//	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 2
//													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 1]];
//
//	/* Mw3 */
//	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[[SMBMeltableWallTileEntity alloc] init_with_meltableBeamEnterDirections:SMBGameBoardTile__direction_up]
//								   to_gameBoardTilePosition:
//	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 4
//													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 4]];
//
//	/* Mw4 */
//	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[[SMBMeltableWallTileEntity alloc] init_with_meltableBeamEnterDirections:SMBGameBoardTile__direction_right]
//								   to_gameBoardTilePosition:
//	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 3
//													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 2]];
//
//	/* Forced redirects. */
//
//	/* Fr1 */
//	[gameBoard gameBoardTileEntity_add:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_right]
//							entityType:SMBGameBoardTile__entityType_beamInteractions
//			  to_gameBoardTilePosition:
//	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column - 1
//													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 4]];
//
//	/* Fr2 */
//	[gameBoard gameBoardTileEntity_add:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_left]
//							entityType:SMBGameBoardTile__entityType_beamInteractions
//			  to_gameBoardTilePosition:
//	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 1
//													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 4]];
//
//	/* Fr3 */
//	[gameBoard gameBoardTileEntity_add:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_right]
//							entityType:SMBGameBoardTile__entityType_beamInteractions
//			  to_gameBoardTilePosition:
//	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 3
//													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row]];
//
//	/* Fr4 */
//	[gameBoard gameBoardTileEntity_add:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_down]
//							entityType:SMBGameBoardTile__entityType_beamInteractions
//			  to_gameBoardTilePosition:
//	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 4
//													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 1]];
//
//	/* Fr5 */
//	[gameBoard gameBoardTileEntity_add:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_right]
//							entityType:SMBGameBoardTile__entityType_beamInteractions
//			  to_gameBoardTilePosition:
//	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 3
//													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 5]];
//
//	/* Fr6 */
//	[gameBoard gameBoardTileEntity_add:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_up]
//							entityType:SMBGameBoardTile__entityType_beamInteractions
//			  to_gameBoardTilePosition:
//	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column - 1
//													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 3]];
//
//	/* Fr7 */
//	[gameBoard gameBoardTileEntity_add:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_left]
//							entityType:SMBGameBoardTile__entityType_beamInteractions
//			  to_gameBoardTilePosition:
//	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 5
//													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 3]];
//
//	/* Beam rotations. */
//
//	/* Br1 */
//	[gameBoard gameBoardTileEntity_add:[[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_right]
//							entityType:SMBGameBoardTile__entityType_beamInteractions
//			  to_gameBoardTilePosition:
//	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column
//													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 4]];
//
//	/* Br2 */
//	[gameBoard gameBoardTileEntity_add:[[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_right]
//							entityType:SMBGameBoardTile__entityType_beamInteractions
//			  to_gameBoardTilePosition:
//	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 3
//													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 1]];
//
//	/* Br3 */
//	[gameBoard gameBoardTileEntity_add:[[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_left]
//							entityType:SMBGameBoardTile__entityType_beamInteractions
//			  to_gameBoardTilePosition:
//	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 4
//													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 3]];
//
//	/* Diagonal mirrors. */
//
//	/* Dm1 */
//	[gameBoard gameBoardTileEntity_add:[[SMBDiagonalMirrorTileEntity alloc] init_with_mirrorType:SMBDiagonalMirrorTileEntity__mirrorType_bottomLeft_to_topRight]
//							entityType:SMBGameBoardTile__entityType_beamInteractions
//			  to_gameBoardTilePosition:
//	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 5
//													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 4]];
//
//	/* Dm2 */
//	[gameBoard gameBoardTileEntity_add:[[SMBDiagonalMirrorTileEntity alloc] init_with_mirrorType:SMBDiagonalMirrorTileEntity__mirrorType_topLeft_to_bottomRight]
//							entityType:SMBGameBoardTile__entityType_beamInteractions
//			  to_gameBoardTilePosition:
//	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column - 1
//													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 5]];
//
//	/* Dm3 */
//	[gameBoard gameBoardTileEntity_add:[[SMBDiagonalMirrorTileEntity alloc] init_with_mirrorType:SMBDiagonalMirrorTileEntity__mirrorType_bottomLeft_to_topRight]
//							entityType:SMBGameBoardTile__entityType_beamInteractions
//			  to_gameBoardTilePosition:
//	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column - 1
//													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 6]];
//
//	/* Dm4 */
//	[gameBoard gameBoardTileEntity_add:[[SMBDiagonalMirrorTileEntity alloc] init_with_mirrorType:SMBDiagonalMirrorTileEntity__mirrorType_topLeft_to_bottomRight]
//							entityType:SMBGameBoardTile__entityType_beamInteractions
//			  to_gameBoardTilePosition:
//	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column
//													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 6]];
//
//	/* Level exit. */
//	[gameBoard gameBoardTileEntity_add_levelExit_to_gameBoardTilePosition:
//	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 5
//													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 2]];
//
//	/* Entity spawners. */
//	NSMutableArray<SMBGameBoardTileEntitySpawner*>* const gameBoardTileEntitySpawners = [NSMutableArray<SMBGameBoardTileEntitySpawner*> array];
//	NSMutableArray<SMBGameBoardTileEntitySpawner_spawnEntityBlock>* const gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse = [NSMutableArray<SMBGameBoardTileEntitySpawner_spawnEntityBlock> array];
//	[gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse addObject:^SMBGameBoardTileEntity * _Nullable{
//		return [[SMBDiagonalMirrorTileEntity alloc] init_with_mirrorType:SMBDiagonalMirrorTileEntity__mirrorType_bottomLeft_to_topRight];
//	}];
//	[gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse addObject:^SMBGameBoardTileEntity * _Nullable{
//		return [[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_right];
//	}];
//	[gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse addObject:^SMBGameBoardTileEntity * _Nullable{
//		return [[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_down];
//	}];
//
//	[gameBoardTileEntitySpawners addObjectsFromArray:
//	 [SMBGameBoardTileEntitySpawner smb_gameBoardTileEntitySpawners_with_spawnedGameBoardTileEntities_tracked_maximum:1
//																									spawnEntityBlocks:gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse]];
//
//	/* Game level. */
//	return
//	[[self alloc] init_with_gameBoard:gameBoard
//	gameBoardTileEntitySpawnerManager:
//	 [[SMBGameBoardTileEntitySpawnerManager alloc] init_with_gameBoardTileEntitySpawners:gameBoardTileEntitySpawners]];
//}

@end
