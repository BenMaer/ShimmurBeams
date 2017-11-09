//
//  NSString+SMBRowNames.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 11/9/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "NSString+SMBRowNames.h"

#import <ResplendentUtilities/RUConstants.h>





@implementation NSString (SMBRowNames)

#pragma mark - rowName
+(nonnull NSString*)smb_rowName_for_rowIndex:(NSUInteger)rowIndex
{
	char const baseLetter = 'A';
	return RUStringWithFormat(@"%lu",(unsigned long)rowIndex + 1);
}

@end
