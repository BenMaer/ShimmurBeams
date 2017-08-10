//
//  SMBBeamEntityTileNode.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/5/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBBeamEntityTileNode.h"
#import "SMBGameBoardTile.h"
#import "SMBBeamCreatorTileEntity.h"
#import "SMBGameBoard.h"
#import "SMBGameBoardTilePosition.h"
#import "SMBGeneralBeamExitDirectionRedirectTileEntity.h"
#import "SMBBeamEntity.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/RUClassOrNilUtil.h>





static void* kSMBBeamEntityTileNode__KVOContext = &kSMBBeamEntityTileNode__KVOContext;





@interface SMBBeamEntityTileNode ()

#pragma mark - beamEntity
-(void)beamEntity_setKVORegistered:(BOOL)registered;

#pragma mark - node_previous
@property (nonatomic, assign) BOOL node_previous_isKVORegistered;
-(void)node_previous_setKVORegistered:(BOOL)registered;

#pragma mark - gameBoardTile
@property (nonatomic, readonly, assign, nullable) SMBGameBoardTile* gameBoardTile_toUseForSetting;

-(void)gameBoardTile_update;
-(BOOL)gameBoardTile_shouldBeSet;

-(void)gameBoardTile_setKVORegistered:(BOOL)registered;

#pragma mark - beamExitDirection
@property (nonatomic, assign) SMBGameBoardTile__direction beamExitDirection;
-(void)beamExitDirection_update;
-(SMBGameBoardTile__direction)beamExitDirection_generate;

#pragma mark - node_next
@property (nonatomic, strong, nullable) SMBBeamEntityTileNode* node_next;

@property (nonatomic, assign) BOOL node_next_generationEnabled;
-(void)node_next_generationEnabled_update;
-(BOOL)node_next_generationEnabled_shouldBe;

-(void)node_next_update;
-(nullable SMBBeamEntityTileNode*)node_next_generate;

#pragma mark - draw
-(void)draw_half_line_in_rect:(CGRect)rect
					direction:(SMBGameBoardTile__direction)direction;

-(CGPoint)draw_point_center_with_rect:(CGRect)rect;

-(CGPoint)draw_point_edgeMiddle_with_rect:(CGRect)rect
								direction:(SMBGameBoardTile__direction)direction;
-(CGFloat)draw_point_edgeMiddle_xCoord_with_rect:(CGRect)rect
									   direction:(SMBGameBoardTile__direction)direction;
-(CGFloat)draw_point_edgeMiddle_yCoord_with_rect:(CGRect)rect
									   direction:(SMBGameBoardTile__direction)direction;

@end





@implementation SMBBeamEntityTileNode

#pragma mark - NSObject
-(void)dealloc
{
	[self node_previous_setKVORegistered:NO];
	[self beamEntity_setKVORegistered:NO];
	[self gameBoardTile_setKVORegistered:NO];
}

-(instancetype)init
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wno-nullability-completeness"
	return [self init_with_gameBoardTile:nil
							  beamEntity:nil
						   node_previous:nil];
#pragma clang diagnostic pop
}

#pragma mark - init
-(nullable instancetype)init_with_gameBoardTile:(nonnull SMBGameBoardTile*)gameBoardTile
									 beamEntity:(nonnull SMBBeamEntity*)beamEntity
								  node_previous:(nullable SMBBeamEntityTileNode*)node_previous
{
	kRUConditionalReturn_ReturnValueNil(gameBoardTile == nil, YES);
	kRUConditionalReturn_ReturnValueNil(beamEntity == nil, YES);

	if (self = [super init])
	{
		_gameBoardTile_toUseForSetting = gameBoardTile;

		_beamEntity = beamEntity;
		[self beamEntity_setKVORegistered:YES];

		_node_previous = node_previous;
		[self node_previous_setKVORegistered:YES];
	}

	return self;
}

#pragma mark - beamEntity
-(void)beamEntity_setKVORegistered:(BOOL)registered
{
	typeof(self.beamEntity) const beamEntity = self.beamEntity;
	kRUConditionalReturn(beamEntity == nil, NO);
	
	NSMutableArray<NSString*>* const propertiesToObserve = [NSMutableArray<NSString*> array];
	[propertiesToObserve addObject:[SMBBeamEntity_PropertiesForKVO beamEntityTileNode_initial]];
	
	[propertiesToObserve enumerateObjectsUsingBlock:^(NSString * _Nonnull propertyToObserve, NSUInteger idx, BOOL * _Nonnull stop) {
		if (registered)
		{
			[beamEntity addObserver:self
						 forKeyPath:propertyToObserve
							options:(NSKeyValueObservingOptionInitial)
							context:&kSMBBeamEntityTileNode__KVOContext];
		}
		else
		{
			[beamEntity removeObserver:self
							forKeyPath:propertyToObserve
							   context:&kSMBBeamEntityTileNode__KVOContext];
		}
	}];
}

#pragma mark - node_previous
-(void)node_previous_setKVORegistered:(BOOL)registered
{
	kRUConditionalReturn(self.node_previous_isKVORegistered == registered, NO);
	[self setNode_previous_isKVORegistered:registered];

	typeof(self.node_previous) const node_previous = self.node_previous;
	kRUConditionalReturn(node_previous == nil, NO);

	NSMutableArray<NSString*>* const propertiesToObserve = [NSMutableArray<NSString*> array];
	[propertiesToObserve addObject:[SMBBeamEntityTileNode_PropertiesForKVO node_next]];
	
	[propertiesToObserve enumerateObjectsUsingBlock:^(NSString * _Nonnull propertyToObserve, NSUInteger idx, BOOL * _Nonnull stop) {
		if (registered)
		{
			[node_previous addObserver:self
							forKeyPath:propertyToObserve
							   options:(NSKeyValueObservingOptionInitial)
							   context:&kSMBBeamEntityTileNode__KVOContext];
		}
		else
		{
			[node_previous removeObserver:self
							   forKeyPath:propertyToObserve
								  context:&kSMBBeamEntityTileNode__KVOContext];
		}
	}];
}

#pragma mark - gameBoardTile
-(void)setGameBoardTile:(nullable SMBGameBoardTile*)gameBoardTile
{
	kRUConditionalReturn((gameBoardTile != nil)
						 &&
						 (self.gameBoardTile != nil), YES) /* Should not be set to a non nil value. */

	[self gameBoardTile_setKVORegistered:NO];

	SMBGameBoardTile* const gameBoardTile_old = self.gameBoardTile;
	[super setGameBoardTile:gameBoardTile];

	[self gameBoardTile_setKVORegistered:YES];

	kRUConditionalReturn(gameBoardTile == gameBoardTile_old, NO);

	[self node_next_generationEnabled_update];

	/**
	 We do this to avoid a memory issue that would otherwise happen, where tile A would die before tile B, but tile B is still registered to tile A.
	 */
	if (self.gameBoardTile == nil)
	{
		[self node_previous_setKVORegistered:NO];
	}
}

-(void)gameBoardTile_update
{
	[self setGameBoardTile:([self gameBoardTile_shouldBeSet] ? self.gameBoardTile_toUseForSetting : nil)];
}

-(BOOL)gameBoardTile_shouldBeSet
{
	SMBBeamEntity* const beamEntity = self.beamEntity;
	kRUConditionalReturn_ReturnValueFalse(beamEntity == nil, NO);
	kRUConditionalReturn_ReturnValueTrue(beamEntity.beamEntityTileNode_initial == self, NO);

	SMBBeamEntityTileNode* const node_previous = self.node_previous;
	kRUConditionalReturn_ReturnValueFalse(node_previous == nil, NO);
	kRUConditionalReturn_ReturnValueTrue(node_previous.node_next == self, NO);

	return NO;
}

-(void)gameBoardTile_setKVORegistered:(BOOL)registered
{
	typeof(self.gameBoardTile) const gameBoardTile = self.gameBoardTile;
	kRUConditionalReturn(gameBoardTile == nil, NO);

	NSMutableArray<NSString*>* const propertiesToObserve = [NSMutableArray<NSString*> array];
	[propertiesToObserve addObject:[SMBGameBoardTile_PropertiesForKVO gameBoardTileEntity_for_beamInteractions]];

	[propertiesToObserve enumerateObjectsUsingBlock:^(NSString * _Nonnull propertyToObserve, NSUInteger idx, BOOL * _Nonnull stop) {
		if (registered)
		{
			[gameBoardTile addObserver:self
							forKeyPath:propertyToObserve
							   options:(NSKeyValueObservingOptionInitial)
							   context:&kSMBBeamEntityTileNode__KVOContext];
		}
		else
		{
			[gameBoardTile removeObserver:self
							   forKeyPath:propertyToObserve
								  context:&kSMBBeamEntityTileNode__KVOContext];
		}
	}];
}

#pragma mark - beamExitDirection
-(void)setBeamExitDirection:(SMBGameBoardTile__direction)beamExitDirection
{
	kRUConditionalReturn(self.beamExitDirection == beamExitDirection, NO);

	_beamExitDirection = beamExitDirection;

	[self node_next_update];
	[self setNeedsRedraw:YES];
}

-(void)beamExitDirection_update
{
	[self setBeamExitDirection:[self beamExitDirection_generate]];
	kRUConditionalReturn(self.beamExitDirection == SMBGameBoardTile__direction_unknown, YES);
}

-(SMBGameBoardTile__direction)beamExitDirection_generate
{
	SMBGameBoardTile__direction const direction_error = SMBGameBoardTile__direction_unknown;

	SMBGameBoardTile* const gameBoardTile = self.gameBoardTile;
	kRUConditionalReturn_ReturnValue(gameBoardTile == nil, YES, direction_error);

	SMBGameBoardTileEntity* const gameBoardTileEntity_for_beamInteractions = gameBoardTile.gameBoardTileEntity_for_beamInteractions;

	SMBBeamEntityTileNode* const node_previous = self.node_previous;
	if (node_previous == nil)
	{
		kRUConditionalReturn_ReturnValue(gameBoardTileEntity_for_beamInteractions == nil, YES, direction_error);

		SMBBeamCreatorTileEntity* const beamCreatorTileEntity = kRUClassOrNil(gameBoardTileEntity_for_beamInteractions, SMBBeamCreatorTileEntity);
		kRUConditionalReturn_ReturnValue(beamCreatorTileEntity == nil, YES, direction_error);

		return beamCreatorTileEntity.beamDirection;
	}

	if (gameBoardTileEntity_for_beamInteractions)
	{
		SMBGeneralBeamExitDirectionRedirectTileEntity* const generalBeamExitDirectionRedirectTileEntity = kRUClassOrNil(gameBoardTileEntity_for_beamInteractions, SMBGeneralBeamExitDirectionRedirectTileEntity);
		if (generalBeamExitDirectionRedirectTileEntity)
		{
			return [generalBeamExitDirectionRedirectTileEntity beamExitDirection_for_beamEnterDirection:[self beamEnterDirection]];
		}
	}

	return node_previous.beamExitDirection;
}

#pragma mark - KVO
-(void)observeValueForKeyPath:(nullable NSString*)keyPath ofObject:(nullable id)object change:(nullable NSDictionary*)change context:(nullable void*)context
{
	if (context == kSMBBeamEntityTileNode__KVOContext)
	{
		if (object == self.gameBoardTile)
		{
			if ([keyPath isEqualToString:[SMBGameBoardTile_PropertiesForKVO gameBoardTileEntity_for_beamInteractions]])
			{
				[self beamExitDirection_update];
			}
			else
			{
				NSAssert(false, @"unhandled keyPath %@",keyPath);
			}
		}
		else if (object == self.node_previous)
		{
			if ([keyPath isEqualToString:[SMBBeamEntityTileNode_PropertiesForKVO node_next]])
			{
				[self gameBoardTile_update];
			}
			else
			{
				NSAssert(false, @"unhandled keyPath %@",keyPath);
			}
		}
		else if (object == self.beamEntity)
		{
			if ([keyPath isEqualToString:[SMBBeamEntity_PropertiesForKVO beamEntityTileNode_initial]])
			{
				[self gameBoardTile_update];
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

#pragma mark - node_next
-(void)setNode_next_generationEnabled:(BOOL)node_next_generationEnabled
{
	kRUConditionalReturn(self.node_next_generationEnabled == node_next_generationEnabled, NO);

	_node_next_generationEnabled = node_next_generationEnabled;

	[self node_next_update];
}

-(void)node_next_generationEnabled_update
{
	[self setNode_next_generationEnabled:[self node_next_generationEnabled_shouldBe]];
}

-(BOOL)node_next_generationEnabled_shouldBe
{
	return (self.gameBoardTile != nil);
}

-(void)node_next_update
{
	[self setNode_next:[self node_next_generate]];
}

-(nullable SMBBeamEntityTileNode*)node_next_generate
{
	kRUConditionalReturn_ReturnValueNil(self.node_next_generationEnabled == false, NO);

	SMBGameBoardTile* const gameBoardTile = self.gameBoardTile;
	kRUConditionalReturn_ReturnValueNil(gameBoardTile == nil, YES);

	SMBGameBoard* const gameBoard = gameBoardTile.gameBoard;
	kRUConditionalReturn_ReturnValueNil(gameBoard == nil, YES);

	SMBGameBoardTile__direction const beamExitDirection = self.beamExitDirection;
	kRUConditionalReturn_ReturnValueNil(SMBGameBoardTile__direction__isInRange(beamExitDirection) == false, YES);
	kRUConditionalReturn_ReturnValueNil(beamExitDirection == SMBGameBoardTile__direction_none, NO);

	SMBBeamEntity* const beamEntity = self.beamEntity;
	kRUConditionalReturn_ReturnValueNil(beamEntity == nil, YES);

	SMBGameBoardTile* const gameBoardTile_next =
	[gameBoardTile gameBoardTile_next_with_direction:beamExitDirection];
	kRUConditionalReturn_ReturnValueNil(gameBoardTile_next == nil, NO);

	SMBBeamEntityTileNode* const node_next =
	[[SMBBeamEntityTileNode alloc] init_with_gameBoardTile:gameBoardTile_next
												beamEntity:beamEntity
											 node_previous:self];

	return node_next;
}

//#pragma mark - SMBMappedDataCollection_MappableObject
//-(nonnull NSString*)smb_uniqueKey
//{
//	NSString* const beamEntity_id = [self.beamEntity smb_uniqueKey];
//	kRUConditionalReturn_ReturnValueNil(beamEntity_id == nil, YES);
//
//	NSString* const beamEntity_id = [self.beamEntity smb_uniqueKey];
//	kRUConditionalReturn_ReturnValueNil(beamEntity_id == nil, YES);
//
//	NSString* const gameBoardTilePosition_id = [self.gameBoardTile_toUseForSetting.gameBoardTilePosition smb_uniqueKey];
//	kRUConditionalReturn_ReturnValueNil(gameBoardTilePosition_id == nil, YES);
//
//	NSMutableArray<NSString*>* const description_lines = [NSMutableArray<NSString*> array];
//	[description_lines ru_addObjectIfNotNil:[self smb_uniqueKey]];
//	[description_lines ru_addObjectIfNotNil:beamEntity_id];
//	[description_lines ru_addObjectIfNotNil:gameBoardTilePosition_id];
//
//	return ;
//}
//
#pragma mark - beamEnterDirection
-(SMBGameBoardTile__direction)beamEnterDirection
{
	SMBBeamEntityTileNode* const node_previous = self.node_previous;
	kRUConditionalReturn_ReturnValue(node_previous == nil, YES, SMBGameBoardTile__direction_unknown);

	SMBGameBoardTile__direction const beamExitDirection = node_previous.beamExitDirection;
	switch (beamExitDirection)
	{
		case SMBGameBoardTile__direction_unknown:
			break;

		case SMBGameBoardTile__direction_up:
			return SMBGameBoardTile__direction_down;
			break;

		case SMBGameBoardTile__direction_right:
			return SMBGameBoardTile__direction_left;
			break;

		case SMBGameBoardTile__direction_down:
			return SMBGameBoardTile__direction_up;
			break;

		case SMBGameBoardTile__direction_left:
			return SMBGameBoardTile__direction_right;
			break;

		case SMBGameBoardTile__direction_none:
			break;
	}

	NSAssert(false, @"unhandled beamExitDirection %li",(long)beamExitDirection);
	return SMBGameBoardTile__direction_unknown;
}

#pragma mark - SMBGameBoardGeneralEntity: draw
-(void)draw_in_rect:(CGRect)rect
{
	[super draw_in_rect:rect];

	CGContextRef const context = UIGraphicsGetCurrentContext();

	CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
	CGContextSetLineWidth(context, 1.0f);

	if (self.node_previous != nil)
	{
		[self draw_half_line_in_rect:rect
						   direction:self.beamEnterDirection];
	}

	SMBGameBoardTile__direction const beamExitDirection = self.beamExitDirection;
	if (beamExitDirection != SMBGameBoardTile__direction_none)
	{
		[self draw_half_line_in_rect:rect
						   direction:beamExitDirection];
	}

	CGContextStrokePath(context);
}

#pragma mark - draw
-(void)draw_half_line_in_rect:(CGRect)rect
					direction:(SMBGameBoardTile__direction)direction
{
	kRUConditionalReturn(SMBGameBoardTile__direction__isInRange(direction) == false, YES);

	CGContextRef const context = UIGraphicsGetCurrentContext();

	CGPoint const point_center = [self draw_point_center_with_rect:rect];
	CGPoint const point_edge = [self draw_point_edgeMiddle_with_rect:rect direction:direction];

	CGContextMoveToPoint(context, point_center.x, point_center.y);
	CGContextAddLineToPoint(context, point_edge.x, point_edge.y);
}

-(CGPoint)draw_point_center_with_rect:(CGRect)rect
{
	return (CGPoint){
		.x	= CGRectGetMidX(rect),
		.y	= CGRectGetMidY(rect),
	};
}

-(CGPoint)draw_point_edgeMiddle_with_rect:(CGRect)rect
								direction:(SMBGameBoardTile__direction)direction
{
	return (CGPoint){
		.x	= [self draw_point_edgeMiddle_xCoord_with_rect:rect direction:direction],
		.y	= [self draw_point_edgeMiddle_yCoord_with_rect:rect direction:direction],
	};
}

-(CGFloat)draw_point_edgeMiddle_xCoord_with_rect:(CGRect)rect
									   direction:(SMBGameBoardTile__direction)direction
{
	switch (direction)
	{
		case SMBGameBoardTile__direction_unknown:
		case SMBGameBoardTile__direction_none:
			break;

		case SMBGameBoardTile__direction_up:
		case SMBGameBoardTile__direction_down:
			return CGRectGetMidX(rect);
			break;

		case SMBGameBoardTile__direction_right:
			return CGRectGetMaxX(rect);
			break;

		case SMBGameBoardTile__direction_left:
			return CGRectGetMinX(rect);
			break;
	}

	NSAssert(false, @"unhandled direction %li",(long)direction);
	return 0.0f;
}

-(CGFloat)draw_point_edgeMiddle_yCoord_with_rect:(CGRect)rect
									   direction:(SMBGameBoardTile__direction)direction
{
	switch (direction)
	{
		case SMBGameBoardTile__direction_unknown:
		case SMBGameBoardTile__direction_none:
			break;

		case SMBGameBoardTile__direction_up:
			return CGRectGetMinY(rect);
			break;

		case SMBGameBoardTile__direction_right:
		case SMBGameBoardTile__direction_left:
			return CGRectGetMidY(rect);
			break;

		case SMBGameBoardTile__direction_down:
			return CGRectGetMaxY(rect);
			break;
	}

	NSAssert(false, @"unhandled direction %li",(long)direction);
	return 0.0f;
}

@end





@implementation SMBBeamEntityTileNode_PropertiesForKVO

+(nonnull NSString*)node_next{return NSStringFromSelector(_cmd);}

@end
