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
	NSArray<NSURL*>* const documentsDirectory_URLS = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
	NSURL* const documentsDirectory_URL = [documentsDirectory_URLS firstObject];

	return
	[self fileURLWithPath:@"user"
			  isDirectory:YES
			relativeToURL:documentsDirectory_URL];
}

@end
