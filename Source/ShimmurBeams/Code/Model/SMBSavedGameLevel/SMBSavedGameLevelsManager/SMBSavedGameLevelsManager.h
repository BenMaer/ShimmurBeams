//
//  SMBSavedGameLevelsManager.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 1/11/18.
//  Copyright © 2018 Shimmur. All rights reserved.
//

#import <Foundation/Foundation.h>





@class SMBSaveGameLevelToDiskOperation;
@class SMBSavedGameLevel;





@interface SMBSavedGameLevelsManager : NSObject

#pragma mark - Singleton
+(nonnull instancetype)sharedInstance;

#pragma mark - saveGameLevel
-(void)saveGameLevel_toDisk_with_operation:(nonnull SMBSaveGameLevelToDiskOperation*)saveGameLevelToDiskOperation;

#pragma mark - savedGameLevels
-(nullable NSArray<SMBSavedGameLevel*>*)savedGameLevels_fetch;

@end
