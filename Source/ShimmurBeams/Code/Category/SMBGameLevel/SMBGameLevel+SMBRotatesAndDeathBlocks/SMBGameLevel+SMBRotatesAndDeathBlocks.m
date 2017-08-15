//
//  SMBGameLevel+SMBRotatesAndDeathBlocks.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/15/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameLevel+SMBRotatesAndDeathBlocks.h"
#import "SMBGameBoard.h"
#import "SMBBeamCreatorTileEntity.h"
#import "SMBGameBoard+SMBAddEntity.h"
#import "SMBBeamRotateTileEntity.h"
#import "SMBGameBoardTile.h"
#import "SMBGameBoardTilePosition.h"
#import "SMBForcedBeamRedirectTileEntity.h"
#import "SMBDeathBlockTileEntity.h"





@implementation SMBGameLevel (SMBRotatesAndDeathBlocks)

+(nonnull instancetype)smb_rotates_oneRotate_right
{
	SMBGameBoard* const gameBoard = [[SMBGameBoard alloc] init_with_numberOfColumns:5
																	   numberOfRows:5];

	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_up];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:1
													row:[gameBoard gameBoardTiles_numberOfRows] - 2]];

	[gameBoard gameBoardTileEntity_add_levelExit_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:[gameBoard gameBoardTiles_numberOfColumns] - 2
													row:1]];

	NSMutableArray<SMBGameBoardTileEntity*>* const gameBoardTileEntity = [NSMutableArray<SMBGameBoardTileEntity*> array];

	SMBBeamRotateTileEntity* const beamRotateTileEntity_right = [[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_right];
	[gameBoardTileEntity addObject:beamRotateTileEntity_right];

	return
	[[self alloc] init_with_gameBoard:gameBoard
		  usableGameBoardTileEntities:[NSArray<SMBGameBoardTileEntity*> arrayWithArray:gameBoardTileEntity]];
}

+(nonnull instancetype)smb_rotates_two_left
{
	SMBGameBoard* const gameBoard = [[SMBGameBoard alloc] init_with_numberOfColumns:5
																	   numberOfRows:5];

	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_up];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:[gameBoard gameBoardTiles_numberOfColumns] - 2
													row:[gameBoard gameBoardTiles_numberOfRows] - 2]];

	[gameBoard gameBoardTileEntity_add_levelExit_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column - 2
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row]];

	NSMutableArray<SMBGameBoardTileEntity*>* const gameBoardTileEntity = [NSMutableArray<SMBGameBoardTileEntity*> array];

	[gameBoardTileEntity addObject:[[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_left]];

	[gameBoardTileEntity addObject:[[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_left]];

	return
	[[self alloc] init_with_gameBoard:gameBoard
		  usableGameBoardTileEntities:[NSArray<SMBGameBoardTileEntity*> arrayWithArray:gameBoardTileEntity]];
}

#pragma mark - rotates and forced
+(nonnull instancetype)smb_rotates_oneLeft_forced_oneLeft
{
	SMBGameBoard* const gameBoard = [[SMBGameBoard alloc] init_with_numberOfColumns:5
																	   numberOfRows:5];

	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_up];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:[gameBoard gameBoardTiles_numberOfColumns] - 2
													row:[gameBoard gameBoardTiles_numberOfRows] - 2]];

	[gameBoard gameBoardTileEntity_add_levelExit_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column - 2
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row]];

	NSMutableArray<SMBGameBoardTileEntity*>* const gameBoardTileEntity = [NSMutableArray<SMBGameBoardTileEntity*> array];

	[gameBoardTileEntity addObject:[[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_left]];

	[gameBoardTileEntity addObject:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_left]];

	return
	[[self alloc] init_with_gameBoard:gameBoard
		  usableGameBoardTileEntities:[NSArray<SMBGameBoardTileEntity*> arrayWithArray:gameBoardTileEntity]];
}

#pragma mark - rotates and wall
+(nonnull instancetype)smb_rotates_oneLeft_twoRight_wall_oneCenter
{
	SMBGameBoard* const gameBoard = [[SMBGameBoard alloc] init_with_numberOfColumns:7
																	   numberOfRows:7];

	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_up];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:floor((CGFloat)[gameBoard gameBoardTiles_numberOfColumns] / 2.0f)
													row:[gameBoard gameBoardTiles_numberOfRows] - 1]];

	[gameBoard gameBoardTileEntity_add_wall_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:floor((CGFloat)[gameBoard gameBoardTiles_numberOfColumns] / 2.0f)
													row:floor((CGFloat)[gameBoard gameBoardTiles_numberOfRows] / 2.0f)]];

	[gameBoard gameBoardTileEntity_add_levelExit_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column
													row:0]];

	NSMutableArray<SMBGameBoardTileEntity*>* const gameBoardTileEntity = [NSMutableArray<SMBGameBoardTileEntity*> array];

	[gameBoardTileEntity addObject:[[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_right]];
	[gameBoardTileEntity addObject:[[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_left]];
	[gameBoardTileEntity addObject:[[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_right]];

	return
	[[self alloc] init_with_gameBoard:gameBoard
		  usableGameBoardTileEntities:[NSArray<SMBGameBoardTileEntity*> arrayWithArray:gameBoardTileEntity]];
}

#pragma mark - rotates and death blocks
+(nonnull instancetype)smb_rotates_twoRight_deathBlock_one
{
	SMBGameBoard* const gameBoard = [[SMBGameBoard alloc] init_with_numberOfColumns:7
																	   numberOfRows:7];

	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_up];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:1
													row:[gameBoard gameBoardTiles_numberOfRows] - 2]];

	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[SMBDeathBlockTileEntity new]
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 2
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 2]];

	[gameBoard gameBoardTileEntity_add_levelExit_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:[gameBoard gameBoardTiles_numberOfColumns] - 2
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 2]];

	NSMutableArray<SMBGameBoardTileEntity*>* const gameBoardTileEntity = [NSMutableArray<SMBGameBoardTileEntity*> array];

	[gameBoardTileEntity addObject:[[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_right]];
	[gameBoardTileEntity addObject:[[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_right]];

	return
	[[self alloc] init_with_gameBoard:gameBoard
		  usableGameBoardTileEntities:[NSArray<SMBGameBoardTileEntity*> arrayWithArray:gameBoardTileEntity]];
}

+(nonnull instancetype)smb_rotates_twoRight_twoLeft_deathBlocks_surrounded_and_someBlocking
{
	SMBGameBoard* const gameBoard = [[SMBGameBoard alloc] init_with_numberOfColumns:7
																	   numberOfRows:7];

	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_up];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
									  to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:floor((CGFloat)[gameBoard gameBoardTiles_numberOfColumns] / 2.0f)
													row:[gameBoard gameBoardTiles_numberOfRows] - 2]];

	[gameBoard gameBoardTileEntity_add_wall_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column
													row:floor((CGFloat)[gameBoard gameBoardTiles_numberOfRows] / 2.0f)]];

	[gameBoard gameBoardTileEntity_add_levelExit_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column
													row:1]];

	[gameBoard gameBoardTileEntities_add:
	 ^SMBGameBoardTileEntity * _Nullable(SMBGameBoardTilePosition * _Nonnull position) {
		 return [SMBDeathBlockTileEntity new];
	 }
							  entityType:SMBGameBoardTile__entityType_beamInteractions
								fillRect:NO
								 columns:
	 (NSRange){
		 .location	= 0,
		 .length	= [gameBoard gameBoardTiles_numberOfColumns],
	 }
									rows:
	 (NSRange){
		 .location	= 0,
		 .length	= [gameBoard gameBoardTiles_numberOfRows],
	 }];

	NSMutableArray<SMBGameBoardTileEntity*>* const gameBoardTileEntity = [NSMutableArray<SMBGameBoardTileEntity*> array];

	[gameBoardTileEntity addObject:[[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_right]];
	[gameBoardTileEntity addObject:[[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_right]];
	[gameBoardTileEntity addObject:[[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_left]];
	[gameBoardTileEntity addObject:[[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_left]];

	return
	[[self alloc] init_with_gameBoard:gameBoard
		  usableGameBoardTileEntities:[NSArray<SMBGameBoardTileEntity*> arrayWithArray:gameBoardTileEntity]];
}

+(nonnull instancetype)smb_rotates_deathBlocks_blackAnglesMatter
{
	SMBGameBoard* const gameBoard = [[SMBGameBoard alloc] init_with_numberOfColumns:5
																	   numberOfRows:5];
	
	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_right];
	
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
									  to_gameBoardTilePosition:[[SMBGameBoardTilePosition alloc] init_with_column:0
																											  row:0]];
	
	[gameBoard gameBoardTileEntity_add_levelExit_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row + 1]];
	
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[SMBDeathBlockTileEntity new]
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 1
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row + 4]];
	
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_left]
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column + 1
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row + 1]];
	
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_left]
								   to_gameBoardTilePosition:[[SMBGameBoardTilePosition alloc] init_with_column:gameBoard.gameBoardTiles_numberOfColumns - 1 row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row +1 ]];
	
	NSMutableArray<SMBGameBoardTileEntity*>* const gameBoardTileEntity = [NSMutableArray<SMBGameBoardTileEntity*> array];
	[gameBoardTileEntity addObject:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_down]];
	[gameBoardTileEntity addObject:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_up]];
	
	return
	[[self alloc] init_with_gameBoard:gameBoard
		  usableGameBoardTileEntities:[NSArray<SMBGameBoardTileEntity*> arrayWithArray:gameBoardTileEntity]];
}

+(nonnull instancetype)smb_rotates_deathBlocks_scattered
{
	SMBGameBoard* const gameBoard = [[SMBGameBoard alloc] init_with_numberOfColumns:11
																	   numberOfRows:11];
	
	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_up];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
									  to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:floor((CGFloat)[gameBoard gameBoardTiles_numberOfColumns] / 2.0f)
													row:[gameBoard gameBoardTiles_numberOfRows] - 3]];
	
	[gameBoard gameBoardTileEntity_add_wall_to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 4]];
	
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:[[SMBForcedBeamRedirectTileEntity alloc] init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_right]
								   to_gameBoardTilePosition:
	 [[SMBGameBoardTilePosition alloc] init_with_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column - 2
													row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row - 2]];
	
	NSMutableArray<SMBGameBoardTileEntity*>* const gameBoardTileEntity = [NSMutableArray<SMBGameBoardTileEntity*> array];
	
	return
	[[self alloc] init_with_gameBoard:gameBoard
		  usableGameBoardTileEntities:[NSArray<SMBGameBoardTileEntity*> arrayWithArray:gameBoardTileEntity]];
}

@end
