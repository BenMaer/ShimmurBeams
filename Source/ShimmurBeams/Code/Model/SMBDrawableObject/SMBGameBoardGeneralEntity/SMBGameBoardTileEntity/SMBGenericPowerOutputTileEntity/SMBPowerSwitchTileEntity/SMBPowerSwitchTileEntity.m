//
//  SMBPowerSwitchTileEntity.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 9/1/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBPowerSwitchTileEntity.h"
#import "SMBGameBoardTile.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/UIView+RUUtility.h>





static void* kSMBPowerSwitchTileEntity__KVOContext = &kSMBPowerSwitchTileEntity__KVOContext;





@interface SMBPowerSwitchTileEntity ()

#pragma mark - draw_switch
-(void)draw_switch_in_rect:(CGRect)rect;
-(CGFloat)draw_switch_fillColor_frame_minX_offset_with_fillColor_width:(CGFloat)fillColor_width;
-(nullable UIColor*)draw_switch_fillColor_color;

#pragma mark - gameBoardTile
-(void)SMBPowerButtonTileEntity_gameBoardTile_setKVORegistered:(BOOL)registered;

#pragma mark - switchState
-(void)switchState_toggle_if_powered;
-(SMBPowerSwitchTileEntity__switchState)switchState_toggle_appropriate;

#pragma mark - providesOutputPower
-(void)providesOutputPower_providesPower_update;
-(BOOL)providesOutputPower_providesPower_appropriate;

@end





@implementation SMBPowerSwitchTileEntity

#pragma mark - NSObject
-(void)dealloc
{
	[self SMBPowerButtonTileEntity_gameBoardTile_setKVORegistered:NO];
}

#pragma mark - SMBGenericPowerOutputTileEntity: init
-(nullable instancetype)init_with_gameBoardTilePosition_toPower:(nonnull SMBGameBoardTilePosition*)gameBoardTilePosition_toPower
{
	if (self = [super init_with_gameBoardTilePosition_toPower:gameBoardTilePosition_toPower])
	{
		[self setSwitchState:SMBPowerSwitchTileEntity__switchState__first];
	}

	return self;
}

#pragma mark - SMBGameBoardGeneralEntity: draw
-(void)draw_in_rect:(CGRect)rect
{
	[super draw_in_rect:rect];

	[self draw_switch_in_rect:rect];
}

#pragma mark - draw_switch
-(void)draw_switch_in_rect:(CGRect)rect
{
	CGContextRef const context = UIGraphicsGetCurrentContext();

	CGFloat const switch_width = CGRectGetWidth(rect) / 2.0f;
	CGFloat const switch_height = CGRectGetHeight(rect) / 4.0f;
	CGRect const switch_rect = (CGRect){
		.origin.x		= CGRectGetMinX(rect) + CGRectGetHorizontallyAlignedXCoordForWidthOnWidth(switch_width, CGRectGetWidth(rect)),
		.origin.y		= CGRectGetMinY(rect) + CGRectGetVerticallyAlignedYCoordForHeightOnHeight(switch_height, CGRectGetHeight(rect)),
		.size.width		= switch_width,
		.size.height	= switch_height,
	};

	CGFloat const fillColor_width = switch_width / 2.0f;
	CGFloat const fillColor_height = switch_height;
	CGRect const fillColor_rect = (CGRect){
		.origin.x		= CGRectGetMinX(switch_rect) + [self draw_switch_fillColor_frame_minX_offset_with_fillColor_width:fillColor_width],
		.origin.y		= CGRectGetMinY(switch_rect) + CGRectGetVerticallyAlignedYCoordForHeightOnHeight(fillColor_width, CGRectGetHeight(switch_rect)),
		.size.width		= fillColor_width,
		.size.height	= fillColor_height,
	};
	
	CGContextSetFillColorWithColor(context,
								   ([self draw_switch_fillColor_color]).CGColor
								   );
	CGContextFillRect(context, fillColor_rect);

	CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
	CGContextSetLineWidth(context, 1.0f);
	
	CGContextStrokeRect(context, switch_rect);
}

-(CGFloat)draw_switch_fillColor_frame_minX_offset_with_fillColor_width:(CGFloat)fillColor_width
{
	SMBPowerSwitchTileEntity__switchState const switchState = self.switchState;
	switch (switchState)
	{
		case SMBPowerSwitchTileEntity__switchState_unknown:
			break;
			
		case SMBPowerSwitchTileEntity__switchState_off:
			return 0.0f;
			break;
			
		case SMBPowerSwitchTileEntity__switchState_on:
			return fillColor_width;
			break;
	}
	
	NSAssert(false, @"unhandled switchState %li",(long)switchState);
	return 0.0f;
}

-(nullable UIColor*)draw_switch_fillColor_color
{
	SMBPowerSwitchTileEntity__switchState const switchState = self.switchState;
	switch (switchState)
	{
		case SMBPowerSwitchTileEntity__switchState_unknown:
			break;
			
		case SMBPowerSwitchTileEntity__switchState_off:
			return [UIColor redColor];
			break;
			
		case SMBPowerSwitchTileEntity__switchState_on:
			return [UIColor greenColor];
			break;
	}
	
	NSAssert(false, @"unhandled switchState %li",(long)switchState);
	return nil;
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
							   options:(0)
							   context:&kSMBPowerSwitchTileEntity__KVOContext];
		}
		else
		{
			[gameBoardTile removeObserver:self
							   forKeyPath:propertyToObserve
								  context:&kSMBPowerSwitchTileEntity__KVOContext];
		}
	}];
}

#pragma mark - KVO
-(void)observeValueForKeyPath:(nullable NSString*)keyPath ofObject:(nullable id)object change:(nullable NSDictionary*)change context:(nullable void*)context
{
	if (context == kSMBPowerSwitchTileEntity__KVOContext)
	{
		if (object == self.gameBoardTile)
		{
			if ([keyPath isEqualToString:[SMBGameBoardTile_PropertiesForKVO isPowered]])
			{
				[self switchState_toggle_if_powered];
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

#pragma mark - switchState
-(void)setSwitchState:(SMBPowerSwitchTileEntity__switchState)switchState
{
	kRUConditionalReturn(self.switchState == switchState, NO);

	_switchState = switchState;

	[self providesOutputPower_providesPower_update];
	[self setNeedsRedraw];
}

-(void)switchState_toggle_if_powered
{
	SMBGameBoardTile* const gameBoardTile = self.gameBoardTile;
	kRUConditionalReturn((gameBoardTile == nil)
						 ||
						 (gameBoardTile.isPowered == false), NO);

	[self setSwitchState:[self switchState_toggle_appropriate]];
}

-(SMBPowerSwitchTileEntity__switchState)switchState_toggle_appropriate
{
	SMBPowerSwitchTileEntity__switchState const switchState = self.switchState;
	switch (switchState)
	{
		case SMBPowerSwitchTileEntity__switchState_unknown:
			break;

		case SMBPowerSwitchTileEntity__switchState_off:
			return SMBPowerSwitchTileEntity__switchState_on;
			break;

		case SMBPowerSwitchTileEntity__switchState_on:
			return SMBPowerSwitchTileEntity__switchState_off;
			break;
	}

	NSAssert(false, @"unhandled switchState %li",(long)switchState);
	return SMBPowerSwitchTileEntity__switchState_unknown;
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
