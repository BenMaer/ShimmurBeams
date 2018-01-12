//
//  SMBSavedGameLevel.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 1/11/18.
//  Copyright © 2018 Shimmur. All rights reserved.
//

#import <Foundation/Foundation.h>





@interface SMBSavedGameLevel : NSObject

#pragma mark - name
@property (nonatomic, readonly, copy, nullable) NSString* name;

//#pragma mark - NSObject
//+(nonnull instancetype)new NS_UNAVAILABLE;
//-(nonnull instancetype)init NS_UNAVAILABLE;

//#pragma mark - init
//-(nullable instancetype)init_with_name:(nonnull NSString*)name
//							 gameLevel:(nonnull SMBGameLevel*)gameLevel NS_DESIGNATED_INITIALIZER;

@end
