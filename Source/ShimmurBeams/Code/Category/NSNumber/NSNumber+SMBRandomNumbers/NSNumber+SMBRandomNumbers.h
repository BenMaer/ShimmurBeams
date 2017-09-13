//
//  NSNumber+SMBRandomNumbers.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 9/13/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import <Foundation/Foundation.h>





@interface NSNumber (SMBRandomNumbers)

#pragma mark - Random Float
+(float)smb_randomFloatBetweenMin:(float)min max:(float)max;

#pragma mark - Random Integer
+(u_int32_t)smb_randomIntegerBetweenMin:(u_int32_t)min max:(u_int32_t)max;

@end
