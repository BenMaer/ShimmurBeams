//
//  SMBGameLevel+SMBTestLevel.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/4/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameLevel+SMBTestLevel.h"
#import "SMBGameBoard.h"
#import "SMBBeamCreatorTileEntity.h"
#import "SMBGameBoard+SMBAddEntity.h"
#import "SMBForcedBeamRedirectTileEntity.h"
#import "SMBGameBoardTile.h"
#import "SMBGameBoardTilePosition.h"





@implementation SMBGameLevel (SMBTestLevel)

#pragma mark - testLevel
+(nonnull instancetype)smb_testLevel_oneForce_right
{
	SMBGameBoard* const gameBoard = [[SMBGameBoard alloc] init_with_numberOfColumns:5
																	   numberOfRows:5];

	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_up];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
												  to_column:1
														row:[gameBoard gameBoardTiles_numberOfRows] - 2];

	[gameBoard gameBoardTileEntity_add_levelExit_to_column:[gameBoard gameBoardTiles_numberOfColumns] - 2
													   row:1];

	NSMutableArray<SMBGameBoardTileEntity*>* const gameBoardTileEntity = [NSMutableArray<SMBGameBoardTileEntity*> array];

	SMBForcedBeamRedirectTileEntity* const forcedBeamRedirectTileEntity_right = [[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_right];
	[gameBoardTileEntity addObject:forcedBeamRedirectTileEntity_right];

	return
	[[self alloc] init_with_gameBoard:gameBoard
		  usableGameBoardTileEntities:[NSArray<SMBGameBoardTileEntity*> arrayWithArray:gameBoardTileEntity]];
}

+(nonnull instancetype)smb_testLevel_twoForces_leftThenDown
{
	SMBGameBoard* const gameBoard = [[SMBGameBoard alloc] init_with_numberOfColumns:5
																	   numberOfRows:5];

	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_up];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
												  to_column:[gameBoard gameBoardTiles_numberOfColumns] - 2
														row:3];

	[gameBoard gameBoardTileEntity_add_levelExit_to_column:1
													   row:[gameBoard gameBoardTiles_numberOfRows] - 2];

	NSMutableArray<SMBGameBoardTileEntity*>* const gameBoardTileEntity = [NSMutableArray<SMBGameBoardTileEntity*> array];

	SMBForcedBeamRedirectTileEntity* const forcedBeamRedirectTileEntity_left = [[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_left];
	[gameBoardTileEntity addObject:forcedBeamRedirectTileEntity_left];

	SMBForcedBeamRedirectTileEntity* const forcedBeamRedirectTileEntity_down = [[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_down];
	[gameBoardTileEntity addObject:forcedBeamRedirectTileEntity_down];

	return
	[[self alloc] init_with_gameBoard:gameBoard
		  usableGameBoardTileEntities:[NSArray<SMBGameBoardTileEntity*> arrayWithArray:gameBoardTileEntity]];
}

+(nonnull instancetype)smb_testLevel_oneWall_threeForces
{
	SMBGameBoard* const gameBoard = [[SMBGameBoard alloc] init_with_numberOfColumns:5
																	   numberOfRows:5];

	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_up];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
												  to_column:2
														row:[gameBoard gameBoardTiles_numberOfRows] - 1];

	[gameBoard gameBoardTileEntity_add_wall_to_column:2
												  row:2];

	[gameBoard gameBoardTileEntity_add_levelExit_to_column:2
													   row:0];

	NSMutableArray<SMBGameBoardTileEntity*>* const gameBoardTileEntity = [NSMutableArray<SMBGameBoardTileEntity*> array];

	SMBForcedBeamRedirectTileEntity* const forcedBeamRedirectTileEntity_right = [[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_right];
	[gameBoardTileEntity addObject:forcedBeamRedirectTileEntity_right];

	SMBForcedBeamRedirectTileEntity* const forcedBeamRedirectTileEntity_up = [[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_up];
	[gameBoardTileEntity addObject:forcedBeamRedirectTileEntity_up];

	SMBForcedBeamRedirectTileEntity* const forcedBeamRedirectTileEntity_left = [[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_left];
	[gameBoardTileEntity addObject:forcedBeamRedirectTileEntity_left];

	return
	[[self alloc] init_with_gameBoard:gameBoard
		  usableGameBoardTileEntities:[NSArray<SMBGameBoardTileEntity*> arrayWithArray:gameBoardTileEntity]];
}

+(nonnull instancetype)smb_testLevel_twoWalls_threeForces
{
	SMBGameBoard* const gameBoard = [[SMBGameBoard alloc] init_with_numberOfColumns:5
																	   numberOfRows:5];

	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_up];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
												  to_column:2
														row:[gameBoard gameBoardTiles_numberOfRows] - 1];

	[gameBoard gameBoardTileEntity_add_wall_to_column:2
												  row:2];

	[gameBoard gameBoardTileEntity_add_wall_to_column:[gameBoard gameBoardTiles_numberOfColumns] - 1
												  row:2];

	[gameBoard gameBoardTileEntity_add_levelExit_to_column:[gameBoard gameBoardTiles_numberOfColumns] - 1
													   row:0];

	NSMutableArray<SMBGameBoardTileEntity*>* const gameBoardTileEntity = [NSMutableArray<SMBGameBoardTileEntity*> array];

	SMBForcedBeamRedirectTileEntity* const forcedBeamRedirectTileEntity_left = [[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_left];
	[gameBoardTileEntity addObject:forcedBeamRedirectTileEntity_left];

	SMBForcedBeamRedirectTileEntity* const forcedBeamRedirectTileEntity_up = [[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_up];
	[gameBoardTileEntity addObject:forcedBeamRedirectTileEntity_up];

	SMBForcedBeamRedirectTileEntity* const forcedBeamRedirectTileEntity_right = [[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_right];
	[gameBoardTileEntity addObject:forcedBeamRedirectTileEntity_right];

	return
	[[self alloc] init_with_gameBoard:gameBoard
		  usableGameBoardTileEntities:[NSArray<SMBGameBoardTileEntity*> arrayWithArray:gameBoardTileEntity]];
}

+(nonnull instancetype)smb_testLevel_wallsAndForces_twoForcesNotMovable
{
	SMBGameBoard* const gameBoard = [[SMBGameBoard alloc] init_with_numberOfColumns:11
																	   numberOfRows:11];

	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_up];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
												  to_column:floor(([gameBoard gameBoardTiles_numberOfColumns] - 1) / 2.0f)
														row:[gameBoard gameBoardTiles_numberOfRows] - 1];

	[gameBoard gameBoardTileEntity_add_wall_to_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column - 1
												  row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 2];

	[gameBoard gameBoardTileEntity_add_wall_to_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 1
												  row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 2];

	[gameBoard gameBoardTileEntity_add_wall_to_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column - 3
												  row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 3];
	
	[gameBoard gameBoardTileEntity_add_wall_to_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 3
												  row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 3];

	[gameBoard gameBoardTileEntity_add_wall_to_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column
												  row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 4];

	[gameBoard gameBoardTileEntity_add_wall_to_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column - 1
												  row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 5];

	[gameBoard gameBoardTileEntity_add_wall_to_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 1
												  row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 5];

	[gameBoard gameBoardTileEntity_add_wall_to_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column
												  row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 6];

	[gameBoard gameBoardTileEntity_add_wall_to_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column - 2
												  row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 7];
	
	[gameBoard gameBoardTileEntity_add_wall_to_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 2
												  row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 7];

	[gameBoard gameBoardTileEntity_add_wall_to_column:0
												  row:0];

	[gameBoard gameBoardTileEntity_add_wall_to_column:[gameBoard gameBoardTiles_numberOfColumns] - 1
												  row:0];

	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_left]
												  to_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 2
														row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 6];

	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_up]
												  to_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column - 1
														row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 6];

	[gameBoard gameBoardTileEntity_add_levelExit_to_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column
													   row:0];

	NSMutableArray<SMBGameBoardTileEntity*>* const gameBoardTileEntity = [NSMutableArray<SMBGameBoardTileEntity*> array];

	[gameBoardTileEntity addObject:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_right]];
	[gameBoardTileEntity addObject:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_up]];
	[gameBoardTileEntity addObject:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_right]];
	[gameBoardTileEntity addObject:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_left]];

	return
	[[self alloc] init_with_gameBoard:gameBoard
		  usableGameBoardTileEntities:[NSArray<SMBGameBoardTileEntity*> arrayWithArray:gameBoardTileEntity]];
}

+(nonnull instancetype)smb_testLevel_clover
{
	SMBGameBoard* const gameBoard = [[SMBGameBoard alloc] init_with_numberOfColumns:5
																	   numberOfRows:5];

	SMBBeamCreatorTileEntity* const beamCreatorEntity_top = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity_top setBeamDirection:SMBGameBoardTile__direction_up];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity_top
												  to_column:2
														row:1];

	SMBBeamCreatorTileEntity* const beamCreatorEntity_right = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity_right setBeamDirection:SMBGameBoardTile__direction_right];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity_right
												  to_column:3
														row:2];

	SMBBeamCreatorTileEntity* const beamCreatorEntity_down = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity_down setBeamDirection:SMBGameBoardTile__direction_down];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity_down
												  to_column:2
														row:3];

	SMBBeamCreatorTileEntity* const beamCreatorEntity_left = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity_left setBeamDirection:SMBGameBoardTile__direction_left];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity_left
												  to_column:1
														row:2];

	return
	[[self alloc] init_with_gameBoard:gameBoard
		  usableGameBoardTileEntities:nil];
}

@end
