//
//  SMBBlockDrawableObject+SMBDefaultBlockDrawings.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/30/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBBlockDrawableObject+SMBDefaultBlockDrawings.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/UIView+RUUtility.h>





@implementation SMBBlockDrawableObject (SMBDefaultBlockDrawings)

#pragma mark - beamCreatorTileEntity
+(nullable instancetype)smb_defaultBlockDrawing_beamCreatorTileEntity_drawableObject_with_powerIndicatorColorRefBlock:(CGColorRef _Nonnull (^)(void))powerIndicatorColorRefBlock
{
	kRUConditionalReturn_ReturnValueNil(powerIndicatorColorRefBlock == nil, YES);

	return
	[self SMBBlockDrawableObject_with_drawBlock:
	 ^(CGRect rect) {
		 SMBBlockDrawableObject_SMBDefaultBlockDrawings__beamCreatorTileEntity_draw(UIGraphicsGetCurrentContext(),
																					rect,
																					powerIndicatorColorRefBlock());
	 }];
}

void SMBBlockDrawableObject_SMBDefaultBlockDrawings__beamCreatorTileEntity_draw(CGContextRef _Nonnull context, CGRect rect, CGColorRef _Nullable powerIndicatorColorRef)
{
	kRUConditionalReturn(context == nil, YES);

	CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
	CGContextSetLineWidth(context, 1.0f);
	
	CGFloat const box_inset_from_side = CGRectGetWidth(rect) / 4.0f;
	
	CGFloat const triangle_inset_from_exit = 2;
	CGFloat const triangle_width_from_exit = 3;
	CGFloat const triangle_height_from_exit = 4;
	
	CGContextMoveToPoint(context, 0.0f, CGRectGetMaxY(rect)); /* Bottom left */
	CGContextAddLineToPoint(context, box_inset_from_side, CGRectGetMaxY(rect)); /* Bottom left of machine */
	CGContextAddLineToPoint(context, box_inset_from_side, CGRectGetMidY(rect)); /* Top left of machine */
	
	CGContextAddLineToPoint(context, CGRectGetMidX(rect) - triangle_inset_from_exit - triangle_width_from_exit, CGRectGetMidY(rect)); /* Left barrel triangle, bottom left. */
	CGContextAddLineToPoint(context, CGRectGetMidX(rect) - triangle_inset_from_exit, CGRectGetMidY(rect) - triangle_height_from_exit); /* Left barrel triangle, top right. */
	CGContextAddLineToPoint(context, CGRectGetMidX(rect) - triangle_inset_from_exit, CGRectGetMidY(rect)); /* Left barrel triangle, bottom right. */
	
	CGContextAddLineToPoint(context, CGRectGetMidX(rect) + triangle_inset_from_exit, CGRectGetMidY(rect)); /* Right barrel triangle, bottom left. */
	CGContextAddLineToPoint(context, CGRectGetMidX(rect) + triangle_inset_from_exit, CGRectGetMidY(rect) - triangle_height_from_exit); /* Right barrel triangle, top right. */
	CGContextAddLineToPoint(context, CGRectGetMidX(rect) + triangle_inset_from_exit + triangle_width_from_exit, CGRectGetMidY(rect)); /* Right barrel triangle, bottom right. */
	
	CGContextAddLineToPoint(context, CGRectGetMaxX(rect) - box_inset_from_side, CGRectGetMidY(rect)); /* Top right of machine */
	CGContextAddLineToPoint(context, CGRectGetMaxX(rect) - box_inset_from_side, CGRectGetMaxY(rect)); /* Bottom right of machine */
	CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect)); /* Bottom right */
	
	CGContextStrokePath(context);
	
	/**
	 Power indicator
	 */
	if (powerIndicatorColorRef)
	{
		CGFloat const powerIndicator_width = ((CGRectGetWidth(rect) / 2.0f) - box_inset_from_side) / 2.0f;
		
		CGContextSetFillColorWithColor(context, powerIndicatorColorRef);
		
		CGRect const powerIndicator_frame = (CGRect){
			.origin.x		= CGRectGetMinX(rect) + CGRectGetHorizontallyAlignedXCoordForWidthOnWidth(powerIndicator_width, CGRectGetWidth(rect)),
			.origin.y		= CGRectGetMaxY(rect) - powerIndicator_width,
			.size.width		= powerIndicator_width,
			.size.height	= powerIndicator_width,
		};
		
		CGContextFillRect(context, powerIndicator_frame);
	}
}

@end
