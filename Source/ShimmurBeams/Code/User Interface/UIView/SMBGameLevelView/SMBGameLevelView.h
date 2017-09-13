//
//  SMBGameLevelView.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/3/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import <UIKit/UIKit.h>





@class SMBGameLevel;





@interface SMBGameLevelView : UIView

#pragma mark - gameLevel
@property (nonatomic, strong, nullable) SMBGameLevel* gameLevel;

@end
