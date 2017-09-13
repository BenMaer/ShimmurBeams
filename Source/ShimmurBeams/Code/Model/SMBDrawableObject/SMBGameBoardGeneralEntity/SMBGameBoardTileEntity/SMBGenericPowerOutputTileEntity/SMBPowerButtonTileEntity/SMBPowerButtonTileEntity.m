//
//  SMBPowerButtonTileEntity.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/18/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBPowerButtonTileEntity.h"
#import "SMBGameBoardTile.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/UIView+RUUtility.h>





static void* kSMBPowerButtonTileEntity__KVOContext = &kSMBPowerButtonTileEntity__KVOContext;





@interface SMBPowerButtonTileEntity ()

#pragma mark - gameBoardTile
-(void)SMBPowerButtonTileEntity_gameBoardTile_setKVORegistered:(BOOL)registered;

#pragma mark - providesOutputPower
-(void)providesOutputPower_providesPower_update;
-(BOOL)providesOutputPower_providesPower_appropriate;

@end





@implementation SMBPowerButtonTileEntity

#pragma mark - NSObject
-(void)dealloc
{
	[self SMBPowerButtonTileEntity_gameBoardTile_setKVORegistered:NO];
}

#pragma mark - SMBGameBoardGeneralEntity: draw
-(void)draw_in_rect:(CGRect)rect
{
	[super draw_in_rect:rect];

	CGContextRef const context = UIGraphicsGetCurrentContext();

	CGFloat const button_width = CGRectGetWidth(rect) / 4.0f;
	CGRect const button_rect = (CGRect){
		.origin.x		= CGRectGetMinX(rect) + CGRectGetHorizontallyAlignedXCoordForWidthOnWidth(button_width, CGRectGetWidth(rect)),
		.origin.y		= CGRectGetMinY(rect) + CGRectGetVerticallyAlignedYCoordForHeightOnHeight(button_width, CGRectGetHeight(rect)),
		.size.width		= button_width,
		.size.height	= button_width,
	};

	CGContextSetFillColorWithColor(context,
								   (self.providesOutputPower
									?
									[UIColor greenColor]
									:
									[UIColor redColor]).CGColor
								   );
	CGContextFillRect(context, button_rect);

	CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
	CGContextSetLineWidth(context, 1.0f);
	
	CGContextStrokeRect(context, button_rect);
}

#pragma mark - SMBGameBoardTileEntity: gameBoardTile
-(void)setGameBoardTile:(nullable SMBGameBoardTile*)gameBoardTile
{
	[self SMBPowerButtonTileEntity_gameBoardTile_setKVORegistered:NO];
	
	[super setGameBoardTile:gameBoardTile];
	
	[self SMBPowerButtonTileEntity_gameBoardTile_setKVORegistered:YES];
}

#pragma mark - gameBoardTile
-(void)SMBPowerButtonTileEntity_gameBoardTile_setKVORegistered:(BOOL)registered
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
							   context:&kSMBPowerButtonTileEntity__KVOContext];
		}
		else
		{
			[gameBoardTile removeObserver:self
							   forKeyPath:propertyToObserve
								  context:&kSMBPowerButtonTileEntity__KVOContext];
		}
	}];
}

#pragma mark - KVO
-(void)observeValueForKeyPath:(nullable NSString*)keyPath ofObject:(nullable id)object change:(nullable NSDictionary*)change context:(nullable void*)context
{
	if (context == kSMBPowerButtonTileEntity__KVOContext)
	{
		if (object == self.gameBoardTile)
		{
			if ([keyPath isEqualToString:[SMBGameBoardTile_PropertiesForKVO isPowered]])
			{
				[self providesOutputPower_providesPower_update];
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

#pragma mark - providesOutputPower
-(void)providesOutputPower_providesPower_update
{
	[self setProvidesOutputPower:[self providesOutputPower_providesPower_appropriate]];
}

-(BOOL)providesOutputPower_providesPower_appropriate
{
	SMBGameBoardTile* const gameBoardTile = self.gameBoardTile;
	kRUConditionalReturn_ReturnValueFalse((gameBoardTile == nil)
										  ||
										  (gameBoardTile.isPowered == false), NO);

	return YES;
}

#pragma mark - SMBGenericPowerOutputTileEntity: providesOutputPower
-(void)setProvidesOutputPower:(BOOL)providesOutputPower
{
	BOOL const providesOutputPower_old = self.providesOutputPower;
	[super setProvidesOutputPower:providesOutputPower];

	kRUConditionalReturn(providesOutputPower_old == providesOutputPower, NO);

	[self setNeedsRedraw];
}

@end
