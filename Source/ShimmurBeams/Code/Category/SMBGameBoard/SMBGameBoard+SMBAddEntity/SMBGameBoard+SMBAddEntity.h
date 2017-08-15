//
//  SMBGameBoard+SMBAddEntity.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/5/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoard.h"
#import "SMBGameBoardTile__entityTypes.h"
#import "SMBGameBoard+SMBAddEntity__blocks.h"





@class SMBGameBoardTileEntity;
@class SMBGameBoardTilePosition;





@interface SMBGameBoard (SMBAddEntity)

#pragma mark - gameBoardTileEntity
-(void)gameBoardTileEntities_add:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
					  entityType:(SMBGameBoardTile__entityType)entityType
		   gameBoardTilePosition:(nonnull SMBGameBoardTilePosition*)gameBoardTilePosition;

-(void)gameBoardTileEntities_add:(nonnull SMBGameBoard_addEntity_createTileEntityAtPosition_block)createTileEntityAtPosition_block
					  entityType:(SMBGameBoardTile__entityType)entityType
		  gameBoardTilePositions:(nonnull NSArray<SMBGameBoardTilePosition*>*)gameBoardTilePositions;

-(void)gameBoardTileEntity_add:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
					entityType:(SMBGameBoardTile__entityType)entityType
					 to_column:(NSUInteger)column
						   row:(NSUInteger)row;

-(void)gameBoardTileEntity_add:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
					 to_column:(NSUInteger)column
						   row:(NSUInteger)row;

-(void)gameBoardTileEntity_for_beamInteractions_set:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
										  to_column:(NSUInteger)column
												row:(NSUInteger)row;

-(void)gameBoardTileEntities_add:(nonnull SMBGameBoard_addEntity_createTileEntityAtPosition_block)createTileEntityAtPosition_block
					  entityType:(SMBGameBoardTile__entityType)entityType
						fillRect:(BOOL)fillRect
						 columns:(NSRange)columns
							rows:(NSRange)rows;

#pragma mark - levelExit
-(void)gameBoardTileEntity_add_levelExit_to_column:(NSUInteger)column
											   row:(NSUInteger)row;

#pragma mark - wall
-(void)gameBoardTileEntity_add_wall_to_column:(NSUInteger)column
										  row:(NSUInteger)row;

@end
