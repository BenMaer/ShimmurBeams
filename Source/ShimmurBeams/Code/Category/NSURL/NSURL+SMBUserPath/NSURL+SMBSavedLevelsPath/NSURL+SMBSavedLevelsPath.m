//
//  NSURL+SMBSavedLevelsPath.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 1/12/18.
//  Copyright © 2018 Shimmur. All rights reserved.
//

#import "NSURL+SMBSavedLevelsPath.h"
#import "NSURL+SMBUserPath.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@implementation NSURL (SMBSavedLevelsPath)

+(nullable instancetype)smb_savedLevelsPath
{
	NSURL* const userPath = [self smb_userPath];

	return
	[self fileURLWithPath:@"saved levels"
			  isDirectory:YES
			relativeToURL:userPath];
}

+(nullable instancetype)smb_savedLevelPath_with_levelName:(nonnull NSString*)levelName
{
	kRUConditionalReturn_ReturnValueNil(levelName == nil, YES);

	NSURL* const savedLevelsPath_URL = [self smb_savedLevelsPath];
	kRUConditionalReturn_ReturnValueNil(savedLevelsPath_URL == nil, YES);

	NSRegularExpression* const regex = [NSRegularExpression regularExpressionWithPattern:@"[^a-zA-Z0-9_ ]+" options:0 error:nil];
	NSString* const name_forPath =
	[regex stringByReplacingMatchesInString:levelName
									options:0
									  range:NSMakeRange(0, levelName.length)
							   withTemplate:@"-"];

	kRUConditionalReturn_ReturnValueNil((name_forPath == nil)
										||
										(name_forPath.length == 0),
										YES);

	NSURL* const filePath_URL =
	[NSURL fileURLWithPath:name_forPath
			   isDirectory:YES
			 relativeToURL:savedLevelsPath_URL];
	kRUConditionalReturn_ReturnValueNil(filePath_URL == nil, YES);

	NSURL* const userPath = [self smb_userPath];

	return
	[self fileURLWithPath:@"saved levels"
			  isDirectory:YES
			relativeToURL:userPath];
}

@end
