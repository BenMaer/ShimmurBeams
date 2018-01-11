//
//  SMBRemoveEntityFromTileGameBoardMove.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 1/11/18.
//  Copyright © 2018 Shimmur. All rights reserved.
//

#import "SMBGameBoardMove.h"

#import <Foundation/Foundation.h>





@class SMBGameBoardTileEntity;




@interface SMBRemoveEntityFromTileGameBoardMove : NSObject <SMBGameBoardMove>

#pragma mark - NSObject
+(nonnull instancetype)new NS_UNAVAILABLE;
-(nonnull instancetype)init NS_UNAVAILABLE;

#pragma mark - init
-(nullable instancetype)init_with_gameBoardTileEntity:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity NS_DESIGNATED_INITIALIZER;

@end
