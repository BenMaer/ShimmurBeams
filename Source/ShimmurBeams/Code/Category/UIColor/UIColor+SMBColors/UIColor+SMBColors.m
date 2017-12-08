//
//  UIColor+SMBColors.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/11/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "UIColor+SMBColors.h"





@implementation UIColor (SMBColors)

#pragma mark - selectedTileEntity
+(nullable instancetype)smb_selectedTileEntity_color_primary
{
	return [self greenColor];
}

+(nullable instancetype)smb_selectedTileEntity_color
{
	return [self redColor];
}

@end
