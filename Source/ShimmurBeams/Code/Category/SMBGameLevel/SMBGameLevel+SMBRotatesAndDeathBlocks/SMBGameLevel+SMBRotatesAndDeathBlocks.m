//
//  SMBGameLevel+SMBRotatesAndDeathBlocks.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/15/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameLevel+SMBRotatesAndDeathBlocks.h"
#import "SMBGameBoard.h"
#import "SMBBeamCreatorTileEntity.h"
#import "SMBGameBoard+SMBAddEntity.h"
#import "SMBBeamRotateTileEntity.h"
#import "SMBGameBoardTile.h"
#import "SMBGameBoardTilePosition.h"
#import "SMBForcedBeamRedirectTileEntity.h"
#import "SMBDeathBlockTileEntity.h"
#import "SMBGameBoardTileEntitySpawner.h"
#import "SMBGameBoardTileEntitySpawnerManager.h"
#import "SMBGameBoardTileEntitySpawner+SMBInitMethods.h"





@implementation SMBGameLevel (SMBRotatesAndDeathBlocks)

+(nonnull instancetype)smb_rotates_oneRotate_right
{
	/*
	 Usable:
	 1) Beam Rotation (direction_rotation: right)
	 
	 Answer:
	 1) Usable 1) Beam Rotation (direction_rotation: right): B2
	 
	 */

	/* Game board. */
	SMBGameBoard* const gameBoard =
	[[SMBGameBoard alloc] init_with_numberOfColumns:5
									   numberOfRows:5
								 leastNumberOfMoves:1];

	/* Initial beam creator. */
	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_up];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:1
													row:[gameBoard gameBoardTiles_numberOfRows] - 2]];

	/* Level exit. */
	[gameBoard gameBoardTileEntity_add_levelExit_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:[gameBoard gameBoardTiles_numberOfColumns] - 2
													row:1]];

	/* Entity spawners. */
	NSMutableArray<SMBGameBoardTileEntitySpawner*>* const gameBoardTileEntitySpawners = [NSMutableArray<SMBGameBoardTileEntitySpawner*> array];

	NSMutableArray<SMBGameBoardTileEntitySpawner_spawnEntityBlock>* const gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse = [NSMutableArray<SMBGameBoardTileEntitySpawner_spawnEntityBlock> array];
	[gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse addObject:^SMBGameBoardTileEntity * _Nullable{
		return [[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_right];
	}];

	[gameBoardTileEntitySpawners addObjectsFromArray:
	 [SMBGameBoardTileEntitySpawner smb_gameBoardTileEntitySpawners_with_spawnedGameBoardTileEntities_tracked_maximum:1
																									spawnEntityBlocks:gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse]];

	/* Game level. */
	return
	[[self alloc] init_with_gameBoard:gameBoard
	gameBoardTileEntitySpawnerManager:
	 [[SMBGameBoardTileEntitySpawnerManager alloc] init_with_gameBoardTileEntitySpawners:gameBoardTileEntitySpawners]];
}

+(nonnull instancetype)smb_rotates_two_left
{
	/*
	 Usable:
	 1) Beam Rotation (direction_rotation: left)
	 2) Beam Rotation (direction_rotation: left)

	 Answer:
	 1) Usable 1) Beam Rotation (direction_rotation: left): D2
	 2) Usable 2) Beam Rotation (direction_rotation: left): B2

	 */

	/* Game board. */
	SMBGameBoard* const gameBoard =
	[[SMBGameBoard alloc] init_with_numberOfColumns:5
									   numberOfRows:5
								 leastNumberOfMoves:2];

	/* Initial beam creator. */
	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_up];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:[gameBoard gameBoardTiles_numberOfColumns] - 2
													row:[gameBoard gameBoardTiles_numberOfRows] - 2]];

	/* Level exit. */
	[gameBoard gameBoardTileEntity_add_levelExit_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column - 2
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row]];

	/* Entity spawners. */
	NSMutableArray<SMBGameBoardTileEntitySpawner*>* const gameBoardTileEntitySpawners = [NSMutableArray<SMBGameBoardTileEntitySpawner*> array];

	NSMutableArray<SMBGameBoardTileEntitySpawner_spawnEntityBlock>* const gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse = [NSMutableArray<SMBGameBoardTileEntitySpawner_spawnEntityBlock> array];
#warning !!Duplicate entity! Can condense to a single spawner later.
	[gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse addObject:^SMBGameBoardTileEntity * _Nullable{
		return [[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_left];
	}];
	[gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse addObject:^SMBGameBoardTileEntity * _Nullable{
		return [[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_left];
	}];

	[gameBoardTileEntitySpawners addObjectsFromArray:
	 [SMBGameBoardTileEntitySpawner smb_gameBoardTileEntitySpawners_with_spawnedGameBoardTileEntities_tracked_maximum:1
																									spawnEntityBlocks:gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse]];

	/* Game level. */
	return
	[[self alloc] init_with_gameBoard:gameBoard
	gameBoardTileEntitySpawnerManager:
	 [[SMBGameBoardTileEntitySpawnerManager alloc] init_with_gameBoardTileEntitySpawners:gameBoardTileEntitySpawners]];
}

#pragma mark - rotates and forced
+(nonnull instancetype)smb_rotates_oneRight_forced_oneRight
{
	/*
	 Usable:
	 1) Beam Rotation (direction_rotation: right)
	 2) Forced Redirect (direction: right)
	 
	 Answer:
	 1) Usable 2) Forced Redirect (direction: right): B2
	 2) Usable 1) Beam Rotation (direction_rotation: right): D2
	 
	 */

	/* Game board. */
	SMBGameBoard* const gameBoard =
	[[SMBGameBoard alloc] init_with_numberOfColumns:5
									   numberOfRows:5
								 leastNumberOfMoves:2];

	/* Initial beam creator. */
	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_up];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:1
													row:[gameBoard gameBoardTiles_numberOfRows] - 2]];

	/* Level exit. */
	[gameBoard gameBoardTileEntity_add_levelExit_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:[gameBoard gameBoardTiles_numberOfColumns] - 2
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row]];

	/* Entity spawners. */
	NSMutableArray<SMBGameBoardTileEntitySpawner*>* const gameBoardTileEntitySpawners = [NSMutableArray<SMBGameBoardTileEntitySpawner*> array];

	NSMutableArray<SMBGameBoardTileEntitySpawner_spawnEntityBlock>* const gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse = [NSMutableArray<SMBGameBoardTileEntitySpawner_spawnEntityBlock> array];
	[gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse addObject:^SMBGameBoardTileEntity * _Nullable{
		return [[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_right];
	}];

	[gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse addObject:^SMBGameBoardTileEntity * _Nullable{
		return [[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_right];
	}];

	[gameBoardTileEntitySpawners addObjectsFromArray:
	 [SMBGameBoardTileEntitySpawner smb_gameBoardTileEntitySpawners_with_spawnedGameBoardTileEntities_tracked_maximum:1
																									spawnEntityBlocks:gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse]];

	/* Game level. */
	return
	[[self alloc] init_with_gameBoard:gameBoard
	gameBoardTileEntitySpawnerManager:
	 [[SMBGameBoardTileEntitySpawnerManager alloc] init_with_gameBoardTileEntitySpawners:gameBoardTileEntitySpawners]];
}

#pragma mark - rotates and wall
+(nonnull instancetype)smb_rotates_oneLeft_twoRight_wall_oneCenter
{
	/*
	 Usable:
	 1) Beam Rotation (direction_rotation: right).
	 2) Beam Rotation (direction_rotation: left).
	 3) Beam Rotation (direction_rotation: right).

	 Answer:
	 1) Usable 2) Beam Rotation (direction_rotation: left): D5
	 2) Usable 1) Beam Rotation (direction_rotation: right): C5
	 3) Usable 3) Beam Rotation (direction_rotation: right): C1

	 */

	/* Game board. */
	SMBGameBoard* const gameBoard =
	[[SMBGameBoard alloc] init_with_numberOfColumns:7
									   numberOfRows:7
								 leastNumberOfMoves:3];

	/* Initial beam creator. */
	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_up];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:floor((CGFloat)[gameBoard gameBoardTiles_numberOfColumns] / 2.0f)
													row:[gameBoard gameBoardTiles_numberOfRows] - 1]];

	/* Walls. */
	[gameBoard gameBoardTileEntity_add_wall_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:floor((CGFloat)[gameBoard gameBoardTiles_numberOfColumns] / 2.0f)
													row:floor((CGFloat)[gameBoard gameBoardTiles_numberOfRows] / 2.0f)]];

	/* Level exit. */
	[gameBoard gameBoardTileEntity_add_levelExit_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column
													row:0]];

	/* Entity spawners. */
	NSMutableArray<SMBGameBoardTileEntitySpawner*>* const gameBoardTileEntitySpawners = [NSMutableArray<SMBGameBoardTileEntitySpawner*> array];

	NSMutableArray<SMBGameBoardTileEntitySpawner_spawnEntityBlock>* const gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse = [NSMutableArray<SMBGameBoardTileEntitySpawner_spawnEntityBlock> array];
	[gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse addObject:^SMBGameBoardTileEntity * _Nullable{
		return [[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_right];
	}];
	[gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse addObject:^SMBGameBoardTileEntity * _Nullable{
		return [[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_left];
	}];
	[gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse addObject:^SMBGameBoardTileEntity * _Nullable{
		return [[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_right];
	}];

	[gameBoardTileEntitySpawners addObjectsFromArray:
	 [SMBGameBoardTileEntitySpawner smb_gameBoardTileEntitySpawners_with_spawnedGameBoardTileEntities_tracked_maximum:1
																									spawnEntityBlocks:gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse]];

	/* Game level. */
	return
	[[self alloc] init_with_gameBoard:gameBoard
	gameBoardTileEntitySpawnerManager:
	 [[SMBGameBoardTileEntitySpawnerManager alloc] init_with_gameBoardTileEntitySpawners:gameBoardTileEntitySpawners]];
}

#pragma mark - rotates and death blocks
+(nonnull instancetype)smb_rotates_twoRight_deathBlock_one
{
	/*
	 Usable:
	 1) Beam Rotation (direction_rotation: right).
	 2) Beam Rotation (direction_rotation: right).
	 
	 Answer:
	 1) Usable 1) Beam Rotation (direction_rotation: right): B2
	 2) Usable 2) Beam Rotation (direction_rotation: right): F2
	 
	 */

	/* Game board. */
	SMBGameBoard* const gameBoard =
	[[SMBGameBoard alloc] init_with_numberOfColumns:7
									   numberOfRows:7
								 leastNumberOfMoves:3];

	/* Initial beam creator. */
	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_up];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:1
													row:[gameBoard gameBoardTiles_numberOfRows] - 2]];

	/* Death blocks. */
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[SMBDeathBlockTileEntity new]
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 2
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 2]];

	/* Level exit. */
	[gameBoard gameBoardTileEntity_add_levelExit_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:[gameBoard gameBoardTiles_numberOfColumns] - 2
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 2]];

	/* Entity spawners. */
	NSMutableArray<SMBGameBoardTileEntitySpawner*>* const gameBoardTileEntitySpawners = [NSMutableArray<SMBGameBoardTileEntitySpawner*> array];

	NSMutableArray<SMBGameBoardTileEntitySpawner_spawnEntityBlock>* const gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse = [NSMutableArray<SMBGameBoardTileEntitySpawner_spawnEntityBlock> array];
	[gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse addObject:^SMBGameBoardTileEntity * _Nullable{
		return [[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_right];
	}];
#warning !!Duplicate entity! Can condense to a single spawner later.
	[gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse addObject:^SMBGameBoardTileEntity * _Nullable{
		return [[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_right];
	}];

	[gameBoardTileEntitySpawners addObjectsFromArray:
	 [SMBGameBoardTileEntitySpawner smb_gameBoardTileEntitySpawners_with_spawnedGameBoardTileEntities_tracked_maximum:1
																									spawnEntityBlocks:gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse]];

	/* Game level. */
	return
	[[self alloc] init_with_gameBoard:gameBoard
	gameBoardTileEntitySpawnerManager:
	 [[SMBGameBoardTileEntitySpawnerManager alloc] init_with_gameBoardTileEntitySpawners:gameBoardTileEntitySpawners]];
}

+(nonnull instancetype)smb_rotates_twoRight_twoLeft_deathBlocks_surrounded_and_someBlocking
{
	/*
	 Usable:
	 1) Beam Rotation (direction_rotation: right).
	 2) Beam Rotation (direction_rotation: right).
	 3) Beam Rotation (direction_rotation: left).
	 4) Beam Rotation (direction_rotation: left).

	 Answer:
	 1) Usable 1) Beam Rotation (direction_rotation: right): D3
	 2) Usable 3) Beam Rotation (direction_rotation: left): E3
	 3) Usable 4) Beam Rotation (direction_rotation: left): E5
	 4) Usable 2) Beam Rotation (direction_rotation: right): D5

	 */

	/* Game board. */
	SMBGameBoard* const gameBoard =
	[[SMBGameBoard alloc] init_with_numberOfColumns:7
									   numberOfRows:7
								 leastNumberOfMoves:4];

	/* Initial beam creator. */
	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_up];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:floor((CGFloat)[gameBoard gameBoardTiles_numberOfColumns] / 2.0f)
													row:[gameBoard gameBoardTiles_numberOfRows] - 2]];

	/* Walls. */
	[gameBoard gameBoardTileEntity_add_wall_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column
													row:floor((CGFloat)[gameBoard gameBoardTiles_numberOfRows] / 2.0f)]];

	/* Level exit. */
	SMBGameBoardTilePosition* const gameBoardTilePosition_levelExit =
	[[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column
												   row:1];
	[gameBoard gameBoardTileEntity_add_levelExit_to_gameBoardTilePosition:gameBoardTilePosition_levelExit];

	/* Death blocks. */
	[gameBoard gameBoardTileEntities_add:
	 ^SMBGameBoardTileEntity * _Nullable(SMBGameBoardTilePosition * _Nonnull position) {
		 return [SMBDeathBlockTileEntity new];
	 }
							  entityType:SMBGameBoardTile__entityType_beamInteractions
								fillRect:NO
								 columns:
	 (NSRange){
		 .location	= 0,
		 .length	= [gameBoard gameBoardTiles_numberOfColumns],
	 }
									rows:
	 (NSRange){
		 .location	= 0,
		 .length	= [gameBoard gameBoardTiles_numberOfRows],
	 }];

	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[SMBDeathBlockTileEntity new]
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:gameBoardTilePosition_levelExit.column - 1
													row:gameBoardTilePosition_levelExit.row]];

	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[SMBDeathBlockTileEntity new]
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:gameBoardTilePosition_levelExit.column + 1
													row:gameBoardTilePosition_levelExit.row]];

	/* Entity spawners. */
	NSMutableArray<SMBGameBoardTileEntitySpawner*>* const gameBoardTileEntitySpawners = [NSMutableArray<SMBGameBoardTileEntitySpawner*> array];

	NSMutableArray<SMBGameBoardTileEntitySpawner_spawnEntityBlock>* const gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse = [NSMutableArray<SMBGameBoardTileEntitySpawner_spawnEntityBlock> array];
	[gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse addObject:^SMBGameBoardTileEntity * _Nullable{
		return [[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_right];
	}];
#warning !!Duplicate entity! Can condense to a single spawner later.
	[gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse addObject:^SMBGameBoardTileEntity * _Nullable{
		return [[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_right];
	}];
	[gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse addObject:^SMBGameBoardTileEntity * _Nullable{
		return [[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_left];
	}];
#warning !!Duplicate entity! Can condense to a single spawner later.
	[gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse addObject:^SMBGameBoardTileEntity * _Nullable{
		return [[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_left];
	}];

	[gameBoardTileEntitySpawners addObjectsFromArray:
	 [SMBGameBoardTileEntitySpawner smb_gameBoardTileEntitySpawners_with_spawnedGameBoardTileEntities_tracked_maximum:1
																									spawnEntityBlocks:gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse]];

	/* Game level. */
	return
	[[self alloc] init_with_gameBoard:gameBoard
	gameBoardTileEntitySpawnerManager:
	 [[SMBGameBoardTileEntitySpawnerManager alloc] init_with_gameBoardTileEntitySpawners:gameBoardTileEntitySpawners]];
}

+(nonnull instancetype)smb_rotates_deathBlocks_blackAnglesMatter
{
	/*
	 Usable:
	 1) Forced Redirect (direction: down).
	 2) Forced Redirect (direction: up).

	 Answer:
	 1) Usable 2) Forced Redirect (direction: up): B4
	 2) Usable 1) Forced Redirect (direction: down): B1

	 */

	/* Game board. */
	SMBGameBoard* const gameBoard =
	[[SMBGameBoard alloc] init_with_numberOfColumns:5
									   numberOfRows:5
								 leastNumberOfMoves:2];

	/* Initial beam creator. */
	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_right];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
								   to_gameBoardTilePosition:[[SMBGameBoardTilePosition alloc] init_with_column:0
																										   row:0]];

	/* Walls. */
	[gameBoard gameBoardTileEntity_add_wall_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:[gameBoard gameBoardTiles_numberOfColumns] - 1
													row:0]];

	/* Level exit. */
	[gameBoard gameBoardTileEntity_add_levelExit_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row + 1]];

	/* Forced redirects. */
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_left]
								   to_gameBoardTilePosition:[[SMBGameBoardTilePosition alloc] init_with_column:gameBoard.gameBoardTiles_numberOfColumns - 1 row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row +1 ]];

	/* Beam rotates. */
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_left]
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 1
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row + 1]];

	/* Death blocks. */
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[SMBDeathBlockTileEntity new]
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 1
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row + 4]];

	/* Entity spawners. */
	NSMutableArray<SMBGameBoardTileEntitySpawner*>* const gameBoardTileEntitySpawners = [NSMutableArray<SMBGameBoardTileEntitySpawner*> array];

	NSMutableArray<SMBGameBoardTileEntitySpawner_spawnEntityBlock>* const gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse = [NSMutableArray<SMBGameBoardTileEntitySpawner_spawnEntityBlock> array];
	[gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse addObject:^SMBGameBoardTileEntity * _Nullable{
		return [[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_down];
	}];
	[gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse addObject:^SMBGameBoardTileEntity * _Nullable{
		return [[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_up];
	}];

	[gameBoardTileEntitySpawners addObjectsFromArray:
	 [SMBGameBoardTileEntitySpawner smb_gameBoardTileEntitySpawners_with_spawnedGameBoardTileEntities_tracked_maximum:1
																									spawnEntityBlocks:gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse]];

	/* Game level. */
	return
	[[self alloc] init_with_gameBoard:gameBoard
	gameBoardTileEntitySpawnerManager:
	 [[SMBGameBoardTileEntitySpawnerManager alloc] init_with_gameBoardTileEntitySpawners:gameBoardTileEntitySpawners]];
}

+(nonnull instancetype)smb_rotates_deathBlocks_scattered
{
	/*
	 Usable:
	 1) Beam Rotation (direction_rotation: right)
	 2) Beam Rotation (direction_rotation: left)
	 3) Beam Rotation (direction_rotation: left)
	 4) Forced Redirect (direction: right).

	 Answer:
	 1) Usable 4) Forced Redirect (direction: right): E3
	 2) Usable 2) Beam Rotation (direction_rotation: left): F8
	 3) Usable 1) Beam Rotation (direction_rotation: right): B5
	 4) Usable 3) Beam Rotation (direction_rotation: left): B11

	 */

	/* Game board. */
	SMBGameBoard* const gameBoard =
	[[SMBGameBoard alloc] init_with_numberOfColumns:11
									   numberOfRows:11
								 leastNumberOfMoves:4];

	/* Initial beam creator. */
	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_up];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:floor((CGFloat)[gameBoard gameBoardTiles_numberOfColumns] / 2.0f)
													row:[gameBoard gameBoardTiles_numberOfRows] - 3]];

	/* Forced redirects. */
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_up]
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:[gameBoard gameBoardTiles_numberOfColumns] - 2
													row:[gameBoard gameBoardTiles_numberOfRows] - 1]];

	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_left]
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 1
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row + 1]];

	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_up]
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:0
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 1]];

	[gameBoard gameBoardTileEntities_add:
	 ^SMBGameBoardTileEntity * _Nullable(SMBGameBoardTilePosition * _Nonnull position) {
		 NSUInteger const row = position.row;
		 kRUConditionalReturn_ReturnValueNil(row == 2, NO);

		 double const row_halved = (double)row / 2.0f;
		 return
		 (ceil(row_halved) == row_halved
		  ?
		  [[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_down]
		  :
		  nil
		  );
	 }
							  entityType:SMBGameBoardTile__entityType_beamInteractions
								fillRect:NO
								 columns:
	 (NSRange){
		 .location	= beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 2,
		 .length	= 1,
	 }
									rows:
	 (NSRange){
		 .location	= 0,
		 .length	= beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 2,
	 }];

	/* Beam rotates. */
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_right]
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 2]];

	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_right]
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column - 3
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 2]];

	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_right]
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:[gameBoard gameBoardTiles_numberOfColumns] - 4
													row:[gameBoard gameBoardTiles_numberOfRows] - 3]];

	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_left]
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:[gameBoard gameBoardTiles_numberOfColumns] - 2
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 2]];

	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_right]
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:0
													row:[gameBoard gameBoardTiles_numberOfRows] - 2]];

	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_left]
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column
													row:2]];

	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_right]
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:0
													row:4]];

	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_right]
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:2
													row:4]];

	/* Death blocks. */
	[gameBoard gameBoardTileEntities_add:
	 ^SMBGameBoardTileEntity * _Nullable(SMBGameBoardTilePosition * _Nonnull position) {
		 NSUInteger const row = position.row;
		 double const row_halved = (double)row / 2.0f;
		 return
		 (ceil(row_halved) != row_halved
		  ?
		  [SMBDeathBlockTileEntity new]
		  :
		  nil
		  );
	 }
							  entityType:SMBGameBoardTile__entityType_beamInteractions
								fillRect:NO
								 columns:
	 (NSRange){
		 .location	= beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 1,
		 .length	= 1,
	 }
									rows:
	 (NSRange){
		 .location	= 0,
		 .length	= beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row,
	 }];

	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[SMBDeathBlockTileEntity new]
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column - 1
													row:0]];

	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[SMBDeathBlockTileEntity new]
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column - 2
													row:2]];

	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[SMBDeathBlockTileEntity new]
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column - 2
													row:1]];

	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[SMBDeathBlockTileEntity new]
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column - 1
													row:3]];

	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[SMBDeathBlockTileEntity new]
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column - 1
													row:5]];

	/* Level exit. */
	[gameBoard gameBoardTileEntity_add_levelExit_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column
													row:0]];

	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[SMBDeathBlockTileEntity new]
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:[gameBoard gameBoardTiles_numberOfColumns] - 3
													row:[gameBoard gameBoardTiles_numberOfRows] - 4]];

	/* Entity spawners. */
	NSMutableArray<SMBGameBoardTileEntitySpawner*>* const gameBoardTileEntitySpawners = [NSMutableArray<SMBGameBoardTileEntitySpawner*> array];

	NSMutableArray<SMBGameBoardTileEntitySpawner_spawnEntityBlock>* const gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse = [NSMutableArray<SMBGameBoardTileEntitySpawner_spawnEntityBlock> array];
	[gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse addObject:^SMBGameBoardTileEntity * _Nullable{
		return [[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_right];
	}];
	[gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse addObject:^SMBGameBoardTileEntity * _Nullable{
		return [[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_left];
	}];
#warning !!Duplicate entity! Can condense to a single spawner later.
	[gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse addObject:^SMBGameBoardTileEntity * _Nullable{
		return [[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_left];
	}];
	[gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse addObject:^SMBGameBoardTileEntity * _Nullable{
		return [[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_right];
	}];

	[gameBoardTileEntitySpawners addObjectsFromArray:
	 [SMBGameBoardTileEntitySpawner smb_gameBoardTileEntitySpawners_with_spawnedGameBoardTileEntities_tracked_maximum:1
																									spawnEntityBlocks:gameBoardTileEntitySpawner_spawnEntityBlocks_singleUse]];

	/* Game level. */
	return
	[[self alloc] init_with_gameBoard:gameBoard
	gameBoardTileEntitySpawnerManager:
	 [[SMBGameBoardTileEntitySpawnerManager alloc] init_with_gameBoardTileEntitySpawners:gameBoardTileEntitySpawners]];
}

@end
