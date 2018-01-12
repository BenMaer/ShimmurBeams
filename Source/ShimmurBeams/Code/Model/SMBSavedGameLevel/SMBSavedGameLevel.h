//
//  SMBSavedGameLevel.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 1/11/18.
//  Copyright © 2018 Shimmur. All rights reserved.
//

#import <Foundation/Foundation.h>





@class SMBGameLevelMetaData;





@interface SMBSavedGameLevel : NSObject

#pragma mark - gameLevelMetaData
@property (nonatomic, readonly, strong, nullable) SMBGameLevelMetaData* gameLevelMetaData;

#pragma mark - NSObject
+(nonnull instancetype)new NS_UNAVAILABLE;
-(nonnull instancetype)init NS_UNAVAILABLE;

#pragma mark - init
-(nullable instancetype)init_with_URL:(nonnull NSURL*)URL NS_DESIGNATED_INITIALIZER;

@end
