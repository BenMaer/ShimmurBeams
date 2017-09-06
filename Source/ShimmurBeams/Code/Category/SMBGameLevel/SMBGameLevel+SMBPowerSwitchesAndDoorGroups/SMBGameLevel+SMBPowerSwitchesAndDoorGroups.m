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
#import "SMBDoorTileEntity.h"
#import "SMBPowerSwitchTileEntity.h"
#import "SMBGenericPowerOutputTileEntity_OutputPowerReceiver_GameBoardTilePowerProvider.h"
#import "SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection.h"
#import "SMBDeathBlockTileEntity.h"
#import "SMBPowerButtonTileEntity.h"
#import "SMBBeamRotateTileEntity.h"
#import "SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection_BlacklistToggler.h"





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

	 Usable:
	 Forced Redirect (direction: up)

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

	/* Power Switches. */

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

+(nonnull instancetype)smb_powerSwitch_and_button_and_door
{
	/*
	 Numbers = Sections

	 Entities:
	 BCP	Beam Creator Powered
	 Exi	Level Exit
	 Wal	Wall
	 PoB	Power Button
	 PoS	Power Switch
	 BCU	Beam Creator Unpowered
	 Dor	Door

	 Usable:
	 Forced Redirect (direction: up)

	 Sections and entities:
	 [   ] [   ] [   ] [   ] [   ] [PoS] [   ]
	 [   ] [BCP] [   ] [ 1 ] [   ] [   ] [PoB]
	 [   ] [   ] [   ] [   ] [   ] [   ] [   ]
	 [Wal] [Wal] [Wal] [Wal] [Wal] [Wal] [Wal]
	 [   ] [   ] [   ] [   ] [   ] [Exi] [   ]
	 [   ] [   ] [   ] [ 2 ] [   ] [Dor] [   ]
	 [   ] [BCU] [   ] [   ] [   ] [   ] [   ]

	 S[x]	Switch [x]
	 S[x]O	Switch [x] Output
	 Wiring:
	 [   ] [   ] [   ] [   ] [   ] [S1 ] [   ]
	 [   ] [   ] [   ] [ 1 ] [   ] [   ] [B1 ]
	 [   ] [   ] [   ] [   ] [   ] [   ] [   ]
	 [Wal] [Wal] [Wal] [Wal] [Wal] [Wal] [Wal]
	 [   ] [   ] [   ] [   ] [   ] [   ] [   ]
	 [   ] [   ] [   ] [ 2 ] [   ] [S1O] [   ]
	 [   ] [B1O] [   ] [   ] [   ] [   ] [   ]

	 */

	/* Initial constants. */

	NSUInteger const wall_between_sections_1_and_2_height = 1;
	NSUInteger const section_1_height = 3;
	NSUInteger const section_2_height = 3;

	/* Game board. */

	SMBGameBoard* const gameBoard = [[SMBGameBoard alloc] init_with_numberOfColumns:7
																	   numberOfRows:(section_1_height + wall_between_sections_1_and_2_height + section_2_height)];

	/* @Matt @Alex I want you guys to fill this in from the above diagrams */
    
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
                                                    row:NSMaxRange(gameBoardTilePosition_section_1_rows_range) - 2]];
    
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
    
    /* Power Switches. */
    
    /* Section 1 -1x0 to Section 1 beamCreatorEntity_unpowered position */
    [gameBoard gameBoardTileEntity_add_powerSwitchTileEntity_with_gameBoardTilePosition_toPower:beamCreatorEntity_unpowered.gameBoardTile.gameBoardTilePosition
                                                                       to_gameBoardTilePosition:
     [[SMBGameBoardTilePosition alloc] init_with_column:NSMaxRange(gameBoardTilePosition_section_1_columns_range) - 2
                                                    row:gameBoardTilePosition_section_1_rows_range.location]];
    
    
    /* Doors. */
    
    SMBDoorTileEntity* const door_section_2_minus1xminus3 = [SMBDoorTileEntity new];
    [gameBoard gameBoardTileEntity_for_beamInteractions_set:door_section_2_minus1xminus3
                                   to_gameBoardTilePosition:
     [[SMBGameBoardTilePosition alloc] init_with_column:NSMaxRange(gameBoardTilePosition_section_2_columns_range) - 2
                                                    row:NSMaxRange(gameBoardTilePosition_section_2_rows_range) - 2]];
    
    // /* Power buttons. INPROGRESS */
    
     [gameBoard gameBoardTileEntity_add_powerButtonTileEntity_with_gameBoardTilePosition_toPower:door_section_2_minus1xminus3.gameBoardTile.gameBoardTilePosition
                                                                        to_gameBoardTilePosition:
      [[SMBGameBoardTilePosition alloc] init_with_column:NSMaxRange(gameBoardTilePosition_section_1_columns_range) - 1
                                                     row:NSMaxRange(gameBoardTilePosition_section_1_rows_range) - 2]];
    
    
    /* Level exit. */
    
    [gameBoard gameBoardTileEntity_add_levelExit_to_gameBoardTilePosition:
     [[SMBGameBoardTilePosition alloc] init_with_column:NSMaxRange(gameBoardTilePosition_section_2_columns_range) - 2
                                                    row:gameBoardTilePosition_section_2_rows_range.location]];

	/* Usable game board tile entities. */

	NSMutableArray<SMBGameBoardTileEntity*>* const gameBoardTileEntities = [NSMutableArray<SMBGameBoardTileEntity*> array];

	return
	[[self alloc] init_with_gameBoard:gameBoard
		  usableGameBoardTileEntities:[NSArray<SMBGameBoardTileEntity*> arrayWithArray:gameBoardTileEntities]];
}

#pragma mark - doorGroups
+(nonnull instancetype)smb_doorGroup_introduction
{
	/*
	 Numbers = Sections

	 Entities:
	 BCP	Beam Creator Powered
	 Exi	Level Exit
	 PoS	Power Switch
	 Dor	Door

	 Usable:
	 Forced Redirect (direction: right)

	 Sections and entities:
	 [   ] [   ] [   ] [   ] [   ]
	 [   ] [   ] [Dor] [Exi] [   ]
	 [   ] [Dor] [   ] [   ] [   ]
	 [   ] [   ] [   ] [PoS] [   ]
	 [   ] [BCP] [   ] [   ] [   ]

	 S[x]	Switch [x]
	 S[x]O	Switch [x] Output
	 C[x]	Power Collection [x]
	 C[x]O	Power Collection [x] Output

	 Wiring:
	 [   ] [   ] [   ] [   ] [   ]
	 [   ] [   ] [C1O] [   ] [   ]
	 [   ] [C1O] [   ] [   ] [   ]
	 [   ] [   ] [   ] [S1 ] [   ]
	 [   ] [   ] [   ] [   ] [   ]

	 S1O:
	 - C1

	 */

	/* Game board. */

	SMBGameBoard* const gameBoard = [[SMBGameBoard alloc] init_with_numberOfColumns:5
																	   numberOfRows:5];

	/* Initial beam creator. */

	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_up];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:1
													row:[gameBoard gameBoardTiles_numberOfRows] - 1]];

	/* Doors */
	SMBDoorTileEntity* const doorTileEntity_1x2 = [SMBDoorTileEntity new];
	[gameBoard gameBoardTileEntity_add:doorTileEntity_1x2
							entityType:SMBGameBoardTile__entityType_beamInteractions
			  to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:1
													row:2]];

	SMBDoorTileEntity* const doorTileEntity_2x1 = [SMBDoorTileEntity new];
	[gameBoard gameBoardTileEntity_add:doorTileEntity_2x1
							entityType:SMBGameBoardTile__entityType_beamInteractions
			  to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:2
													row:1]];

	/* Output Power Receiver Collections. */

	NSMutableSet<id<SMBGenericPowerOutputTileEntity_OutputPowerReceiver>>* const outputPowerReceiverCollections_1_outputPowerReceivers = [NSMutableSet<id<SMBGenericPowerOutputTileEntity_OutputPowerReceiver>> set];
	[outputPowerReceiverCollections_1_outputPowerReceivers addObject:[[SMBGenericPowerOutputTileEntity_OutputPowerReceiver_GameBoardTilePowerProvider alloc] init_with_gameBoardTilePosition_toPower:doorTileEntity_1x2.gameBoardTile.gameBoardTilePosition]];
	[outputPowerReceiverCollections_1_outputPowerReceivers addObject:[[SMBGenericPowerOutputTileEntity_OutputPowerReceiver_GameBoardTilePowerProvider alloc] init_with_gameBoardTilePosition_toPower:doorTileEntity_2x1.gameBoardTile.gameBoardTilePosition]];

	SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection* const outputPowerReceiverCollections_1_genericPowerOutputTileEntity_OutputPowerReceiverCollection =
	[[SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection alloc] init_with_outputPowerReceivers:outputPowerReceiverCollections_1_outputPowerReceivers];

	/* Power Switches. */

	/* 3x3 to Door Group 1 */
	[gameBoard gameBoardTileEntity_add:[[SMBPowerSwitchTileEntity alloc] init_with_outputPowerReceiverCollection:outputPowerReceiverCollections_1_genericPowerOutputTileEntity_OutputPowerReceiverCollection]
							entityType:SMBGameBoardTile__entityType_beamInteractions
			  to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:3
													row:3]];

	/* Level exit. */

	[gameBoard gameBoardTileEntity_add_levelExit_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:3
													row:1]];

	/* Usable game board tile entities. */

	NSMutableArray<SMBGameBoardTileEntity*>* const gameBoardTileEntities = [NSMutableArray<SMBGameBoardTileEntity*> array];
	[gameBoardTileEntities addObject:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_right]];

	return
	[[self alloc] init_with_gameBoard:gameBoard
		  usableGameBoardTileEntities:[NSArray<SMBGameBoardTileEntity*> arrayWithArray:gameBoardTileEntities]];
}

+(nonnull instancetype)smb_powerSwitch_and_doorGroup_combo
{
	/*
	 Numbers = Sections

	 Entities:
	 BCP	Beam Creator Powered
	 Exi	Level Exit
	 Wal	Wall
	 PoS	Power Switch
	 BCU	Beam Creator Unpowered
	 Dor	Door

	 Usable:
	 Forced Redirect (direction: up)

	 Sections and entities:
	 [   ] [   ] [   ] [   ] [   ] [Exi] [   ]
	 [   ] [   ] [   ] [ 2 ] [   ] [   ] [   ]
	 [   ] [BCU] [Dor] [Dor] [Dor] [   ] [   ]
	 [Wal] [Wal] [Wal] [Wal] [Wal] [Wal] [Wal]
	 [   ] [   ] [   ] [   ] [PoS] [PoS] [   ]
	 [   ] [   ] [   ] [ 1 ] [   ] [   ] [   ]
	 [   ] [BCP] [   ] [   ] [   ] [   ] [   ]

	 S[x]	Switch [x]
	 S[x]O	Switch [x] Output
	 C[x]	Power Collection [x]
	 C[x]O	Power Collection [x] Output

	 Wiring:
	 [   ] [   ] [   ] [   ] [   ] [   ] [   ]
	 [   ] [   ] [   ] [ 2 ] [   ] [   ] [   ]
	 [   ] [S1O] [C1O] [C1O] [C1O] [   ] [   ]
	 [Wal] [Wal] [Wal] [Wal] [Wal] [Wal] [Wal]
	 [   ] [   ] [   ] [   ] [S1 ] [S2 ] [   ]
	 [   ] [   ] [   ] [ 1 ] [   ] [   ] [   ]
	 [   ] [   ] [   ] [   ] [   ] [   ] [   ]

	 S2O:
	  - C1

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

	NSRange const gameBoardTilePosition_section_2_columns_range = (NSRange){
		.location	= 0,
		.length		= [gameBoard gameBoardTiles_numberOfColumns],
	};
	NSRange const gameBoardTilePosition_section_2_rows_range = (NSRange){
		.location	= 0,
		.length		= section_2_height,
	};

	NSRange const gameBoardTilePosition_wall_between_sections_1_and_2_columns_range = (NSRange){
		.location	= 0,
		.length		= [gameBoard gameBoardTiles_numberOfColumns],
	};
	NSRange const gameBoardTilePosition_wall_between_sections_1_and_2_rows_range = (NSRange){
		.location	= NSMaxRange(gameBoardTilePosition_section_2_rows_range),
		.length		= wall_between_sections_1_and_2_height,
	};

	NSRange const gameBoardTilePosition_section_1_columns_range = (NSRange){
		.location	= 0,
		.length		= [gameBoard gameBoardTiles_numberOfColumns],
	};
	NSRange const gameBoardTilePosition_section_1_rows_range = (NSRange){
		.location	= NSMaxRange(gameBoardTilePosition_wall_between_sections_1_and_2_rows_range),
		.length		= section_1_height,
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

	/* Doors */
	SMBDoorTileEntity* const doorTileEntity_section_2_2xminus0 = [SMBDoorTileEntity new];
	[gameBoard gameBoardTileEntity_add:doorTileEntity_section_2_2xminus0
							entityType:SMBGameBoardTile__entityType_beamInteractions
			  to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:gameBoardTilePosition_section_2_columns_range.location + 2
													row:NSMaxRange(gameBoardTilePosition_section_2_rows_range) - 1]];

	SMBDoorTileEntity* const doorTileEntity_section_2_3xminus0 = [SMBDoorTileEntity new];
	[gameBoard gameBoardTileEntity_add:doorTileEntity_section_2_3xminus0
							entityType:SMBGameBoardTile__entityType_beamInteractions
			  to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:gameBoardTilePosition_section_2_columns_range.location + 3
													row:NSMaxRange(gameBoardTilePosition_section_2_rows_range) - 1]];

	SMBDoorTileEntity* const doorTileEntity_section_2_4xminus0 = [SMBDoorTileEntity new];
	[gameBoard gameBoardTileEntity_add:doorTileEntity_section_2_4xminus0
							entityType:SMBGameBoardTile__entityType_beamInteractions
			  to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:gameBoardTilePosition_section_2_columns_range.location + 4
													row:NSMaxRange(gameBoardTilePosition_section_2_rows_range) - 1]];

	/* Output Power Receiver Collections. */

	NSMutableSet<id<SMBGenericPowerOutputTileEntity_OutputPowerReceiver>>* const outputPowerReceiverCollections_1_outputPowerReceivers = [NSMutableSet<id<SMBGenericPowerOutputTileEntity_OutputPowerReceiver>> set];
	[outputPowerReceiverCollections_1_outputPowerReceivers addObject:[[SMBGenericPowerOutputTileEntity_OutputPowerReceiver_GameBoardTilePowerProvider alloc] init_with_gameBoardTilePosition_toPower:doorTileEntity_section_2_2xminus0.gameBoardTile.gameBoardTilePosition]];
	[outputPowerReceiverCollections_1_outputPowerReceivers addObject:[[SMBGenericPowerOutputTileEntity_OutputPowerReceiver_GameBoardTilePowerProvider alloc] init_with_gameBoardTilePosition_toPower:doorTileEntity_section_2_3xminus0.gameBoardTile.gameBoardTilePosition]];
	[outputPowerReceiverCollections_1_outputPowerReceivers addObject:[[SMBGenericPowerOutputTileEntity_OutputPowerReceiver_GameBoardTilePowerProvider alloc] init_with_gameBoardTilePosition_toPower:doorTileEntity_section_2_4xminus0.gameBoardTile.gameBoardTilePosition]];

	SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection* const outputPowerReceiverCollections_1_genericPowerOutputTileEntity_OutputPowerReceiverCollection =
	[[SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection alloc] init_with_outputPowerReceivers:outputPowerReceiverCollections_1_outputPowerReceivers];

	/* Power Switches. */

	/* Section 1 -2x0 to Section 1 beamCreatorEntity_unpowered position */
	[gameBoard gameBoardTileEntity_add_powerSwitchTileEntity_with_gameBoardTilePosition_toPower:beamCreatorEntity_unpowered.gameBoardTile.gameBoardTilePosition
																	   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:NSMaxRange(gameBoardTilePosition_section_1_columns_range) - 3
													row:gameBoardTilePosition_section_1_rows_range.location]];

	/* Section 1 -1x0 to Door Group 1 */
	[gameBoard gameBoardTileEntity_add:[[SMBPowerSwitchTileEntity alloc] init_with_outputPowerReceiverCollection:outputPowerReceiverCollections_1_genericPowerOutputTileEntity_OutputPowerReceiverCollection]
							entityType:SMBGameBoardTile__entityType_beamInteractions
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

+(nonnull instancetype)smb_doorGroups_introduction
{
	/*
	 Numbers = Sections

	 Entities:
	 BCP	Beam Creator Powered
	 Exi	Level Exit
	 Wal	Wall
	 PoS	Power Switch
	 BCU	Beam Creator Unpowered
	 Dor	Door

	 Usable:
	 Forced Redirect (direction: up)

	 Sections and entities:
	 [   ] [   ] [   ] [   ] [   ] [Exi] [   ]
	 [   ] [   ] [   ] [ 2 ] [   ] [   ] [   ]
	 [   ] [BCU] [Dor] [Dor] [Dor] [   ] [   ]
	 [Wal] [Wal] [Wal] [Wal] [Wal] [Wal] [Wal]
	 [   ] [   ] [PoS] [   ] [   ] [PoS] [   ]
	 [   ] [   ] [   ] [ 1 ] [   ] [   ] [   ]
	 [   ] [BCP] [   ] [Dor] [Dor] [   ] [   ]

	 S[x]	Switch [x]
	 S[x]O	Switch [x] Output
	 C[x]	Power Collection [x]
	 C[x]O	Power Collection [x] Output

	 Collection notes:
	 - C2
	  - outputPowerReceivers_powerIsOppositeOfReceiver = YES
	 - C3
	  - Contains:
	   - C1
	   - C2

	 Wiring:
	 [   ] [   ] [   ] [   ] [   ] [   ] [   ]
	 [   ] [   ] [   ] [ 2 ] [   ] [   ] [   ]
	 [   ] [S2O] [C2O] [C2O] [C2O] [   ] [   ]
	 [Wal] [Wal] [Wal] [Wal] [Wal] [Wal] [Wal]
	 [   ] [   ] [S1 ] [   ] [   ] [S2 ] [   ]
	 [   ] [   ] [   ] [ 1 ] [   ] [   ] [   ]
	 [   ] [   ] [   ] [C1O] [C1O] [   ] [   ]

	 S1O:
	 - C3

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

	NSRange const gameBoardTilePosition_section_2_columns_range = (NSRange){
		.location	= 0,
		.length		= [gameBoard gameBoardTiles_numberOfColumns],
	};
	NSRange const gameBoardTilePosition_section_2_rows_range = (NSRange){
		.location	= 0,
		.length		= section_2_height,
	};

	NSRange const gameBoardTilePosition_wall_between_sections_1_and_2_columns_range = (NSRange){
		.location	= 0,
		.length		= [gameBoard gameBoardTiles_numberOfColumns],
	};
	NSRange const gameBoardTilePosition_wall_between_sections_1_and_2_rows_range = (NSRange){
		.location	= NSMaxRange(gameBoardTilePosition_section_2_rows_range),
		.length		= wall_between_sections_1_and_2_height,
	};

	NSRange const gameBoardTilePosition_section_1_columns_range = (NSRange){
		.location	= 0,
		.length		= [gameBoard gameBoardTiles_numberOfColumns],
	};
	NSRange const gameBoardTilePosition_section_1_rows_range = (NSRange){
		.location	= NSMaxRange(gameBoardTilePosition_wall_between_sections_1_and_2_rows_range),
		.length		= section_1_height,
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

	/* Doors */
	SMBDoorTileEntity* const doorTileEntity_section_1_3xminus0 = [SMBDoorTileEntity new];
	[gameBoard gameBoardTileEntity_add:doorTileEntity_section_1_3xminus0
							entityType:SMBGameBoardTile__entityType_beamInteractions
			  to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:gameBoardTilePosition_section_1_columns_range.location + 3
													row:NSMaxRange(gameBoardTilePosition_section_1_rows_range) - 1]];

	SMBDoorTileEntity* const doorTileEntity_section_1_4xminus0 = [SMBDoorTileEntity new];
	[gameBoard gameBoardTileEntity_add:doorTileEntity_section_1_4xminus0
							entityType:SMBGameBoardTile__entityType_beamInteractions
			  to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:gameBoardTilePosition_section_1_columns_range.location + 4
													row:NSMaxRange(gameBoardTilePosition_section_1_rows_range) - 1]];

	SMBDoorTileEntity* const doorTileEntity_section_2_2xminus0 = [SMBDoorTileEntity new];
	[gameBoard gameBoardTileEntity_add:doorTileEntity_section_2_2xminus0
							entityType:SMBGameBoardTile__entityType_beamInteractions
			  to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:gameBoardTilePosition_section_2_columns_range.location + 2
													row:NSMaxRange(gameBoardTilePosition_section_2_rows_range) - 1]];

	SMBDoorTileEntity* const doorTileEntity_section_2_3xminus0 = [SMBDoorTileEntity new];
	[gameBoard gameBoardTileEntity_add:doorTileEntity_section_2_3xminus0
							entityType:SMBGameBoardTile__entityType_beamInteractions
			  to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:gameBoardTilePosition_section_2_columns_range.location + 3
													row:NSMaxRange(gameBoardTilePosition_section_2_rows_range) - 1]];

	SMBDoorTileEntity* const doorTileEntity_section_2_4xminus0 = [SMBDoorTileEntity new];
	[gameBoard gameBoardTileEntity_add:doorTileEntity_section_2_4xminus0
							entityType:SMBGameBoardTile__entityType_beamInteractions
			  to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:gameBoardTilePosition_section_2_columns_range.location + 4
													row:NSMaxRange(gameBoardTilePosition_section_2_rows_range) - 1]];

	/* Output Power Receiver Collections. */

	NSMutableSet<id<SMBGenericPowerOutputTileEntity_OutputPowerReceiver>>* const outputPowerReceiverCollections_1_outputPowerReceivers = [NSMutableSet<id<SMBGenericPowerOutputTileEntity_OutputPowerReceiver>> set];
	[outputPowerReceiverCollections_1_outputPowerReceivers addObject:[[SMBGenericPowerOutputTileEntity_OutputPowerReceiver_GameBoardTilePowerProvider alloc] init_with_gameBoardTilePosition_toPower:doorTileEntity_section_1_3xminus0.gameBoardTile.gameBoardTilePosition]];
	[outputPowerReceiverCollections_1_outputPowerReceivers addObject:[[SMBGenericPowerOutputTileEntity_OutputPowerReceiver_GameBoardTilePowerProvider alloc] init_with_gameBoardTilePosition_toPower:doorTileEntity_section_1_4xminus0.gameBoardTile.gameBoardTilePosition]];

	SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection* const outputPowerReceiverCollections_1_genericPowerOutputTileEntity_OutputPowerReceiverCollection =
	[[SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection alloc] init_with_outputPowerReceivers:outputPowerReceiverCollections_1_outputPowerReceivers];

	NSMutableSet<id<SMBGenericPowerOutputTileEntity_OutputPowerReceiver>>* const outputPowerReceiverCollections_2_outputPowerReceivers = [NSMutableSet<id<SMBGenericPowerOutputTileEntity_OutputPowerReceiver>> set];
	[outputPowerReceiverCollections_2_outputPowerReceivers addObject:[[SMBGenericPowerOutputTileEntity_OutputPowerReceiver_GameBoardTilePowerProvider alloc] init_with_gameBoardTilePosition_toPower:doorTileEntity_section_2_2xminus0.gameBoardTile.gameBoardTilePosition]];
	[outputPowerReceiverCollections_2_outputPowerReceivers addObject:[[SMBGenericPowerOutputTileEntity_OutputPowerReceiver_GameBoardTilePowerProvider alloc] init_with_gameBoardTilePosition_toPower:doorTileEntity_section_2_3xminus0.gameBoardTile.gameBoardTilePosition]];
	[outputPowerReceiverCollections_2_outputPowerReceivers addObject:[[SMBGenericPowerOutputTileEntity_OutputPowerReceiver_GameBoardTilePowerProvider alloc] init_with_gameBoardTilePosition_toPower:doorTileEntity_section_2_4xminus0.gameBoardTile.gameBoardTilePosition]];

	SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection* const outputPowerReceiverCollections_2_genericPowerOutputTileEntity_OutputPowerReceiverCollection =
	[[SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection alloc] init_with_outputPowerReceivers:outputPowerReceiverCollections_2_outputPowerReceivers];
	[outputPowerReceiverCollections_2_genericPowerOutputTileEntity_OutputPowerReceiverCollection setOutputPowerReceivers_powerIsOppositeOfReceiver:YES];

	NSMutableSet<id<SMBGenericPowerOutputTileEntity_OutputPowerReceiver>>* const outputPowerReceiverCollections_3_outputPowerReceivers = [NSMutableSet<id<SMBGenericPowerOutputTileEntity_OutputPowerReceiver>> set];
	[outputPowerReceiverCollections_3_outputPowerReceivers addObject:outputPowerReceiverCollections_1_genericPowerOutputTileEntity_OutputPowerReceiverCollection];
	[outputPowerReceiverCollections_3_outputPowerReceivers addObject:outputPowerReceiverCollections_2_genericPowerOutputTileEntity_OutputPowerReceiverCollection];

	SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection* const outputPowerReceiverCollections_3_genericPowerOutputTileEntity_OutputPowerReceiverCollection =
	[[SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection alloc] init_with_outputPowerReceivers:outputPowerReceiverCollections_3_outputPowerReceivers];

	/* Power Switches. */

	/* Section 1 2x0 to Section 1 beamCreatorEntity_unpowered position */
	[gameBoard gameBoardTileEntity_add:[[SMBPowerSwitchTileEntity alloc] init_with_outputPowerReceiverCollection:outputPowerReceiverCollections_3_genericPowerOutputTileEntity_OutputPowerReceiverCollection]
							entityType:SMBGameBoardTile__entityType_beamInteractions
																	   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:gameBoardTilePosition_section_1_columns_range.location + 2
													row:gameBoardTilePosition_section_1_rows_range.location]];

	/* Section 1 -1x0 to Door Group 1 */
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

#pragma mark - powerSwitches_and_doorGroups
+(nonnull instancetype)smb_powerSwitches_and_doorGroups_beamCreatorGroup
{
	/*
	 Numbers = Sections

	 Entities:
	 BCP	Beam Creator Powered
	 Exi	Level Exit
	 Wal	Wall
	 PoS	Power Button
	 PoS	Power Switch
	 BCU	Beam Creator Unpowered
	 Dor	Door
	 Dth	Death block

	 Usable:
	 Beam Rotation (direction_rotation: left)
	 Beam Rotation (direction_rotation: left)
	 Beam Rotation (direction_rotation: right)

	 Sections and entities:
	 [   ] [   ] [   ] [Exi] [Dor] [   ] [   ]
	 [   ] [BCU] [   ] [Dor] [Dor] [   ] [   ]
	 [BCU] [   ] [   ] [ 2 ] [   ] [   ] [   ]
	 [Wal] [Wal] [Wal] [Wal] [Wal] [Wal] [Wal]
	 [   ] [   ] [PoS] [   ] [   ] [PoS] [   ]
	 [   ] [   ] [   ] [ 1 ] [   ] [PoB] [   ]
	 [   ] [BCP] [   ] [Dor] [   ] [   ] [Dth]

	 B[x]	Button [x]
	 B[x]O	Button [x] Output
	 S[x]	Switch [x]
	 S[x]O	Switch [x] Output
	 C[x]	Power Collection [x]
	 C[x]O	Power Collection [x] Output
	 T[X]	Power Collection Toggle [x]
	 T[X]O	Power Collection Toggle [x] Output

	 Collection notes:
	 - C2
	 *- outputPowerReceivers_powerIsOppositeOfReceiver = YES
	 - C3
	 *- Contains:
	 **- C1
	 **- C2
	 - C4
	 *- Starting blacklist:
	 **- Section 2, 1x-0
	 - C5
	 *- Contains:
	 **- T1

	 Toggle notes:
	 - T1

	 Wiring:
	 [   ] [   ] [   ] [   ] [C1O] [   ] [   ]
	 [   ] [C4O] [   ] [C2O] [C2O] [   ] [   ]
	 [C4O] [   ] [   ] [ 2 ] [   ] [   ] [   ]
	 [Wal] [Wal] [Wal] [Wal] [Wal] [Wal] [Wal]
	 [   ] [   ] [S1 ] [   ] [   ] [S2 ] [   ]
	 [   ] [   ] [   ] [ 1 ] [   ] [B1 ] [   ]
	 [   ] [   ] [   ] [C1O] [   ] [   ] [   ]

	 B1O:
	 - C4
	 S1O:
	 - C3
	 S2O:
	 - C5
	 T1O:
	 - Toggles blacklist on C4

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

	NSRange const gameBoardTilePosition_section_2_columns_range = (NSRange){
		.location	= 0,
		.length		= [gameBoard gameBoardTiles_numberOfColumns],
	};
	NSRange const gameBoardTilePosition_section_2_rows_range = (NSRange){
		.location	= 0,
		.length		= section_2_height,
	};

	NSRange const gameBoardTilePosition_wall_between_sections_1_and_2_columns_range = (NSRange){
		.location	= 0,
		.length		= [gameBoard gameBoardTiles_numberOfColumns],
	};
	NSRange const gameBoardTilePosition_wall_between_sections_1_and_2_rows_range = (NSRange){
		.location	= NSMaxRange(gameBoardTilePosition_section_2_rows_range),
		.length		= wall_between_sections_1_and_2_height,
	};

	NSRange const gameBoardTilePosition_section_1_columns_range = (NSRange){
		.location	= 0,
		.length		= [gameBoard gameBoardTiles_numberOfColumns],
	};
	NSRange const gameBoardTilePosition_section_1_rows_range = (NSRange){
		.location	= NSMaxRange(gameBoardTilePosition_wall_between_sections_1_and_2_rows_range),
		.length		= section_1_height,
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

	SMBBeamCreatorTileEntity* const beamCreatorEntity_unpowered_section_2_1xminus1 = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity_unpowered_section_2_1xminus1 setRequiresExternalPowerForBeam:YES];
	[beamCreatorEntity_unpowered_section_2_1xminus1 setBeamDirection:SMBGameBoardTile__direction_right];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity_unpowered_section_2_1xminus1
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:gameBoardTilePosition_section_2_columns_range.location + 1
													row:NSMaxRange(gameBoardTilePosition_section_2_rows_range) - 2]];

	SMBBeamCreatorTileEntity* const beamCreatorEntity_unpowered_section_2_0xminus0 = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity_unpowered_section_2_0xminus0 setRequiresExternalPowerForBeam:YES];
	[beamCreatorEntity_unpowered_section_2_0xminus0 setBeamDirection:SMBGameBoardTile__direction_right];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity_unpowered_section_2_0xminus0
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:gameBoardTilePosition_section_2_columns_range.location
													row:NSMaxRange(gameBoardTilePosition_section_2_rows_range) - 1]];

	/* Doors */
	SMBDoorTileEntity* const doorTileEntity_section_1_3xminus0 = [SMBDoorTileEntity new];
	[gameBoard gameBoardTileEntity_add:doorTileEntity_section_1_3xminus0
							entityType:SMBGameBoardTile__entityType_beamInteractions
			  to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:gameBoardTilePosition_section_1_columns_range.location + 3
													row:NSMaxRange(gameBoardTilePosition_section_1_rows_range) - 1]];

	SMBDoorTileEntity* const doorTileEntity_section_2_4x0 = [SMBDoorTileEntity new];
	[gameBoard gameBoardTileEntity_add:doorTileEntity_section_2_4x0
							entityType:SMBGameBoardTile__entityType_beamInteractions
			  to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:gameBoardTilePosition_section_2_columns_range.location + 4
													row:0]];

	SMBDoorTileEntity* const doorTileEntity_section_2_3x1 = [SMBDoorTileEntity new];
	[gameBoard gameBoardTileEntity_add:doorTileEntity_section_2_3x1
							entityType:SMBGameBoardTile__entityType_beamInteractions
			  to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:gameBoardTilePosition_section_2_columns_range.location + 3
													row:1]];

	SMBDoorTileEntity* const doorTileEntity_section_2_4x1 = [SMBDoorTileEntity new];
	[gameBoard gameBoardTileEntity_add:doorTileEntity_section_2_4x1
							entityType:SMBGameBoardTile__entityType_beamInteractions
			  to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:gameBoardTilePosition_section_2_columns_range.location + 4
													row:1]];

	/* Output Power Receiver Collections. */

	NSMutableSet<id<SMBGenericPowerOutputTileEntity_OutputPowerReceiver>>* const outputPowerReceiverCollections_1_outputPowerReceivers = [NSMutableSet<id<SMBGenericPowerOutputTileEntity_OutputPowerReceiver>> set];
	[outputPowerReceiverCollections_1_outputPowerReceivers addObject:[[SMBGenericPowerOutputTileEntity_OutputPowerReceiver_GameBoardTilePowerProvider alloc] init_with_gameBoardTilePosition_toPower:doorTileEntity_section_2_4x0.gameBoardTile.gameBoardTilePosition]];
	[outputPowerReceiverCollections_1_outputPowerReceivers addObject:[[SMBGenericPowerOutputTileEntity_OutputPowerReceiver_GameBoardTilePowerProvider alloc] init_with_gameBoardTilePosition_toPower:doorTileEntity_section_1_3xminus0.gameBoardTile.gameBoardTilePosition]];

	SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection* const outputPowerReceiverCollections_1_genericPowerOutputTileEntity_OutputPowerReceiverCollection =
	[[SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection alloc] init_with_outputPowerReceivers:outputPowerReceiverCollections_1_outputPowerReceivers];

	NSMutableSet<id<SMBGenericPowerOutputTileEntity_OutputPowerReceiver>>* const outputPowerReceiverCollections_2_outputPowerReceivers = [NSMutableSet<id<SMBGenericPowerOutputTileEntity_OutputPowerReceiver>> set];
	[outputPowerReceiverCollections_2_outputPowerReceivers addObject:[[SMBGenericPowerOutputTileEntity_OutputPowerReceiver_GameBoardTilePowerProvider alloc] init_with_gameBoardTilePosition_toPower:doorTileEntity_section_2_3x1.gameBoardTile.gameBoardTilePosition]];
	[outputPowerReceiverCollections_2_outputPowerReceivers addObject:[[SMBGenericPowerOutputTileEntity_OutputPowerReceiver_GameBoardTilePowerProvider alloc] init_with_gameBoardTilePosition_toPower:doorTileEntity_section_2_4x1.gameBoardTile.gameBoardTilePosition]];

	SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection* const outputPowerReceiverCollections_2_genericPowerOutputTileEntity_OutputPowerReceiverCollection =
	[[SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection alloc] init_with_outputPowerReceivers:outputPowerReceiverCollections_2_outputPowerReceivers];
	[outputPowerReceiverCollections_2_genericPowerOutputTileEntity_OutputPowerReceiverCollection setOutputPowerReceivers_powerIsOppositeOfReceiver:YES];

	NSMutableSet<id<SMBGenericPowerOutputTileEntity_OutputPowerReceiver>>* const outputPowerReceiverCollections_3_outputPowerReceivers = [NSMutableSet<id<SMBGenericPowerOutputTileEntity_OutputPowerReceiver>> set];
	[outputPowerReceiverCollections_3_outputPowerReceivers addObject:outputPowerReceiverCollections_1_genericPowerOutputTileEntity_OutputPowerReceiverCollection];
	[outputPowerReceiverCollections_3_outputPowerReceivers addObject:outputPowerReceiverCollections_2_genericPowerOutputTileEntity_OutputPowerReceiverCollection];

	SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection* const outputPowerReceiverCollections_3_genericPowerOutputTileEntity_OutputPowerReceiverCollection =
	[[SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection alloc] init_with_outputPowerReceivers:outputPowerReceiverCollections_3_outputPowerReceivers];

	NSMutableSet<id<SMBGenericPowerOutputTileEntity_OutputPowerReceiver>>* const outputPowerReceiverCollections_4_outputPowerReceivers = [NSMutableSet<id<SMBGenericPowerOutputTileEntity_OutputPowerReceiver>> set];
	[outputPowerReceiverCollections_4_outputPowerReceivers addObject:[[SMBGenericPowerOutputTileEntity_OutputPowerReceiver_GameBoardTilePowerProvider alloc] init_with_gameBoardTilePosition_toPower:beamCreatorEntity_unpowered_section_2_1xminus1.gameBoardTile.gameBoardTilePosition]];

	SMBGenericPowerOutputTileEntity_OutputPowerReceiver_GameBoardTilePowerProvider* const outputPowerReceiver_GameBoardTilePowerProvider_section_2_0xminus0 =
	[[SMBGenericPowerOutputTileEntity_OutputPowerReceiver_GameBoardTilePowerProvider alloc] init_with_gameBoardTilePosition_toPower:beamCreatorEntity_unpowered_section_2_0xminus0.gameBoardTile.gameBoardTilePosition];
	[outputPowerReceiverCollections_4_outputPowerReceivers addObject:outputPowerReceiver_GameBoardTilePowerProvider_section_2_0xminus0];

	NSMutableSet<id<SMBGenericPowerOutputTileEntity_OutputPowerReceiver>>* const outputPowerReceiverCollections_4_outputPowerReceivers_blacklisted = [NSMutableSet<id<SMBGenericPowerOutputTileEntity_OutputPowerReceiver>> set];
	[outputPowerReceiverCollections_4_outputPowerReceivers_blacklisted addObject:outputPowerReceiver_GameBoardTilePowerProvider_section_2_0xminus0];

	SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection* const outputPowerReceiverCollections_4_genericPowerOutputTileEntity_OutputPowerReceiverCollection =
	[[SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection alloc] init_with_outputPowerReceivers:outputPowerReceiverCollections_4_outputPowerReceivers];
	[outputPowerReceiverCollections_4_genericPowerOutputTileEntity_OutputPowerReceiverCollection setOutputPowerReceivers_blacklisted:outputPowerReceiverCollections_4_outputPowerReceivers_blacklisted];

	SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection_BlacklistToggler* const outputPowerReceiverCollections_4_genericPowerOutputTileEntity_OutputPowerReceiverCollection_Toggler =
	[[SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection_BlacklistToggler alloc] init_with_genericPowerOutputTileEntity_OutputPowerReceiverCollection:outputPowerReceiverCollections_4_genericPowerOutputTileEntity_OutputPowerReceiverCollection];

	NSMutableSet<id<SMBGenericPowerOutputTileEntity_OutputPowerReceiver>>* const outputPowerReceiverCollections_5_outputPowerReceivers = [NSMutableSet<id<SMBGenericPowerOutputTileEntity_OutputPowerReceiver>> set];
	[outputPowerReceiverCollections_5_outputPowerReceivers addObject:outputPowerReceiverCollections_4_genericPowerOutputTileEntity_OutputPowerReceiverCollection_Toggler];

	SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection* const outputPowerReceiverCollections_5_genericPowerOutputTileEntity_OutputPowerReceiverCollection =
	[[SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection alloc] init_with_outputPowerReceivers:outputPowerReceiverCollections_5_outputPowerReceivers];

	/* Power Buttons. */

	/* Section 1 -1x1 to Power Collection 4. */
	[gameBoard gameBoardTileEntity_add:[[SMBPowerButtonTileEntity alloc] init_with_outputPowerReceiverCollection:outputPowerReceiverCollections_4_genericPowerOutputTileEntity_OutputPowerReceiverCollection]
							entityType:SMBGameBoardTile__entityType_beamInteractions
			  to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:NSMaxRange(gameBoardTilePosition_section_1_columns_range) - 2
													row:gameBoardTilePosition_section_1_rows_range.location + 1]];

	/* Power Switches. */

	/* Section 1 2x0 to Section 1 beamCreatorEntity_unpowered position */
	[gameBoard gameBoardTileEntity_add:[[SMBPowerSwitchTileEntity alloc] init_with_outputPowerReceiverCollection:outputPowerReceiverCollections_3_genericPowerOutputTileEntity_OutputPowerReceiverCollection]
							entityType:SMBGameBoardTile__entityType_beamInteractions
			  to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:gameBoardTilePosition_section_1_columns_range.location + 2
													row:gameBoardTilePosition_section_1_rows_range.location]];

	/* Section 1 -1x0 to Door Group 1 */
	[gameBoard gameBoardTileEntity_add:[[SMBPowerSwitchTileEntity alloc] init_with_outputPowerReceiverCollection:outputPowerReceiverCollections_5_genericPowerOutputTileEntity_OutputPowerReceiverCollection]
							entityType:SMBGameBoardTile__entityType_beamInteractions
			  to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:NSMaxRange(gameBoardTilePosition_section_1_columns_range) - 2
													row:gameBoardTilePosition_section_1_rows_range.location]];

	/* Death blocks. */

	/* Section 1 -0x-0 */
	[gameBoard gameBoardTileEntity_add:[SMBDeathBlockTileEntity new]
							entityType:SMBGameBoardTile__entityType_beamInteractions
			  to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:NSMaxRange(gameBoardTilePosition_section_1_columns_range) - 1
													row:NSMaxRange(gameBoardTilePosition_section_1_rows_range) - 1]];

	/* Level exit. */

	[gameBoard gameBoardTileEntity_add_levelExit_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:gameBoardTilePosition_section_2_columns_range.location + 3
													row:gameBoardTilePosition_section_2_rows_range.location]];

	/* Usable game board tile entities. */

	NSMutableArray<SMBGameBoardTileEntity*>* const gameBoardTileEntities = [NSMutableArray<SMBGameBoardTileEntity*> array];
	[gameBoardTileEntities addObject:[[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_left]];
	[gameBoardTileEntities addObject:[[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_left]];
	[gameBoardTileEntities addObject:[[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_right]];

	return
	[[self alloc] init_with_gameBoard:gameBoard
		  usableGameBoardTileEntities:[NSArray<SMBGameBoardTileEntity*> arrayWithArray:gameBoardTileEntities]];
}

@end
