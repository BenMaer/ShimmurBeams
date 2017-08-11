//
//  SMBBeamCreatorTileEntity.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/4/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBBeamCreatorTileEntity.h"
#import "SMBBeamEntity.h"
#import "SMBGameBoardTile.h"
#import "SMBGameBoard.h"
#import "CoreGraphics+SMBRotation.h"
#import "SMBGameBoardTile__directions_to_CoreGraphics_SMBRotation__orientations_utilities.h"

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

#import <ResplendentUtilities/RUConditionalReturn.h>




@interface SMBBeamCreatorTileEntity ()

#pragma mark - beamEntity
@property (nonatomic, strong, nullable) SMBBeamEntity* beamEntity;
-(void)beamEntity_update;
-(nullable SMBBeamEntity*)beamEntity_create;

@end





@implementation SMBBeamCreatorTileEntity

#pragma mark - draw
-(void)draw_in_rect:(CGRect)rect
{
	[super draw_in_rect:rect];

	CGContextRef const context = UIGraphicsGetCurrentContext();

	CoreGraphics_SMBRotation__rotateCTM(context, rect, CoreGraphics_SMBRotation__orientation_for_direction(self.beamDirection));

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
}

-(void)setGameBoardTile:(nullable SMBGameBoardTile*)gameBoardTile
{
	SMBGameBoardTile* const gameBoardTile_old = self.gameBoardTile;
	[super setGameBoardTile:gameBoardTile];

	kRUConditionalReturn(gameBoardTile_old == self.gameBoardTile, NO);

	[self beamEntity_update];
}

#pragma mark - beamEntity
-(void)setBeamEntity:(nullable SMBBeamEntity*)beamEntity
{
	kRUConditionalReturn(self.beamEntity == beamEntity, NO);

	if (self.beamEntity)
	{
		[self.gameBoardTile.gameBoard gameBoardEntity_remove:self.beamEntity];
	}

	_beamEntity = beamEntity;

	if (self.beamEntity)
	{
		[self.gameBoardTile.gameBoard gameBoardEntity_add:self.beamEntity];
	}
}

-(void)beamEntity_update
{
	[self setBeamEntity:[self beamEntity_create]];
}

-(nullable SMBBeamEntity*)beamEntity_create
{
	SMBGameBoardTile* const gameBoardTile = self.gameBoardTile;
	kRUConditionalReturn_ReturnValueNil(gameBoardTile == nil, NO);

	return [[SMBBeamEntity alloc] init_with_gameBoardTile:gameBoardTile];
}

#pragma mark - beamDirection
-(void)setBeamDirection:(SMBGameBoardTile__direction)beamDirection
{
	kRUConditionalReturn(self.beamDirection == beamDirection, NO);

	_beamDirection = beamDirection;

	[self beamEntity_update];
}

@end
