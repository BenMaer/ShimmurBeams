//
//  CoreGraphics+SMBDrawArrow.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/10/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#ifndef CoreGraphics_SMBDrawArrow_h
#define CoreGraphics_SMBDrawArrow_h

#import <CoreGraphics/CoreGraphics.h>

#import <ResplendentUtilities/UIView+RUUtility.h>
#import <ResplendentUtilities/UIGeometry+RUUtility.h>





static inline void CoreGraphics_SMBDrawArrow(CGContextRef context, CGRect rect){
	CGFloat const arrow_base_width = CGRectGetWidth(rect) / 2.0f;

	CGFloat const arrow_triangle_extraWidth = 4.0f;
	CGFloat const arrow_triangle_width = arrow_base_width + (2.0f * arrow_triangle_extraWidth);

	CGRect const arrow_triangle_frame = (CGRect){
		.origin.x		= CGRectGetMinX(rect) + CGRectGetHorizontallyAlignedXCoordForWidthOnWidth(arrow_triangle_width, CGRectGetWidth(rect)),
		.origin.y		= CGRectGetMinY(rect),
		.size.width		= arrow_triangle_width,
		.size.height	= arrow_triangle_width,
	};

	CGFloat const arrow_shaft_yCoord = CGRectGetMaxY(arrow_triangle_frame);
	CGRect const arrow_shaft_frame = (CGRect){
		.origin.x		= CGRectGetMinX(rect) + CGRectGetHorizontallyAlignedXCoordForWidthOnWidth(arrow_base_width, CGRectGetWidth(rect)),
		.origin.y		= arrow_shaft_yCoord,
		.size.width		= arrow_base_width,
		.size.height	= CGRectGetMaxY(rect) - CGRectGetMaxY(arrow_triangle_frame),
	};

	CGContextMoveToPoint(context, CGRectGetMinX(arrow_shaft_frame), CGRectGetMaxY(arrow_shaft_frame)); /* Shaft, bottom left */
	CGContextAddLineToPoint(context, CGRectGetMinX(arrow_shaft_frame), CGRectGetMinY(arrow_shaft_frame)); /* Shaft, top left */

	CGContextAddLineToPoint(context, CGRectGetMinX(arrow_triangle_frame), CGRectGetMaxY(arrow_triangle_frame)); /* Triangle, bottom left */
	CGContextAddLineToPoint(context, CGRectGetMidX(arrow_triangle_frame), CGRectGetMinY(arrow_triangle_frame)); /* Triangle, top middle point */
	CGContextAddLineToPoint(context, CGRectGetMaxX(arrow_triangle_frame), CGRectGetMaxY(arrow_triangle_frame)); /* Triangle, bottom right */

	CGContextAddLineToPoint(context, CGRectGetMaxX(arrow_shaft_frame), CGRectGetMinY(arrow_shaft_frame)); /* Shaft, top right */
	CGContextAddLineToPoint(context, CGRectGetMaxX(arrow_shaft_frame), CGRectGetMaxY(arrow_shaft_frame)); /* Shaft, bottom right */

	CGContextClosePath(context);

	CGContextStrokePath(context);
}

#endif /* CoreGraphics_SMBDrawArrow_h */
