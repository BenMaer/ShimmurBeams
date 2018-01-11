//
//  SMBLevelEditorViewController.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 1/11/18.
//  Copyright © 2018 Shimmur. All rights reserved.
//

#import <UIKit/UIKit.h>





@class SMBLevelEditorCreationData;





@interface SMBLevelEditorViewController : UIViewController

#pragma mark - levelEditorCreationData
@property (nonatomic, strong, nullable) SMBLevelEditorCreationData* levelEditorCreationData;

@end
