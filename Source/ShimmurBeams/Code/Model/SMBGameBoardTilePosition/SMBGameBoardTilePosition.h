//
//  SMBGameBoardTilePosition.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/3/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import <Foundation/Foundation.h>





@interface SMBGameBoardTilePosition : NSObject

#pragma mark - column
@property (nonatomic, readonly, assign) NSUInteger column;

#pragma mark - row
@property (nonatomic, readonly, assign) NSUInteger row;

#pragma mark - init
/**
 Initializes an instance of this class.

 @param column The column on the game board. Values range from [0 - (n-1)].
 @param row The row on the game board. Values range from [0 - (n-1)].
 @return The initialized instance if there were no issues, otherwise nil.
 */
-(nullable instancetype)init_with_column:(NSUInteger)column
									 row:(NSUInteger)row NS_DESIGNATED_INITIALIZER;

#pragma mark - gameBoardTilePosition
-(BOOL)isEqual_to_gameBoardTilePosition:(nullable SMBGameBoardTilePosition*)gameBoardTilePosition;

@end
