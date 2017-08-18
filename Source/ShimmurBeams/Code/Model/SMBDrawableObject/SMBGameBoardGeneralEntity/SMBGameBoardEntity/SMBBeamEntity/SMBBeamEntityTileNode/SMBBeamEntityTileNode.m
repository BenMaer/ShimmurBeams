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
#import "SMBGameBoardTileEntity+SMBBeamBlocker.h"
#import "SMBGameBoardTile__directions.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/RUClassOrNilUtil.h>
#import <ResplendentUtilities/RUProtocolOrNil.h>





static void* kSMBBeamEntityTileNode__KVOContext = &kSMBBeamEntityTileNode__KVOContext;





typedef NS_ENUM(NSInteger, SMBBeamEntityTileNode__state) {
	SMBBeamEntityTileNode__state_none,

	SMBBeamEntityTileNode__state_created,
	SMBBeamEntityTileNode__state_ready,
	SMBBeamEntityTileNode__state_finished,

	SMBBeamEntityTileNode__state__first		= SMBBeamEntityTileNode__state_created,
	SMBBeamEntityTileNode__state__last		= SMBBeamEntityTileNode__state_finished,
};





@interface SMBBeamEntityTileNode ()

#pragma mark - beamEntity
-(BOOL)beamEntity_contains_self;

//#pragma mark - node_previous
//@property (nonatomic, assign) BOOL node_previous_isKVORegistered;

#pragma mark - gameBoardTile
-(BOOL)gameBoardTile_validateNew:(nullable SMBGameBoardTile*)gameBoardTile;
-(void)SMBBeamEntityTileNode_gameBoardTile_setKVORegistered:(BOOL)registered;

#pragma mark - beamExitDirection
@property (nonatomic, assign) SMBGameBoardTile__direction beamExitDirection;
-(void)beamExitDirection_update;
-(SMBGameBoardTile__direction)beamExitDirection_generate;

#pragma mark - node_next
@property (nonatomic, strong, nullable) SMBBeamEntityTileNode* node_next;
//-(void)node_next_setKVORegistered:(BOOL)registered;
-(void)node_next_update;
-(nullable SMBBeamEntityTileNode*)node_next_generate;

//-(void)node_next_removeFromTile;

//@property (nonatomic, assign) BOOL node_next_generationEnabled;
//-(void)node_next_generationEnabled_update;
//-(BOOL)node_next_generationEnabled_shouldBe;

-(BOOL)node_next_update_is_needed;

#pragma mark - beamEnterDirection
+(SMBGameBoardTile__direction)beamEnterDirection_for_node_previous_exitDirection:(SMBGameBoardTile__direction)node_previous_exitDirection;
//@property (nonatomic, assign) SMBGameBoardTile__direction beamEnterDirection;
//-(void)beamEnterDirection_update;
//-(SMBGameBoardTile__direction)beamEnterDirection_appropriate;

#pragma mark - node_next_gameTile
@property (nonatomic, assign, nullable) SMBGameBoardTile* node_next_gameTile;
-(void)node_next_gameTile_update;
-(nullable SMBGameBoardTile*)node_next_gameTile_appropriate;

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

#pragma mark - state
@property (nonatomic, assign) SMBBeamEntityTileNode__state state;
-(BOOL)state_validate_new:(SMBBeamEntityTileNode__state)state_new;

#pragma mark - beamEntityTileNode
-(void)beamEntityTileNode_gameBoardTile_update:(nonnull SMBBeamEntityTileNode*)beamEntityTileNode;

@end





@implementation SMBBeamEntityTileNode

#pragma mark - NSObject
-(void)dealloc
{
//	[self node_next_setKVORegistered:NO];
	[self SMBBeamEntityTileNode_gameBoardTile_setKVORegistered:NO];
}

-(instancetype)init
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wno-nullability-completeness"
	return [self init_with_beamEntity:nil
				   beamEnterDirection:SMBGameBoardTile__direction_unknown];
#pragma clang diagnostic pop
}

#pragma mark - init
-(nullable instancetype)init_with_beamEntity:(nonnull SMBBeamEntity*)beamEntity
						  beamEnterDirection:(SMBGameBoardTile__direction)beamEnterDirection
{
	kRUConditionalReturn_ReturnValueNil(beamEntity == nil, YES);
	kRUConditionalReturn_ReturnValueNil(SMBGameBoardTile__direction__isInRange_or_none(beamEnterDirection) == false, YES);

	if (self = [super init])
	{
		_beamEntity = beamEntity;
		_beamEnterDirection = beamEnterDirection;

//		[self beamEnterDirection_update];

		[self setState:SMBBeamEntityTileNode__state_created];
	}

	return self;
}

#pragma mark - beamEntity
-(BOOL)beamEntity_contains_self
{
	SMBBeamEntity* const beamEntity = self.beamEntity;
	kRUConditionalReturn_ReturnValueFalse(beamEntity == nil, YES);

	return [beamEntity beamEntityTileNodes_contains:self];
}

#pragma mark - gameBoardTile
-(void)setGameBoardTile:(nullable SMBGameBoardTile*)gameBoardTile
{
	kRUConditionalReturn([self gameBoardTile_validateNew:gameBoardTile] == false, YES);

	[self SMBBeamEntityTileNode_gameBoardTile_setKVORegistered:NO];

	SMBGameBoardTile* const gameBoardTile_old = self.gameBoardTile;
	[super setGameBoardTile:gameBoardTile];

	[self SMBBeamEntityTileNode_gameBoardTile_setKVORegistered:YES];

	kRUConditionalReturn(gameBoardTile == gameBoardTile_old, NO);

	[self node_next_gameTile_update];
}

-(BOOL)gameBoardTile_validateNew:(nullable SMBGameBoardTile*)gameBoardTile
{
	kRUConditionalReturn_ReturnValueFalse((gameBoardTile != nil)
										  &&
										  (self.gameBoardTile != nil), YES) /* Should not be set to a new tile while we already . */

	return YES;
}

-(void)SMBBeamEntityTileNode_gameBoardTile_setKVORegistered:(BOOL)registered
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

	[self node_next_gameTile_update];
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

	SMBGameBoardTile__direction const beamEnterDirection = self.beamEnterDirection;
	kRUConditionalReturn_ReturnValue(SMBGameBoardTile__direction__isInRange_or_none(beamEnterDirection) == false, YES, SMBGameBoardTile__direction_unknown);

	if (beamEnterDirection == SMBGameBoardTile__direction_none)
	{
		if (gameBoardTileEntity_for_beamInteractions == nil)
		{
			BOOL const isError = [self beamEntity_contains_self];
			NSAssert(isError != false, @"We should not be contained in the beam entity if there's no previous node, nor no beam creator on this entity.");
			return (isError ? direction_error : SMBGameBoardTile__direction_none);
		}

		SMBBeamCreatorTileEntity* const beamCreatorTileEntity = kRUClassOrNil(gameBoardTileEntity_for_beamInteractions, SMBBeamCreatorTileEntity);
		kRUConditionalReturn_ReturnValue((beamCreatorTileEntity == nil)
										 ||
										 (self.beamEntity.beamEntityTileNode_initial != self), YES, direction_error);

		return beamCreatorTileEntity.beamDirection;
	}

	if (gameBoardTileEntity_for_beamInteractions)
	{
		id<SMBGeneralBeamExitDirectionRedirectTileEntity> const generalBeamExitDirectionRedirectTileEntity = kRUProtocolOrNil(gameBoardTileEntity_for_beamInteractions, SMBGeneralBeamExitDirectionRedirectTileEntity);
		if (generalBeamExitDirectionRedirectTileEntity)
		{
			return [generalBeamExitDirectionRedirectTileEntity beamExitDirection_for_beamEnterDirection:[self beamEnterDirection]];
		}
	}

	return SMBGameBoardTile__direction__opposite(beamEnterDirection);
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
//				[self beamEnterDirection_update];
			}
			else
			{
				NSAssert(false, @"unhandled keyPath %@",keyPath);
			}
		}
//		else if (object == self.node_next)
//		{
//			if ([keyPath isEqualToString:[SMBBeamEntityTileNode_PropertiesForKVO beamEnterDirection]])
//			{
//				[self node_next_gameTile_update];
//			}
//			else
//			{
//				NSAssert(false, @"unhandled keyPath %@",keyPath);
//			}
//		}
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
-(void)setNode_next:(nullable SMBBeamEntityTileNode*)node_next
{
	kRUConditionalReturn(self.node_next == node_next, NO);

	NSAssert((node_next == nil)
			 ||
			 (node_next.gameBoardTile == nil), @"non-nil node next shouldn't have a game board tile yet");
//	[self node_next_setKVORegistered:NO];

	SMBBeamEntityTileNode* const node_next_old = self.node_next;
	_node_next = node_next;

//	[self node_next_setKVORegistered:YES];

	if (node_next_old)
	{
		[self beamEntityTileNode_gameBoardTile_update:node_next_old];
	}

	if ((node_next != nil)
		&&
		(self.node_next == node_next))
	{
		[self beamEntityTileNode_gameBoardTile_update:node_next];
	}
}

//-(void)node_next_setKVORegistered:(BOOL)registered
//{
//	typeof(self.node_next) const node_next = self.node_next;
//	kRUConditionalReturn(node_next == nil, NO);
//
//	NSMutableArray<NSString*>* const propertiesToObserve = [NSMutableArray<NSString*> array];
//	[propertiesToObserve addObject:[SMBBeamEntityTileNode_PropertiesForKVO beamEnterDirection]];
//
//	[propertiesToObserve enumerateObjectsUsingBlock:^(NSString * _Nonnull propertyToObserve, NSUInteger idx, BOOL * _Nonnull stop) {
//		if (registered)
//		{
//			[node_next addObserver:self
//						forKeyPath:propertyToObserve
//						   options:(0)
//						   context:&kSMBBeamEntityTileNode__KVOContext];
//		}
//		else
//		{
//			[node_next removeObserver:self
//						   forKeyPath:propertyToObserve
//							  context:&kSMBBeamEntityTileNode__KVOContext];
//		}
//	}];
//}

//-(void)node_next_removeFromTile
//{
//	SMBBeamEntityTileNode* const node_next = self.node_next;
//	kRUConditionalReturn(node_next == nil, YES);
//
//	SMBGameBoardTile* const gameBoardTile = node_next.gameBoardTile;
//	kRUConditionalReturn(gameBoardTile == nil, NO);
//
//	[gameBoardTile gameBoardTileEntities_many_remove:node_next];
//}
//
//-(void)setNode_next_generationEnabled:(BOOL)node_next_generationEnabled
//{
//	kRUConditionalReturn(self.node_next_generationEnabled == node_next_generationEnabled, NO);
//
//	_node_next_generationEnabled = node_next_generationEnabled;
//
//	[self node_next_update];
//}
//
//-(void)node_next_generationEnabled_update
//{
//	[self setNode_next_generationEnabled:[self node_next_generationEnabled_shouldBe]];
//}
//
//-(BOOL)node_next_generationEnabled_shouldBe
//{
//	return
//	((self.gameBoardTile != nil)
//	 &&
//	 (self.state == SMBBeamEntityTileNode__state_ready));
//}

-(void)node_next_update_if_needed
{
	kRUConditionalReturn([self node_next_update_is_needed] == false, NO);

	[self node_next_update];
}

-(BOOL)node_next_update_is_needed
{
	SMBBeamEntityTileNode* const node_next = self.node_next;
	kRUConditionalReturn_ReturnValueFalse((node_next != nil)
										  &&
										  (node_next.gameBoardTile == nil), NO);

	SMBGameBoardTile* const node_next_gameTile = self.node_next_gameTile;
//	kRUConditionalReturn_ReturnValueFalse((node_next_gameTile == nil)
//										  &&
//										  (node_next == nil), NO);

	kRUConditionalReturn_ReturnValueFalse((node_next_gameTile != nil)
										  &&
										  (node_next != nil)
										  &&
										  (node_next.gameBoardTile == node_next_gameTile), NO)

	return YES;
}

-(void)node_next_update
{
	[self setNode_next:[self node_next_generate]];
}

-(nullable SMBBeamEntityTileNode*)node_next_generate
{
	SMBGameBoardTile* const node_next_gameTile = self.node_next_gameTile;
	kRUConditionalReturn_ReturnValueNil(node_next_gameTile == nil, NO);

	SMBBeamEntityTileNode* const node_next_existing = self.node_next;
	kRUConditionalReturn_ReturnValue((node_next_existing != nil)
									 &&
									 (node_next_existing.gameBoardTile == nil), NO, node_next_existing);

	SMBBeamEntity* const beamEntity = self.beamEntity;
	kRUConditionalReturn_ReturnValueNil(beamEntity == nil, YES);

	SMBGameBoardTile__direction const beamExitDirection = self.beamExitDirection;
	kRUConditionalReturn_ReturnValueNil(SMBGameBoardTile__direction__isInRange(beamExitDirection) == false, NO);

	SMBBeamEntityTileNode* const node_next =
	[[SMBBeamEntityTileNode alloc] init_with_beamEntity:beamEntity
									 beamEnterDirection:[[self class] beamEnterDirection_for_node_previous_exitDirection:self.beamExitDirection]];

	return node_next;
}

#pragma mark - node_next_gameTile
-(void)setNode_next_gameTile:(nullable SMBGameBoardTile*)node_next_gameTile
{
	kRUConditionalReturn(self.node_next_gameTile == node_next_gameTile, NO);

	_node_next_gameTile = node_next_gameTile;

	if ((self.node_next != nil)
		&&
		(self.node_next.gameBoardTile != nil))
	{
		[self setNode_next:nil];
	}
}

-(void)node_next_gameTile_update
{
	[self setNode_next_gameTile:[self node_next_gameTile_appropriate]];
}

-(nullable SMBGameBoardTile*)node_next_gameTile_appropriate
{
	kRUConditionalReturn_ReturnValueNil(self.state != SMBBeamEntityTileNode__state_ready, NO);

	SMBGameBoardTile* const gameBoardTile = self.gameBoardTile;
	kRUConditionalReturn_ReturnValueNil(gameBoardTile == nil, NO);

	SMBGameBoardTile__direction const beamExitDirection = self.beamExitDirection;
	kRUConditionalReturn_ReturnValueNil(beamExitDirection == SMBGameBoardTile__direction_none, NO);
	kRUConditionalReturn_ReturnValueNil(SMBGameBoardTile__direction__isInRange(beamExitDirection) == false, YES);

	SMBGameBoardTile* const gameBoardTile_next = [gameBoardTile gameBoardTile_next_with_direction:beamExitDirection];
	kRUConditionalReturn_ReturnValueNil(gameBoardTile_next == nil, NO);

	SMBGameBoardTileEntity* const gameBoardTileEntity = gameBoardTile_next.gameBoardTileEntity_for_beamInteractions;
	kRUConditionalReturn_ReturnValueNil((gameBoardTileEntity != nil)
										&&
										([gameBoardTileEntity smb_beamBlocker_and_beamEnterDirection_isBlocked:[SMBBeamEntityTileNode beamEnterDirection_for_node_previous_exitDirection:beamExitDirection]]), NO);

	SMBBeamEntity* const beamEntity = self.beamEntity;
	kRUConditionalReturn_ReturnValueNil(beamEntity == nil, YES);
	
	SMBGameBoardTilePosition* const gameBoardTilePosition = gameBoardTile.gameBoardTilePosition;
	kRUConditionalReturn_ReturnValueNil(gameBoardTilePosition == nil, NO);
	
	NSArray<SMBBeamEntityTileNode*>* const beamEntityTileNodes_at_samePosition =
	[beamEntity beamEntityTileNodes_contained_at_position:gameBoardTilePosition
								   with_beamExitDirection:self.beamExitDirection];
	/* This node should be included in these nodes already. */
	kRUConditionalReturn_ReturnValueNil((beamEntityTileNodes_at_samePosition == nil)
										||
										([beamEntityTileNodes_at_samePosition containsObject:self] == false),
										YES);
	
	__block BOOL alreadyHaveNextNode = NO;
	[beamEntityTileNodes_at_samePosition enumerateObjectsUsingBlock:^(SMBBeamEntityTileNode * _Nonnull beamEntityTileNode, NSUInteger idx, BOOL * _Nonnull stop) {
		if ((beamEntityTileNode != self)
			&&
			beamEntityTileNode.node_next != nil)
		{
			alreadyHaveNextNode = YES;
			*stop = YES;
		}
	}];
	kRUConditionalReturn_ReturnValueNil(alreadyHaveNextNode, NO);

	return gameBoardTile_next;
}

#pragma mark - beamEnterDirection
//-(void)beamEnterDirection_update
//{
//	[self setBeamEnterDirection:[self beamEnterDirection_appropriate]];
//}
//
//-(SMBGameBoardTile__direction)beamEnterDirection_appropriate
//{
//	SMBBeamEntityTileNode* const node_previous = self.node_previous;
//	kRUConditionalReturn_ReturnValue(node_previous == nil, NO, SMBGameBoardTile__direction_none);
//
//	return [[self class] beamEnterDirection_for_node_previous_exitDirection:node_previous.beamExitDirection];
//}
+(SMBGameBoardTile__direction)beamEnterDirection_for_node_previous_exitDirection:(SMBGameBoardTile__direction)node_previous_exitDirection
{
	return SMBGameBoardTile__direction__opposite(node_previous_exitDirection);
}

#pragma mark - SMBGameBoardGeneralEntity: draw
-(void)draw_in_rect:(CGRect)rect
{
	[super draw_in_rect:rect];

	CGContextRef const context = UIGraphicsGetCurrentContext();

	CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
	CGContextSetLineWidth(context, 1.0f);

	SMBGameBoardTile__direction const beamEnterDirection = self.beamEnterDirection;
	if (SMBGameBoardTile__direction__isInRange(beamEnterDirection))
	{
		[self draw_half_line_in_rect:rect
						   direction:beamEnterDirection];
	}

	SMBGameBoardTile__direction const beamExitDirection = self.beamExitDirection;
	if (SMBGameBoardTile__direction__isInRange(beamExitDirection))
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

#pragma mark - state
-(void)setState:(SMBBeamEntityTileNode__state)state
{
	kRUConditionalReturn([self state_validate_new:state] == false, YES);
	kRUConditionalReturn(self.state == state, NO);

	_state = state;

	[self node_next_gameTile_update];
}

-(void)setState_ready
{
	[self setState:SMBBeamEntityTileNode__state_ready];
}

-(void)setState_finished
{
	[self setState:SMBBeamEntityTileNode__state_finished];
}

-(BOOL)state_validate_new:(SMBBeamEntityTileNode__state)state_new
{
	switch (state_new)
	{
		case SMBBeamEntityTileNode__state_none:
			return NO;
			break;

		case SMBBeamEntityTileNode__state_created:
			return (self.state == SMBBeamEntityTileNode__state_none);
			break;

		case SMBBeamEntityTileNode__state_ready:
		{
			kRUConditionalReturn_ReturnValueFalse(self.gameBoardTile == nil, NO);
			kRUConditionalReturn_ReturnValueFalse(self.state != SMBBeamEntityTileNode__state_created, NO);

			return YES;
		}
			break;

		case SMBBeamEntityTileNode__state_finished:
			return (self.state == SMBBeamEntityTileNode__state_ready);
			break;
	}

	NSAssert(false, @"unhandled state_new %li",(long)state_new);
	return NO;
}

#pragma mark - beamEntityTileNode
-(void)beamEntityTileNode_gameBoardTile_update:(nonnull SMBBeamEntityTileNode*)beamEntityTileNode
{
	kRUConditionalReturn(beamEntityTileNode == nil, YES);

	if (self.node_next == beamEntityTileNode)
	{
		SMBGameBoardTile* const node_next_gameTile = self.node_next_gameTile;
		kRUConditionalReturn(node_next_gameTile == nil, YES);

		NSAssert(beamEntityTileNode.gameBoardTile == nil, @"Should be");
		[node_next_gameTile gameBoardTileEntities_many_add:beamEntityTileNode];
		NSAssert(beamEntityTileNode.gameBoardTile == node_next_gameTile, @"Should be");
	}
	else
	{
		SMBGameBoardTile* const beamEntityTileNode_gameTile = beamEntityTileNode.gameBoardTile;
		kRUConditionalReturn(beamEntityTileNode_gameTile == nil, YES);

		NSAssert(beamEntityTileNode.gameBoardTile == beamEntityTileNode_gameTile, @"Should be");
		[beamEntityTileNode_gameTile gameBoardTileEntities_many_remove:beamEntityTileNode];
		NSAssert(beamEntityTileNode.gameBoardTile == nil, @"Should be");
	}
}

@end





@implementation SMBBeamEntityTileNode_PropertiesForKVO

+(nonnull NSString*)node_next{return NSStringFromSelector(_cmd);}
//+(nonnull NSString*)beamEnterDirection{return NSStringFromSelector(_cmd);}
+(nonnull NSString*)node_next_gameTile{return NSStringFromSelector(_cmd);}

@end
