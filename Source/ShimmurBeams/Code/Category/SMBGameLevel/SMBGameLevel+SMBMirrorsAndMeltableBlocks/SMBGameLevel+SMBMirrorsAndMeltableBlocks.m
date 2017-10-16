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





@implementation SMBGameLevel (SMBMirrorsAndMeltableBlocks)

+(nonnull instancetype)smb_mirrors_introduction
{
	SMBGameBoard* const gameBoard = [[SMBGameBoard alloc] init_with_numberOfColumns:5
																	   numberOfRows:5];

	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_up];

	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
								   to_gameBoardTilePosition:[[SMBGameBoardTilePosition alloc] init_with_column:1
																										   row:3]];

	[gameBoard gameBoardTileEntity_add_levelExit_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 2
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 2]];

	NSMutableArray<SMBGameBoardTileEntity*>* const gameBoardTileEntities = [NSMutableArray<SMBGameBoardTileEntity*> array];
	[gameBoardTileEntities addObject:[[SMBDiagonalMirrorTileEntity alloc] init_with_startingPosition:SMBDiagonalMirrorTileEntity_startingPosition_bottomLeft]];

	return
	[[self alloc] init_with_gameBoard:gameBoard
		  usableGameBoardTileEntities:[NSArray<SMBGameBoardTileEntity*> arrayWithArray:gameBoardTileEntities]];
}

+(nonnull instancetype)smb_mirror_man_in_the_mirror
{
	SMBGameBoard* const gameBoard = [[SMBGameBoard alloc] init_with_numberOfColumns:4
																	   numberOfRows:4];

	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_up];

	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
								   to_gameBoardTilePosition:[[SMBGameBoardTilePosition alloc] init_with_column:2
																										   row:3]];

	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[[SMBDiagonalMirrorTileEntity alloc]init_with_startingPosition:SMBDiagonalMirrorTileEntity_startingPosition_bottomLeft]
								   to_gameBoardTilePosition:[[SMBGameBoardTilePosition alloc]
															 init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column
															 row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 1]];

	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[[SMBDiagonalMirrorTileEntity alloc]init_with_startingPosition:SMBDiagonalMirrorTileEntity_startingPosition_topLeft]
								   to_gameBoardTilePosition:[[SMBGameBoardTilePosition alloc]
															 init_with_column:gameBoard.gameBoardTiles_numberOfColumns - 1
															 row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 3]];

	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[[SMBDiagonalMirrorTileEntity alloc]init_with_startingPosition:SMBDiagonalMirrorTileEntity_startingPosition_bottomLeft]
								   to_gameBoardTilePosition:[[SMBGameBoardTilePosition alloc]
															 init_with_column:0
															 row:0]];

	[gameBoard gameBoardTileEntity_add_wall_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column - 1
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 2]];

	[gameBoard gameBoardTileEntity_add_levelExit_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 2]];

	NSMutableArray<SMBGameBoardTileEntity*>* const gameBoardTileEntities = [NSMutableArray<SMBGameBoardTileEntity*> array];
	[gameBoardTileEntities addObject:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_up]];
	[gameBoardTileEntities addObject:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_right]];

	return
	[[self alloc] init_with_gameBoard:gameBoard
		  usableGameBoardTileEntities:[NSArray<SMBGameBoardTileEntity*> arrayWithArray:gameBoardTileEntities]];
}

#pragma mark - meltableWall
+(nonnull instancetype)smb_meltableWall_introduction
{
	/*
	 Entities:
	 Bc[x]	Beam Creator
	 Mw[x]	Meltable Wall
	 Exi	Level Exit

	 Entity Notes:
	 - Bc1
	 *- direction: up
	 - Mw1
	 *- meltableBeamEnterDirections: all
	 
	 Usable:
	 Diagonal Mirror (startingPosition: bottomLeft)

	 Sections and entities:
	 [   ] [   ] [   ] [   ] [   ]
	 [   ] [   ] [Mw1] [Exi] [   ]
	 [   ] [   ] [   ] [   ] [   ]
	 [   ] [Bc1] [   ] [   ] [   ]
	 [   ] [   ] [   ] [   ] [   ]
	 
	 */

	SMBGameBoard* const gameBoard = [[SMBGameBoard alloc] init_with_numberOfColumns:5
																	   numberOfRows:5];

	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_up];

	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
								   to_gameBoardTilePosition:[[SMBGameBoardTilePosition alloc] init_with_column:1
																										   row:3]];

	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[[SMBMeltableWallTileEntity alloc] init_with_meltableBeamEnterDirections:SMBGameBoardTile__directions_all()]
								   to_gameBoardTilePosition:[[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 1
																										   row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 2]];

	[gameBoard gameBoardTileEntity_add_levelExit_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 2
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 2]];

	NSMutableArray<SMBGameBoardTileEntity*>* const gameBoardTileEntities = [NSMutableArray<SMBGameBoardTileEntity*> array];
	[gameBoardTileEntities addObject:[[SMBDiagonalMirrorTileEntity alloc] init_with_startingPosition:SMBDiagonalMirrorTileEntity_startingPosition_bottomLeft]];

	return
	[[self alloc] init_with_gameBoard:gameBoard
		  usableGameBoardTileEntities:[NSArray<SMBGameBoardTileEntity*> arrayWithArray:gameBoardTileEntities]];
}

@end
