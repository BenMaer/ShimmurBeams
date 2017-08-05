//
//  SMBGameLevel+SMBTestLevel.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/4/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameLevel+SMBTestLevel.h"
#import "SMBGameBoard.h"
#import "SMBBeamCreatorEntity.h"
#import "SMBGameBoard+SMBAddEntity.h"





@implementation SMBGameLevel (SMBTestLevel)

#pragma mark - testLevel
+(nonnull instancetype)smb_testLevel
{
	SMBGameBoard* const gameBoard = [[SMBGameBoard alloc] init_with_numberOfColumns:5
																	   numberOfRows:5];

	SMBBeamCreatorEntity* const beamCreatorEntity_top = [SMBBeamCreatorEntity new];
	[beamCreatorEntity_top setOrientation:SMBGameBoardEntity__orientation_up];
	[gameBoard gameBoardEntity_add:beamCreatorEntity_top
						 to_column:2
							   row:1];

	SMBBeamCreatorEntity* const beamCreatorEntity_right = [SMBBeamCreatorEntity new];
	[beamCreatorEntity_right setOrientation:SMBGameBoardEntity__orientation_right];
	[gameBoard gameBoardEntity_add:beamCreatorEntity_right
						 to_column:3
							   row:2];

	SMBBeamCreatorEntity* const beamCreatorEntity_down = [SMBBeamCreatorEntity new];
	[beamCreatorEntity_down setOrientation:SMBGameBoardEntity__orientation_down];
	[gameBoard gameBoardEntity_add:beamCreatorEntity_down
						 to_column:2
							   row:3];

	SMBBeamCreatorEntity* const beamCreatorEntity_left = [SMBBeamCreatorEntity new];
	[beamCreatorEntity_left setOrientation:SMBGameBoardEntity__orientation_left];
	[gameBoard gameBoardEntity_add:beamCreatorEntity_left
						 to_column:1
							   row:2];

	SMBGameLevel* const gameLevel = [[self alloc] init_with_gameBoard:gameBoard];

	return gameLevel;
}

@end
