//
//  SMBImageDrawableObject.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/30/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBImageDrawableObject.h"

#import <ResplendentUtilities/UIView+RUUtility.h>





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

		CGSize const size = image.size;
		[image drawInRect:(CGRect){
			.origin.x	= CGRectGetMinX(rect) + CGRectGetHorizontallyAlignedXCoordForWidthOnWidth(size.width, CGRectGetWidth(rect)),
			.origin.y	= CGRectGetMinY(rect) + CGRectGetVerticallyAlignedYCoordForHeightOnHeight(size.height, CGRectGetHeight(rect)),
			.size		= size,
		}];

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
