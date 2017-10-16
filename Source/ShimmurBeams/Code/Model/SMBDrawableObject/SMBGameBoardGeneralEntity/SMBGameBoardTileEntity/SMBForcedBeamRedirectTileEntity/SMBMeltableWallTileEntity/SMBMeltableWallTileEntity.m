//
//  SMBMeltableWallTileEntity.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/15/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBMeltableWallTileEntity.h"
#import "SMBGameBoardTile.h"
#import "CoreGraphics+SMBRotation.h"
#import "SMBGameBoardTile__directions_to_CoreGraphics_SMBRotation__orientations_utilities.h"
#import "SMBTimer.h"
#import "SMBBeamEntityTileNode.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/UIView+RUUtility.h>





static void* kSMBMeltableWallTileEntity__KVOContext = &kSMBMeltableWallTileEntity__KVOContext;





@interface SMBMeltableWallTileEntity () <SMBTimer__timerDidFireDelegate>

#pragma mark - gameBoardTile
-(void)SMBMeltableWallTileEntity_gameBoardTile_setKVORegistered:(BOOL)registered;

#pragma mark - meltableWall_draw
-(void)meltableWall_draw_in_rect:(CGRect)rect;

#pragma mark - square
-(void)square_draw_in_rect:(CGRect)rect
				 direction:(SMBGameBoardTile__direction)direction
			inset_fromEdge:(CGFloat)inset_fromEdge
		  inset_fromCenter:(CGFloat)inset_fromCenter;

#pragma mark - squareGap
-(void)squareGap_draw_in_rect:(CGRect)rect
					direction:(SMBGameBoardTile__direction)direction
			   inset_fromEdge:(CGFloat)inset_fromEdge
			 inset_fromCenter:(CGFloat)inset_fromCenter;

#pragma mark - melting_timer
@property (nonatomic, strong, nullable) SMBTimer* melting_timer;
-(void)melting_timer_update;
-(nullable SMBTimer*)melting_timer_generate_attempt;

#pragma mark - beamEnterDirections_blocked
-(void)beamEnterDirections_blocked_update;
-(SMBGameBoardTile__direction)beamEnterDirections_blocked_appropriate;

@end





@implementation SMBMeltableWallTileEntity

#pragma mark - NSObject
-(void)dealloc
{
	[self SMBMeltableWallTileEntity_gameBoardTile_setKVORegistered:NO];
}

#pragma mark - NSObject
-(nullable instancetype)init_with_meltableBeamEnterDirections:(SMBGameBoardTile__direction)meltableBeamEnterDirections
{
	if (self = [super init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_none])
	{
		_meltableBeamEnterDirections = meltableBeamEnterDirections;
		[self beamEnterDirections_blocked_update];

		[self setForcedBeamRedirectArrow_drawing_disable:YES];
	}

	return self;
}

#pragma mark - SMBForcedBeamRedirectTileEntity: init
-(nullable instancetype)init_with_forcedBeamExitDirection:(SMBGameBoardTile__direction)forcedBeamExitDirection
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);

	return [self init];
}

#pragma mark - SMBGameBoardGeneralEntity: draw
-(void)draw_in_rect:(CGRect)rect
{
	[super draw_in_rect:rect];

	[self meltableWall_draw_in_rect:rect];
}

#pragma mark - meltableWall_draw
-(void)meltableWall_draw_in_rect:(CGRect)rect
{
	CGContextRef const context = UIGraphicsGetCurrentContext();

	CGContextSaveGState(context);

	CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
	CGContextSetLineWidth(context, 1.0f);

	CGFloat const inset_fromEdge = CGRectGetWidth(rect) / 20.0f;
	CGFloat const inset_fromCenter = [SMBBeamEntityTileNode half_line_offset_amount_for_rect:rect] + [SMBBeamEntityTileNode half_line_width_in_rect:rect] + CGRectGetWidth(rect) / 20.0f;
	SMBGameBoardTile__direction const meltableBeamEnterDirections = self.meltableBeamEnterDirections;

	for (SMBGameBoardTile__direction direction = SMBGameBoardTile__direction__first;
		 direction <= SMBGameBoardTile__direction__last;
		 direction = direction << 1)
	{
		[self square_draw_in_rect:rect
						direction:direction
				   inset_fromEdge:inset_fromEdge
				 inset_fromCenter:inset_fromCenter];

		if ((meltableBeamEnterDirections & direction) == false)
		{
			[self squareGap_draw_in_rect:rect
							   direction:direction
						  inset_fromEdge:inset_fromEdge
						inset_fromCenter:inset_fromCenter];
		}
	}

	CGFloat const square_inner_dimension_length = (inset_fromCenter * 2.0f);
	CGRect const squareRect_inner = (CGRect){
		.origin.x		= CGRectGetMidX(rect) - inset_fromCenter,
		.origin.y		= CGRectGetMidY(rect) - inset_fromCenter,
		.size.width		= square_inner_dimension_length,
		.size.height	= square_inner_dimension_length,
	};

	CGContextSetFillColorWithColor(context, [UIColor brownColor].CGColor);
	CGContextFillRect(context, squareRect_inner);

	CGContextRestoreGState(context);
}

#pragma mark - square
-(void)square_draw_in_rect:(CGRect)rect
				 direction:(SMBGameBoardTile__direction)direction
			inset_fromEdge:(CGFloat)inset_fromEdge
		  inset_fromCenter:(CGFloat)inset_fromCenter
{
	kRUConditionalReturn(direction == SMBGameBoardTile__direction_none, NO);

	CGContextRef const context = UIGraphicsGetCurrentContext();

	CGContextSaveGState(context);

	CoreGraphics_SMBRotation__rotateCTM(context, rect, CoreGraphics_SMBRotation__orientation_for_direction(direction));

	CGFloat const dimension_length =
	((CGRectGetWidth(rect) / 2.0f)
	 -
	 (inset_fromEdge + inset_fromCenter));

	CGRect const squareRect = (CGRect){
		.origin.x		= CGRectGetMinX(rect) + inset_fromEdge,
		.origin.y		= CGRectGetMinY(rect) + inset_fromEdge,
		.size.width		= dimension_length,
		.size.height	= dimension_length,
	};

	CGContextAddRect(context, squareRect);

	CGContextStrokePath(context);

	CGContextRestoreGState(context);
}

#pragma mark - squareGap
-(void)squareGap_draw_in_rect:(CGRect)rect
					direction:(SMBGameBoardTile__direction)direction
			   inset_fromEdge:(CGFloat)inset_fromEdge
			 inset_fromCenter:(CGFloat)inset_fromCenter
{
	kRUConditionalReturn(direction == SMBGameBoardTile__direction_none, NO);

	CGContextRef const context = UIGraphicsGetCurrentContext();

	CGContextSaveGState(context);

	CoreGraphics_SMBRotation__rotateCTM(context, rect, CoreGraphics_SMBRotation__orientation_for_direction(direction));

	CGFloat const width = (2.0f * inset_fromCenter);
	CGFloat const height =
	((CGRectGetHeight(rect) / 2.0f)
	 -
	 (inset_fromEdge + inset_fromCenter)
	 );

	CGRect const squareRect = (CGRect){
		.origin.x		= CGRectGetMinX(rect) + CGRectGetHorizontallyAlignedXCoordForWidthOnWidth(width, CGRectGetWidth(rect)),
		.origin.y		= CGRectGetMinY(rect) + inset_fromEdge,
		.size.width		= width,
		.size.height	= height,
	};

	CGContextFillRect(context, squareRect);

	CGContextStrokePath(context);

	CGContextRestoreGState(context);
}

#pragma mark - gameBoardTile
-(void)setGameBoardTile:(nullable SMBGameBoardTile*)gameBoardTile
{
	[self SMBMeltableWallTileEntity_gameBoardTile_setKVORegistered:NO];

	[super setGameBoardTile:gameBoardTile];

	[self SMBMeltableWallTileEntity_gameBoardTile_setKVORegistered:YES];

	[self melting_timer_update];
}

-(void)SMBMeltableWallTileEntity_gameBoardTile_setKVORegistered:(BOOL)registered
{
	typeof(self.gameBoardTile) const gameBoardTile = self.gameBoardTile;
	kRUConditionalReturn(gameBoardTile == nil, NO);

	NSMutableArray<NSString*>* const propertiesToObserve = [NSMutableArray<NSString*> array];
	[propertiesToObserve addObject:[SMBGameBoardTile_PropertiesForKVO isPowered]];

	[propertiesToObserve enumerateObjectsUsingBlock:^(NSString * _Nonnull propertyToObserve, NSUInteger idx, BOOL * _Nonnull stop) {
		if (registered)
		{
			[gameBoardTile addObserver:self
							forKeyPath:propertyToObserve
							   options:(0)
							   context:&kSMBMeltableWallTileEntity__KVOContext];
		}
		else
		{
			[gameBoardTile removeObserver:self
							   forKeyPath:propertyToObserve
								  context:&kSMBMeltableWallTileEntity__KVOContext];
		}
	}];
}

#pragma mark - KVO
-(void)observeValueForKeyPath:(nullable NSString*)keyPath ofObject:(nullable id)object change:(nullable NSDictionary*)change context:(nullable void*)context
{
	if (context == kSMBMeltableWallTileEntity__KVOContext)
	{
		if (object == self.gameBoardTile)
		{
			if ([keyPath isEqualToString:[SMBGameBoardTile_PropertiesForKVO isPowered]])
			{
				[self melting_timer_update];
			}
			else
			{
				NSAssert(false, @"unhandled keyPath %@",keyPath);
			}
		}
		else
		{
			NSAssert(false, @"unhandled object %@",object);
		}
	}
	else
	{
		[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
	}
}

#pragma mark - melting_timer
-(void)setMelting_timer:(nullable SMBTimer*)melting_timer
{
	kRUConditionalReturn(self.melting_timer == melting_timer, NO);

	_melting_timer = melting_timer;

	if (self.melting_timer)
	{
		[self.melting_timer setRunning:YES];
	}
}

-(void)melting_timer_update
{
	[self setMelting_timer:[self melting_timer_generate_attempt]];
}

-(nullable SMBTimer*)melting_timer_generate_attempt
{
	SMBGameBoardTile* const gameBoardTile = self.gameBoardTile;
	kRUConditionalReturn_ReturnValueNil(gameBoardTile == nil, NO);
	kRUConditionalReturn_ReturnValueNil(gameBoardTile.isPowered == NO, NO);

	SMBTimer* const timer = [SMBTimer new];
	[timer setTimerDidFireDelegate:self];
	[timer setTimerDuration:1.0f];

	return timer;
}

#pragma mark - SMBTimer__timerDidFireDelegate
-(void)timer_didFire:(nonnull SMBTimer*)timer
{
	SMBGameBoardTile* const gameBoardTile = self.gameBoardTile;
	kRUConditionalReturn(gameBoardTile == nil, YES);

	[gameBoardTile gameBoardTileEntities_remove:self entityType:SMBGameBoardTile__entityType_beamInteractions];
	NSAssert(self.gameBoardTile == nil, @"should be cleared");
}

#pragma mark - SMBBeamBlockerTileEntity
@synthesize beamEnterDirections_blocked = _beamEnterDirections_blocked;

#pragma mark - beamEnterDirections_blocked
-(void)beamEnterDirections_blocked_update
{
	[self setBeamEnterDirections_blocked:[self beamEnterDirections_blocked_appropriate]];
}

-(SMBGameBoardTile__direction)beamEnterDirections_blocked_appropriate
{
	return SMBGameBoardTile__directions__opposite(self.meltableBeamEnterDirections);
}

@end
