//
//  SMBPowerButtonTileEntity.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/18/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBPowerButtonTileEntity.h"
#import "SMBPowerOutputTileEntity.h"
#import "SMBGameBoardTile.h"
#import "SMBGameBoard.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/UIView+RUUtility.h>





static void* kSMBPowerButtonTileEntity__KVOContext = &kSMBPowerButtonTileEntity__KVOContext;





@interface SMBPowerButtonTileEntity ()

#pragma mark - gameBoardTile
-(void)SMBPowerButtonTileEntity_gameBoardTile_setKVORegistered:(BOOL)registered;

#pragma mark - powerOutputTileEntity
@property (nonatomic, readonly, strong, nullable) SMBPowerOutputTileEntity* powerOutputTileEntity;
-(void)powerOutputTileEntity_gameBoardTile_update;
-(nullable SMBGameBoardTile*)powerOutputTileEntity_gameBoardTile_appropriate;
-(void)powerOutputTileEntity_providesPower_update;
-(BOOL)powerOutputTileEntity_providesPower_appropriate;

@end





@implementation SMBPowerButtonTileEntity

#pragma mark - NSObject
-(void)dealloc
{
	[self SMBPowerButtonTileEntity_gameBoardTile_setKVORegistered:NO];
}

#pragma mark - NSObject
-(instancetype)init
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);
	
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wno-nullability-completeness"
	return [self init_with_gameBoardTilePosition_toPower:nil];
#pragma clang diagnostic pop
}

#pragma mark - init
-(nullable instancetype)init_with_gameBoardTilePosition_toPower:(nonnull SMBGameBoardTilePosition*)gameBoardTilePosition_toPower
{
	kRUConditionalReturn_ReturnValueNil(gameBoardTilePosition_toPower == nil, YES);
	
	if (self = [super init])
	{
		_gameBoardTilePosition_toPower = gameBoardTilePosition_toPower;

		_powerOutputTileEntity = [SMBPowerOutputTileEntity new];
		[self powerOutputTileEntity_gameBoardTile_update];
		[self powerOutputTileEntity_providesPower_update];
	}
	
	return self;
}

#pragma mark - SMBGameBoardGeneralEntity: draw
-(void)draw_in_rect:(CGRect)rect
{
	[super draw_in_rect:rect];

	CGContextRef const context = UIGraphicsGetCurrentContext();

	CGContextSaveGState(context);

	CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
	CGContextSetLineWidth(context, 1.0f);

	CGFloat const button_width = CGRectGetWidth(rect) / 4.0f;
	CGContextStrokeRect(context, (CGRect){
		.origin.x		= CGRectGetMinX(rect) + CGRectGetHorizontallyAlignedXCoordForWidthOnWidth(button_width, CGRectGetWidth(rect)),
		.origin.y		= CGRectGetMinY(rect) + CGRectGetVerticallyAlignedYCoordForHeightOnHeight(button_width, CGRectGetHeight(rect)),
		.size.width		= button_width,
		.size.height	= button_width,
	});

	CGContextRestoreGState(context);
}

#pragma mark - SMBGameBoardTileEntity: gameBoardTile
-(void)setGameBoardTile:(nullable SMBGameBoardTile*)gameBoardTile
{
	[self SMBPowerButtonTileEntity_gameBoardTile_setKVORegistered:NO];
	
	[super setGameBoardTile:gameBoardTile];
	
	[self SMBPowerButtonTileEntity_gameBoardTile_setKVORegistered:YES];

	[self powerOutputTileEntity_gameBoardTile_update];
	[self powerOutputTileEntity_providesPower_update];
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
				[self powerOutputTileEntity_providesPower_update];
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

#pragma mark - powerOutputTileEntity
-(void)powerOutputTileEntity_gameBoardTile_update
{
	SMBPowerOutputTileEntity* const powerOutputTileEntity = self.powerOutputTileEntity;
	kRUConditionalReturn(powerOutputTileEntity == nil, YES);

	SMBGameBoardTile__entityType const entityType = SMBGameBoardTile__entityType_many;
	SMBGameBoardTile* const powerOutputTileEntity_gameBoardTile_appropriate = self.powerOutputTileEntity_gameBoardTile_appropriate;
	if (powerOutputTileEntity_gameBoardTile_appropriate)
	{
		[powerOutputTileEntity_gameBoardTile_appropriate gameBoardTileEntities_add:powerOutputTileEntity
																		entityType:entityType];
	}
	else
	{
		SMBGameBoardTile* const powerOutputTileEntity_gameBoardTile = powerOutputTileEntity.gameBoardTile;;
		kRUConditionalReturn(powerOutputTileEntity_gameBoardTile == nil,
							 self.gameBoardTile != nil);

		[powerOutputTileEntity_gameBoardTile gameBoardTileEntities_remove:powerOutputTileEntity
															   entityType:entityType];
	}
}

-(nullable SMBGameBoardTile*)powerOutputTileEntity_gameBoardTile_appropriate
{
	SMBGameBoardTile* const gameBoardTile = self.gameBoardTile;
	kRUConditionalReturn_ReturnValueNil(gameBoardTile == nil, NO);

	SMBPowerOutputTileEntity* const powerOutputTileEntity = self.powerOutputTileEntity;
	kRUConditionalReturn_ReturnValueNil(powerOutputTileEntity == nil, YES);

	SMBGameBoardTilePosition* const gameBoardTilePosition_toPower = self.gameBoardTilePosition_toPower;
	kRUConditionalReturn_ReturnValueNil(gameBoardTilePosition_toPower == nil, NO);

	SMBGameBoard* const gameBoard = gameBoardTile.gameBoard;
	kRUConditionalReturn_ReturnValueNil(gameBoard == nil, YES);

	SMBGameBoardTile* const gameBoardTile_at_position = [gameBoard gameBoardTile_at_position:gameBoardTilePosition_toPower];
	kRUConditionalReturn_ReturnValueNil(gameBoardTile_at_position == nil, YES);

	return gameBoardTile_at_position;
}

-(void)powerOutputTileEntity_providesPower_update
{
	[self.powerOutputTileEntity setProvidesPower:[self powerOutputTileEntity_providesPower_appropriate]];
}

-(BOOL)powerOutputTileEntity_providesPower_appropriate
{
	SMBGameBoardTile* const gameBoardTile = self.gameBoardTile;
	kRUConditionalReturn_ReturnValueFalse((gameBoardTile == nil)
										  ||
										  (gameBoardTile.isPowered == false), NO);

	return YES;
}

@end
