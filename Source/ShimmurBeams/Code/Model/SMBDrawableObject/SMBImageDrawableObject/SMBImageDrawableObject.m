//
//  SMBImageDrawableObject.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/30/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBImageDrawableObject.h"





@implementation SMBImageDrawableObject

#pragma mark - SMBDrawableObject: draw
-(void)draw_in_rect:(CGRect)rect
{
	[super draw_in_rect:rect];

	UIImage* const image =
	[self image_toDraw_in_rect:rect];

	if (image)
	{
		CGContextRef const context = UIGraphicsGetCurrentContext();

		CGContextSaveGState(context);

		[image drawInRect:rect];

		CGContextRestoreGState(context);
	}
}

#pragma mark - image
-(nullable UIImage*)image_toDraw_in_rect:(CGRect)rect
{
	NSAssert(false, @"This method should be overloaded");
	return nil;
}

@end
