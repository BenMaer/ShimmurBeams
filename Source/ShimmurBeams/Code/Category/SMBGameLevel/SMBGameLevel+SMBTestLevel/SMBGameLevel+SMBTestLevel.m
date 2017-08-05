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





@implementation SMBGameLevel (SMBTestLevel)

#pragma mark - testLevel
+(nonnull instancetype)smb_testLevel
{
	SMBGameBoard* const gameBoard = [[SMBGameBoard alloc] init_with_numberOfColumns:5
																	   numberOfRows:5];

	SMBBeamCreatorTileEntity* const beamCreatorEntity_top = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity_top setOrientation:SMBGameBoardTileEntity__orientation_up];
	[gameBoard gameBoardEntity_add:beamCreatorEntity_top
						 to_column:2
							   row:1];

	SMBBeamCreatorTileEntity* const beamCreatorEntity_right = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity_right setOrientation:SMBGameBoardTileEntity__orientation_right];
	[gameBoard gameBoardEntity_add:beamCreatorEntity_right
						 to_column:3
							   row:2];

	SMBBeamCreatorTileEntity* const beamCreatorEntity_down = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity_down setOrientation:SMBGameBoardTileEntity__orientation_down];
	[gameBoard gameBoardEntity_add:beamCreatorEntity_down
						 to_column:2
							   row:3];

	SMBBeamCreatorTileEntity* const beamCreatorEntity_left = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity_left setOrientation:SMBGameBoardTileEntity__orientation_left];
	[gameBoard gameBoardEntity_add:beamCreatorEntity_left
						 to_column:1
							   row:2];

	SMBGameLevel* const gameLevel = [[self alloc] init_with_gameBoard:gameBoard];

	return gameLevel;
}

@end
