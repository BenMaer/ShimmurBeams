//
//  SMBGameBoardTile.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/3/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import <Foundation/Foundation.h>





@class SMBGameBoardTilePosition;
@class SMBGameBoard;
@class SMBGameBoardEntity;





@interface SMBGameBoardTile : NSObject

#pragma mark - gameBoardTilePosition
@property (nonatomic, readonly, strong, nullable) SMBGameBoardTilePosition* gameBoardTilePosition;

#pragma mark - gameBoard
@property (nonatomic, readonly, assign, nullable) SMBGameBoard* gameBoard;

#pragma mark - gameBoardEntity
@property (nonatomic, strong, nullable) SMBGameBoardEntity* gameBoardEntity;

#pragma mark - init
-(nullable instancetype)init_with_gameBoardTilePosition:(nonnull SMBGameBoardTilePosition*)gameBoardTilePosition
											  gameBoard:(nonnull SMBGameBoard*)gameBoard NS_DESIGNATED_INITIALIZER;

@end





@interface SMBGameBoardTile_PropertiesForKVO : NSObject

+(nonnull NSString*)gameBoardEntity;

@end
