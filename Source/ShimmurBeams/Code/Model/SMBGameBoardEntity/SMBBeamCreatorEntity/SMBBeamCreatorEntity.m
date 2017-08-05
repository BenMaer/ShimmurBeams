//
//  SMBBeamCreatorEntity.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/4/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBBeamCreatorEntity.h"

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>





@implementation SMBBeamCreatorEntity

#pragma mark - draw
-(void)drawRect:(CGRect)rect
{
	UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);

	CGContextRef const context_inside = UIGraphicsGetCurrentContext();

	CGContextSetStrokeColorWithColor(context_inside, [UIColor redColor].CGColor);
	CGContextSetLineWidth(context_inside, 1.0f);

	CGFloat const inset = CGRectGetWidth(rect) / 2.0f;

	CGContextMoveToPoint(context_inside, 0.0f, CGRectGetMaxY(rect)); /* Bottom left */
	CGContextAddLineToPoint(context_inside, inset, CGRectGetMaxY(rect)); /* Bottom left of machine */
	CGContextAddLineToPoint(context_inside, inset, CGRectGetMidY(rect)); /* Top left of machine */
	CGContextAddLineToPoint(context_inside, CGRectGetMaxX(rect) - inset, CGRectGetMidY(rect)); /* Top right of machine */
	CGContextAddLineToPoint(context_inside, CGRectGetMaxX(rect) - inset, CGRectGetMaxY(rect)); /* Bottom right of machine */
	CGContextAddLineToPoint(context_inside, CGRectGetMaxX(rect), CGRectGetMaxY(rect)); /* Bottom right */

	UIImage* const image_inside = UIGraphicsGetImageFromCurrentImageContext();

	UIGraphicsEndImageContext();

	[image_inside drawInRect:rect];
}

@end
