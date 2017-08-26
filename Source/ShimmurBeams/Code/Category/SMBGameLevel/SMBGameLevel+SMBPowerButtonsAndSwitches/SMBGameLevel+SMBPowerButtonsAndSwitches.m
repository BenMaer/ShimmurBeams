//
//  SMBGameLevel+SMBPowerButtonsAndSwitches.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/18/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameLevel+SMBPowerButtonsAndSwitches.h"
#import "SMBGameBoard.h"
#import "SMBBeamCreatorTileEntity.h"
#import "SMBGameBoardTilePosition.h"
#import "SMBGameBoard+SMBAddEntity.h"
#import "SMBWallTileEntity.h"
#import "SMBForcedBeamRedirectTileEntity.h"
#import "SMBGameBoardTile.h"
#import "SMBDeathBlockTileEntity.h"
#import "SMBBeamRotateTileEntity.h"





@implementation SMBGameLevel (SMBPowerButtonsAndSwitches)

#pragma mark - button
+(nonnull instancetype)smb_button_introduction
{
	SMBGameBoard* const gameBoard = [[SMBGameBoard alloc] init_with_numberOfColumns:7
																	   numberOfRows:7];

	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_right];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
								   to_gameBoardTilePosition:[[SMBGameBoardTilePosition alloc] init_with_column:1
																										   row:2]];

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
		 .location	= floor((CGFloat)[gameBoard gameBoardTiles_numberOfColumns] / 2.0f),
		 .length	= 1,
	 }];

	SMBBeamCreatorTileEntity* const beamCreatorEntity_unpowered = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity_unpowered setRequiresExternalPowerForBeam:YES];
	[beamCreatorEntity_unpowered setBeamDirection:SMBGameBoardTile__direction_right];

	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity_unpowered
								   to_gameBoardTilePosition:[[SMBGameBoardTilePosition alloc] init_with_column:1
																										   row:[gameBoard gameBoardTiles_numberOfRows] - 1]];

	[gameBoard gameBoardTileEntity_add_powerButtonTileEntity_with_gameBoardTilePosition_toPower:beamCreatorEntity_unpowered.gameBoardTile.gameBoardTilePosition
																	   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:[gameBoard gameBoardTiles_numberOfColumns] - 2
													row:0]];

	[gameBoard gameBoardTileEntity_add_levelExit_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:[gameBoard gameBoardTiles_numberOfColumns] - 2
													row:floor((CGFloat)[gameBoard gameBoardTiles_numberOfColumns] / 2.0f) + 1]];

	NSMutableArray<SMBGameBoardTileEntity*>* const gameBoardTileEntities = [NSMutableArray<SMBGameBoardTileEntity*> array];
	[gameBoardTileEntities addObject:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_up]];
	[gameBoardTileEntities addObject:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_up]];

	return
	[[self alloc] init_with_gameBoard:gameBoard
		  usableGameBoardTileEntities:[NSArray<SMBGameBoardTileEntity*> arrayWithArray:gameBoardTileEntities]];

}

+(nonnull instancetype)smb_buttons_3choices
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

+(nonnull instancetype)smb_buttons_usableGameBoardTileEntities_choices
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

+(nonnull instancetype)smb_buttons_windows_3x3
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

@end
