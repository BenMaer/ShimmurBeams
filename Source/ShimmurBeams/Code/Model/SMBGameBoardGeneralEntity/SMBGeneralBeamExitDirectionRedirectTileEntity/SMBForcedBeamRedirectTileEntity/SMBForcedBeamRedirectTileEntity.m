//
//  SMBForcedBeamRedirectTileEntity.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/8/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBForcedBeamRedirectTileEntity.h"
#import "CoreGraphics+SMBRotation.h"
#import "SMBGameBoardTile__directions_to_CoreGraphics_SMBRotation__orientations_utilities.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/UIView+RUUtility.h>





@interface SMBForcedBeamRedirectTileEntity ()

#pragma mark - forcedBeamRedirectArrow_drawing
-(void)forcedBeamRedirectArrow_draw_in_rect:(CGRect)rect;

@end





@implementation SMBForcedBeamRedirectTileEntity

#pragma mark - draw
-(void)draw_in_rect:(CGRect)rect
{
	[super draw_in_rect:rect];

	if (self.forcedBeamRedirectArrow_drawing_disable == false)
	{
		[self forcedBeamRedirectArrow_draw_in_rect:rect];
	}
}

#pragma mark - forcedBeamRedirectArrow_drawing
-(void)setForcedBeamRedirectArrow_drawing_disable:(BOOL)forcedBeamRedirectArrow_drawing_disable
{
	kRUConditionalReturn(self.forcedBeamRedirectArrow_drawing_disable == forcedBeamRedirectArrow_drawing_disable, NO);

	_forcedBeamRedirectArrow_drawing_disable = forcedBeamRedirectArrow_drawing_disable;

	[self setNeedsRedraw:YES];
}

-(void)forcedBeamRedirectArrow_draw_in_rect:(CGRect)rect
{
	CGContextRef const context = UIGraphicsGetCurrentContext();

	CoreGraphics_SMBRotation__rotateCTM(context, rect, CoreGraphics_SMBRotation__orientation_for_direction(self.forcedBeamExitDirection));

	CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
	CGContextSetLineWidth(context, 1.0f);
	
	CGFloat const arrow_inset_from_side = CGRectGetWidth(rect) / 4.0f;

	CGFloat const arrow_base_width = CGRectGetWidth(rect) / 4.0f;

	CGFloat const arrow_triangle_extraWidth = 4.0f;
	CGFloat const arrow_triangle_width = arrow_base_width + (2.0f * arrow_triangle_extraWidth);

	CGRect const arrow_triangle_frame = (CGRect){
		.origin.x		= CGRectGetMinX(rect) + CGRectGetHorizontallyAlignedXCoordForWidthOnWidth(arrow_triangle_width, CGRectGetWidth(rect)),
		.origin.y		= CGRectGetMinY(rect) + arrow_inset_from_side,
		.size.width		= arrow_triangle_width,
		.size.height	= arrow_triangle_width,
	};

	CGFloat const arrow_shaft_yCoord = CGRectGetMaxY(arrow_triangle_frame);
	CGRect const arrow_shaft_frame = (CGRect){
		.origin.x		= CGRectGetMinX(rect) + CGRectGetHorizontallyAlignedXCoordForWidthOnWidth(arrow_base_width, CGRectGetWidth(rect)),
		.origin.y		= arrow_shaft_yCoord,
		.size.width		= arrow_base_width,
		.size.height	= CGRectGetMaxY(rect) - arrow_inset_from_side - CGRectGetMaxY(arrow_triangle_frame),
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

#pragma mark - NSObject
-(instancetype)init
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);

	return [self init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_unknown];
}

#pragma mark - init
-(nullable instancetype)init_with_forcedBeamExitDirection:(SMBGameBoardTile__direction)forcedBeamExitDirection
{
	kRUConditionalReturn_ReturnValueNil(SMBGameBoardTile__direction__isInRange(forcedBeamExitDirection) == false, YES);

	if (self = [super init])
	{
		_forcedBeamExitDirection = forcedBeamExitDirection;
	}

	return self;
}

#pragma mark - beamExitDirection
-(SMBGameBoardTile__direction)beamExitDirection_for_beamEnterDirection:(SMBGameBoardTile__direction)beamEnterDirection
{
	SMBGameBoardTile__direction const forcedBeamExitDirection = self.forcedBeamExitDirection;
	kRUConditionalReturn_ReturnValue(SMBGameBoardTile__direction__isInRange(forcedBeamExitDirection) == false, YES, SMBGameBoardTile__direction_unknown);

	return forcedBeamExitDirection;
}

@end
