//
//  SMBKeyArchiverManager.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 1/12/18.
//  Copyright © 2018 Shimmur. All rights reserved.
//

#import <Foundation/Foundation.h>





@interface SMBKeyArchiverManager : NSObject

#pragma mark - Singleton
+(nonnull instancetype)sharedInstance;

#pragma mark - unarchive
-(nullable id)unarchiveObject_withFile_atPath:(nonnull NSString*)filePath;

@end
