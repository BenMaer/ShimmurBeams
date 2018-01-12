//
//  NSURL+SMBUserPath.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 1/11/18.
//  Copyright © 2018 Shimmur. All rights reserved.
//

#import "NSURL+SMBUserPath.h"





@implementation NSURL (SMBUserPath)

+(nullable instancetype)smb_userPath
{
	return [NSURL fileURLWithPath:@"user" isDirectory:YES];
}

@end
