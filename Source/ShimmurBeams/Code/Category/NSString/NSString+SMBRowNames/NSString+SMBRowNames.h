//
//  NSString+SMBRowNames.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 11/9/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import <Foundation/Foundation.h>





@interface NSString (SMBRowNames)

#pragma mark - rowName
+(nonnull NSString*)smb_rowName_for_rowIndex:(NSUInteger)rowIndex;

@end
