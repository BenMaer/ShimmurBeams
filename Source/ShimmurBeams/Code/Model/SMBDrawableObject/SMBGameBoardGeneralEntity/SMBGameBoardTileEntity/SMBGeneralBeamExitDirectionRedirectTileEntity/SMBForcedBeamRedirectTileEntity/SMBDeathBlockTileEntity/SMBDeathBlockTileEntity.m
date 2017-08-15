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

#import <ResplendentUtilities/RUConditionalReturn.h>





static void* kSMBDeathBlockTileEntity__KVOContext = &kSMBDeathBlockTileEntity__KVOContext;





@interface SMBDeathBlockTileEntity ()

#pragma mark - gameBoardTile
-(void)SMBDeathBlockTileEntity_gameBoardTile_setKVORegistered:(BOOL)registered;

#pragma mark - failLevelAction
-(void)failLevelAction_attempt;

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

	CGContextRef const context = UIGraphicsGetCurrentContext();

	CGContextSaveGState(context);

	CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
	CGContextSetLineWidth(context, 3.0f);

	CGFloat const horizontal_distanceFromEdge = CGRectGetWidth(rect) / 8.0f;
	CGFloat const lines_boundingWidth = CGRectGetWidth(rect) - (horizontal_distanceFromEdge * 2.0f);

	NSUInteger const numberOfLines = 4;
	CGFloat const line_horizontal_distance = lines_boundingWidth / (CGFloat)numberOfLines;
	CGFloat const line_vertical_distance = line_horizontal_distance;

	CGFloat (^line_yCoord)(NSUInteger line_index) = ^CGFloat(NSUInteger line_index){
		double const line_index_halved = ((double)line_index / 2.0f);
		BOOL const isEven = (line_index_halved == ceil(line_index_halved));
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
		 isEven
		  ?
		  1.0f
		  :
		  -1.0f
		 )
		);
	};
	CGContextMoveToPoint(context,
						 CGRectGetMinX(rect) + horizontal_distanceFromEdge,
						 CGRectGetMidY(rect) - x_dimention_distanceFromCenter);

	for (NSUInteger line_index = 0;
		 line_index < numberOfLines;
		 line_index++)
	{
		<#statements#>
	}

	CGContextMoveToPoint(context, CGRectGetMidX(rect) - x_dimention_distanceFromCenter, CGRectGetMidY(rect) - x_dimention_distanceFromCenter); /* Top left. */

	CGContextMoveToPoint(context, CGRectGetMidX(rect) - x_dimention_distanceFromCenter, CGRectGetMidY(rect) - x_dimention_distanceFromCenter); /* Top left. */
	CGContextAddLineToPoint(context, CGRectGetMidX(rect) + x_dimention_distanceFromCenter, CGRectGetMidY(rect) + x_dimention_distanceFromCenter); /* Bottom right. */

	CGContextMoveToPoint(context, CGRectGetMidX(rect) - x_dimention_distanceFromCenter, CGRectGetMidY(rect) + x_dimention_distanceFromCenter); /* Top right. */
	CGContextAddLineToPoint(context, CGRectGetMidX(rect) + x_dimention_distanceFromCenter, CGRectGetMidY(rect) - x_dimention_distanceFromCenter); /* Bottom left. */

	CGContextStrokePath(context);

	CGContextRestoreGState(context);
}

#pragma mark - gameBoardTile
-(void)setGameBoardTile:(nullable SMBGameBoardTile*)gameBoardTile
{
	[self SMBDeathBlockTileEntity_gameBoardTile_setKVORegistered:NO];

	[super setGameBoardTile:gameBoardTile];

	[self SMBDeathBlockTileEntity_gameBoardTile_setKVORegistered:YES];
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

	[gameLevel setCompletion:[[SMBGameLevelCompletion alloc] init_with_failureReason:@"You have died!"]];
}

@end
