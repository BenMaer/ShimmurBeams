//
//  SMBGenericGameLevelGeneratorViewController.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 1/11/18.
//  Copyright © 2018 Shimmur. All rights reserved.
//

#import <UIKit/UIKit.h>





@class SMBGameLevelGenerator;
@class SMBGameLevel;





@interface SMBGenericGameLevelGeneratorViewController : UIViewController

#pragma mark - gameLevelGenerator
@property (nonatomic, strong, nullable) SMBGameLevelGenerator* gameLevelGenerator;

#pragma mark - gameLevelGenerator_gameLevel
@property (nonatomic, readonly, strong, nullable) SMBGameLevel* gameLevelGenerator_gameLevel;
-(void)gameLevelGenerator_gameLevel_regenerate;
-(void)gameLevelGenerator_gameLevel_will_update;
-(void)gameLevelGenerator_gameLevel_did_update;

#pragma mark - gameLevelView
@property (nonatomic, assign) UIEdgeInsets gameLevelView_frame_insets;

#pragma mark - navigationItem_rightBarButtonItems
-(void)navigationItem_rightBarButtonItems_update;
-(nullable NSArray<UIBarButtonItem*>*)navigationItem_rightBarButtonItems_generate;

@end
