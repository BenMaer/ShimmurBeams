//
//  SMBGameLevelView_UserSelection_GameBoardTile_HighlightData.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 11/8/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>





@class SMBGameBoardTile;





@interface SMBGameLevelView_UserSelection_GameBoardTile_HighlightData : NSObject

#pragma mark - gameBoardTile
@property (nonatomic, readonly, strong, nullable) SMBGameBoardTile* gameBoardTile;

#pragma mark - highlightColor
@property (nonatomic, readonly, strong, nullable) UIColor* highlightColor;

#pragma mark - init
-(nullable instancetype)init_with_gameBoardTile:(nonnull SMBGameBoardTile*)gameBoardTile
								 highlightColor:(nonnull UIColor*)highlightColor NS_DESIGNATED_INITIALIZER;

@end
