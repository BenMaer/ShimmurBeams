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

	CGFloat const inset = CGRectGetWidth(rect) / 4.0f;

//	CGContextTranslateCTM(context_inside, rect.origin.x, rect.origin.y);
//	CGContextRotateCTM(context_inside, 90.0f/180.0f * M_PI);
//	CGContextTranslateCTM(context_inside, rect.size.width * -0.5, -rect.size.height);

//	CGContextTranslateCTM(context_inside, 0.0f, CGRectGetHeight(rect) / 2.0f);
//	CGContextTranslateCTM(context_inside, 0.0f, -CGRectGetHeight(rect) / 2.0f);
//	CGContextTranslateCTM(context_inside, -CGRectGetWidth(rect) / 2.0f, CGRectGetHeight(rect) / 2.0f);
//	CGContextRotateCTM(context_inside, 5.0f/180.0f * M_PI);
//	CGContextRotateCTM(context_inside, 20.0f/180.0f * M_PI);
//	CGContextRotateCTM(context_inside, 45.0f/180.0f * M_PI);

//	CGContextRotateCTM(context_inside, 90.0f/180.0f * M_PI);

//	CGContextTranslateCTM(context_inside, CGRectGetWidth(rect) / 2.0f, 0.0f);
//	CGContextTranslateCTM(context_inside, CGRectGetWidth(rect) / 2.0f, -CGRectGetHeight(rect) / 2.0f);
//	CGContextTranslateCTM(context_inside, CGRectGetWidth(rect) / 2.0f, CGRectGetHeight(rect) / 2.0f);

	CGContextMoveToPoint(context_inside, 0.0f, CGRectGetMaxY(rect)); /* Bottom left */
	CGContextAddLineToPoint(context_inside, inset, CGRectGetMaxY(rect)); /* Bottom left of machine */
	CGContextAddLineToPoint(context_inside, inset, CGRectGetMidY(rect)); /* Top left of machine */
	CGContextAddLineToPoint(context_inside, CGRectGetMaxX(rect) - inset, CGRectGetMidY(rect)); /* Top right of machine */
	CGContextAddLineToPoint(context_inside, CGRectGetMaxX(rect) - inset, CGRectGetMaxY(rect)); /* Bottom right of machine */
	CGContextAddLineToPoint(context_inside, CGRectGetMaxX(rect), CGRectGetMaxY(rect)); /* Bottom right */

	CGContextStrokePath(context_inside);

//	CGContextTranslateCTM(context_inside, CGRectGetWidth(rect) / 2.0f, CGRectGetHeight(rect) / 2.0f);

	UIImage* const image_inside = UIGraphicsGetImageFromCurrentImageContext();

	UIGraphicsEndImageContext();

//	CGContextDrawImage(UIGraphicsGetCurrentContext(), rect, image_inside.CGImage);
	[image_inside drawInRect:rect];
}

@end
