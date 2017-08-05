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
#import "SMBGameBoardTilePosition.h"
#import "SMBGameBoardTile.h"





@implementation SMBGameLevel (SMBTestLevel)

#pragma mark - testLevel
+(nonnull instancetype)smb_testLevel
{
	SMBGameBoard* const gameBoard = [[SMBGameBoard alloc] init_with_numberOfColumns:3
																	   numberOfRows:5];

	SMBGameBoardTile* const gameBoardTile =
	[gameBoard gameBoardTile_at_position:[[SMBGameBoardTilePosition alloc] init_with_column:1 row:2]];

	SMBBeamCreatorEntity* const beamCreatorEntity = [SMBBeamCreatorEntity new];
	[beamCreatorEntity setOrientation:SMBGameBoardEntity__orientation_up];

	[gameBoardTile setGameBoardEntity:beamCreatorEntity];

	SMBGameLevel* const gameLevel = [[self alloc] init_with_gameBoard:gameBoard];

	return gameLevel;
}

@end
