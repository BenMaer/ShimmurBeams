//
//  SMBLevelExitTileEntity.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/9/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBLevelExitTileEntity.h"
#import "SMBGameBoardTile.h"
#import "SMBGameBoard.h"
#import "SMBGameLevel.h"
#import "SMBGameBoardTile__directions_to_CoreGraphics_SMBRotation__orientations_utilities.h"
#import "CoreGraphics+SMBRotation.h"
#import "CoreGraphics+SMBDrawArrow.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/UIView+RUUtility.h>





static void* kSMBLevelExitTileEntity__KVOContext = &kSMBLevelExitTileEntity__KVOContext;





@interface SMBLevelExitTileEntity ()

#pragma mark - gameBoardTile
-(void)SMBLevelExitTileEntity_gameBoardTile_setKVORegistered:(BOOL)registered;

#pragma mark - finishLevelAction
-(void)finishLevelAction_attempt;

#pragma mark - arrow
-(void)arrow_draw_in_rect:(CGRect)rect;
-(void)arrow_draw_in_rect:(CGRect)rect
				direction:(SMBGameBoardTile__direction)direction;

@end





@implementation SMBLevelExitTileEntity

#pragma mark - NSObject
-(void)dealloc
{
	[self SMBLevelExitTileEntity_gameBoardTile_setKVORegistered:NO];
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

	[self arrow_draw_in_rect:rect];
}

#pragma mark - arrow
-(void)arrow_draw_in_rect:(CGRect)rect
{
	CGContextRef const context = UIGraphicsGetCurrentContext();

	CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
	CGContextSetLineWidth(context, 1.0f);

	for (SMBGameBoardTile__direction direction = SMBGameBoardTile__direction__first;
		 direction <= SMBGameBoardTile__direction__last;
		 direction++)
	{
		CGContextSaveGState(context);

		[self arrow_draw_in_rect:rect
					   direction:direction];

		CGContextRestoreGState(context);
	}
}

-(void)arrow_draw_in_rect:(CGRect)rect
				direction:(SMBGameBoardTile__direction)direction
{
	kRUConditionalReturn(direction == SMBGameBoardTile__direction_none, NO);

	CGContextRef const context = UIGraphicsGetCurrentContext();

	CGFloat const inset_small = 5.0f;
	CGFloat const inset_large = (CGRectGetWidth(rect) / 2.0f) + 2.0f;
	CGFloat const dimension_length = CGRectGetWidth(rect) - inset_large - inset_small;

	CoreGraphics_SMBRotation__rotateCTM(context, rect, CoreGraphics_SMBRotation__orientation_for_direction(direction));

	CGRect const arrow_rect = (CGRect){
		.origin.x		= CGRectGetMinX(rect) + CGRectGetHorizontallyAlignedXCoordForWidthOnWidth(dimension_length, CGRectGetWidth(rect)),
		.origin.y		= CGRectGetMinY(rect) + inset_large,
		.size.width		= dimension_length,
		.size.height	= dimension_length,
	};

	CoreGraphics_SMBDrawArrow(context, arrow_rect);
}

#pragma mark - gameBoardTile
-(void)setGameBoardTile:(nullable SMBGameBoardTile*)gameBoardTile
{
	[self SMBLevelExitTileEntity_gameBoardTile_setKVORegistered:NO];

	[super setGameBoardTile:gameBoardTile];

	[self SMBLevelExitTileEntity_gameBoardTile_setKVORegistered:YES];
}

-(void)SMBLevelExitTileEntity_gameBoardTile_setKVORegistered:(BOOL)registered
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
							   context:&kSMBLevelExitTileEntity__KVOContext];
		}
		else
		{
			[gameBoardTile removeObserver:self
							   forKeyPath:propertyToObserve
								  context:&kSMBLevelExitTileEntity__KVOContext];
		}
	}];
}

#pragma mark - KVO
-(void)observeValueForKeyPath:(nullable NSString*)keyPath ofObject:(nullable id)object change:(nullable NSDictionary*)change context:(nullable void*)context
{
	if (context == kSMBLevelExitTileEntity__KVOContext)
	{
		if (object == self.gameBoardTile)
		{
			if ([keyPath isEqualToString:[SMBGameBoardTile_PropertiesForKVO isPowered]])
			{
				[self finishLevelAction_attempt];
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

#pragma mark - finishLevelAction
-(void)finishLevelAction_attempt
{
	SMBGameBoardTile* const gameBoardTile = self.gameBoardTile;
	kRUConditionalReturn(gameBoardTile == nil, NO);

	kRUConditionalReturn(gameBoardTile.isPowered == false, NO);

	SMBGameBoard* const gameBoard = gameBoardTile.gameBoard;
	kRUConditionalReturn(gameBoard == nil, YES);

	SMBGameLevel* const gameLevel = gameBoard.gameLevel;
	kRUConditionalReturn(gameLevel == nil, YES);

	[gameLevel setIsComplete:YES];
}

@end
