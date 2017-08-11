//
//  SMBWallTileEntity.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/10/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBWallTileEntity.h"





@implementation SMBWallTileEntity

#pragma mark - SMBGameBoardGeneralEntity: draw
-(void)draw_in_rect:(CGRect)rect
{
	[super draw_in_rect:rect];

	CGContextRef const context = UIGraphicsGetCurrentContext();

	CGContextSetFillColorWithColor(context, [UIColor darkGrayColor].CGColor);
	CGContextFillRect(context, rect);
}

@end
