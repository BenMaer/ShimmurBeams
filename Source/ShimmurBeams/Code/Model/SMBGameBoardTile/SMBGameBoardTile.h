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
@class SMBBeamEntityTileNode;





@interface SMBGameBoardTile : NSObject

#pragma mark - gameBoardTilePosition
@property (nonatomic, readonly, strong, nullable) SMBGameBoardTilePosition* gameBoardTilePosition;

#pragma mark - gameBoard
@property (nonatomic, readonly, assign, nullable) SMBGameBoard* gameBoard;

#pragma mark - gameBoardTileEntity
@property (nonatomic, strong, nullable) SMBGameBoardTileEntity* gameBoardTileEntity;

#pragma mark - beamEntityTileNodes
@property (nonatomic, readonly, copy, nullable) NSArray<SMBBeamEntityTileNode*>* beamEntityTileNodes;
-(void)beamEntityTileNodes_add:(nonnull SMBBeamEntityTileNode*)beamEntityTileNode;
-(void)beamEntityTileNodes_remove:(nonnull SMBBeamEntityTileNode*)beamEntityTileNode;

#pragma mark - init
-(nullable instancetype)init_with_gameBoardTilePosition:(nonnull SMBGameBoardTilePosition*)gameBoardTilePosition
											  gameBoard:(nonnull SMBGameBoard*)gameBoard NS_DESIGNATED_INITIALIZER;

#pragma mark - gameBoardTile
-(nullable SMBGameBoardTile*)gameBoardTile_next_with_direction:(SMBGameBoardTile__direction)direction;

@end





@interface SMBGameBoardTile_PropertiesForKVO : NSObject

+(nonnull NSString*)gameBoardTileEntity;
+(nonnull NSString*)beamEntityTileNodes;

@end
