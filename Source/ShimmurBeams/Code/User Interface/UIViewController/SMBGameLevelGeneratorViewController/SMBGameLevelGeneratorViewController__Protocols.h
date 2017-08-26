//
//  SMBGameLevelGeneratorViewController__Protocols.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/14/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import <Foundation/Foundation.h>





@class SMBGameLevelGeneratorViewController;
@class SMBGameLevel;
@class UIBarButtonItem;





@protocol SMBGameLevelGeneratorViewController_gameLevelDidCompleteDelegate <NSObject>

-(void)gameLevelGeneratorViewController:(nonnull SMBGameLevelGeneratorViewController*)gameLevelGeneratorViewController
				   gameLevelDidComplete:(nonnull SMBGameLevel*)gameLevel;

@end





@protocol SMBGameLevelGeneratorViewController_levelCompletionBarButtonItemDelegate <NSObject>

-(nonnull UIBarButtonItem*)gameLevelGeneratorViewController_levelCompletionBarButtonItem:(nonnull SMBGameLevelGeneratorViewController*)gameLevelGeneratorViewController;

@end
