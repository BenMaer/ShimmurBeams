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
#import "CoreGraphics+SMBDrawArrow.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@interface SMBForcedBeamRedirectTileEntity ()

#pragma mark - forcedBeamRedirectArrow_drawing
-(void)forcedBeamRedirectArrow_draw_in_rect:(CGRect)rect;

@end





@implementation SMBForcedBeamRedirectTileEntity

#pragma mark - SMBGameBoardGeneralEntity: draw
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

	CGRect const rect_inset = UIEdgeInsetsInsetRect(rect, RU_UIEdgeInsetsMakeAll(arrow_inset_from_side));

	CoreGraphics_SMBDrawArrow(context, rect_inset);
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

#pragma mark - SMBGeneralBeamExitDirectionRedirectTileEntity
-(SMBGameBoardTile__direction)beamExitDirection_for_beamEnterDirection:(SMBGameBoardTile__direction)beamEnterDirection
{
	SMBGameBoardTile__direction const forcedBeamExitDirection = self.forcedBeamExitDirection;
	kRUConditionalReturn_ReturnValue(SMBGameBoardTile__direction__isInRange(forcedBeamExitDirection) == false, YES, SMBGameBoardTile__direction_unknown);

	return forcedBeamExitDirection;
}

@end
