//
//  SMBGameLevel+SMBPowerSwitchesAndDoorGroups.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 9/1/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameLevel+SMBPowerSwitchesAndDoorGroups.h"
#import "SMBGameBoard.h"
#import "SMBBeamCreatorTileEntity.h"
#import "SMBGameBoardTilePosition.h"
#import "SMBGameBoard+SMBAddEntity.h"
#import "SMBWallTileEntity.h"
#import "SMBGameBoardTile.h"
#import "SMBForcedBeamRedirectTileEntity.h"





@implementation SMBGameLevel (SMBPowerSwitchesAndDoorGroups)

#pragma mark - powerSwitches
+(nonnull instancetype)smb_powerSwitch_introduction
{
	/*
	 Numbers = Sections
	 
	 Entities:
	 BCP	Beam Creator Powered
	 Exi	Level Exit
	 Wal	Wall
	 PoS	Power Switch
	 BCU	Beam Creator Unpowered
	 
	 Sections and entities:
	 [   ] [   ] [   ] [   ] [   ] [PoS] [   ]
	 [   ] [   ] [   ] [ 1 ] [   ] [   ] [   ]
	 [   ] [BCP] [   ] [   ] [   ] [   ] [   ]
	 [Wal] [Wal] [Wal] [Wal] [Wal] [Wal] [Wal]
	 [   ] [   ] [   ] [   ] [   ] [Exi] [   ]
	 [   ] [   ] [   ] [ 2 ] [   ] [   ] [   ]
	 [   ] [BCU] [   ] [   ] [   ] [   ] [   ]
	 
	 S[x]	Switch [x]
	 S[x]O	Switch [x] Output
	 Wiring:
	 [   ] [   ] [   ] [   ] [   ] [S1 ] [   ]
	 [   ] [   ] [   ] [ 1 ] [   ] [   ] [   ]
	 [   ] [   ] [   ] [   ] [   ] [   ] [   ]
	 [Wal] [Wal] [Wal] [Wal] [Wal] [Wal] [Wal]
	 [   ] [   ] [   ] [   ] [   ] [   ] [   ]
	 [   ] [   ] [   ] [ 2 ] [   ] [   ] [   ]
	 [   ] [S1O] [   ] [   ] [   ] [   ] [   ]
	 
	 */
	
	/* Initial constants. */
	
	NSUInteger const wall_between_sections_1_and_2_height = 1;
	NSUInteger const section_1_height = 3;
	NSUInteger const section_2_height = 3;
	
	/* Game board. */
	
	SMBGameBoard* const gameBoard = [[SMBGameBoard alloc] init_with_numberOfColumns:7
																	   numberOfRows:(section_1_height + wall_between_sections_1_and_2_height + section_2_height)];
	
	/*
	 Section values.
	 */
	
	NSRange const gameBoardTilePosition_section_1_columns_range = (NSRange){
		.location	= 0,
		.length		= [gameBoard gameBoardTiles_numberOfColumns],
	};
	NSRange const gameBoardTilePosition_section_1_rows_range = (NSRange){
		.location	= 0,
		.length		= section_1_height,
	};
	
	NSRange const gameBoardTilePosition_wall_between_sections_1_and_2_columns_range = (NSRange){
		.location	= 0,
		.length		= [gameBoard gameBoardTiles_numberOfColumns],
	};
	NSRange const gameBoardTilePosition_wall_between_sections_1_and_2_rows_range = (NSRange){
		.location	= NSMaxRange(gameBoardTilePosition_section_1_rows_range),
		.length		= wall_between_sections_1_and_2_height,
	};
	
	NSRange const gameBoardTilePosition_section_2_columns_range = (NSRange){
		.location	= 0,
		.length		= [gameBoard gameBoardTiles_numberOfColumns],
	};
	NSRange const gameBoardTilePosition_section_2_rows_range = (NSRange){
		.location	= NSMaxRange(gameBoardTilePosition_wall_between_sections_1_and_2_rows_range),
		.length		= section_2_height,
	};
	
	/* Initial beam creator. */
	
	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_right];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:gameBoardTilePosition_section_1_columns_range.location + 1
													row:NSMaxRange(gameBoardTilePosition_section_1_rows_range) - 1]];
	
	/* Walls. */
	
	[gameBoard gameBoardTileEntities_add:
	 ^SMBGameBoardTileEntity * _Nullable(SMBGameBoardTilePosition * _Nonnull position) {
		 return [SMBWallTileEntity new];
	 }
							  entityType:SMBGameBoardTile__entityType_beamInteractions
								fillRect:YES
								 columns:gameBoardTilePosition_wall_between_sections_1_and_2_columns_range
									rows:gameBoardTilePosition_wall_between_sections_1_and_2_rows_range];
	
	/* Un-powered beam creators. */
	
	SMBBeamCreatorTileEntity* const beamCreatorEntity_unpowered = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity_unpowered setRequiresExternalPowerForBeam:YES];
	[beamCreatorEntity_unpowered setBeamDirection:SMBGameBoardTile__direction_right];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity_unpowered
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:gameBoardTilePosition_section_2_columns_range.location + 1
													row:NSMaxRange(gameBoardTilePosition_section_2_rows_range) - 1]];
	
	/* Power buttons. */
	
	/* Section 1 -1x0 to Section 1 beamCreatorEntity_unpowered position */
	[gameBoard gameBoardTileEntity_add_powerSwitchTileEntity_with_gameBoardTilePosition_toPower:beamCreatorEntity_unpowered.gameBoardTile.gameBoardTilePosition
																	   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:NSMaxRange(gameBoardTilePosition_section_1_columns_range) - 2
													row:gameBoardTilePosition_section_1_rows_range.location]];
	
	/* Level exit. */
	
	[gameBoard gameBoardTileEntity_add_levelExit_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:NSMaxRange(gameBoardTilePosition_section_2_columns_range) - 2
													row:gameBoardTilePosition_section_2_rows_range.location]];
	
	/* Usable game board tile entities. */
	
	NSMutableArray<SMBGameBoardTileEntity*>* const gameBoardTileEntities = [NSMutableArray<SMBGameBoardTileEntity*> array];
	[gameBoardTileEntities addObject:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_up]];
	
	return
	[[self alloc] init_with_gameBoard:gameBoard
		  usableGameBoardTileEntities:[NSArray<SMBGameBoardTileEntity*> arrayWithArray:gameBoardTileEntities]];
}

@end
