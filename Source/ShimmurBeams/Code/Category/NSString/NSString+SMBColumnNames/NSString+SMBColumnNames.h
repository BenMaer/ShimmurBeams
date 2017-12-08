//
//  NSString+SMBColumnNames.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 11/9/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import <Foundation/Foundation.h>





@interface NSString (SMBColumnNames)

#pragma mark - columnName
+(nonnull NSString*)smb_columnName_for_columnIndex:(NSUInteger)columnIndex;

@end
