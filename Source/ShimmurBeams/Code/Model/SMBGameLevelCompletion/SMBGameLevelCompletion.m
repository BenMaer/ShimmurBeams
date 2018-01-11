//
//  SMBGameLevelCompletion.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/15/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameLevelCompletion.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@implementation SMBGameLevelCompletion

#pragma mark - init
-(nullable instancetype)init_with_failureReason:(nullable NSString*)failureReason
{
	if (self = [self init])
	{
		_failureReason = (failureReason ? [NSString stringWithString:failureReason] : nil);
	}

	return self;
}

#pragma mark - completionType
-(SMBGameLevelCompletion__completionType)completionType
{
	kRUConditionalReturn_ReturnValue(self.failureReason != nil, NO, SMBGameLevelCompletion__completionType_defeat);

	return SMBGameLevelCompletion__completionType_success;
}

@end
