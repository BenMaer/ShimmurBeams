//
//  SMBGameBoardTileView.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/9/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardTileView__Protocols.h"

#import <UIKit/UIKit.h>





@class SMBGameBoardTile;





@interface SMBGameBoardTileView : UIView

#pragma mark - gameBoardTile
@property (nonatomic, readonly, strong, nullable) SMBGameBoardTile* gameBoardTile;

#pragma mark - tapDelegate
@property (nonatomic, assign, nullable) id<SMBGameBoardTileView__tapDelegate> tapDelegate;

#pragma mark - init
-(nullable instancetype)init_with_gameBoardTile:(nonnull SMBGameBoardTile*)gameBoardTile NS_DESIGNATED_INITIALIZER;

@end
