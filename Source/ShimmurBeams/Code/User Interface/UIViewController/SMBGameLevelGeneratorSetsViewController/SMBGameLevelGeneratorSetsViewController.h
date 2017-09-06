//
//  SMBGameLevelGeneratorSetsViewController.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/10/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import <UIKit/UIKit.h>





@class SMBGameLevelGeneratorSet;





@interface SMBGameLevelGeneratorSetsViewController : UIViewController

#pragma mark - gameLevelGeneratorSets
@property (nonatomic, strong, nullable) NSArray<SMBGameLevelGeneratorSet*>* gameLevelGeneratorSets;

@end
