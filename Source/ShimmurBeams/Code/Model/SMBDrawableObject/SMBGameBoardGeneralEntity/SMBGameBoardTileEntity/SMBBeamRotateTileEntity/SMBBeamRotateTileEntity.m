//
//  SMBBeamRotateTileEntity.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/14/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBBeamRotateTileEntity.h"
#import "SMBBeamEntityTileNode.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@interface SMBBeamRotateTileEntity ()

#pragma mark - beamRotateTileEntity_draw
-(void)beamRotateTileEntity_draw_in_rect:(CGRect)rect;
-(CGFloat)beamRotateTileEntity_draw_point_final_xCoord_offsetFromCenter_with_point_distanceFromCenter:(CGFloat)point_distanceFromCenter;

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
	CGContextRef const context = UIGraphicsGetCurrentContext();

	CGContextSaveGState(context);
	
	CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
	CGContextSetLineWidth(context, 1.0f);

	CGFloat const point_distanceFromCenter = CGRectGetWidth(rect) / 4.0f;

	CGPoint const point_start = (CGPoint){
		.x	= CGRectGetMidX(rect),
		.y	= CGRectGetMidY(rect) + point_distanceFromCenter,
	};

	CGFloat const point_final_xCoord_offsetFromCenter = [self beamRotateTileEntity_draw_point_final_xCoord_offsetFromCenter_with_point_distanceFromCenter:point_distanceFromCenter];
	CGPoint const point_end = (CGPoint){
		.x	= CGRectGetMidX(rect) + point_final_xCoord_offsetFromCenter,
		.y	= CGRectGetMidY(rect),
	};

	CGContextMoveToPoint(context,
						 point_start.x,
						 point_start.y);

	CGContextAddArcToPoint(context,
						   CGRectGetMidX(rect),
						   CGRectGetMidY(rect),
						   point_end.x,
						   point_end.y,
						   point_distanceFromCenter);

	CGFloat const arrow_length = point_final_xCoord_offsetFromCenter / 4.0f;

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

-(CGFloat)beamRotateTileEntity_draw_point_final_xCoord_offsetFromCenter_with_point_distanceFromCenter:(CGFloat)point_distanceFromCenter
{
	SMBGameBoardTile__direction_rotation const direction_rotation = self.direction_rotation;
	switch (direction_rotation)
	{
		case SMBGameBoardTile__direction_rotation_none:
		case SMBGameBoardTile__direction_rotation_unknown:
			break;

		case SMBGameBoardTile__direction_rotation_left:
			return -point_distanceFromCenter;
			break;

		case SMBGameBoardTile__direction_rotation_right:
			return point_distanceFromCenter;
			break;
	}

	NSAssert(false, @"unhandled direction_rotation %li",(long)direction_rotation);
	return 0.0f;
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
