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





@implementation SMBGameLevel (SMBRotatesAndDeathBlocks)

+(nonnull instancetype)smb_rotates_oneRotate_right
{
	SMBGameBoard* const gameBoard = [[SMBGameBoard alloc] init_with_numberOfColumns:5
																	   numberOfRows:5];
	
	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_up];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
												  to_column:1
														row:[gameBoard gameBoardTiles_numberOfRows] - 2];
	
	[gameBoard gameBoardTileEntity_add_levelExit_to_column:[gameBoard gameBoardTiles_numberOfColumns] - 2
													   row:1];
	
	NSMutableArray<SMBGameBoardTileEntity*>* const gameBoardTileEntity = [NSMutableArray<SMBGameBoardTileEntity*> array];
	
	SMBBeamRotateTileEntity* const beamRotateTileEntity_right = [[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_right];
	[gameBoardTileEntity addObject:beamRotateTileEntity_right];

	return
	[[self alloc] init_with_gameBoard:gameBoard
		  usableGameBoardTileEntities:[NSArray<SMBGameBoardTileEntity*> arrayWithArray:gameBoardTileEntity]];
}

+(nonnull instancetype)smb_rotates_twoLefts_right
{
	SMBGameBoard* const gameBoard = [[SMBGameBoard alloc] init_with_numberOfColumns:5
																	   numberOfRows:5];
	
	SMBBeamCreatorTileEntity* const beamCreatorEntity = [SMBBeamCreatorTileEntity new];
	[beamCreatorEntity setBeamDirection:SMBGameBoardTile__direction_up];
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:beamCreatorEntity
												  to_column:[gameBoard gameBoardTiles_numberOfColumns] - 2
														row:[gameBoard gameBoardTiles_numberOfRows] - 2];

	[gameBoard gameBoardTileEntity_add_levelExit_to_column:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.column - 2
													   row:beamCreatorEntity.gameBoardTile.gameBoardTilePosition.row];

	NSMutableArray<SMBGameBoardTileEntity*>* const gameBoardTileEntity = [NSMutableArray<SMBGameBoardTileEntity*> array];
	
	[gameBoardTileEntity addObject:[[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_left]];

	[gameBoardTileEntity addObject:[[SMBBeamRotateTileEntity alloc] init_with_direction_rotation:SMBGameBoardTile__direction_rotation_left]];

	return
	[[self alloc] init_with_gameBoard:gameBoard
		  usableGameBoardTileEntities:[NSArray<SMBGameBoardTileEntity*> arrayWithArray:gameBoardTileEntity]];
}

@end
