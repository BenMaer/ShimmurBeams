//
//  SMBMoveEntityToTileGameBoardMove.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 12/20/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardMove.h"

#import <Foundation/Foundation.h>





@class SMBGameBoardTilePosition;
@class SMBGameBoardTileEntity;





@interface SMBMoveEntityToTileGameBoardMove : NSObject <SMBGameBoardMove>

#pragma mark - NSObject
+(nonnull instancetype)new NS_UNAVAILABLE;
-(nonnull instancetype)init NS_UNAVAILABLE;

#pragma mark - init
-(nullable instancetype)init_with_gameBoardTilePosition:(nonnull SMBGameBoardTilePosition*)gameBoardTilePosition
									gameBoardTileEntity:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity NS_DESIGNATED_INITIALIZER;

@end
