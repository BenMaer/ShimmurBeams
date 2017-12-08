//
//  NSString+SMBColumnNames.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 11/9/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "NSString+SMBColumnNames.h"

#import <ResplendentUtilities/RUConstants.h>





@implementation NSString (SMBColumnNames)

#pragma mark - columnName
+(nonnull NSString*)smb_columnName_for_columnIndex:(NSUInteger)columnIndex
{
	char const baseLetter = 'A';
	return RUStringWithFormat(@"%c",baseLetter + (char)columnIndex);
}

@end
