//
//  SMBGameLevel+SMBPowerButtonsAndDoors.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/18/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameLevel+SMBPowerButtonsAndDoors.h"
#import "SMBGameBoard.h"
#import "SMBBeamCreatorTileEntity.h"
#import "SMBGameBoardTilePosition.h"
#import "SMBGameBoard+SMBAddEntity.h"
#import "SMBWallTileEntity.h"
#import "SMBForcedBeamRedirectTileEntity.h"
#import "SMBGameBoardTile.h"
#import "SMBDeathBlockTileEntity.h"
#import "SMBBeamRotateTileEntity.h"
#import "SMBDoorTileEntity.h"
#import "SMBDiagonalMirrorTileEntity.h"





@implementation SMBGameLevel (SMBPowerButtonsAndDoors)

#pragma mark - button
+(nonnull instancetype)smb_powerButton_introduction
{
	/*
	 Numbers = Sections

	 Entities:
	 BcP	Beam Creator Powered
	 Exi	Level Exit
	 Wal	Wall
	 PoB	Power Button
	 BcU	Beam Creator Unpowered

	 Usable:
	 Forced Redirect (direction: up) x2

	 Sections and entities:
	 [   ] [   ] [   ] [   ] [   ] [PoB] [   ]
	 [   ] [   ] [   ] [ 1 ] [   ] [   ] [   ]
	 [   ] [BcP] [   ] [   ] [   ] [   ] [   ]
	 [Wal] [Wal] [Wal] [Wal] [Wal] [Wal] [Wal]
	 [   ] [   ] [   ] [   ] [   ] [Exi] [   ]
	 [   ] [   ] [   ] [ 2 ] [   ] [   ] [   ]
	 [   ] [BcU] [   ] [   ] [   ] [   ] [   ]

	 B[x]	Button [x]
	 B[x]O	Button [x] Output
	 Wiring:
	 [   ] [   ] [   ] [   ] [   ] [B1 ] [   ]
	 [   ] [   ] [   ] [ 1 ] [   ] [   ] [   ]
	 [   ] [   ] [   ] [   ] [   ] [   ] [   ]
	 [Wal] [Wal] [Wal] [Wal] [Wal] [Wal] [Wal]
	 [   ] [   ] [   ] [   ] [   ] [   ] [   ]
	 [   ] [   ] [   ] [ 2 ] [   ] [   ] [   ]
	 [   ] [B1O] [   ] [   ] [   ] [   ] [   ]

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
	[gameBoard gameBoardTileEntity_add_powerButtonTileEntity_with_gameBoardTilePosition_toPower:beamCreatorEntity_unpowered.gameBoardTile.gameBoardTilePosition
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
	[gameBoardTileEntities addObject:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_up]];

	return
	[[self alloc] init_with_gameBoard:gameBoard
		  usableGameBoardTileEntities:[NSArray<SMBGameBoardTileEntity*> arrayWithArray:gameBoardTileEntities]];
}

+(nonnull instancetype)smb_powerButtons_3choices
{
	NSUInteger const numberOfChoices = 3;
	NSUInteger const wall_width = 1;
	SMBGameBoard* const gameBoard = [[SMBGameBoard alloc] init_with_numberOfColumns:(numberOfChoices * 2) + 1 + wall_width
																	   numberOfRows:(numberOfChoices * 2) - 1 + wall_width];

	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_up];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:0
													row:[gameBoard gameBoardTiles_numberOfRows] - 1]];

	[gameBoard gameBoardTileEntity_add_wall_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:0
													row:0]];

	NSUInteger const wall_column = numberOfChoices + 1;
	[gameBoard gameBoardTileEntities_add:
	 ^SMBGameBoardTileEntity * _Nullable(SMBGameBoardTilePosition * _Nonnull position) {
		 return [SMBWallTileEntity new];
	 }
							  entityType:SMBGameBoardTile__entityType_beamInteractions
								fillRect:YES
								 columns:
	 (NSRange){
		 .location	= wall_column,
		 .length	= wall_width,
	 }
									rows:
	 (NSRange){
		 .location	= 0,
		 .length	= [gameBoard gameBoardTiles_numberOfRows],
	 }];

	for (NSUInteger choice_index = 0;
		 choice_index < numberOfChoices;
		 choice_index++)
	{
		NSUInteger const offset = choice_index + 1;
		[gameBoard gameBoardTileEntity_for_beamInteractions_set:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_up]
									   to_gameBoardTilePosition:
		 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + offset
														row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - offset]];

		SMBBeamCreatorTileEntity* const beamCreatorEntity_unpowered = [SMBBeamCreatorTileEntity new];
		[beamCreatorEntity_unpowered setRequiresExternalPowerForBeam:YES];
		[beamCreatorEntity_unpowered setBeamDirection:SMBGameBoardTile__direction_up];

		[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity_unpowered
									   to_gameBoardTilePosition:[[SMBGameBoardTilePosition alloc] init_with_column:wall_column + offset
																											   row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row]];

		[gameBoard gameBoardTileEntity_add_powerButtonTileEntity_with_gameBoardTilePosition_toPower:beamCreatorEntity_unpowered.gameBoardTile.gameBoardTilePosition
																		   to_gameBoardTilePosition:
		 [[SMBGameBoardTilePosition alloc] init_with_column:offset
														row:0]];
	}

	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_right]
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:[gameBoard gameBoardTiles_numberOfColumns] - 3
													row:2]];

	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[SMBDeathBlockTileEntity new]
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:[gameBoard gameBoardTiles_numberOfColumns] - 1
													row:2]];

	[gameBoard gameBoardTileEntity_add_levelExit_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:wall_column + 1
													row:0]];

	NSMutableArray<SMBGameBoardTileEntity*>* const gameBoardTileEntities = [NSMutableArray<SMBGameBoardTileEntity*> array];
	[gameBoardTileEntities addObject:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_right]];
	[gameBoardTileEntities addObject:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_left]];

	return
	[[self alloc] init_with_gameBoard:gameBoard
		  usableGameBoardTileEntities:[NSArray<SMBGameBoardTileEntity*> arrayWithArray:gameBoardTileEntities]];
}

+(nonnull instancetype)smb_powerButtons_usableGameBoardTileEntities_choices
{
	NSUInteger const numberOfChoices = 3;
	NSUInteger const wall_width = 1;
	SMBGameBoard* const gameBoard = [[SMBGameBoard alloc] init_with_numberOfColumns:(numberOfChoices * 2) + 1 + wall_width
																	   numberOfRows:(numberOfChoices * 2) - 1 + wall_width];

	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_up];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:0
													row:[gameBoard gameBoardTiles_numberOfRows] - 1]];

	[gameBoard gameBoardTileEntity_add_wall_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:0
													row:0]];

	NSUInteger const wall_column = numberOfChoices + 1;
	[gameBoard gameBoardTileEntities_add:
	 ^SMBGameBoardTileEntity * _Nullable(SMBGameBoardTilePosition * _Nonnull position) {
		 return [SMBWallTileEntity new];
	 }
							  entityType:SMBGameBoardTile__entityType_beamInteractions
								fillRect:YES
								 columns:
	 (NSRange){
		 .location	= wall_column,
		 .length	= wall_width,
	 }
									rows:
	 (NSRange){
		 .location	= 0,
		 .length	= [gameBoard gameBoardTiles_numberOfRows],
	 }];

	for (NSUInteger choice_index = 0;
		 choice_index < numberOfChoices;
		 choice_index++)
	{
		NSUInteger const offset = choice_index + 1;
		[gameBoard gameBoardTileEntity_for_beamInteractions_set:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_up]
									   to_gameBoardTilePosition:
		 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + offset
														row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - offset]];

		SMBBeamCreatorTileEntity* const beamCreatorEntity_unpowered = [SMBBeamCreatorTileEntity new];
		[beamCreatorEntity_unpowered setRequiresExternalPowerForBeam:YES];
		[beamCreatorEntity_unpowered setBeamDirection:SMBGameBoardTile__direction_up];

		[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity_unpowered
									   to_gameBoardTilePosition:[[SMBGameBoardTilePosition alloc] init_with_column:wall_column + offset
																											   row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row]];

		[gameBoard gameBoardTileEntity_add_powerButtonTileEntity_with_gameBoardTilePosition_toPower:beamCreatorEntity_unpowered.gameBoardTile.gameBoardTilePosition
																		   to_gameBoardTilePosition:
		 [[SMBGameBoardTilePosition alloc] init_with_column:offset
														row:0]];
	}

	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_right]
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:[gameBoard gameBoardTiles_numberOfColumns] - 3
													row:2]];

	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_right]
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:[gameBoard gameBoardTiles_numberOfColumns] - 2
													row:3]];

	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[SMBDeathBlockTileEntity new]
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:[gameBoard gameBoardTiles_numberOfColumns] - 1
													row:2]];

	[gameBoard gameBoardTileEntity_add_levelExit_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:wall_column + 1
													row:0]];

	NSMutableArray<SMBGameBoardTileEntity*>* const gameBoardTileEntities = [NSMutableArray<SMBGameBoardTileEntity*> array];
	[gameBoardTileEntities addObject:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_right]];
	[gameBoardTileEntities addObject:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_left]];

	return
	[[self alloc] init_with_gameBoard:gameBoard
		  usableGameBoardTileEntities:[NSArray<SMBGameBoardTileEntity*> arrayWithArray:gameBoardTileEntities]];
}

+(nonnull instancetype)smb_powerButtons_windows_3x3
{
	NSUInteger const cell_width = 3;
	NSUInteger const cell_height = 3;
	NSUInteger const cells_width = 3;
	NSUInteger const cells_height = 3;
	NSUInteger const wall_width = 1;

	SMBGameBoard* const gameBoard = [[SMBGameBoard alloc] init_with_numberOfColumns:(cells_width * cell_width) + ((cells_width * wall_width) - 1)
																	   numberOfRows:(cells_height * cell_height) + ((cells_height * wall_width) - 1)];

	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_up];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:floor((CGFloat)[gameBoard gameBoardTiles_numberOfColumns] / 2.0f)
													row:[gameBoard gameBoardTiles_numberOfRows] - 1]];

	for (NSUInteger wall_column_index = 1;
		 wall_column_index < cells_width;
		 wall_column_index++)
	{
		[gameBoard gameBoardTileEntities_add:
		 ^SMBGameBoardTileEntity * _Nullable(SMBGameBoardTilePosition * _Nonnull position) {
			 return [SMBWallTileEntity new];
		 }
								  entityType:SMBGameBoardTile__entityType_beamInteractions
									fillRect:YES
									 columns:
		 (NSRange){
			 .location	= (wall_column_index * (cell_width + wall_width)) - 1,
			 .length	= wall_width,
		 }
										rows:
		 (NSRange){
			 .location	= 0,
			 .length	= [gameBoard gameBoardTiles_numberOfRows],
		 }];
	}

	for (NSUInteger wall_row_index = 1;
		 wall_row_index < cells_width;
		 wall_row_index++)
	{
		[gameBoard gameBoardTileEntities_add:
		 ^SMBGameBoardTileEntity * _Nullable(SMBGameBoardTilePosition * _Nonnull position) {
			 return [SMBWallTileEntity new];
		 }
								  entityType:SMBGameBoardTile__entityType_beamInteractions
									fillRect:YES
									 columns:
		 (NSRange){
			 .location	= 0,
			 .length	= [gameBoard gameBoardTiles_numberOfColumns],
		 }
										rows:
		 (NSRange){
			 .location	= (wall_row_index * (cell_height + wall_width)) - 1,
			 .length	= wall_width,
		 }];
	}

	NSUInteger(^column_for_cellXIndex)(NSUInteger cellColumn, NSUInteger cellXOffset) = ^NSUInteger(NSUInteger cellColumn, NSUInteger cellXOffset) {
		NSAssert(cellColumn < cells_width, @"cellColumn should be less than cells_width");
		NSAssert(cellXOffset < cell_width, @"cellXOffset should be less than cell_width");

		return (cellColumn * (cell_width + wall_width)) + cellXOffset;
	};

	NSUInteger(^row_for_rowXIndex)(NSUInteger cellRow, NSUInteger cellYOffset) = ^NSUInteger(NSUInteger cellRow, NSUInteger cellYOffset) {
		NSAssert(cellRow < cells_height, @"cellRow should be less than cells_height");
		NSAssert(cellYOffset < cell_height, @"cellYOffset should be less than cell_height");

		return (cellRow * (cell_height + wall_width)) + cellYOffset;
	};

	/*
	 + Un-powered beam creators.
	 */

	SMBBeamCreatorTileEntity* const beamCreatorEntity_unpowered_1x2_bottom = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity_unpowered_1x2_bottom setRequiresExternalPowerForBeam:YES];
	[beamCreatorEntity_unpowered_1x2_bottom setBeamDirection:SMBGameBoardTile__direction_up];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity_unpowered_1x2_bottom
								   to_gameBoardTilePosition:[[SMBGameBoardTilePosition alloc] init_with_column:column_for_cellXIndex(0, 1)
																										   row:row_for_rowXIndex(1, 2)]];

	SMBBeamCreatorTileEntity* const beamCreatorEntity_unpowered_2x2_right = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity_unpowered_2x2_right setRequiresExternalPowerForBeam:YES];
	[beamCreatorEntity_unpowered_2x2_right setBeamDirection:SMBGameBoardTile__direction_left];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity_unpowered_2x2_right
								   to_gameBoardTilePosition:[[SMBGameBoardTilePosition alloc] init_with_column:column_for_cellXIndex(1, 2)
																										   row:row_for_rowXIndex(1, 1)]];

	SMBBeamCreatorTileEntity* const beamCreatorEntity_unpowered_2x1_left = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity_unpowered_2x1_left setRequiresExternalPowerForBeam:YES];
	[beamCreatorEntity_unpowered_2x1_left setBeamDirection:SMBGameBoardTile__direction_right];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity_unpowered_2x1_left
								   to_gameBoardTilePosition:[[SMBGameBoardTilePosition alloc] init_with_column:column_for_cellXIndex(1, 0)
																										   row:row_for_rowXIndex(0, 1)]];

	SMBBeamCreatorTileEntity* const beamCreatorEntity_unpowered_3x3_bottomRight = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity_unpowered_3x3_bottomRight setRequiresExternalPowerForBeam:YES];
	[beamCreatorEntity_unpowered_3x3_bottomRight setBeamDirection:SMBGameBoardTile__direction_left];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity_unpowered_3x3_bottomRight
								   to_gameBoardTilePosition:[[SMBGameBoardTilePosition alloc] init_with_column:column_for_cellXIndex(2, 2)
																										   row:row_for_rowXIndex(2, 2)]];

	SMBBeamCreatorTileEntity* const beamCreatorEntity_unpowered_1x1_bottom = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity_unpowered_1x1_bottom setRequiresExternalPowerForBeam:YES];
	[beamCreatorEntity_unpowered_1x1_bottom setBeamDirection:SMBGameBoardTile__direction_up];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity_unpowered_1x1_bottom
								   to_gameBoardTilePosition:[[SMBGameBoardTilePosition alloc] init_with_column:column_for_cellXIndex(0, 1)
																										   row:row_for_rowXIndex(0, 2)]];

	SMBBeamCreatorTileEntity* const beamCreatorEntity_unpowered_2x1_right = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity_unpowered_2x1_right setRequiresExternalPowerForBeam:YES];
	[beamCreatorEntity_unpowered_2x1_right setBeamDirection:SMBGameBoardTile__direction_left];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity_unpowered_2x1_right
								   to_gameBoardTilePosition:[[SMBGameBoardTilePosition alloc] init_with_column:column_for_cellXIndex(1, 2)
																										   row:row_for_rowXIndex(0, 1)]];

	SMBBeamCreatorTileEntity* const beamCreatorEntity_unpowered_1x3_right = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity_unpowered_1x3_right setRequiresExternalPowerForBeam:YES];
	[beamCreatorEntity_unpowered_1x3_right setBeamDirection:SMBGameBoardTile__direction_left];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity_unpowered_1x3_right
								   to_gameBoardTilePosition:[[SMBGameBoardTilePosition alloc] init_with_column:column_for_cellXIndex(0, 2)
																										   row:row_for_rowXIndex(2, 1)]];


	SMBBeamCreatorTileEntity* const beamCreatorEntity_unpowered_3x3_right = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity_unpowered_3x3_right setRequiresExternalPowerForBeam:YES];
	[beamCreatorEntity_unpowered_3x3_right setBeamDirection:SMBGameBoardTile__direction_right];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity_unpowered_3x3_right
								   to_gameBoardTilePosition:[[SMBGameBoardTilePosition alloc] init_with_column:column_for_cellXIndex(2, 0)
																										   row:row_for_rowXIndex(2, 1)]];

	SMBBeamCreatorTileEntity* const beamCreatorEntity_unpowered_3x2_bottom = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity_unpowered_3x2_bottom setRequiresExternalPowerForBeam:YES];
	[beamCreatorEntity_unpowered_3x2_bottom setBeamDirection:SMBGameBoardTile__direction_up];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity_unpowered_3x2_bottom
								   to_gameBoardTilePosition:[[SMBGameBoardTilePosition alloc] init_with_column:column_for_cellXIndex(2, 1)
																										   row:row_for_rowXIndex(1, 2)]];

	SMBBeamCreatorTileEntity* const beamCreatorEntity_unpowered_2x2_left = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity_unpowered_2x2_left setRequiresExternalPowerForBeam:YES];
	[beamCreatorEntity_unpowered_2x2_left setBeamDirection:SMBGameBoardTile__direction_right];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity_unpowered_2x2_left
								   to_gameBoardTilePosition:[[SMBGameBoardTilePosition alloc] init_with_column:column_for_cellXIndex(1, 0)
																										   row:row_for_rowXIndex(1, 1)]];

	SMBBeamCreatorTileEntity* const beamCreatorEntity_unpowered_1x3_bottomLeft = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity_unpowered_1x3_bottomLeft setRequiresExternalPowerForBeam:YES];
	[beamCreatorEntity_unpowered_1x3_bottomLeft setBeamDirection:SMBGameBoardTile__direction_right];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity_unpowered_1x3_bottomLeft
								   to_gameBoardTilePosition:[[SMBGameBoardTilePosition alloc] init_with_column:column_for_cellXIndex(0, 0)
																										   row:row_for_rowXIndex(2, 2)]];

	SMBBeamCreatorTileEntity* const beamCreatorEntity_unpowered_3x1_bottom = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity_unpowered_3x1_bottom setRequiresExternalPowerForBeam:YES];
	[beamCreatorEntity_unpowered_3x1_bottom setBeamDirection:SMBGameBoardTile__direction_up];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity_unpowered_3x1_bottom
								   to_gameBoardTilePosition:[[SMBGameBoardTilePosition alloc] init_with_column:column_for_cellXIndex(2, 1)
																										   row:row_for_rowXIndex(0, 2)]];

	/*
	 - Un-powered beam creators.
	 */

	/*
	 + Power buttons.
	 */

	/* 1x1 top to 1x2 bottom */
	[gameBoard gameBoardTileEntity_add_powerButtonTileEntity_with_gameBoardTilePosition_toPower:beamCreatorEntity_unpowered_1x2_bottom.gameBoardTile.gameBoardTilePosition
																	   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:column_for_cellXIndex(0, 1)
													row:row_for_rowXIndex(0, 0)]];

	/* 1x1 left to 3x1 bottom */
	[gameBoard gameBoardTileEntity_add_powerButtonTileEntity_with_gameBoardTilePosition_toPower:beamCreatorEntity_unpowered_3x1_bottom.gameBoardTile.gameBoardTilePosition
																	   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:column_for_cellXIndex(0, 0)
													row:row_for_rowXIndex(0, 1)]];

	/* 1x1 right to 2x2 left */
	[gameBoard gameBoardTileEntity_add_powerButtonTileEntity_with_gameBoardTilePosition_toPower:beamCreatorEntity_unpowered_2x2_left.gameBoardTile.gameBoardTilePosition
																	   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:column_for_cellXIndex(0, 2)
													row:row_for_rowXIndex(0, 1)]];

	/* 1x2 top to 2x2 right */
	[gameBoard gameBoardTileEntity_add_powerButtonTileEntity_with_gameBoardTilePosition_toPower:beamCreatorEntity_unpowered_2x2_right.gameBoardTile.gameBoardTilePosition
																	   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:column_for_cellXIndex(0, 1)
													row:row_for_rowXIndex(1, 0)]];

	/* 1x2 left to 2x1 left */
	[gameBoard gameBoardTileEntity_add_powerButtonTileEntity_with_gameBoardTilePosition_toPower:beamCreatorEntity_unpowered_2x1_left.gameBoardTile.gameBoardTilePosition
																	   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:column_for_cellXIndex(0, 0)
													row:row_for_rowXIndex(1, 1)]];

	/* 1x3 left to 3x3 bottom right */
	[gameBoard gameBoardTileEntity_add_powerButtonTileEntity_with_gameBoardTilePosition_toPower:beamCreatorEntity_unpowered_3x3_bottomRight.gameBoardTile.gameBoardTilePosition
																	   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:column_for_cellXIndex(0, 0)
													row:row_for_rowXIndex(2, 1)]];

	/* 1x3 top to 1x1 bottom */
	[gameBoard gameBoardTileEntity_add_powerButtonTileEntity_with_gameBoardTilePosition_toPower:beamCreatorEntity_unpowered_1x1_bottom.gameBoardTile.gameBoardTilePosition
																	   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:column_for_cellXIndex(0, 1)
													row:row_for_rowXIndex(2, 0)]];

	/* 2x2 top to 2x1 right */
	[gameBoard gameBoardTileEntity_add_powerButtonTileEntity_with_gameBoardTilePosition_toPower:beamCreatorEntity_unpowered_2x1_right.gameBoardTile.gameBoardTilePosition
																	   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:column_for_cellXIndex(1, 1)
													row:row_for_rowXIndex(1, 0)]];

	/* 2x3 left to 1x3 right */
	[gameBoard gameBoardTileEntity_add_powerButtonTileEntity_with_gameBoardTilePosition_toPower:beamCreatorEntity_unpowered_1x3_right.gameBoardTile.gameBoardTilePosition
																	   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:column_for_cellXIndex(1, 0)
													row:row_for_rowXIndex(2, 1)]];

	/* 2x3 right to 3x3 left */
	[gameBoard gameBoardTileEntity_add_powerButtonTileEntity_with_gameBoardTilePosition_toPower:beamCreatorEntity_unpowered_3x3_right.gameBoardTile.gameBoardTilePosition
																	   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:column_for_cellXIndex(1, 2)
													row:row_for_rowXIndex(2, 1)]];

	/* 3x1 top to 3x2 bottom */
	[gameBoard gameBoardTileEntity_add_powerButtonTileEntity_with_gameBoardTilePosition_toPower:beamCreatorEntity_unpowered_3x2_bottom.gameBoardTile.gameBoardTilePosition
																	   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:column_for_cellXIndex(2, 1)
													row:row_for_rowXIndex(0, 0)]];

	/* 3x1 right to 1x1 bottom */
	[gameBoard gameBoardTileEntity_add_powerButtonTileEntity_with_gameBoardTilePosition_toPower:beamCreatorEntity_unpowered_1x1_bottom.gameBoardTile.gameBoardTilePosition
																	   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:column_for_cellXIndex(2, 2)
													row:row_for_rowXIndex(0, 1)]];

	/* 3x1 left to 2x2 left */
	[gameBoard gameBoardTileEntity_add_powerButtonTileEntity_with_gameBoardTilePosition_toPower:beamCreatorEntity_unpowered_2x2_left.gameBoardTile.gameBoardTilePosition
																	   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:column_for_cellXIndex(2, 0)
													row:row_for_rowXIndex(0, 1)]];

	/* 3x2 right to 2x2 left */
	[gameBoard gameBoardTileEntity_add_powerButtonTileEntity_with_gameBoardTilePosition_toPower:beamCreatorEntity_unpowered_2x2_left.gameBoardTile.gameBoardTilePosition
																	   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:column_for_cellXIndex(2, 2)
													row:row_for_rowXIndex(1, 1)]];

	/* 3x2 top to 2x2 left */
	[gameBoard gameBoardTileEntity_add_powerButtonTileEntity_with_gameBoardTilePosition_toPower:beamCreatorEntity_unpowered_2x2_left.gameBoardTile.gameBoardTilePosition
																	   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:column_for_cellXIndex(2, 1)
													row:row_for_rowXIndex(1, 0)]];

	/* 3x3 right to 1x3 bottom left */
	[gameBoard gameBoardTileEntity_add_powerButtonTileEntity_with_gameBoardTilePosition_toPower:beamCreatorEntity_unpowered_1x3_bottomLeft.gameBoardTile.gameBoardTilePosition
																	   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:column_for_cellXIndex(2, 2)
													row:row_for_rowXIndex(2, 1)]];

	/* 3x3 top to 3x1 bottom */
	[gameBoard gameBoardTileEntity_add_powerButtonTileEntity_with_gameBoardTilePosition_toPower:beamCreatorEntity_unpowered_3x1_bottom.gameBoardTile.gameBoardTilePosition
																	   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:column_for_cellXIndex(2, 1)
													row:row_for_rowXIndex(2, 0)]];

	/*
	 - Power buttons.
	 */

	[gameBoard gameBoardTileEntity_add_levelExit_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:floor((CGFloat)[gameBoard gameBoardTiles_numberOfColumns] / 2.0f)
													row:0]];

	NSMutableArray<SMBGameBoardTileEntity*>* const gameBoardTileEntities = [NSMutableArray<SMBGameBoardTileEntity*> array];
	[gameBoardTileEntities addObject:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_left]];
	[gameBoardTileEntities addObject:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_right]];
	[gameBoardTileEntities addObject:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_up]];
	[gameBoardTileEntities addObject:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_up]];

	return
	[[self alloc] init_with_gameBoard:gameBoard
		  usableGameBoardTileEntities:[NSArray<SMBGameBoardTileEntity*> arrayWithArray:gameBoardTileEntities]];
}


#pragma mark - buttons and doors
+(nonnull instancetype)smb_powerButtons_and_door_introduction
{
	NSUInteger const topHallway_height = 1;
	SMBGameBoard* const gameBoard =
	[[SMBGameBoard alloc] init_with_numberOfColumns:5
									   numberOfRows:4 + topHallway_height];

	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_up];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:0
													row:[gameBoard gameBoardTiles_numberOfRows] - 1]];

	NSUInteger const topWallStrip_row = topHallway_height;
	[gameBoard gameBoardTileEntities_add:
	 ^SMBGameBoardTileEntity * _Nullable(SMBGameBoardTilePosition * _Nonnull position) {
		 return [SMBWallTileEntity new];
	 }
							  entityType:SMBGameBoardTile__entityType_beamInteractions
								fillRect:YES
								 columns:
	 (NSRange){
		 .location	= 0,
		 .length	= [gameBoard gameBoardTiles_numberOfColumns] - 1,
	 }
									rows:
	 (NSRange){
		 .location	= topWallStrip_row,
		 .length	= 1,
	 }];

	NSUInteger const middleWallStrip_row = topWallStrip_row + 1;
	NSUInteger const middleWallStrip_column = [gameBoard gameBoardTiles_numberOfColumns] - 2;
	[gameBoard gameBoardTileEntities_add:
	 ^SMBGameBoardTileEntity * _Nullable(SMBGameBoardTilePosition * _Nonnull position) {
		 return [SMBWallTileEntity new];
	 }
							  entityType:SMBGameBoardTile__entityType_beamInteractions
								fillRect:YES
								 columns:
	 (NSRange){
		 .location	= middleWallStrip_column,
		 .length	= 1,
	 }
									rows:
	 (NSRange){
		 .location	= middleWallStrip_row,
		 .length	= [gameBoard gameBoardTiles_numberOfRows] - middleWallStrip_row,
	 }];

	/* Unpowered beam creator and button */
	SMBBeamCreatorTileEntity* const beamCreatorEntity_unpowered = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity_unpowered setRequiresExternalPowerForBeam:YES];
	[beamCreatorEntity_unpowered setBeamDirection:SMBGameBoardTile__direction_up];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity_unpowered
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:middleWallStrip_column + 1
													row:[gameBoard gameBoardTiles_numberOfRows] - 1]];

	[gameBoard gameBoardTileEntity_add_powerButtonTileEntity_with_gameBoardTilePosition_toPower:beamCreatorEntity_unpowered.gameBoardTile.gameBoardTilePosition
																	   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:1
													row:topWallStrip_row + 1]];

	/* Door and button */
	SMBDoorTileEntity* const doorTileEntity = [SMBDoorTileEntity new];
	[gameBoard gameBoardTileEntity_add:doorTileEntity
							entityType:SMBGameBoardTile__entityType_beamInteractions
			  to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:middleWallStrip_column + 1
													row:topWallStrip_row]];

	[gameBoard gameBoardTileEntity_add_powerButtonTileEntity_with_gameBoardTilePosition_toPower:doorTileEntity.gameBoardTile.gameBoardTilePosition
																	   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:2
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 1]];

	/* Level exit */
	[gameBoard gameBoardTileEntity_add_levelExit_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:0
													row:0]];

	NSMutableArray<SMBGameBoardTileEntity*>* const gameBoardTileEntities = [NSMutableArray<SMBGameBoardTileEntity*> array];
	[gameBoardTileEntities addObject:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_right]];
	[gameBoardTileEntities addObject:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_down]];
	[gameBoardTileEntities addObject:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_left]];

	return
	[[self alloc] init_with_gameBoard:gameBoard
		  usableGameBoardTileEntities:[NSArray<SMBGameBoardTileEntity*> arrayWithArray:gameBoardTileEntities]];
}

+(nonnull instancetype)smb_powerButtons_and_door_selfPoweredBeamCreator
{
	/*
	 Numbers = Sections
	 
	 Entities:
	 Bc[x]	Beam Creator
	 Exi	Level Exit
	 PoB	Power Button
	 PoS	Power Switch
	 Dor	Door
	 
	 Entity Notes:
	 - Bc1
	 *- direction: right
	 - Bc2
	 *- direction: down
	 *- requiresExternalPowerForBeam = YES
	 
	 Usable:
	 Forced Redirect (direction: down)
	 
	 Sections and entities:
	 [   ] [   ] [   ] [Bc2] [   ] [   ] [   ]
	 [   ] [Bc1] [   ] [   ] [   ] [   ] [   ]
	 [   ] [   ] [   ] [PoB] [   ] [Dor] [   ]
	 [   ] [   ] [   ] [PoS] [   ] [Exi] [   ]
	 
	 B[x]	Button [x]
	 B[x]O	Button [x] Output
	 S[x]	Switch [x]
	 S[x]O	Switch [x] Output
	 
	 Wiring:
	 [   ] [   ] [   ] [B1O] [   ] [   ] [   ]
	 [   ] [Bc1] [   ] [   ] [   ] [   ] [   ]
	 [   ] [   ] [   ] [B1 ] [   ] [B2O] [   ]
	 [   ] [   ] [   ] [B2 ] [   ] [Exi] [   ]
	 
	 */

	/* Game board. */

	SMBGameBoard* const gameBoard =
	[[SMBGameBoard alloc] init_with_numberOfColumns:7
									   numberOfRows:4];

	/* Initial beam creator. */
	
	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_right];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:1
													row:1]];

	/* Un-powered beam creators. */
	
	SMBBeamCreatorTileEntity* const beamCreatorEntity_unpowered_3x0 = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity_unpowered_3x0 setRequiresExternalPowerForBeam:YES];
	[beamCreatorEntity_unpowered_3x0 setBeamDirection:SMBGameBoardTile__direction_down];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity_unpowered_3x0
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:3
													row:0]];

	/* Doors */
	
	SMBDoorTileEntity* const doorTileEntity_minus1xminus1 = [SMBDoorTileEntity new];
	[gameBoard gameBoardTileEntity_add:doorTileEntity_minus1xminus1
							entityType:SMBGameBoardTile__entityType_beamInteractions
			  to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:[gameBoard gameBoardTiles_numberOfColumns] - 2
													row:[gameBoard gameBoardTiles_numberOfRows] - 2]];

	/* Power Buttons. */

	/* 3x-1 to 3x0 */
	[gameBoard gameBoardTileEntity_add_powerButtonTileEntity_with_gameBoardTilePosition_toPower:beamCreatorEntity_unpowered_3x0.gameBoardTile.gameBoardTilePosition
																	   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:3
													row:[gameBoard gameBoardTiles_numberOfRows] - 2]];

	/* 3x-0 to -1x-1 */
	[gameBoard gameBoardTileEntity_add_powerButtonTileEntity_with_gameBoardTilePosition_toPower:doorTileEntity_minus1xminus1.gameBoardTile.gameBoardTilePosition
																	   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:3
													row:[gameBoard gameBoardTiles_numberOfRows] - 1]];

	/* Level exit. */

	[gameBoard gameBoardTileEntity_add_levelExit_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:[gameBoard gameBoardTiles_numberOfColumns] - 2
													row:[gameBoard gameBoardTiles_numberOfRows] - 1]];
	
	/* Usable game board tile entities. */
	NSMutableArray<SMBGameBoardTileEntity*>* const gameBoardTileEntities = [NSMutableArray<SMBGameBoardTileEntity*> array];
	[gameBoardTileEntities addObject:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_down]];
	
	return
	[[self alloc] init_with_gameBoard:gameBoard
		  usableGameBoardTileEntities:[NSArray<SMBGameBoardTileEntity*> arrayWithArray:gameBoardTileEntities]];
}

+(nonnull instancetype)smb_powerButtons_and_doors_choices
{
	/*
	 Numbers = Sections

	 Entities:
	 BcP	Beam Creator Powered
	 Exi	Level Exit
	 Wal	Wall
	 PoB	Power Button
	 BcU	Beam Creator Unpowered
	 Dor	Door

	 Usable:
	 Beam Rotation (direction_rotation: left)
	 Beam Rotation (direction_rotation: right)
	 Forced Redirect (direction: right)
	 Beam Rotation (direction_rotation: right)
	 Diagonal Mirror (startingPosition: topLeft)

	 Sections and entities:
	 [BcU] [   ] [   ] [ 3 ] [   ] [   ] [BcU]
	 [   ] [   ] [   ] [Exi] [   ] [   ] [   ]
	 [Wal] [Wal] [Wal] [Wal] [Wal] [Wal] [Dor]
	 [PoB] [   ] [PoB] [Wal] [   ] [   ] [   ]
	 [   ] [PoB] [PoB] [Wal] [   ] [Pob] [   ]
	 [   ] [ 1 ] [   ] [Wal] [   ] [Dor] [   ]
	 [   ] [   ] [   ] [Wal] [BcU] [ 2 ] [BcU]
	 [   ] [   ] [   ] [Wal] [   ] [Dor] [   ]
	 [   ] [BcP] [   ] [Wal] [   ] [Pob] [   ]

	 B[x]	Button [x]
	 B[x]O	Button [x] Output
	 Wiring:
	 [B50] [   ] [   ] [ 3 ] [   ] [   ] [B60]
	 [   ] [   ] [   ] [   ] [   ] [   ] [   ]
	 [Wal] [Wal] [Wal] [Wal] [Wal] [Wal] [Dor]
	 [B4 ] [   ] [B3 ] [Wal] [   ] [   ] [   ]
	 [   ] [B1 ] [B2 ] [Wal] [   ] [B5 ] [   ]
	 [   ] [ 1 ] [   ] [Wal] [   ] [B40] [   ]
	 [   ] [   ] [   ] [Wal] [B1O] [ 2 ] [B2O]
	 [   ] [   ] [   ] [Wal] [   ] [B30] [   ]
	 [   ] [   ] [   ] [Wal] [   ] [B6 ] [   ]

	 */

	/* Initial constants. */

	NSUInteger const section_1_width = 3;
	NSUInteger const section_2_width = 3;
	NSUInteger const section_3_height = 2;

	/* Game board. */

	SMBGameBoard* const gameBoard =
	[[SMBGameBoard alloc] init_with_numberOfColumns:(section_1_width + section_2_width) + 1
									   numberOfRows:7 + section_3_height];

	/*
	 Section values.
	 */

	NSRange const gameBoardTilePosition_section_3_columns_range = (NSRange){
		.location	= 0,
		.length		= [gameBoard gameBoardTiles_numberOfColumns],
	};
	NSRange const gameBoardTilePosition_section_3_rows_range = (NSRange){
		.location	= 0,
		.length		= section_3_height,
	};

	NSRange const gameBoardTilePosition_wall_below_section_1_columns = (NSRange){
		.location	= 0,
		.length		= [gameBoard gameBoardTiles_numberOfColumns],
	};
	NSRange const gameBoardTilePosition_wall_below_section_1_rows = (NSRange){
		.location	= NSMaxRange(gameBoardTilePosition_section_3_rows_range),
		.length		= 1,
	};

	NSUInteger const gameBoardTilePosition_wall_between_sections_2_and_3_width = 1;
	NSRange const gameBoardTilePosition_wall_between_sections_2_and_3_columns = (NSRange){
		.location	= floor(([gameBoard gameBoardTiles_numberOfColumns] - gameBoardTilePosition_wall_between_sections_2_and_3_width) / 2.0f),
		.length		= gameBoardTilePosition_wall_between_sections_2_and_3_width,
	};
	NSUInteger const gameBoardTilePosition_wall_between_sections_2_and_3_location = NSMaxRange(gameBoardTilePosition_wall_below_section_1_rows);
	NSRange const gameBoardTilePosition_wall_between_sections_2_and_3_rows = (NSRange){
		.location	= gameBoardTilePosition_wall_between_sections_2_and_3_location,
		.length		= [gameBoard gameBoardTiles_numberOfRows] - gameBoardTilePosition_wall_between_sections_2_and_3_location,
	};

	NSRange const gameBoardTilePosition_section_1_columns_range = (NSRange){
		.location	= gameBoardTilePosition_wall_below_section_1_columns.location,
		.length		= section_1_width,
	};
	NSRange const gameBoardTilePosition_section_1_rows_range = (NSRange){
		.location	= gameBoardTilePosition_wall_between_sections_2_and_3_rows.location,
		.length		= gameBoardTilePosition_wall_between_sections_2_and_3_rows.length,
	};

	NSUInteger const gameBoardTilePosition_section_2_columns_location = NSMaxRange(gameBoardTilePosition_wall_between_sections_2_and_3_columns);
	NSRange const gameBoardTilePosition_section_2_columns_range = (NSRange){
		.location	= gameBoardTilePosition_section_2_columns_location,
		.length		= section_2_width,
	};
	NSRange const gameBoardTilePosition_section_2_rows_range = (NSRange){
		.location	= gameBoardTilePosition_wall_between_sections_2_and_3_rows.location,
		.length		= gameBoardTilePosition_wall_between_sections_2_and_3_rows.length,
	};

	/* Initial beam creator. */

	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_up];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:floor(NSMaxRange(gameBoardTilePosition_section_1_columns_range) / 2.0f)
													row:NSMaxRange(gameBoardTilePosition_section_1_rows_range) - 1]];

	/* Walls. */

	[gameBoard gameBoardTileEntities_add:
	 ^SMBGameBoardTileEntity * _Nullable(SMBGameBoardTilePosition * _Nonnull position) {
		 return [SMBWallTileEntity new];
	 }
							  entityType:SMBGameBoardTile__entityType_beamInteractions
								fillRect:YES
								 columns:gameBoardTilePosition_wall_below_section_1_columns
									rows:gameBoardTilePosition_wall_below_section_1_rows];

	[gameBoard gameBoardTileEntities_add:
	 ^SMBGameBoardTileEntity * _Nullable(SMBGameBoardTilePosition * _Nonnull position) {
		 return [SMBWallTileEntity new];
	 }
							  entityType:SMBGameBoardTile__entityType_beamInteractions
								fillRect:YES
								 columns:gameBoardTilePosition_wall_between_sections_2_and_3_columns
									rows:gameBoardTilePosition_wall_between_sections_2_and_3_rows];

	/* Beam direction changing entities. */

	[gameBoard gameBoardTileEntity_add:[[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_right]
							entityType:SMBGameBoardTile__entityType_beamInteractions
			  to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column - 1
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 1]];

	[gameBoard gameBoardTileEntity_add:[[SMBDiagonalMirrorTileEntity alloc] init_with_startingPosition:SMBDiagonalMirrorTileEntity_startingPosition_bottomLeft]
							entityType:SMBGameBoardTile__entityType_beamInteractions
			  to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 2]];

	[gameBoard gameBoardTileEntity_add:[[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_left]
							entityType:SMBGameBoardTile__entityType_beamInteractions
			  to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 1
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 3]];

	/* Un-powered beam creators. */

	SMBBeamCreatorTileEntity* const beamCreatorEntity_unpowered_section_2_0xminus2_right = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity_unpowered_section_2_0xminus2_right setRequiresExternalPowerForBeam:YES];
	[beamCreatorEntity_unpowered_section_2_0xminus2_right setBeamDirection:SMBGameBoardTile__direction_right];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity_unpowered_section_2_0xminus2_right
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:gameBoardTilePosition_section_2_columns_range.location
													row:NSMaxRange(gameBoardTilePosition_section_2_rows_range) - 3]];

	SMBBeamCreatorTileEntity* const beamCreatorEntity_unpowered_section_2_minus0xminus2_left = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity_unpowered_section_2_minus0xminus2_left setRequiresExternalPowerForBeam:YES];
	[beamCreatorEntity_unpowered_section_2_minus0xminus2_left setBeamDirection:SMBGameBoardTile__direction_left];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity_unpowered_section_2_minus0xminus2_left
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:NSMaxRange(gameBoardTilePosition_section_2_columns_range) - 1
													row:NSMaxRange(gameBoardTilePosition_section_2_rows_range) - 3]];

	SMBBeamCreatorTileEntity* const beamCreatorEntity_unpowered_section_3_0x0_right = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity_unpowered_section_3_0x0_right setRequiresExternalPowerForBeam:YES];
	[beamCreatorEntity_unpowered_section_3_0x0_right setBeamDirection:SMBGameBoardTile__direction_right];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity_unpowered_section_3_0x0_right
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:gameBoardTilePosition_section_3_columns_range.location
													row:gameBoardTilePosition_section_3_rows_range.location]];

	SMBBeamCreatorTileEntity* const beamCreatorEntity_unpowered_section_3_minus0x0_left = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity_unpowered_section_3_minus0x0_left setRequiresExternalPowerForBeam:YES];
	[beamCreatorEntity_unpowered_section_3_minus0x0_left setBeamDirection:SMBGameBoardTile__direction_left];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity_unpowered_section_3_minus0x0_left
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:NSMaxRange(gameBoardTilePosition_section_3_columns_range) - 1
													row:gameBoardTilePosition_section_3_rows_range.location]];

	/* Doors. */

	SMBDoorTileEntity* const door_section_2_minus1xminus3 = [SMBDoorTileEntity new];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:door_section_2_minus1xminus3
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:NSMaxRange(gameBoardTilePosition_section_2_columns_range) - 2
													row:NSMaxRange(gameBoardTilePosition_section_2_rows_range) - 4]];

	SMBDoorTileEntity* const door_section_2_minus1xminus1 = [SMBDoorTileEntity new];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:door_section_2_minus1xminus1
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:NSMaxRange(gameBoardTilePosition_section_2_columns_range) - 2
													row:NSMaxRange(gameBoardTilePosition_section_2_rows_range) - 2]];

	/* Power buttons. */

	/* Section 1 1x1 to Section 2 4x-2 */
	[gameBoard gameBoardTileEntity_add_powerButtonTileEntity_with_gameBoardTilePosition_toPower:beamCreatorEntity_unpowered_section_2_0xminus2_right.gameBoardTile.gameBoardTilePosition
																	   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:gameBoardTilePosition_section_1_columns_range.location + 1
													row:gameBoardTilePosition_section_1_rows_range.location + 1]];

	/* Section 1 2x1 to Section 2 -0x-2 */
	[gameBoard gameBoardTileEntity_add_powerButtonTileEntity_with_gameBoardTilePosition_toPower:beamCreatorEntity_unpowered_section_2_minus0xminus2_left.gameBoardTile.gameBoardTilePosition
																	   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:gameBoardTilePosition_section_1_columns_range.location + 2
													row:gameBoardTilePosition_section_1_rows_range.location + 1]];

	/* Section 1 0x0 to Section 2 -1x-3 */
	[gameBoard gameBoardTileEntity_add_powerButtonTileEntity_with_gameBoardTilePosition_toPower:door_section_2_minus1xminus3.gameBoardTile.gameBoardTilePosition
																	   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:gameBoardTilePosition_section_1_columns_range.location + 0
													row:gameBoardTilePosition_section_1_rows_range.location + 0]];

	/* Section 1 2x0 to Section 2 -1x-1 */
	[gameBoard gameBoardTileEntity_add_powerButtonTileEntity_with_gameBoardTilePosition_toPower:door_section_2_minus1xminus1.gameBoardTile.gameBoardTilePosition
																	   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:gameBoardTilePosition_section_1_columns_range.location + 2
													row:gameBoardTilePosition_section_1_rows_range.location + 0]];

	/* Section 2 1x1 to Section 3 0x0 */
	[gameBoard gameBoardTileEntity_add_powerButtonTileEntity_with_gameBoardTilePosition_toPower:beamCreatorEntity_unpowered_section_3_0x0_right.gameBoardTile.gameBoardTilePosition
																	   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:gameBoardTilePosition_section_2_columns_range.location + 1
													row:gameBoardTilePosition_section_2_rows_range.location + 1]];

	/* Section 2 1x-0 to Section 3 0x0 */
	[gameBoard gameBoardTileEntity_add_powerButtonTileEntity_with_gameBoardTilePosition_toPower:beamCreatorEntity_unpowered_section_3_minus0x0_left.gameBoardTile.gameBoardTilePosition
																	   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:gameBoardTilePosition_section_2_columns_range.location + 1
													row:NSMaxRange(gameBoardTilePosition_section_2_rows_range) - 1]];

	/* Level exit. */

	[gameBoard gameBoardTileEntity_add_levelExit_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:gameBoardTilePosition_section_3_columns_range.location + floor((double)gameBoardTilePosition_section_3_columns_range.length / 2.0f)
													row:NSMaxRange(gameBoardTilePosition_section_3_rows_range) - 1]];

	/* Usable game board tile entities. */
	NSMutableArray<SMBGameBoardTileEntity*>* const gameBoardTileEntities = [NSMutableArray<SMBGameBoardTileEntity*> array];
	[gameBoardTileEntities addObject:[[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_left]];
	[gameBoardTileEntities addObject:[[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_right]];
	[gameBoardTileEntities addObject:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_up]];
	[gameBoardTileEntities addObject:[[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_right]];
	[gameBoardTileEntities addObject:[[SMBDiagonalMirrorTileEntity alloc] init_with_startingPosition:SMBDiagonalMirrorTileEntity_startingPosition_topLeft]];

	return
	[[self alloc] init_with_gameBoard:gameBoard
		  usableGameBoardTileEntities:[NSArray<SMBGameBoardTileEntity*> arrayWithArray:gameBoardTileEntities]];
}

@end
