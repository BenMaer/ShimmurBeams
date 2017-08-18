//
//  SMBBeamRotateTileEntity.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/14/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBBeamRotateTileEntity.h"
#import "SMBBeamEntityTileNode.h"
#import "CoreGraphics+SMBRotation.h"
#import "SMBGameBoardTile__directions_to_CoreGraphics_SMBRotation__orientations_utilities.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@interface SMBBeamRotateTileEntity ()

#pragma mark - beamRotateTileEntity_draw
-(void)beamRotateTileEntity_draw_in_rect:(CGRect)rect;
-(void)beamRotateTileEntity_draw_in_rect:(CGRect)rect
							   direction:(SMBGameBoardTile__direction)direction
								   color:(nonnull UIColor*)color;
-(CGFloat)beamRotateTileEntity_draw_point_final_xCoord_offsetFromCenter_scalar;
-(nullable UIColor*)beamRotateTileEntity_draw_color_for_direction_rotation:(SMBGameBoardTile__direction_rotation)direction_rotation;

@end





@implementation SMBBeamRotateTileEntity

#pragma mark - SMBGameBoardGeneralEntity: draw
-(void)draw_in_rect:(CGRect)rect
{
	[super draw_in_rect:rect];
	
	[self beamRotateTileEntity_draw_in_rect:rect];
}

#pragma mark - beamRotateTileEntity_draw
-(void)beamRotateTileEntity_draw_in_rect:(CGRect)rect
{
	for (SMBGameBoardTile__direction direction = SMBGameBoardTile__direction__first;
		 direction <= SMBGameBoardTile__direction__last;
		 direction = direction << 1)
	{
		[self beamRotateTileEntity_draw_in_rect:rect
									  direction:direction
		 color:
		 (direction == SMBGameBoardTile__direction__first
		  ?
		  [self beamRotateTileEntity_draw_color_for_direction_rotation:self.direction_rotation]
		  :
		  [UIColor blackColor]
		 )];
	}
}

-(void)beamRotateTileEntity_draw_in_rect:(CGRect)rect
							   direction:(SMBGameBoardTile__direction)direction
								   color:(nonnull UIColor*)color
{
	kRUConditionalReturn(color == nil, YES);

	CGContextRef const context = UIGraphicsGetCurrentContext();

	CGContextSaveGState(context);

	CoreGraphics_SMBRotation__rotateCTM(context, rect, CoreGraphics_SMBRotation__orientation_for_direction(direction));

	CGContextSetStrokeColorWithColor(context, color.CGColor);
	CGContextSetLineWidth(context, 1.0f);

	CGFloat const inset_FromCenter = 3.0f;
	CGFloat const circle_radius = (CGRectGetWidth(rect) / 4.0f);
	CGFloat const point_distanceFromCenter = inset_FromCenter + circle_radius;

	CGFloat const beamRotateTileEntity_draw_point_final_xCoord_offsetFromCenter_scalar = [self beamRotateTileEntity_draw_point_final_xCoord_offsetFromCenter_scalar];

	CGFloat const inset_FromCenter_scaled = (beamRotateTileEntity_draw_point_final_xCoord_offsetFromCenter_scalar * inset_FromCenter);
	CGPoint const point_start = (CGPoint){
		.x	= CGRectGetMidX(rect) + inset_FromCenter_scaled,
		.y	= CGRectGetMidY(rect) + point_distanceFromCenter,
	};

	CGFloat const point_distanceFromCenter_scaled = (beamRotateTileEntity_draw_point_final_xCoord_offsetFromCenter_scalar * point_distanceFromCenter);
	CGPoint const point_end = (CGPoint){
		.x	=
		CGRectGetMidX(rect)
		+
		point_distanceFromCenter_scaled,
		.y	= CGRectGetMidY(rect) + inset_FromCenter,
	};

	CGContextMoveToPoint(context,
						 point_start.x,
						 point_start.y);

	CGContextAddArcToPoint(context,
						   point_start.x,
						   point_end.y,
						   point_end.x,
						   point_end.y,
						   circle_radius);

	CGFloat const arrow_length = inset_FromCenter_scaled;

	CGContextMoveToPoint(context,
						 point_end.x - arrow_length,
						 point_end.y - fabs(arrow_length));

	CGContextAddLineToPoint(context,
							point_end.x,
							point_end.y);

	CGContextAddLineToPoint(context,
							point_end.x - arrow_length,
							point_end.y + fabs(arrow_length));

	CGContextStrokePath(context);

	CGContextRestoreGState(context);
}

-(CGFloat)beamRotateTileEntity_draw_point_final_xCoord_offsetFromCenter_scalar
{
	SMBGameBoardTile__direction_rotation const direction_rotation = self.direction_rotation;
	switch (direction_rotation)
	{
		case SMBGameBoardTile__direction_rotation_none:
		case SMBGameBoardTile__direction_rotation_unknown:
			break;

		case SMBGameBoardTile__direction_rotation_left:
			return -1.0f;
			break;

		case SMBGameBoardTile__direction_rotation_right:
			return 1.0f;
			break;
	}

	NSAssert(false, @"unhandled direction_rotation %li",(long)direction_rotation);
	return 0.0f;
}

-(nullable UIColor*)beamRotateTileEntity_draw_color_for_direction_rotation:(SMBGameBoardTile__direction_rotation)direction_rotation
{
	switch (direction_rotation)
	{
		case SMBGameBoardTile__direction_rotation_unknown:
		case SMBGameBoardTile__direction_rotation_none:
			break;
			
		case SMBGameBoardTile__direction_rotation_left:
			return [UIColor magentaColor];
			break;
			
		case SMBGameBoardTile__direction_rotation_right:
			return [UIColor redColor];
			break;
	}
	
	NSAssert(false, @"unhandled direction_rotation %li",(long)direction_rotation);
	return nil;
}

#pragma mark - NSObject
-(instancetype)init
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);
	
	return [self init_with_direction_rotation:SMBGameBoardTile__direction_rotation_unknown];
}

#pragma mark - init
-(nullable instancetype)init_with_direction_rotation:(SMBGameBoardTile__direction_rotation)direction_rotation
{
	kRUConditionalReturn_ReturnValueNil((SMBGameBoardTile__direction_rotation__isInRange(direction_rotation) == false)
										||
										(direction_rotation == SMBGameBoardTile__direction_rotation_none),
										YES);
	
	if (self = [super init])
	{
		_direction_rotation = direction_rotation;
	}
	
	return self;
}

#pragma mark - SMBGeneralBeamExitDirectionRedirectTileEntity
-(SMBGameBoardTile__direction)beamExitDirection_for_beamEnterDirection:(SMBGameBoardTile__direction)beamEnterDirection
{
	return SMBGameBoardTile__direction_rotation_direction_rotated([SMBBeamEntityTileNode beamEnterDirection_for_node_previous_exitDirection:beamEnterDirection], self.direction_rotation);
}

@end
