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





@implementation SMBGameLevel (SMBTestLevel)

#pragma mark - testLevel
+(nonnull instancetype)smb_testLevel
{
	SMBGameBoard* const gameBoard = [[SMBGameBoard alloc] init_with_numberOfColumns:5
																	   numberOfRows:5];

	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_up];
	[gameBoard gameBoardEntity_add:beamCreatorEntity
						 to_column:1
							   row:[gameBoard gameBoardTiles_numberOfRows] - 1];

	SMBForcedBeamRedirectTileEntity* const forcedBeamRedirectTileEntity = [[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_right];
	[gameBoard gameBoardEntity_add:forcedBeamRedirectTileEntity
						 to_column:1
							   row:1];

	SMBForcedBeamRedirectTileEntity* const forcedBeamRedirectTileEntity2 = [[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_down];
	[gameBoard gameBoardEntity_add:forcedBeamRedirectTileEntity2
						 to_column:3
							   row:1];

	return [[self alloc] init_with_gameBoard:gameBoard];
}

+(nonnull instancetype)smb_testLevel_clover
{
	SMBGameBoard* const gameBoard = [[SMBGameBoard alloc] init_with_numberOfColumns:5
																	   numberOfRows:5];

	SMBBeamCreatorTileEntity* const beamCreatorEntity_top = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity_top setBeamDirection:SMBGameBoardTile__direction_up];
	[gameBoard gameBoardEntity_add:beamCreatorEntity_top
						 to_column:2
							   row:1];

	SMBBeamCreatorTileEntity* const beamCreatorEntity_right = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity_right setBeamDirection:SMBGameBoardTile__direction_right];
	[gameBoard gameBoardEntity_add:beamCreatorEntity_right
						 to_column:3
							   row:2];

	SMBBeamCreatorTileEntity* const beamCreatorEntity_down = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity_down setBeamDirection:SMBGameBoardTile__direction_down];
	[gameBoard gameBoardEntity_add:beamCreatorEntity_down
						 to_column:2
							   row:3];

	SMBBeamCreatorTileEntity* const beamCreatorEntity_left = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity_left setBeamDirection:SMBGameBoardTile__direction_left];
	[gameBoard gameBoardEntity_add:beamCreatorEntity_left
						 to_column:1
							   row:2];

	SMBGameLevel* const gameLevel = [[self alloc] init_with_gameBoard:gameBoard];

	return gameLevel;
}

@end
