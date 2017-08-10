//
//  SMBGameBoardTile.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/3/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardTile__directions.h"

#import <Foundation/Foundation.h>





@class SMBGameBoardTilePosition;
@class SMBGameBoard;
@class SMBGameBoardTileEntity;





@interface SMBGameBoardTile : NSObject

#pragma mark - gameBoardTilePosition
@property (nonatomic, readonly, strong, nullable) SMBGameBoardTilePosition* gameBoardTilePosition;

#pragma mark - gameBoard
@property (nonatomic, readonly, assign, nullable) SMBGameBoard* gameBoard;

#pragma mark - gameBoardTileEntity_for_beamInteractions
@property (nonatomic, strong, nullable) SMBGameBoardTileEntity* gameBoardTileEntity_for_beamInteractions;

#pragma mark - gameBoardTileEntities
@property (nonatomic, readonly, copy, nullable) NSArray<SMBGameBoardTileEntity*>* gameBoardTileEntities;
-(void)gameBoardTileEntities_add:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity;
-(void)gameBoardTileEntities_remove:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity;

#pragma mark - init
-(nullable instancetype)init_with_gameBoardTilePosition:(nonnull SMBGameBoardTilePosition*)gameBoardTilePosition
											  gameBoard:(nonnull SMBGameBoard*)gameBoard NS_DESIGNATED_INITIALIZER;

#pragma mark - gameBoardTile
-(nullable SMBGameBoardTile*)gameBoardTile_next_with_direction:(SMBGameBoardTile__direction)direction;

#pragma mark - isPowered
@property (nonatomic, readonly, assign) BOOL isPowered;

@end





@interface SMBGameBoardTile_PropertiesForKVO : NSObject

+(nonnull NSString*)gameBoardTileEntity_for_beamInteractions;
+(nonnull NSString*)gameBoardTileEntities;
+(nonnull NSString*)isPowered;

@end
