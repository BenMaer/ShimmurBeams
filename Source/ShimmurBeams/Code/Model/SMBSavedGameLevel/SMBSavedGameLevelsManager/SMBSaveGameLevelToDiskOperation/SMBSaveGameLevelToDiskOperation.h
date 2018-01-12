//
//  SMBSaveGameLevelToDiskOperation.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 1/11/18.
//  Copyright © 2018 Shimmur. All rights reserved.
//

#import <Foundation/Foundation.h>





@class SMBGameLevelMetaData;
@class SMBGameLevel;





@interface SMBSaveGameLevelToDiskOperation : NSObject

#pragma mark - gameLevelMetaData
@property (nonatomic, readonly, strong, nullable) SMBGameLevelMetaData* gameLevelMetaData;

#pragma mark - NSObject
+(nonnull instancetype)new NS_UNAVAILABLE;
-(nonnull instancetype)init NS_UNAVAILABLE;

#pragma mark - init
-(nullable instancetype)init_with_gameLevelMetaData:(nonnull SMBGameLevelMetaData*)gameLevelMetaData
										  gameLevel:(nonnull SMBGameLevel*)gameLevel NS_DESIGNATED_INITIALIZER;

#pragma mark - saveGameLevelToDisk
-(void)saveGameLevelToDisk;

@end
