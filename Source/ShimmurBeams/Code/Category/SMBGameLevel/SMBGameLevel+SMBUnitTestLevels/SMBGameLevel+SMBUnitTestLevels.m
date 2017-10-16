//
//  SMBGameLevel+SMBUnitTestLevels.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 9/8/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameLevel+SMBUnitTestLevels.h"
#import "SMBGameBoard.h"
#import "SMBBeamCreatorTileEntity.h"
#import "SMBGameBoardTilePosition.h"
#import "SMBGameBoard+SMBAddEntity.h"
#import "SMBWallTileEntity.h"
#import "SMBForcedBeamRedirectTileEntity.h"
#import "SMBDoorTileEntity.h"
#import "SMBGameBoardTile.h"
#import "SMBDeathBlockTileEntity.h"
#import "SMBPowerButtonTileEntity.h"
#import "SMBGenericPowerOutputTileEntity_OutputPowerReceiver_GameBoardTilePowerProvider.h"
#import "SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection.h"
#import "SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection_BlacklistToggler.h"
#import "SMBBeamRotateTileEntity.h"
#import "SMBPowerSwitchTileEntity.h"





@implementation SMBGameLevel (SMBUnitTestLevels)

#pragma mark - initialBeamDrawing
+(nonnull instancetype)smb_initialBeamDrawing
{
	/*
	 Entities:
	 Bc[x]	Beam Creator

	 Entity Notes:
	 - Bc1
	 *- direction: up

	 Sections and entities:
	 [Bc1]

	 */

	/* Game board. */

	SMBGameBoard* const gameBoard =
	[[SMBGameBoard alloc] init_with_numberOfColumns:1
									   numberOfRows:1];
	/* Initial beam creator. */

	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_up];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:0
													row:0]];

	/* Usable game board tile entities. */

	NSMutableArray<SMBGameBoardTileEntity*>* const gameBoardTileEntities = [NSMutableArray<SMBGameBoardTileEntity*> array];

	return
	[[self alloc] init_with_gameBoard:gameBoard
		  usableGameBoardTileEntities:[NSArray<SMBGameBoardTileEntity*> arrayWithArray:gameBoardTileEntities]];
}

#pragma mark - beamEntityOrder
+(nonnull instancetype)smb_beamEntityOrder
{
	/*
	 Numbers = Sections

	 Entities:
	 Bc[x]	Beam Creator
	 Wal	Wall
	 PoB	Power Button
	 Dor	Door
	 Dth	Death block

	 Usable:
	 Forced Redirect (direction: right)

	 Entity Notes:
	 - Bc1
	 *- direction: up
	 - Bc2
	 *- direction: right
	 *- requiresExternalPowerForBeam = YES

	 Sections and entities:
	 [   ] [ 2 ] [   ]
	 [Bc2] [Dor] [Dth]
	 [Wal] [Wal] [Wal]
	 [   ] [PoB] [PoB]
	 [Bc1] [ 1 ] [   ]

	 B[x]	Button [x]
	 B[x]O	Button [x] Output
	 C[x]	Power Collection [x]
	 C[x]O	Power Collection [x] Output

	 Collection notes:
	 - C1
	 *- outputPowerReceivers_powerIsOppositeOfReceiver = YES

	 Wiring:
	 [   ] [ 2 ] [   ]
	 [B1O] [C1O] [   ]
	 [Wal] [Wal] [Wal]
	 [   ] [B1 ] [B2 ]
	 [   ] [ 1 ] [   ]

	 B2O:
	 - C1

	 */

	/* Initial constants. */

	NSUInteger const wall_between_sections_1_and_2_height = 1;
	NSUInteger const section_1_height = 2;
	NSUInteger const section_2_height = 2;

	/* Game board. */

	SMBGameBoard* const gameBoard = [[SMBGameBoard alloc] init_with_numberOfColumns:3
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
	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_up];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:gameBoardTilePosition_section_1_columns_range.location
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

	SMBBeamCreatorTileEntity* const beamCreatorEntity_unpowered_section_2_0xminus0 = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity_unpowered_section_2_0xminus0 setRequiresExternalPowerForBeam:YES];
	[beamCreatorEntity_unpowered_section_2_0xminus0 setBeamDirection:SMBGameBoardTile__direction_right];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity_unpowered_section_2_0xminus0
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:gameBoardTilePosition_section_2_columns_range.location
													row:NSMaxRange(gameBoardTilePosition_section_2_rows_range) - 1]];

	/* Doors */

	SMBDoorTileEntity* const doorTileEntity_section_2_1xminus0 = [SMBDoorTileEntity new];
	[gameBoard gameBoardTileEntity_add:doorTileEntity_section_2_1xminus0
							entityType:SMBGameBoardTile__entityType_beamInteractions
			  to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:gameBoardTilePosition_section_2_columns_range.location + 1
													row:NSMaxRange(gameBoardTilePosition_section_2_rows_range) - 1]];

	/* Output Power Receiver Collections. */

	NSMutableSet<SMBGenericPowerOutputTileEntity_OutputPowerReceiver*>* const outputPowerReceiverCollections_1_outputPowerReceivers = [NSMutableSet<SMBGenericPowerOutputTileEntity_OutputPowerReceiver*> set];
	[outputPowerReceiverCollections_1_outputPowerReceivers addObject:[[SMBGenericPowerOutputTileEntity_OutputPowerReceiver_GameBoardTilePowerProvider alloc] init_with_gameBoardTilePosition_toPower:doorTileEntity_section_2_1xminus0.gameBoardTile.gameBoardTilePosition]];

	SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection* const outputPowerReceiverCollections_1_genericPowerOutputTileEntity_OutputPowerReceiverCollection =
	[[SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection alloc] init_with_outputPowerReceivers:outputPowerReceiverCollections_1_outputPowerReceivers];
	[outputPowerReceiverCollections_1_genericPowerOutputTileEntity_OutputPowerReceiverCollection setOutputPowerReceivers_powerIsOppositeOfReceiver:YES];

	/* Power Buttons. */

	/* Section 1 1x0 to Section 2 0x-0. */
	[gameBoard gameBoardTileEntity_add_powerButtonTileEntity_with_gameBoardTilePosition_toPower:beamCreatorEntity_unpowered_section_2_0xminus0.gameBoardTile.gameBoardTilePosition
																	   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:gameBoardTilePosition_section_1_columns_range.location + 1
													row:gameBoardTilePosition_section_1_rows_range.location]];

	/* Section 1 2x0 to Power Collection 1. */
	[gameBoard gameBoardTileEntity_add:[[SMBPowerButtonTileEntity alloc] init_with_outputPowerReceiver:outputPowerReceiverCollections_1_genericPowerOutputTileEntity_OutputPowerReceiverCollection]
							entityType:SMBGameBoardTile__entityType_beamInteractions
			  to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:gameBoardTilePosition_section_1_columns_range.location + 2
													row:gameBoardTilePosition_section_1_rows_range.location]];

	/* Death blocks. */

	/* Section 2 -0x-0 */
	[gameBoard gameBoardTileEntity_add:[SMBDeathBlockTileEntity new]
							entityType:SMBGameBoardTile__entityType_beamInteractions
			  to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:NSMaxRange(gameBoardTilePosition_section_2_columns_range) - 1
													row:NSMaxRange(gameBoardTilePosition_section_2_rows_range) - 1]];

	/* Usable game board tile entities. */

	NSMutableArray<SMBGameBoardTileEntity*>* const gameBoardTileEntities = [NSMutableArray<SMBGameBoardTileEntity*> array];
	[gameBoardTileEntities addObject:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_right]];

	return
	[[self alloc] init_with_gameBoard:gameBoard
		  usableGameBoardTileEntities:[NSArray<SMBGameBoardTileEntity*> arrayWithArray:gameBoardTileEntities]];
}

#pragma mark - buttonPoweredImmediately
+(nonnull instancetype)smb_buttonPoweredImmediately
{
	/*
	 Entities:
	 Bc[x]	Beam Creator
	 PoB	Power Button

	 Entity Notes:
	 - Bc1
	 *- direction: right
	 - Bc2
	 *- direction: right
	 *- requiresExternalPowerForBeam = YES

	 Sections and entities:
	 [Bc2] [   ]
	 [Bc1] [PoB]

	 B[x]	Button [x]
	 B[x]O	Button [x] Output
	 C[x]	Power Collection [x]
	 C[x]O	Power Collection [x] Output

	 Wiring:
	 [C1O] [   ]
	 [   ] [B1 ]

	 B1O:
	 - C1

	 */

	/* Game board. */

	SMBGameBoard* const gameBoard = [[SMBGameBoard alloc] init_with_numberOfColumns:2
																	   numberOfRows:2];

	/* Initial beam creator. */

	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_right];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:0
													row:[gameBoard gameBoardTiles_numberOfRows] - 1]];

	/* Un-powered beam creators. */

	SMBBeamCreatorTileEntity* const beamCreatorEntity_unpowered_0x0 = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity_unpowered_0x0 setRequiresExternalPowerForBeam:YES];
	[beamCreatorEntity_unpowered_0x0 setBeamDirection:SMBGameBoardTile__direction_right];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity_unpowered_0x0
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:0
													row:0]];

	/* Output Power Receiver Collections. */

	NSMutableSet<SMBGenericPowerOutputTileEntity_OutputPowerReceiver*>* const outputPowerReceiverCollections_1_outputPowerReceivers = [NSMutableSet<SMBGenericPowerOutputTileEntity_OutputPowerReceiver*> set];
	[outputPowerReceiverCollections_1_outputPowerReceivers addObject:[[SMBGenericPowerOutputTileEntity_OutputPowerReceiver_GameBoardTilePowerProvider alloc] init_with_gameBoardTilePosition_toPower:beamCreatorEntity_unpowered_0x0.gameBoardTile.gameBoardTilePosition]];

	SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection* const outputPowerReceiverCollections_1_genericPowerOutputTileEntity_OutputPowerReceiverCollection =
	[[SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection alloc] init_with_outputPowerReceivers:outputPowerReceiverCollections_1_outputPowerReceivers];

	/* Power Buttons. */

	/* Section 1 -0x-0 to Power Collection 1. */
	[gameBoard gameBoardTileEntity_add:[[SMBPowerButtonTileEntity alloc] init_with_outputPowerReceiver:outputPowerReceiverCollections_1_genericPowerOutputTileEntity_OutputPowerReceiverCollection]
							entityType:SMBGameBoardTile__entityType_beamInteractions
			  to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:[gameBoard gameBoardTiles_numberOfColumns] - 1
													row:[gameBoard gameBoardTiles_numberOfRows] - 1]];

	return
	[[self alloc] init_with_gameBoard:gameBoard
		  usableGameBoardTileEntities:nil];
}

#pragma mark - beamCreatorPoweringItself
+(nonnull instancetype)smb_beamCreatorPoweringItself
{
	/*
	 Entities:
	 Bc[x]	Beam Creator
	 PoB	Power Button

	 Entity Notes:
	 - Bc1
	 *- direction: right
	 - Bc2
	 *- direction: down
	 *- requiresExternalPowerForBeam = YES

	 Usable:
	 Forced Redirect (direction: down)
	 Forced Redirect (direction: left)

	 Sections and entities:
	 [   ] [   ] [Bc2]
	 [Bc1] [   ] [   ]
	 [   ] [   ] [PoB]

	 B[x]	Button [x]
	 B[x]O	Button [x] Output

	 Wiring:
	 [   ] [   ] [B1O]
	 [   ] [   ] [   ]
	 [   ] [   ] [B1 ]

	 */

	/* Game board. */

	SMBGameBoard* const gameBoard = [[SMBGameBoard alloc] init_with_numberOfColumns:3
																	   numberOfRows:3];

	/* Initial beam creator. */

	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_right];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:0
													row:[gameBoard gameBoardTiles_numberOfRows] - 2]];

	/* Un-powered beam creators. */

	SMBBeamCreatorTileEntity* const beamCreatorEntity_unpowered_minus0x0 = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity_unpowered_minus0x0 setRequiresExternalPowerForBeam:YES];
	[beamCreatorEntity_unpowered_minus0x0 setBeamDirection:SMBGameBoardTile__direction_down];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity_unpowered_minus0x0
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:[gameBoard gameBoardTiles_numberOfColumns] - 1
													row:0]];

	/* Power Buttons. */

	/* Section 1 -0x-0 to -0x0. */
	[gameBoard gameBoardTileEntity_add_powerButtonTileEntity_with_gameBoardTilePosition_toPower:beamCreatorEntity_unpowered_minus0x0.gameBoardTile.gameBoardTilePosition
																	   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:[gameBoard gameBoardTiles_numberOfColumns] - 1
													row:[gameBoard gameBoardTiles_numberOfRows] - 1]];

	/* Usable game board tile entities. */

	NSMutableArray<SMBGameBoardTileEntity*>* const gameBoardTileEntities = [NSMutableArray<SMBGameBoardTileEntity*> array];
	[gameBoardTileEntities addObject:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_down]];
	[gameBoardTileEntities addObject:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_left]];

	return
	[[self alloc] init_with_gameBoard:gameBoard
		  usableGameBoardTileEntities:gameBoardTileEntities];
}

#pragma mark - powerToggle_beamEntityManagerStuck
+(nonnull instancetype)smb_powerToggle_beamEntityManagerStuck
{
	/*
	 Numbers = Sections

	 Entities:
	 Bc[x]	Beam Creator
	 Wal	Wall
	 PoS	Power Button
	 PoS	Power Switch

	 Entity Notes:
	 - Bc1
	 *- direction: right
	 - Bc2
	 *- direction: up
	 *- requiresExternalPowerForBeam = YES
	 - Bc3
	 *- direction: up
	 *- requiresExternalPowerForBeam = YES

	 Usable:
	 Beam Rotation (direction_rotation: left)

	 Sections and entities:
	 [ 1 ] [PoS] [Wal] [ 2 ] [   ]
	 [   ] [PoB] [Wal] [   ] [   ]
	 [Bc1] [   ] [Wal] [Bc2] [Bc3]

	 B[x]	Button [x]
	 B[x]O	Button [x] Output
	 S[x]	Switch [x]
	 S[x]O	Switch [x] Output
	 C[x]	Power Collection [x]
	 C[x]O	Power Collection [x] Output
	 T[X]	Power Collection Toggle [x]
	 T[X]O	Power Collection Toggle [x] Output

	 Collection notes:
	 - C1
	 *- Starting blacklist:
	 **- Section 2, 1x-0
	 - C2
	 *- Contains:
	 **- T1

	 Wiring:
	 [ 1 ] [S1 ] [Wal] [ 2 ] [   ]
	 [   ] [B1 ] [Wal] [   ] [   ]
	 [   ] [   ] [Wal] [C1O] [C1O]

	 B1O:
	 - C1
	 S1O:
	 - C2
	 T1O:
	 - Toggles blacklist on C1

	 */

	/* Initial constants. */

	NSUInteger const wall_between_sections_1_and_2_width = 1;
	NSUInteger const section_1_width = 2;
	NSUInteger const section_2_width = 2;

	/* Game board. */

	SMBGameBoard* const gameBoard =
	[[SMBGameBoard alloc] init_with_numberOfColumns:
	 (section_1_width
	  +
	  wall_between_sections_1_and_2_width
	  +
	  section_2_width
	  )
									   numberOfRows:3];

	/*
	 Section values.
	 */

	NSRange const gameBoardTilePosition_section_1_columns_range = (NSRange){
		.location	= 0,
		.length		= section_1_width,
	};
	NSRange const gameBoardTilePosition_section_1_rows_range = (NSRange){
		.location	= 0,
		.length		= [gameBoard gameBoardTiles_numberOfRows],
	};

	NSRange const gameBoardTilePosition_wall_between_sections_1_and_2_columns_range = (NSRange){
		.location	= NSMaxRange(gameBoardTilePosition_section_1_columns_range),
		.length		= wall_between_sections_1_and_2_width,
	};
	NSRange const gameBoardTilePosition_wall_between_sections_1_and_2_rows_range = (NSRange){
		.location	= 0,
		.length		= [gameBoard gameBoardTiles_numberOfRows],
	};

	NSRange const gameBoardTilePosition_section_2_columns_range = (NSRange){
		.location	= NSMaxRange(gameBoardTilePosition_wall_between_sections_1_and_2_columns_range),
		.length		= section_2_width,
	};
	NSRange const gameBoardTilePosition_section_2_rows_range = (NSRange){
		.location	= 0,
		.length		= [gameBoard gameBoardTiles_numberOfRows],
	};

	/* Walls. */

	[gameBoard gameBoardTileEntities_add:
	 ^SMBGameBoardTileEntity * _Nullable(SMBGameBoardTilePosition * _Nonnull position) {
		 return [SMBWallTileEntity new];
	 }
							  entityType:SMBGameBoardTile__entityType_beamInteractions
								fillRect:YES
								 columns:gameBoardTilePosition_wall_between_sections_1_and_2_columns_range
									rows:gameBoardTilePosition_wall_between_sections_1_and_2_rows_range];

	/* Initial beam creator. */

	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_right];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:gameBoardTilePosition_section_1_columns_range.location
													row:NSMaxRange(gameBoardTilePosition_section_1_rows_range) - 1]];

	/* Un-powered beam creators. */

	SMBBeamCreatorTileEntity* const beamCreatorEntity_unpowered_section_2_0xminus0 = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity_unpowered_section_2_0xminus0 setRequiresExternalPowerForBeam:YES];
	[beamCreatorEntity_unpowered_section_2_0xminus0 setBeamDirection:SMBGameBoardTile__direction_up];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity_unpowered_section_2_0xminus0
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:gameBoardTilePosition_section_2_columns_range.location
													row:NSMaxRange(gameBoardTilePosition_section_2_rows_range) - 1]];

	SMBBeamCreatorTileEntity* const beamCreatorEntity_unpowered_section_2_minus0xminus0 = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity_unpowered_section_2_minus0xminus0 setRequiresExternalPowerForBeam:YES];
	[beamCreatorEntity_unpowered_section_2_minus0xminus0 setBeamDirection:SMBGameBoardTile__direction_up];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity_unpowered_section_2_minus0xminus0
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:NSMaxRange(gameBoardTilePosition_section_2_columns_range) - 1
													row:NSMaxRange(gameBoardTilePosition_section_2_rows_range) - 1]];

	/* Output Power Receiver Collections. */

	NSMutableSet<SMBGenericPowerOutputTileEntity_OutputPowerReceiver*>* const outputPowerReceiverCollections_1_outputPowerReceivers = [NSMutableSet<SMBGenericPowerOutputTileEntity_OutputPowerReceiver*> set];
	[outputPowerReceiverCollections_1_outputPowerReceivers addObject:[[SMBGenericPowerOutputTileEntity_OutputPowerReceiver_GameBoardTilePowerProvider alloc] init_with_gameBoardTilePosition_toPower:beamCreatorEntity_unpowered_section_2_0xminus0.gameBoardTile.gameBoardTilePosition]];

	SMBGenericPowerOutputTileEntity_OutputPowerReceiver_GameBoardTilePowerProvider* const outputPowerReceiver_GameBoardTilePowerProvider_section_2_minus0xminus0 =
	[[SMBGenericPowerOutputTileEntity_OutputPowerReceiver_GameBoardTilePowerProvider alloc] init_with_gameBoardTilePosition_toPower:beamCreatorEntity_unpowered_section_2_minus0xminus0.gameBoardTile.gameBoardTilePosition];
	[outputPowerReceiverCollections_1_outputPowerReceivers addObject:outputPowerReceiver_GameBoardTilePowerProvider_section_2_minus0xminus0];

	NSMutableSet<SMBGenericPowerOutputTileEntity_OutputPowerReceiver*>* const outputPowerReceiverCollections_1_outputPowerReceivers_blacklisted = [NSMutableSet<SMBGenericPowerOutputTileEntity_OutputPowerReceiver*> set];
	[outputPowerReceiverCollections_1_outputPowerReceivers_blacklisted addObject:outputPowerReceiver_GameBoardTilePowerProvider_section_2_minus0xminus0];

	SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection* const outputPowerReceiverCollections_1_genericPowerOutputTileEntity_OutputPowerReceiverCollection =
	[[SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection alloc] init_with_outputPowerReceivers:outputPowerReceiverCollections_1_outputPowerReceivers];
	[outputPowerReceiverCollections_1_genericPowerOutputTileEntity_OutputPowerReceiverCollection setOutputPowerReceivers_blacklisted:outputPowerReceiverCollections_1_outputPowerReceivers_blacklisted];

	SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection_BlacklistToggler* const outputPowerReceiverCollections_1_genericPowerOutputTileEntity_OutputPowerReceiverCollection_Toggler =
	[[SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection_BlacklistToggler alloc] init_with_genericPowerOutputTileEntity_OutputPowerReceiverCollection:outputPowerReceiverCollections_1_genericPowerOutputTileEntity_OutputPowerReceiverCollection];

	NSMutableSet<SMBGenericPowerOutputTileEntity_OutputPowerReceiver*>* const outputPowerReceiverCollections_2_outputPowerReceivers = [NSMutableSet<SMBGenericPowerOutputTileEntity_OutputPowerReceiver*> set];
	[outputPowerReceiverCollections_2_outputPowerReceivers addObject:outputPowerReceiverCollections_1_genericPowerOutputTileEntity_OutputPowerReceiverCollection_Toggler];

	SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection* const outputPowerReceiverCollections_2_genericPowerOutputTileEntity_OutputPowerReceiverCollection =
	[[SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection alloc] init_with_outputPowerReceivers:outputPowerReceiverCollections_2_outputPowerReceivers];

	/* Power Buttons. */

	/* Section 1 -0x1 to Door Group 1 */
	[gameBoard gameBoardTileEntity_add:[[SMBPowerButtonTileEntity alloc] init_with_outputPowerReceiver:outputPowerReceiverCollections_1_genericPowerOutputTileEntity_OutputPowerReceiverCollection]
							entityType:SMBGameBoardTile__entityType_beamInteractions
			  to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:NSMaxRange(gameBoardTilePosition_section_1_columns_range) - 1
													row:gameBoardTilePosition_section_1_rows_range.location + 1]];
	/* Power Switches. */

	/* Section 1 -0x0 to Door Group 2 */
	[gameBoard gameBoardTileEntity_add:[[SMBPowerSwitchTileEntity alloc] init_with_outputPowerReceiver:outputPowerReceiverCollections_2_genericPowerOutputTileEntity_OutputPowerReceiverCollection]
							entityType:SMBGameBoardTile__entityType_beamInteractions
			  to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:NSMaxRange(gameBoardTilePosition_section_1_columns_range) - 1
													row:gameBoardTilePosition_section_1_rows_range.location]];

	/* Usable game board tile entities. */

	NSMutableArray<SMBGameBoardTileEntity*>* const gameBoardTileEntities = [NSMutableArray<SMBGameBoardTileEntity*> array];
	[gameBoardTileEntities addObject:[[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_left]];

	return
	[[self alloc] init_with_gameBoard:gameBoard
		  usableGameBoardTileEntities:[NSArray<SMBGameBoardTileEntity*> arrayWithArray:gameBoardTileEntities]];
}

@end
