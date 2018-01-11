//
//  SMBGameLevelCompletion.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/15/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameLevelCompletion__completionTypes.h"

#import <Foundation/Foundation.h>





/**
 Represents the completion of a level.
 
 If `failureReason` is nil, then this completion should be considered a success, otherwise it should be considered a failure.
 */
@interface SMBGameLevelCompletion : NSObject

#pragma mark - failureReason
@property (nonatomic, readonly, copy, nullable) NSString* failureReason;

#pragma mark - init
-(nullable instancetype)init_with_failureReason:(nullable NSString*)failureReason;

#pragma mark - completionType
-(SMBGameLevelCompletion__completionType)completionType;

@end
