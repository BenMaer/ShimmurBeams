//
//  SMBGameLevelMetaData.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 1/11/18.
//  Copyright © 2018 Shimmur. All rights reserved.
//

#import <Foundation/Foundation.h>





@interface SMBGameLevelMetaData : NSObject <NSCoding>

#pragma mark - name
@property (nonatomic, readonly, copy, nullable) NSString* name;

#pragma mark - hint
@property (nonatomic, readonly, copy, nullable) NSString* hint;

#pragma mark - NSObject
+(nonnull instancetype)new NS_UNAVAILABLE;
-(nonnull instancetype)init NS_UNAVAILABLE;

#pragma mark - init
-(nullable instancetype)init_with_name:(nonnull NSString*)name
								  hint:(nullable NSString*)hint NS_DESIGNATED_INITIALIZER;

#pragma mark - NSCoding
-(nullable instancetype)initWithCoder:(nonnull NSCoder*)aDecoder NS_DESIGNATED_INITIALIZER;

@end
