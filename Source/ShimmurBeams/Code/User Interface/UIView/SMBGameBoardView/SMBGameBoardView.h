//
//  SMBGameBoardView.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/4/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardView__Protocols.h"

#import <UIKit/UIKit.h>





@class SMBGameBoard;
@class SMBGameBoardTilePosition;





@interface SMBGameBoardView : UIView

#pragma mark - gameBoard
@property (nonatomic, strong, nullable) SMBGameBoard* gameBoard;

#pragma mark - tileTapDelegate
@property (nonatomic, assign, nullable) id<SMBGameBoardView_tileTapDelegate> tileTapDelegate;

@end
