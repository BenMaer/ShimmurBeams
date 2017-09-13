//
//  NSNumber+SMBRandomNumbers.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 9/13/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "NSNumber+SMBRandomNumbers.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@implementation NSNumber (SMBRandomNumbers)

#pragma mark - Random Float
+(float)smb_randomFloatBetweenMin:(float)min max:(float)max
{
	kRUConditionalReturn_ReturnValue(min > max, YES, 0.0f);
	
	float difference = max - min;
	
	float randomValueBetween0And1 = ((float)rand() / RAND_MAX);
	
	NSTimeInterval nextSpawnTime = (randomValueBetween0And1 * difference) + min;
	kRUConditionalReturn_ReturnValue(nextSpawnTime < min, YES, min);
	kRUConditionalReturn_ReturnValue(nextSpawnTime > max, YES, max);
	
	return nextSpawnTime;
}

#pragma mark - Random Integer
+(u_int32_t)smb_randomIntegerBetweenMin:(u_int32_t)min max:(u_int32_t)max
{
	kRUConditionalReturn_ReturnValue(min >= max, YES, 0);
	
	u_int32_t difference = max - min;
	return arc4random_uniform(difference + 1) + min;
}

@end
