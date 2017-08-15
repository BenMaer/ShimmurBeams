//
//  SMBGameLevel+SMBForcedRedirectsAndWalls.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/14/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameLevel+SMBForcedRedirectsAndWalls.h"
#import "SMBGameBoard.h"
#import "SMBBeamCreatorTileEntity.h"
#import "SMBGameBoard+SMBAddEntity.h"
#import "SMBForcedBeamRedirectTileEntity.h"
#import "SMBGameBoardTile.h"
#import "SMBGameBoardTilePosition.h"





@implementation SMBGameLevel (SMBForcedRedirectsAndWalls)

#pragma mark - forcedRedirectsAndWalls
+(nonnull instancetype)smb_forcedRedirects_oneForce_right
{
	SMBGameBoard* const gameBoard = [[SMBGameBoard alloc] init_with_numberOfColumns:5
																	   numberOfRows:5];

	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_up];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:1
													row:[gameBoard gameBoardTiles_numberOfRows] - 2]];

	[gameBoard gameBoardTileEntity_add_levelExit_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:[gameBoard gameBoardTiles_numberOfColumns] - 2
										   row:1]];

	NSMutableArray<SMBGameBoardTileEntity*>* const gameBoardTileEntities = [NSMutableArray<SMBGameBoardTileEntity*> array];

	SMBForcedBeamRedirectTileEntity* const forcedBeamRedirectTileEntity_right = [[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_right];
	[gameBoardTileEntities addObject:forcedBeamRedirectTileEntity_right];

	return
	[[self alloc] init_with_gameBoard:gameBoard
		  usableGameBoardTileEntities:[NSArray<SMBGameBoardTileEntity*> arrayWithArray:gameBoardTileEntity]];
}

+(nonnull instancetype)smb_forcedRedirects_twoForces_leftThenDown
{
	SMBGameBoard* const gameBoard = [[SMBGameBoard alloc] init_with_numberOfColumns:5
																	   numberOfRows:5];

	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_up];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
									  to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:[gameBoard gameBoardTiles_numberOfColumns] - 2
													row:3]];

	[gameBoard gameBoardTileEntity_add_levelExit_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:1
										   row:[gameBoard gameBoardTiles_numberOfRows] - 2]];

	NSMutableArray<SMBGameBoardTileEntity*>* const gameBoardTileEntities = [NSMutableArray<SMBGameBoardTileEntity*> array];

	SMBForcedBeamRedirectTileEntity* const forcedBeamRedirectTileEntity_left = [[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_left];
	[gameBoardTileEntities addObject:forcedBeamRedirectTileEntity_left];

	SMBForcedBeamRedirectTileEntity* const forcedBeamRedirectTileEntity_down = [[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_down];
	[gameBoardTileEntities addObject:forcedBeamRedirectTileEntity_down];

	return
	[[self alloc] init_with_gameBoard:gameBoard
		  usableGameBoardTileEntities:[NSArray<SMBGameBoardTileEntity*> arrayWithArray:gameBoardTileEntity]];
}

+(nonnull instancetype)smb_forcedRedirectsAndWalls_oneWall_threeForces
{
	SMBGameBoard* const gameBoard = [[SMBGameBoard alloc] init_with_numberOfColumns:5
																	   numberOfRows:5];

	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_up];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
									  to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:2
													row:[gameBoard gameBoardTiles_numberOfRows] - 1]];

	[gameBoard gameBoardTileEntity_add_wall_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:2
													row:2]];

	[gameBoard gameBoardTileEntity_add_levelExit_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:2
										   row:0]];

	NSMutableArray<SMBGameBoardTileEntity*>* const gameBoardTileEntities = [NSMutableArray<SMBGameBoardTileEntity*> array];

	SMBForcedBeamRedirectTileEntity* const forcedBeamRedirectTileEntity_right = [[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_right];
	[gameBoardTileEntities addObject:forcedBeamRedirectTileEntity_right];

	SMBForcedBeamRedirectTileEntity* const forcedBeamRedirectTileEntity_up = [[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_up];
	[gameBoardTileEntities addObject:forcedBeamRedirectTileEntity_up];

	SMBForcedBeamRedirectTileEntity* const forcedBeamRedirectTileEntity_left = [[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_left];
	[gameBoardTileEntities addObject:forcedBeamRedirectTileEntity_left];

	return
	[[self alloc] init_with_gameBoard:gameBoard
		  usableGameBoardTileEntities:[NSArray<SMBGameBoardTileEntity*> arrayWithArray:gameBoardTileEntity]];
}

+(nonnull instancetype)smb_forcedRedirectsAndWalls_twoWalls_threeForces
{
	SMBGameBoard* const gameBoard = [[SMBGameBoard alloc] init_with_numberOfColumns:5
																	   numberOfRows:5];

	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_up];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
									  to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:2
													row:[gameBoard gameBoardTiles_numberOfRows] - 1]];

	[gameBoard gameBoardTileEntity_add_wall_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:2
													row:2]];

	[gameBoard gameBoardTileEntity_add_wall_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:[gameBoard gameBoardTiles_numberOfColumns] - 1
													row:2]];

	[gameBoard gameBoardTileEntity_add_levelExit_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:[gameBoard gameBoardTiles_numberOfColumns] - 1
										   row:0]];

	NSMutableArray<SMBGameBoardTileEntity*>* const gameBoardTileEntities = [NSMutableArray<SMBGameBoardTileEntity*> array];

	SMBForcedBeamRedirectTileEntity* const forcedBeamRedirectTileEntity_left = [[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_left];
	[gameBoardTileEntities addObject:forcedBeamRedirectTileEntity_left];

	SMBForcedBeamRedirectTileEntity* const forcedBeamRedirectTileEntity_up = [[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_up];
	[gameBoardTileEntities addObject:forcedBeamRedirectTileEntity_up];

	SMBForcedBeamRedirectTileEntity* const forcedBeamRedirectTileEntity_right = [[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_right];
	[gameBoardTileEntities addObject:forcedBeamRedirectTileEntity_right];

	return
	[[self alloc] init_with_gameBoard:gameBoard
		  usableGameBoardTileEntities:[NSArray<SMBGameBoardTileEntity*> arrayWithArray:gameBoardTileEntity]];
}

+(nonnull instancetype)smb_forcedRedirectsAndWalls_wallsAndForces_twoForcesNotMovable_tricky
{
	SMBGameBoard* const gameBoard = [[SMBGameBoard alloc] init_with_numberOfColumns:11
																	   numberOfRows:11];

	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_up];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
									  to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:floor(([gameBoard gameBoardTiles_numberOfColumns] - 1) / 2.0f)
													row:[gameBoard gameBoardTiles_numberOfRows] - 1]];

	[gameBoard gameBoardTileEntity_add_wall_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column - 1
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 2]];

	[gameBoard gameBoardTileEntity_add_wall_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 1
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 2]];

	[gameBoard gameBoardTileEntity_add_wall_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column - 3
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 3]];

	[gameBoard gameBoardTileEntity_add_wall_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 3
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 3]];

	[gameBoard gameBoardTileEntity_add_wall_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 4]];

	[gameBoard gameBoardTileEntity_add_wall_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column - 1
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 5]];

	[gameBoard gameBoardTileEntity_add_wall_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 1
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 5]];

	[gameBoard gameBoardTileEntity_add_wall_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 6]];

	[gameBoard gameBoardTileEntity_add_wall_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column - 2
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 7]];

	[gameBoard gameBoardTileEntity_add_wall_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 2
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 7]];

	[gameBoard gameBoardTileEntity_add_wall_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:0
													row:0]];

	[gameBoard gameBoardTileEntity_add_wall_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:[gameBoard gameBoardTiles_numberOfColumns] - 1
													row:0]];

	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_left]
									  to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 2
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 6]];

	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_up]
									  to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column - 1
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 6]];

	[gameBoard gameBoardTileEntity_add_levelExit_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column
										   row:0]];

	NSMutableArray<SMBGameBoardTileEntity*>* const gameBoardTileEntities = [NSMutableArray<SMBGameBoardTileEntity*> array];

	[gameBoardTileEntities addObject:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_right]];
	[gameBoardTileEntities addObject:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_up]];
	[gameBoardTileEntities addObject:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_right]];
	[gameBoardTileEntities addObject:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_left]];

	return
	[[self alloc] init_with_gameBoard:gameBoard
		  usableGameBoardTileEntities:[NSArray<SMBGameBoardTileEntity*> arrayWithArray:gameBoardTileEntity]];
}

#pragma mark - forces not movable
+(nonnull instancetype)smb_forcedRedirects_oneForceNotMovable
{
	SMBGameBoard* const gameBoard = [[SMBGameBoard alloc] init_with_numberOfColumns:5
																	   numberOfRows:5];

	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_up];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
									  to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:floor(([gameBoard gameBoardTiles_numberOfColumns] - 1) / 2.0f)
													row:[gameBoard gameBoardTiles_numberOfRows] - 1]];

	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_right]
									  to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 2]];

	[gameBoard gameBoardTileEntity_add_levelExit_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column
										   row:0]];

	NSMutableArray<SMBGameBoardTileEntity*>* const gameBoardTileEntities = [NSMutableArray<SMBGameBoardTileEntity*> array];

	[gameBoardTileEntities addObject:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_up]];
	[gameBoardTileEntities addObject:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_left]];

	return
	[[self alloc] init_with_gameBoard:gameBoard
		  usableGameBoardTileEntities:[NSArray<SMBGameBoardTileEntity*> arrayWithArray:gameBoardTileEntity]];
}

+(nonnull instancetype)smb_forcedRedirects_wallsAndForces_threeForcesNotMovable
{
	SMBGameBoard* const gameBoard = [[SMBGameBoard alloc] init_with_numberOfColumns:7
																	   numberOfRows:7];

	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_up];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
									  to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:floor(([gameBoard gameBoardTiles_numberOfColumns] - 1) / 2.0f)
													row:[gameBoard gameBoardTiles_numberOfRows] - 1]];

	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_left]
									  to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 3]];

	[gameBoard gameBoardTileEntity_add_wall_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:2
													row:0]];

	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_right]
									  to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column - 2
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 5]];

	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_left]
									  to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 3
													row:0]];

	[gameBoard gameBoardTileEntity_add_levelExit_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column
										   row:0]];

	NSMutableArray<SMBGameBoardTileEntity*>* const gameBoardTileEntities = [NSMutableArray<SMBGameBoardTileEntity*> array];

	[gameBoardTileEntities addObject:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_up]];
	[gameBoardTileEntities addObject:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_right]];

	return
	[[self alloc] init_with_gameBoard:gameBoard
		  usableGameBoardTileEntities:[NSArray<SMBGameBoardTileEntity*> arrayWithArray:gameBoardTileEntity]];
}

@end
