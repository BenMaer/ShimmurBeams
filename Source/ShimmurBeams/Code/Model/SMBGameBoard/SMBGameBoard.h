//
//  SMBGameBoard.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/3/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import <Foundation/Foundation.h>





@class SMBGameBoardTile;
@class SMBGameBoardTilePosition;
@class SMBGameBoardTileEntity;





@interface SMBGameBoard : NSObject

#pragma mark - init
/**
 Initializes an instance of this class.

 @param numberOfColumns The number of columns this game board will have. Must be at least 1.
 @param numberOfRows The number of rows this game board will have. Must be at least 1.
 @return The initialized instance if there were no issues, otherwise nil.
 */
-(nullable instancetype)init_with_numberOfColumns:(NSUInteger)numberOfColumns
									 numberOfRows:(NSUInteger)numberOfRows NS_DESIGNATED_INITIALIZER;

#pragma mark - gameBoardTiles
/**
 Returns an instance of `SMBGameBoardTile` at the location given, if one is available at the given location.

 @param position (required) The position to return the tile at.
 @return an instance of `SMBGameBoardTile` at the location given, if one is available at the given location. Otherwise returns nil.
 */
-(nullable SMBGameBoardTile*)gameBoardTile_at_position:(nonnull SMBGameBoardTilePosition*)position;

-(NSUInteger)gameBoardTiles_numberOfColumns;
-(NSUInteger)gameBoardTiles_numberOfRows;

#pragma mark - gameBoardTileEntities
@property (nonatomic, readonly, copy, nullable) NSArray<SMBGameBoardTileEntity*>* gameBoardTileEntities;
-(void)gameBoardTileEntities_setupActions;

@end





@interface SMBGameBoard_PropertiesForKVO : NSObject

+(nonnull NSString*)gameBoardTileEntities;

@end
