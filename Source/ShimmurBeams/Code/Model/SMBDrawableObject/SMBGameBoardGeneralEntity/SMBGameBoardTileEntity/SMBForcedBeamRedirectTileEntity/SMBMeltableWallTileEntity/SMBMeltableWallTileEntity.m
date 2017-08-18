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

#import <ResplendentUtilities/RUConditionalReturn.h>





static void* kSMBMeltableWallTileEntity__KVOContext = &kSMBMeltableWallTileEntity__KVOContext;





@interface SMBMeltableWallTileEntity () <SMBTimer__timerDidFireDelegate>

#pragma mark - gameBoardTile
-(void)SMBMeltableWallTileEntity_gameBoardTile_setKVORegistered:(BOOL)registered;

#pragma mark - square
-(void)squares_draw_in_rect:(CGRect)rect;

-(void)square_draw_in_rect:(CGRect)rect
				 direction:(SMBGameBoardTile__direction)direction
   inset_fromEdgeAndCenter:(CGFloat)inset_fromEdgeAndCenter;

#pragma mark - melting_timer
@property (nonatomic, strong, nullable) SMBTimer* melting_timer;
-(void)melting_timer_update;
-(nullable SMBTimer*)melting_timer_generate_attempt;

@end





@implementation SMBMeltableWallTileEntity

#pragma mark - NSObject
-(void)dealloc
{
	[self SMBMeltableWallTileEntity_gameBoardTile_setKVORegistered:NO];
}

#pragma mark - NSObject
-(instancetype)init
{
	if (self = [super init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_none])
	{
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

	[self squares_draw_in_rect:rect];
}

#pragma mark - square
-(void)squares_draw_in_rect:(CGRect)rect
{
	CGContextRef const context = UIGraphicsGetCurrentContext();

	CGContextSaveGState(context);

	CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
	CGContextSetLineWidth(context, 1.0f);

	CGFloat const inset_fromEdgeAndCenter = CGRectGetWidth(rect) / 10.0f;

	for (SMBGameBoardTile__direction direction = SMBGameBoardTile__direction__first;
		 direction <= SMBGameBoardTile__direction__last;
		 direction = direction << 1)
	{
		[self square_draw_in_rect:rect
						direction:direction
		  inset_fromEdgeAndCenter:inset_fromEdgeAndCenter];
	}

	CGFloat const square_inner_dimension_length = (inset_fromEdgeAndCenter * 2.0f);
	CGRect const squareRect_inner = (CGRect){
		.origin.x		= CGRectGetMidX(rect) - inset_fromEdgeAndCenter,
		.origin.y		= CGRectGetMidY(rect) - inset_fromEdgeAndCenter,
		.size.width		= square_inner_dimension_length,
		.size.height	= square_inner_dimension_length,
	};

	CGContextSetFillColorWithColor(context, [UIColor brownColor].CGColor);
	CGContextFillRect(context, squareRect_inner);

	CGContextRestoreGState(context);
}

-(void)square_draw_in_rect:(CGRect)rect
				 direction:(SMBGameBoardTile__direction)direction
   inset_fromEdgeAndCenter:(CGFloat)inset_fromEdgeAndCenter
{
	kRUConditionalReturn(direction == SMBGameBoardTile__direction_none, NO);
	
	CGContextRef const context = UIGraphicsGetCurrentContext();

	CGContextSaveGState(context);

	CoreGraphics_SMBRotation__rotateCTM(context, rect, CoreGraphics_SMBRotation__orientation_for_direction(direction));

	CGFloat const dimension_length =
	((CGRectGetWidth(rect) / 2.0f)
	 -
	 (2.0f * inset_fromEdgeAndCenter));

	CGRect const squareRect = (CGRect){
		.origin.x		= CGRectGetMinX(rect) + inset_fromEdgeAndCenter,
		.origin.y		= CGRectGetMinY(rect) + inset_fromEdgeAndCenter,
		.size.width		= dimension_length,
		.size.height	= dimension_length,
	};

	CGContextAddRect(context, squareRect);

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
	[timer setTimerDuration:2.0f];

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

@end
