//
//  SMBDeathBlockTileEntity.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/15/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBDeathBlockTileEntity.h"
#import "SMBGameBoardTile.h"
#import "SMBGameBoard.h"
#import "SMBGameLevel.h"
#import "SMBGameLevelCompletion.h"
#import "NSNumber+SMBRandomNumbers.h"

#import <ResplendentUtilities/RUConditionalReturn.h>

#define kSMBDeathBlockTileEntity__shortCircuitTimer (0)

#if kSMBDeathBlockTileEntity__shortCircuitTimer
#import "SMBTimer.h"

#import <ResplendentUtilities/RUEnumIsInRangeSynthesization.h>
#endif





static void* kSMBDeathBlockTileEntity__KVOContext = &kSMBDeathBlockTileEntity__KVOContext;





#if kSMBDeathBlockTileEntity__shortCircuitTimer

typedef NS_ENUM(NSInteger, SMBDeathBlockTileEntity__drawState) {
	SMBDeathBlockTileEntity__drawState_none,

	SMBDeathBlockTileEntity__drawState_lines_startTop,
	SMBDeathBlockTileEntity__drawState_lines_startBottom,
	
	SMBDeathBlockTileEntity__drawState__first	= SMBDeathBlockTileEntity__drawState_lines_startTop,
	SMBDeathBlockTileEntity__drawState__last	= SMBDeathBlockTileEntity__drawState_lines_startBottom,
};

RUEnumIsInRangeSynthesization_autoFirstLast(SMBDeathBlockTileEntity__drawState);

#endif





@interface SMBDeathBlockTileEntity ()
#if kSMBDeathBlockTileEntity__shortCircuitTimer
<SMBTimer__timerDidFireDelegate>
#endif

#pragma mark - customFailureReasons
//@property (nonatomic, assign) NSUInteger customFailureReasons_index;
//-(void)customFailureReasons_index_increment;
-(nullable NSString*)customFailureReason_random;

#pragma mark - gameBoardTile
-(void)SMBDeathBlockTileEntity_gameBoardTile_setKVORegistered:(BOOL)registered;

#pragma mark - failLevelAction
-(void)failLevelAction_attempt;

#if kSMBDeathBlockTileEntity__shortCircuitTimer

#pragma mark - drawStateTimer
@property (nonatomic, readonly, strong, nullable) SMBTimer* drawStateTimer;
-(void)drawStateTimer_running_update;
-(BOOL)drawStateTimer_running_shouldBe;

#pragma mark - drawState
@property (nonatomic, assign) SMBDeathBlockTileEntity__drawState drawState;
-(void)drawState_toggle;
-(SMBDeathBlockTileEntity__drawState)drawState_toggle_nextState;

#endif

@end





@implementation SMBDeathBlockTileEntity

#pragma mark - NSObject
-(void)dealloc
{
	[self SMBDeathBlockTileEntity_gameBoardTile_setKVORegistered:NO];
}

#pragma mark - NSObject
-(instancetype)init
{
	if (self = [super init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_none])
	{
		[self setForcedBeamRedirectArrow_drawing_disable:YES];

#if kSMBDeathBlockTileEntity__shortCircuitTimer
		_drawStateTimer = [SMBTimer new];
		[self.drawStateTimer setTimerDidFireDelegate:self];

		NSUInteger const numberOfFramePerSecond = 2;
		[self.drawStateTimer setTimerDuration:1.0f / (CGFloat)numberOfFramePerSecond];

		[self setDrawState:SMBDeathBlockTileEntity__drawState__first];
#endif
	}

	return self;
}

#pragma mark - SMBForcedBeamRedirectTileEntity: init
-(nullable instancetype)init_with_forcedBeamExitDirection:(SMBGameBoardTile__direction)forcedBeamExitDirection
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);

	return [self init];
}

#pragma mark - customFailureReasons
//-(void)setCustomFailureReasons:(nullable NSArray<NSString*>*)customFailureReasons
//{
//	kRUConditionalReturn((self.customFailureReasons == customFailureReasons)
//						 ||
//						 ([self.customFailureReasons isEqual:customFailureReasons]), NO);
//
//	[self setCustomFailureReasons_index:0];
//
//	_customFailureReasons = (customFailureReasons ? [NSArray<NSString*> arrayWithArray:customFailureReasons] : nil);
//}
//
//-(void)customFailureReasons_index_increment
//{
//	NSArray<NSString*>* const customFailureReasons = self.customFailureReasons;
//	kRUConditionalReturn(customFailureReasons == nil, YES);
//	kRUConditionalReturn(customFailureReasons.count == 0, YES);
//
//	NSUInteger const customFailureReasons_index = self.customFailureReasons_index;
//	NSUInteger const customFailureReasons_index_incremented = customFailureReasons_index + 1;
//	NSUInteger const customFailureReasons_index_new =
//	(customFailureReasons_index_incremented >= customFailureReasons.count
//	 ?
//	 0
//	 :
//	 customFailureReasons_index_incremented
//	);
//
//	[self setCustomFailureReasons_index:customFailureReasons_index_new];
//}

-(nullable NSString*)customFailureReason_random
{
	NSArray<NSString*>* const customFailureReasons = self.customFailureReasons;
	kRUConditionalReturn_ReturnValueNil(customFailureReasons == nil, NO);

	NSUInteger const customFailureReasons_count = customFailureReasons.count;
	kRUConditionalReturn_ReturnValueNil(customFailureReasons_count == 0, YES);
	kRUConditionalReturn_ReturnValue(customFailureReasons_count == 1, NO, customFailureReasons.firstObject);

	NSUInteger const customFailureReasons_index = [NSNumber smb_randomIntegerBetweenMin:0 max:(u_int32_t)customFailureReasons_count - 1];
	kRUConditionalReturn_ReturnValueNil(customFailureReasons_index >= customFailureReasons_count, YES);

	return [customFailureReasons objectAtIndex:customFailureReasons_index];
}

#pragma mark - SMBGameBoardGeneralEntity: draw
-(void)draw_in_rect:(CGRect)rect
{
	[super draw_in_rect:rect];

	CGContextRef const context = UIGraphicsGetCurrentContext();

	CGContextSaveGState(context);

	CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
	CGContextSetLineWidth(context, 3.0f);

#if kSMBDeathBlockTileEntity__shortCircuitTimer
	CGFloat const horizontal_distanceFromEdge = CGRectGetWidth(rect) / 8.0f;
	CGFloat const lines_boundingWidth = CGRectGetWidth(rect) - (horizontal_distanceFromEdge * 2.0f);

	NSUInteger const numberOfLines = 4;
	CGFloat const line_horizontal_distance = lines_boundingWidth / (CGFloat)numberOfLines;
	CGFloat const line_vertical_distance = line_horizontal_distance;

	SMBDeathBlockTileEntity__drawState const drawState = self.drawState;

	CGFloat (^line_xCoord)(NSUInteger line_index) = ^CGFloat(NSUInteger line_index){
		return
		(
		 CGRectGetMinX(rect)
		 +
		 horizontal_distanceFromEdge
		 +
		 ((CGFloat)line_index
		  *
		  line_horizontal_distance
		 )
		);
	};

	CGFloat (^line_yCoord)(NSUInteger line_index) = ^CGFloat(NSUInteger line_index){
		double const line_index_halved = ((double)line_index / 2.0f);
		BOOL const isEven = (line_index_halved == ceil(line_index_halved));
		BOOL const isUp =
		((drawState == SMBDeathBlockTileEntity__drawState_lines_startTop) == isEven);

		return
		(
		CGRectGetMidY(rect)
		 +
		 (
		 (line_vertical_distance
		  /
		  2.0f
		  )
		 )
		 *
		 (
		 isUp
		  ?
		  -1.0f
		  :
		  1.0f
		 )
		);
	};

	CGContextMoveToPoint(context,
						 line_xCoord(0),
						 line_yCoord(0));

	for (NSUInteger line_end_index = 0;
		 line_end_index < numberOfLines;
		 line_end_index++)
	{
		CGContextAddLineToPoint(context,
								line_xCoord(line_end_index + 1),
								line_yCoord(line_end_index + 1));
	}

#else
	CGFloat const x_dimention_distanceFromCenter = CGRectGetWidth(rect) / 3.0f;

	CGContextMoveToPoint(context, CGRectGetMidX(rect) - x_dimention_distanceFromCenter, CGRectGetMidY(rect) - x_dimention_distanceFromCenter); /* Top left. */
	CGContextAddLineToPoint(context, CGRectGetMidX(rect) + x_dimention_distanceFromCenter, CGRectGetMidY(rect) + x_dimention_distanceFromCenter); /* Bottom right. */

	CGContextMoveToPoint(context, CGRectGetMidX(rect) - x_dimention_distanceFromCenter, CGRectGetMidY(rect) + x_dimention_distanceFromCenter); /* Top right. */
	CGContextAddLineToPoint(context, CGRectGetMidX(rect) + x_dimention_distanceFromCenter, CGRectGetMidY(rect) - x_dimention_distanceFromCenter); /* Bottom left. */
#endif

	CGContextStrokePath(context);

	CGContextRestoreGState(context);
}

#pragma mark - gameBoardTile
-(void)setGameBoardTile:(nullable SMBGameBoardTile*)gameBoardTile
{
	[self SMBDeathBlockTileEntity_gameBoardTile_setKVORegistered:NO];

	[super setGameBoardTile:gameBoardTile];

	[self SMBDeathBlockTileEntity_gameBoardTile_setKVORegistered:YES];

#if kSMBDeathBlockTileEntity__shortCircuitTimer
	[self drawStateTimer_running_update];
#endif
}

-(void)SMBDeathBlockTileEntity_gameBoardTile_setKVORegistered:(BOOL)registered
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
							   options:(NSKeyValueObservingOptionInitial)
							   context:&kSMBDeathBlockTileEntity__KVOContext];
		}
		else
		{
			[gameBoardTile removeObserver:self
							   forKeyPath:propertyToObserve
								  context:&kSMBDeathBlockTileEntity__KVOContext];
		}
	}];
}

#pragma mark - KVO
-(void)observeValueForKeyPath:(nullable NSString*)keyPath ofObject:(nullable id)object change:(nullable NSDictionary*)change context:(nullable void*)context
{
	if (context == kSMBDeathBlockTileEntity__KVOContext)
	{
		if (object == self.gameBoardTile)
		{
			if ([keyPath isEqualToString:[SMBGameBoardTile_PropertiesForKVO isPowered]])
			{
				[self failLevelAction_attempt];
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

#pragma mark - failLevelAction
-(void)failLevelAction_attempt
{
	SMBGameBoardTile* const gameBoardTile = self.gameBoardTile;
	kRUConditionalReturn(gameBoardTile == nil, NO);

	kRUConditionalReturn(gameBoardTile.isPowered == false, NO);

	SMBGameBoard* const gameBoard = gameBoardTile.gameBoard;
	kRUConditionalReturn(gameBoard == nil, YES);

	SMBGameLevel* const gameLevel = gameBoard.gameLevel;
	kRUConditionalReturn(gameLevel == nil, YES);

	NSMutableString* const failureReason = [NSMutableString stringWithString:@"You have died!"];

	NSString* const customFailureReason_random = [self customFailureReason_random];
	if (customFailureReason_random)
	{
		[failureReason appendFormat:@"\nReason: %@",customFailureReason_random];
	}

	[gameLevel setCompletion:[[SMBGameLevelCompletion alloc] init_with_failureReason:failureReason]];
}

#if kSMBDeathBlockTileEntity__shortCircuitTimer

#pragma mark - drawStateTimer
-(void)drawStateTimer_running_update
{
	SMBTimer* const drawStateTimer = self.drawStateTimer;
	kRUConditionalReturn(drawStateTimer == nil, YES);

	[drawStateTimer setRunning:[self drawStateTimer_running_shouldBe]];
}

-(BOOL)drawStateTimer_running_shouldBe
{
	kRUConditionalReturn_ReturnValueFalse(self.gameBoardTile == nil, NO);

	return YES;
}

#pragma mark - SMBTimer__timerDidFireDelegate
-(void)timer_didFire:(nonnull SMBTimer*)timer
{
	[self drawState_toggle];
}

#pragma mark - drawState
-(void)setDrawState:(SMBDeathBlockTileEntity__drawState)drawState
{
	kRUConditionalReturn(SMBDeathBlockTileEntity__drawState__isInRange(drawState) == false, YES);
	kRUConditionalReturn(self.drawState == drawState, NO);

	_drawState = drawState;

	[self setNeedsRedraw];
}

-(void)drawState_toggle
{
	[self setDrawState:[self drawState_toggle_nextState]];
}

-(SMBDeathBlockTileEntity__drawState)drawState_toggle_nextState
{
	SMBDeathBlockTileEntity__drawState const drawState = self.drawState;
	kRUConditionalReturn_ReturnValue(SMBDeathBlockTileEntity__drawState__isInRange(drawState) == false, YES, SMBDeathBlockTileEntity__drawState_none);

	return
	((drawState == SMBDeathBlockTileEntity__drawState__last)
	 ?
	 SMBDeathBlockTileEntity__drawState__first
	 :
	 drawState + 1
	 );
}

#endif

@end
