//
//  SMBGameLevelGeneratorViewController.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/14/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameLevelGeneratorViewController__Protocols.h"

#import <UIKit/UIKit.h>





@class SMBGameLevelGenerator;





@interface SMBGameLevelGeneratorViewController : UIViewController

#pragma mark - gameLevelGenerator
@property (nonatomic, strong, nullable) SMBGameLevelGenerator* gameLevelGenerator;

#pragma mark - gameLevelGenerator_gameLevel
-(void)gameLevelGenerator_gameLevel_regenerate;

#pragma mark - gameLevelDidCompleteDelegate
@property (nonatomic, assign, nullable) id<SMBGameLevelGeneratorViewController_gameLevelDidCompleteDelegate> gameLevelDidCompleteDelegate;

#pragma mark - levelSuccessBarButtonItemDelegate
@property (nonatomic, assign, nullable) id<SMBGameLevelGeneratorViewController_levelSuccessBarButtonItemDelegate> levelSuccessBarButtonItemDelegate;

@end
