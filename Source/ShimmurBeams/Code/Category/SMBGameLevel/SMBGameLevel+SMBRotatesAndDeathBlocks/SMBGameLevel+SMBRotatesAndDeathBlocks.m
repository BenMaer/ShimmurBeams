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





@implementation SMBGameLevel (SMBRotatesAndDeathBlocks)

+(nonnull instancetype)smb_rotates_oneRotate_right
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

	SMBBeamRotateTileEntity* const beamRotateTileEntity_right = [[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_right];
	[gameBoardTileEntity addObject:beamRotateTileEntity_right];

	return
	[[self alloc] init_with_gameBoard:gameBoard
		  usableGameBoardTileEntities:[NSArray<SMBGameBoardTileEntity*> arrayWithArray:gameBoardTileEntity]];
}

+(nonnull instancetype)smb_rotates_two_left
{
	SMBGameBoard* const gameBoard = [[SMBGameBoard alloc] init_with_numberOfColumns:5
																	   numberOfRows:5];

	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_up];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
												  to_column:[gameBoard gameBoardTiles_numberOfColumns] - 2
														row:[gameBoard gameBoardTiles_numberOfRows] - 2];

	[gameBoard gameBoardTileEntity_add_levelExit_to_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column - 2
													   row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row];

	NSMutableArray<SMBGameBoardTileEntity*>* const gameBoardTileEntity = [NSMutableArray<SMBGameBoardTileEntity*> array];

	[gameBoardTileEntity addObject:[[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_left]];

	[gameBoardTileEntity addObject:[[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_left]];

	return
	[[self alloc] init_with_gameBoard:gameBoard
		  usableGameBoardTileEntities:[NSArray<SMBGameBoardTileEntity*> arrayWithArray:gameBoardTileEntity]];
}

#pragma mark - rotates and forced
+(nonnull instancetype)smb_rotates_oneLeft_forced_oneLeft
{
	SMBGameBoard* const gameBoard = [[SMBGameBoard alloc] init_with_numberOfColumns:5
																	   numberOfRows:5];

	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_up];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
												  to_column:[gameBoard gameBoardTiles_numberOfColumns] - 2
														row:[gameBoard gameBoardTiles_numberOfRows] - 2];

	[gameBoard gameBoardTileEntity_add_levelExit_to_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column - 2
													   row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row];

	NSMutableArray<SMBGameBoardTileEntity*>* const gameBoardTileEntity = [NSMutableArray<SMBGameBoardTileEntity*> array];

	[gameBoardTileEntity addObject:[[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_left]];

	[gameBoardTileEntity addObject:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_left]];

	return
	[[self alloc] init_with_gameBoard:gameBoard
		  usableGameBoardTileEntities:[NSArray<SMBGameBoardTileEntity*> arrayWithArray:gameBoardTileEntity]];
}

#pragma mark - rotates and wall
+(nonnull instancetype)smb_rotates_oneLeft_twoRight_wall_oneCenter
{
	SMBGameBoard* const gameBoard = [[SMBGameBoard alloc] init_with_numberOfColumns:7
																	   numberOfRows:7];
	
	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_up];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
												  to_column:floor((CGFloat)[gameBoard gameBoardTiles_numberOfColumns] / 2.0f)
														row:[gameBoard gameBoardTiles_numberOfRows] - 1];

	[gameBoard gameBoardTileEntity_add_wall_to_column:floor((CGFloat)[gameBoard gameBoardTiles_numberOfColumns] / 2.0f)
												  row:floor((CGFloat)[gameBoard gameBoardTiles_numberOfRows] / 2.0f)];

	[gameBoard gameBoardTileEntity_add_levelExit_to_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column
													   row:0];
	
	NSMutableArray<SMBGameBoardTileEntity*>* const gameBoardTileEntity = [NSMutableArray<SMBGameBoardTileEntity*> array];
	
	[gameBoardTileEntity addObject:[[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_right]];
	[gameBoardTileEntity addObject:[[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_left]];
	[gameBoardTileEntity addObject:[[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_right]];
	
	return
	[[self alloc] init_with_gameBoard:gameBoard
		  usableGameBoardTileEntities:[NSArray<SMBGameBoardTileEntity*> arrayWithArray:gameBoardTileEntity]];
}

#pragma mark - rotates and death block
+(nonnull instancetype)smb_rotates_twoRight_deathBlock_one
{
	SMBGameBoard* const gameBoard = [[SMBGameBoard alloc] init_with_numberOfColumns:7
																	   numberOfRows:7];
	
	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_up];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
												  to_column:1
														row:[gameBoard gameBoardTiles_numberOfRows] - 2];

	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[SMBDeathBlockTileEntity new]
												  to_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 2
														row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 2];

	[gameBoard gameBoardTileEntity_add_levelExit_to_column:[gameBoard gameBoardTiles_numberOfColumns] - 2
													   row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 2];
	
	NSMutableArray<SMBGameBoardTileEntity*>* const gameBoardTileEntity = [NSMutableArray<SMBGameBoardTileEntity*> array];
	
	[gameBoardTileEntity addObject:[[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_right]];
	[gameBoardTileEntity addObject:[[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_right]];
	
	return
	[[self alloc] init_with_gameBoard:gameBoard
		  usableGameBoardTileEntities:[NSArray<SMBGameBoardTileEntity*> arrayWithArray:gameBoardTileEntity]];
}

@end
