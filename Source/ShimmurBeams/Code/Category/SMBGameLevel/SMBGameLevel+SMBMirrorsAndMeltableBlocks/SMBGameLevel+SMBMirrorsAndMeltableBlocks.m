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
	 Exi	Level Exit
	 Mw[x]	Meltable Wall

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

	/* Game board. */

	SMBGameBoard* const gameBoard = [[SMBGameBoard alloc] init_with_numberOfColumns:5
																	   numberOfRows:5];

	/* Initial beam creator. */

	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_up];

	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
								   to_gameBoardTilePosition:[[SMBGameBoardTilePosition alloc] init_with_column:1
																										   row:3]];

	/* Meltable Wall. */

	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[[SMBMeltableWallTileEntity alloc] init_with_meltableBeamEnterDirections:SMBGameBoardTile__directions_all()]
								   to_gameBoardTilePosition:[[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 1
																										   row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 2]];

	/* Level exit. */

	[gameBoard gameBoardTileEntity_add_levelExit_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 2
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 2]];

	/* Usable game board tile entities. */

	NSMutableArray<SMBGameBoardTileEntity*>* const gameBoardTileEntities = [NSMutableArray<SMBGameBoardTileEntity*> array];
	[gameBoardTileEntities addObject:[[SMBDiagonalMirrorTileEntity alloc] init_with_startingPosition:SMBDiagonalMirrorTileEntity_startingPosition_bottomLeft]];

	return
	[[self alloc] init_with_gameBoard:gameBoard
		  usableGameBoardTileEntities:[NSArray<SMBGameBoardTileEntity*> arrayWithArray:gameBoardTileEntities]];
}

+(nonnull instancetype)smb_meltableWall_oneDirection
{
	/*
	 Entities:
	 Bc[x]	Beam Creator
	 Exi	Level Exit
	 Dm[x]	Diagonal Mirror
	 Mw[x]	Meltable Wall

	 Entity Notes:
	 - Bc1
	 *- direction: up
	 - Dm1
	 *- startingPosition: bottomLeft
	 - Dm2
	 *- startingPosition: bottomLeft
	 - Dm3
	 *- startingPosition: bottomLeft
	 - Dm4
	 *- startingPosition: bottomLeft
	 - Mw1
	 *- meltableBeamEnterDirections: bottom

	 Usable:
	 Diagonal Mirror (startingPosition: bottomLeft)

	 Sections and entities:
	 [   ] [   ] [Dm4] [Exi] [   ]
	 [   ] [Dm1] [Mw1] [Dm2] [   ]
	 [   ] [   ] [Dm3] [   ] [   ]
	 [   ] [Bc1] [   ] [   ] [   ]
	 [   ] [   ] [   ] [   ] [   ]

	 */

	/* Game board. */

	SMBGameBoard* const gameBoard = [[SMBGameBoard alloc] init_with_numberOfColumns:5
																	   numberOfRows:5];

	/* Initial beam creator. */

	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_up];

	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
								   to_gameBoardTilePosition:[[SMBGameBoardTilePosition alloc] init_with_column:1
																										   row:3]];

	/* Meltable Wall. */

	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[[SMBMeltableWallTileEntity alloc] init_with_meltableBeamEnterDirections:SMBGameBoardTile__direction_down]
								   to_gameBoardTilePosition:[[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 1
																										   row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 2]];

	/* Diagonal Mirrors */

	/* Dm1, 1x1 */
	[gameBoard gameBoardTileEntity_add:[[SMBDiagonalMirrorTileEntity alloc] init_with_startingPosition:SMBDiagonalMirrorTileEntity_startingPosition_bottomLeft]
							entityType:SMBGameBoardTile__entityType_beamInteractions
			  to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 2]];

	/* Dm2, 3x1 */
	[gameBoard gameBoardTileEntity_add:[[SMBDiagonalMirrorTileEntity alloc] init_with_startingPosition:SMBDiagonalMirrorTileEntity_startingPosition_bottomLeft]
							entityType:SMBGameBoardTile__entityType_beamInteractions
			  to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 2
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 2]];

	/* Dm3, 2x2 */
	[gameBoard gameBoardTileEntity_add:[[SMBDiagonalMirrorTileEntity alloc] init_with_startingPosition:SMBDiagonalMirrorTileEntity_startingPosition_bottomLeft]
							entityType:SMBGameBoardTile__entityType_beamInteractions
			  to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 1
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 1]];

	/* Dm4, 2x0 */
	[gameBoard gameBoardTileEntity_add:[[SMBDiagonalMirrorTileEntity alloc] init_with_startingPosition:SMBDiagonalMirrorTileEntity_startingPosition_bottomLeft]
							entityType:SMBGameBoardTile__entityType_beamInteractions
			  to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 1
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 3]];

	/* Level exit. */

	[gameBoard gameBoardTileEntity_add_levelExit_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 2
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 3]];

	/* Usable game board tile entities. */

	NSMutableArray<SMBGameBoardTileEntity*>* const gameBoardTileEntities = [NSMutableArray<SMBGameBoardTileEntity*> array];
	[gameBoardTileEntities addObject:[[SMBDiagonalMirrorTileEntity alloc] init_with_startingPosition:SMBDiagonalMirrorTileEntity_startingPosition_bottomLeft]];

	return
	[[self alloc] init_with_gameBoard:gameBoard
		  usableGameBoardTileEntities:[NSArray<SMBGameBoardTileEntity*> arrayWithArray:gameBoardTileEntities]];
}

+(nonnull instancetype)smb_meltableWall_inTheWay
{
	/*
	 Entities:
	 Bc[x]	Beam Creator
	 Exi	Level Exit
	 Wal	Wall
	 Br[x]	Beam rotation
	 Dm[x]	Diagonal Mirror
	 Mw[x]	Meltable Wall
	 
	 Entity Notes:
	 - Bc1
	 *- direction: up
	 - Br1
	 *- direction_rotation: right
	 - Br2
	 *- direction_rotation: right
	 - Fr1
	 *- direction: right
	 - Fr2
	 *- direction: left
	 - Fr3
	 *- direction: right
	 - Dm1
	 *- startingPosition: topLeft
	 - Mw1
	 *- meltableBeamEnterDirections: top
	 - Mw2
	 *- meltableBeamEnterDirections: right

	 Usable:
	 Diagonal Mirror (startingPosition: bottomLeft)
	 Beam Rotation (direction_rotation: right)
	 Forced Redirect (direction: down)

	 Sections and entities:
	 [   ] [   ] [   ] [   ] [   ] [Dm1] [   ]
	 [Fr1] [Br1] [Fr2] [   ] [   ] [   ] [   ]
	 [   ] [   ] [   ] [Wal] [Wal] [   ] [Wal]
	 [   ] [Mw1] [   ] [Wal] [   ] [   ] [Exi]
	 [   ] [   ] [   ] [Mw2] [Br2] [   ] [   ]
	 [   ] [Bc1] [   ] [   ] [Fr3] [   ] [   ]
	 
	 */
	
	/* Game board. */
	
	SMBGameBoard* const gameBoard = [[SMBGameBoard alloc] init_with_numberOfColumns:7
																	   numberOfRows:6];

	/* Initial beam creator. */
	
	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_up];
	
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
								   to_gameBoardTilePosition:[[SMBGameBoardTilePosition alloc] init_with_column:1
//								   to_gameBoardTilePosition:[[SMBGameBoardTilePosition alloc] init_with_column:floor([gameBoard gameBoardTiles_numberOfColumns] / 2.0f)
																										   row:[gameBoard gameBoardTiles_numberOfRows] - 1]];

	/* Walls. */

	[gameBoard gameBoardTileEntity_add_wall_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 2
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 3]];

	[gameBoard gameBoardTileEntity_add_wall_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 2
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 2]];

	[gameBoard gameBoardTileEntity_add_wall_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 3
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 3]];

	[gameBoard gameBoardTileEntity_add_wall_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:[gameBoard gameBoardTiles_numberOfColumns] - 1
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 3]];

	/* Meltable Wall. */

	/* Mw1 */
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[[SMBMeltableWallTileEntity alloc] init_with_meltableBeamEnterDirections:SMBGameBoardTile__direction_up]
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 2]];

	/* Mw2 */
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[[SMBMeltableWallTileEntity alloc] init_with_meltableBeamEnterDirections:SMBGameBoardTile__direction_right]
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 2
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 1]];

	/* Forced redirects. */
	
	/* Fr1 */
	[gameBoard gameBoardTileEntity_add:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_right]
							entityType:SMBGameBoardTile__entityType_beamInteractions
			  to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column - 1
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 4]];

	/* Fr2 */
	[gameBoard gameBoardTileEntity_add:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_left]
							entityType:SMBGameBoardTile__entityType_beamInteractions
			  to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 1
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 4]];

	/* Fr3 */
	[gameBoard gameBoardTileEntity_add:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_right]
							entityType:SMBGameBoardTile__entityType_beamInteractions
			  to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 3
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row]];

	/* Beam rotations. */

	/* Br1 */
	[gameBoard gameBoardTileEntity_add:[[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_right]
							entityType:SMBGameBoardTile__entityType_beamInteractions
			  to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 4]];

	/* Br2 */
	[gameBoard gameBoardTileEntity_add:[[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_right]
							entityType:SMBGameBoardTile__entityType_beamInteractions
			  to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 3
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 1]];

	/* Diagonal Mirrors. */

	/* Dm1 */
	[gameBoard gameBoardTileEntity_add:[[SMBDiagonalMirrorTileEntity alloc] init_with_startingPosition:SMBDiagonalMirrorTileEntity_startingPosition_topLeft]
							entityType:SMBGameBoardTile__entityType_beamInteractions
			  to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 4
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 5]];

	/* Level exit. */
	
	[gameBoard gameBoardTileEntity_add_levelExit_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 5
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 2]];

	/* Usable game board tile entities. */
	
	NSMutableArray<SMBGameBoardTileEntity*>* const gameBoardTileEntities = [NSMutableArray<SMBGameBoardTileEntity*> array];
	[gameBoardTileEntities addObject:[[SMBDiagonalMirrorTileEntity alloc] init_with_startingPosition:SMBDiagonalMirrorTileEntity_startingPosition_bottomLeft]];
	[gameBoardTileEntities addObject:[[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_right]];
	[gameBoardTileEntities addObject:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_down]];

	return
	[[self alloc] init_with_gameBoard:gameBoard
		  usableGameBoardTileEntities:[NSArray<SMBGameBoardTileEntity*> arrayWithArray:gameBoardTileEntities]];
}

@end
