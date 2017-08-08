//
//  SMBForcedBeamRedirectTileEntity.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/8/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBForcedBeamRedirectTileEntity.h"
#import "SMBBeamEntityTileNode__beamOrientations_to_SMBGameBoardTileEntity__orientation_utilities.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/UIView+RUUtility.h>





@implementation SMBForcedBeamRedirectTileEntity

#pragma mark - draw
-(void)draw_in_gameBoardView:(nonnull SMBGameBoardView*)gameBoardView
						rect:(CGRect)rect
{
	[super draw_in_gameBoardView:gameBoardView
							rect:rect];
	
	CGContextRef const context = UIGraphicsGetCurrentContext();
	
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

	return [self init_with_forcedBeamExitOrientation:SMBBeamEntityTileNode__beamOrientation_none];
}

#pragma mark - init
-(nullable instancetype)init_with_forcedBeamExitOrientation:(SMBBeamEntityTileNode__beamOrientation)forcedBeamExitOrientation
{
	kRUConditionalReturn_ReturnValueNil(SMBBeamEntityTileNode__beamOrientation__isInRange(forcedBeamExitOrientation) == false, YES);

	if (self = [super init])
	{
		_forcedBeamExitOrientation = forcedBeamExitOrientation;
		[self setOrientation:SMBGameBoardTileEntity__orientation_for_beamOrientation(self.forcedBeamExitOrientation)];
	}

	return self;
}

#pragma mark - beamExitOrientation
-(SMBBeamEntityTileNode__beamOrientation)beamExitOrientation_for_beamEnterOrientation:(SMBBeamEntityTileNode__beamOrientation)beamEnterOrientation
{
	SMBBeamEntityTileNode__beamOrientation const forcedBeamExitOrientation = self.forcedBeamExitOrientation;
	kRUConditionalReturn_ReturnValue(SMBBeamEntityTileNode__beamOrientation__isInRange(forcedBeamExitOrientation) == false, YES, SMBBeamEntityTileNode__beamOrientation_none);

	return forcedBeamExitOrientation;
}

@end
