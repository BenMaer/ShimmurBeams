//
//  SMBGameLevelCompletion.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/15/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameLevelCompletion.h"





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

@end
