//
//  SMBBeamEntityTileNode.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/5/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#define kSMBBeamEntityTileNode__beamDrawing_shouldBeOnRightSide (kSMBEnvironment__SMBBeamEntityTileNode_beamDrawing_shouldBeOnRightSide && 1)

#import "SMBBeamEntityTileNode.h"
#import "SMBGameBoardTile.h"
#import "SMBBeamCreatorTileEntity.h"
#import "SMBGameBoard.h"
#import "SMBGameBoardTilePosition.h"
#import "SMBGeneralBeamEnterToExitDirectionRedirectTileEntity.h"
#import "SMBBeamEntity.h"
#import "SMBGameBoardTileEntity+SMBBeamBlocker.h"
#import "SMBGameBoardTile__directions.h"
#import "SMBGameBoardTile__direction_rotations.h"
#import "SMBGameBoardTileBeamEnterToExitDirectionMapping.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/RUClassOrNilUtil.h>
#import <ResplendentUtilities/RUProtocolOrNil.h>
#import <ResplendentUtilities/NSMutableArray+RUAddObjectIfNotNil.h>
#import <ResplendentUtilities/RUConstants.h>





@interface SMBBeamEntityTileNode_DrawHalfLineProperties : NSObject

#pragma mark - startPoint
@property (nonatomic, readonly, assign) CGPoint startPoint;

#pragma mark - endPoint
@property (nonatomic, readonly, assign) CGPoint endPoint;

#pragma mark - init
-(nullable instancetype)init_with_startPoint:(CGPoint)startPoint
									endPoint:(CGPoint)endPoint NS_DESIGNATED_INITIALIZER;

@end





@implementation SMBBeamEntityTileNode_DrawHalfLineProperties

#pragma mark - NSObject
-(instancetype)init
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);

	return [self init_with_startPoint:CGPointZero
							  endPoint:CGPointZero];
}

#pragma mark - init
-(nullable instancetype)init_with_startPoint:(CGPoint)startPoint
									endPoint:(CGPoint)endPoint
{
	kRUConditionalReturn_ReturnValueNil(CGPointEqualToPoint(startPoint, endPoint), YES);

	if (self = [super init])
	{
		_startPoint = startPoint;
		_endPoint = endPoint;
	}

	return self;
}

@end





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

#pragma mark - gameBoardTile
-(BOOL)gameBoardTile_validateNew:(nullable SMBGameBoardTile*)gameBoardTile;
-(void)SMBBeamEntityTileNode_gameBoardTile_setKVORegistered:(BOOL)registered;
-(void)gameBoardTile_gameBoardTileEntity_for_beamInteractions_did_change_updates;

#pragma mark - beamExitDirection
@property (nonatomic, assign) SMBGameBoardTile__direction beamExitDirection;
-(void)beamExitDirection_update;
-(SMBGameBoardTile__direction)beamExitDirection_generate;

#pragma mark - node_next
@property (nonatomic, strong, nullable) SMBBeamEntityTileNode* node_next;
-(void)node_next_update;
-(nullable SMBBeamEntityTileNode*)node_next_generate;

-(BOOL)node_next_update_is_needed;

#pragma mark - beamEnterDirection
+(SMBGameBoardTile__direction)beamEnterDirection_for_node_previous_exitDirection:(SMBGameBoardTile__direction)node_previous_exitDirection;

#pragma mark - node_next_gameTilePosition
@property (nonatomic, strong, nullable) SMBGameBoardTilePosition* node_next_gameTilePosition;
-(void)node_next_gameTilePosition_update;
-(nullable SMBGameBoardTilePosition*)node_next_gameTilePosition_appropriate;
-(nullable SMBGameBoardTile*)node_next_gameTile_for_position;

#pragma mark - gameBoardTile_allows_beamEnterDirection
@property (nonatomic, assign) BOOL gameBoardTile_allows_beamEnterDirection;
-(void)gameBoardTile_allows_beamEnterDirection_update;
-(BOOL)gameBoardTile_allows_beamEnterDirection_appropriate;

#pragma mark - half_line
-(nullable SMBBeamEntityTileNode_DrawHalfLineProperties*)half_line_draw_in_rect:(CGRect)rect
																	  direction:(SMBGameBoardTile__direction)direction
																		 offset:(UIOffset)offset
																		  inset:(UIEdgeInsets)inset;
-(UIOffset)half_line_offset_in_rect:(CGRect)rect
						  direction:(SMBGameBoardTile__direction)direction
							   exit:(BOOL)exit;
-(UIEdgeInsets)half_line_inset_in_rect:(CGRect)rect
							 direction:(SMBGameBoardTile__direction)direction
								isLong:(BOOL)isLong;
-(nullable SMBBeamEntityTileNode_DrawHalfLineProperties*)half_line_draw_enter_in_rect:(CGRect)rect;
-(nullable SMBBeamEntityTileNode_DrawHalfLineProperties*)half_line_draw_exit_in_rect:(CGRect)rect;

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

#pragma mark - providesPower
-(void)providesPower_update;
-(BOOL)providesPower_appropriate;

@end





@implementation SMBBeamEntityTileNode

#pragma mark - NSObject
-(void)dealloc
{
	[self SMBBeamEntityTileNode_gameBoardTile_setKVORegistered:NO];
}

-(instancetype)init
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);

#if __has_feature(nullability)
#pragma clang diagnostic push
#pragma GCC diagnostic ignored "-Wnullability-completeness"
#endif
	return [self init_with_beamEntity:nil
				   beamEnterDirection:SMBGameBoardTile__direction_unknown];
#if __has_feature(nullability)
#pragma clang diagnostic pop
#endif
}

-(nonnull NSString*)description
{
	NSMutableArray<NSString*>* const description_lines = [NSMutableArray<NSString*> array];
	[description_lines ru_addObjectIfNotNil:[super description]];
	[description_lines ru_addObjectIfNotNil:RUStringWithFormat(@"node_next_gameTilePosition: %@",self.node_next_gameTilePosition)];
	[description_lines ru_addObjectIfNotNil:RUStringWithFormat(@"beamEnterDirection: %lu",(unsigned long)self.beamEnterDirection)];
	[description_lines ru_addObjectIfNotNil:RUStringWithFormat(@"beamExitDirection: %lu",(unsigned long)self.beamExitDirection)];

	return [description_lines componentsJoinedByString:@"\n"];
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
		[self providesPower_update];
		[self gameBoardTile_allows_beamEnterDirection_update];

		[self setState:SMBBeamEntityTileNode__state_created];
	}

	return self;
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

	[self node_next_gameTilePosition_update];
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

	NSMutableDictionary<NSNumber*,NSMutableArray<NSString*>*>* const KVOOptions_to_propertiesToObserve_mapping = [NSMutableDictionary<NSNumber*,NSMutableArray<NSString*>*> dictionary];

	NSMutableArray<NSString*>* const propertiesToObserve_observe_initial = [NSMutableArray<NSString*> array];
	[propertiesToObserve_observe_initial addObject:[SMBGameBoardTile_PropertiesForKVO gameBoardTileEntity_for_beamInteractions]];
	[propertiesToObserve_observe_initial addObject:[SMBGameBoardTile_PropertiesForKVO beamEnterDirections_blocked]];
	[propertiesToObserve_observe_initial addObject:[SMBGameBoardTile_PropertiesForKVO beamEnterToExitDirectionMapping]];
	[KVOOptions_to_propertiesToObserve_mapping setObject:propertiesToObserve_observe_initial forKey:@(NSKeyValueObservingOptionInitial)];

	[KVOOptions_to_propertiesToObserve_mapping enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull KVOOptions_number, NSMutableArray<NSString *> * _Nonnull propertiesToObserve, BOOL * _Nonnull stop) {
		[propertiesToObserve enumerateObjectsUsingBlock:^(NSString * _Nonnull propertyToObserve, NSUInteger idx, BOOL * _Nonnull stop) {
			if (registered)
			{
				[gameBoardTile addObserver:self
								forKeyPath:propertyToObserve
								   options:(KVOOptions_number.unsignedIntegerValue)
								   context:&kSMBBeamEntityTileNode__KVOContext];
			}
			else
			{
				[gameBoardTile removeObserver:self
								   forKeyPath:propertyToObserve
									  context:&kSMBBeamEntityTileNode__KVOContext];
			}
		}];
	}];
}

-(void)gameBoardTile_gameBoardTileEntity_for_beamInteractions_did_change_updates
{
	[self beamExitDirection_update];
}

#pragma mark - beamExitDirection
-(void)setBeamExitDirection:(SMBGameBoardTile__direction)beamExitDirection
{
	kRUConditionalReturn(SMBGameBoardTile__direction__isInRange_or_none(beamExitDirection) == false, YES);
	kRUConditionalReturn(self.beamExitDirection == beamExitDirection, NO);

	_beamExitDirection = beamExitDirection;

	[self node_next_gameTilePosition_update];
	[self setNeedsRedraw];
}

-(void)beamExitDirection_update
{
	[self setBeamExitDirection:[self beamExitDirection_generate]];
}

-(SMBGameBoardTile__direction)beamExitDirection_generate
{
	SMBGameBoardTile__direction const direction_error = SMBGameBoardTile__direction_unknown;

	SMBGameBoardTile* const gameBoardTile = self.gameBoardTile;
	kRUConditionalReturn_ReturnValue(gameBoardTile == nil, NO, SMBGameBoardTile__direction_none);

	SMBGameBoardTile__direction const beamEnterDirection = self.beamEnterDirection;
	kRUConditionalReturn_ReturnValue(SMBGameBoardTile__direction__isInRange_or_none(beamEnterDirection) == false, YES, direction_error);

	SMBGameBoardTileEntity* const gameBoardTileEntity_for_beamInteractions = gameBoardTile.gameBoardTileEntity_for_beamInteractions;

	if (beamEnterDirection == SMBGameBoardTile__direction_none)
	{
		if (gameBoardTileEntity_for_beamInteractions == nil)
		{
			SMBBeamEntity* const beamEntity = self.beamEntity;
			kRUConditionalReturn_ReturnValue(beamEntity == nil, YES, direction_error);
			kRUConditionalReturn_ReturnValue((beamEntity.beamEntityManager != nil)
											 &&
											 [beamEntity beamEntityTileNodes_contains:self], YES, direction_error);

			return SMBGameBoardTile__direction_none;
		}

		SMBBeamCreatorTileEntity* const beamCreatorTileEntity = kRUClassOrNil(gameBoardTileEntity_for_beamInteractions, SMBBeamCreatorTileEntity);
		kRUConditionalReturn_ReturnValue((beamCreatorTileEntity == nil)
										 ||
										 (self.beamEntity.beamEntityTileNode_initial != self), YES, direction_error);

		return beamCreatorTileEntity.beamDirection;
	}

	kRUConditionalReturn_ReturnValue(self.gameBoardTile_allows_beamEnterDirection == false, NO, SMBGameBoardTile__direction_none);

	SMBGameBoardTileBeamEnterToExitDirectionMapping* const beamEnterToExitDirectionMapping = gameBoardTile.beamEnterToExitDirectionMapping;
	kRUConditionalReturn_ReturnValue(beamEnterToExitDirectionMapping == nil, YES, SMBGameBoardTile__direction__opposite(beamEnterDirection));

	return [beamEnterToExitDirectionMapping beamExitDirection_for_beamEnterDirection:beamEnterDirection];
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
				[self gameBoardTile_gameBoardTileEntity_for_beamInteractions_did_change_updates];
			}
			else if ([keyPath isEqualToString:[SMBGameBoardTile_PropertiesForKVO beamEnterDirections_blocked]])
			{
				[self gameBoardTile_allows_beamEnterDirection_update];
			}
			else if ([keyPath isEqualToString:[SMBGameBoardTile_PropertiesForKVO beamEnterToExitDirectionMapping]])
			{
				[self beamExitDirection_update];
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
-(void)setNode_next:(nullable SMBBeamEntityTileNode*)node_next
{
	kRUConditionalReturn(self.node_next == node_next, NO);

	NSAssert((node_next == nil)
			 ||
			 (node_next.gameBoardTile == nil), @"non-nil node next shouldn't have a game board tile yet");

	SMBBeamEntityTileNode* const node_next_old = self.node_next;
	_node_next = node_next;

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

-(void)node_next_update_if_needed
{
	[self gameBoardTile_gameBoardTileEntity_for_beamInteractions_did_change_updates];

	kRUConditionalReturn([self node_next_update_is_needed] == false, NO);

	[self node_next_update];
}

-(BOOL)node_next_update_is_needed
{
	SMBBeamEntityTileNode* const node_next = self.node_next;
	kRUConditionalReturn_ReturnValueFalse((node_next != nil)
										  &&
										  (node_next.gameBoardTile == nil), NO);

	SMBGameBoardTilePosition* const node_next_gameTilePosition = self.node_next_gameTilePosition;
	kRUConditionalReturn_ReturnValueFalse((node_next_gameTilePosition != nil)
										  &&
										  (node_next != nil)
										  &&
										  ([node_next.gameBoardTile.gameBoardTilePosition isEqual_to_gameBoardTilePosition:node_next_gameTilePosition]), NO)

	return YES;
}

-(void)node_next_update
{
	[self setNode_next:[self node_next_generate]];
}

-(nullable SMBBeamEntityTileNode*)node_next_generate
{
	SMBGameBoardTilePosition* const node_next_gameTilePosition = self.node_next_gameTilePosition;
	kRUConditionalReturn_ReturnValueNil(node_next_gameTilePosition == nil, NO);

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

#pragma mark - node_next_gameTilePosition
-(void)node_next_gameTilePosition_update
{
	[self setNode_next_gameTilePosition:[self node_next_gameTilePosition_appropriate]];
}

-(nullable SMBGameBoardTilePosition*)node_next_gameTilePosition_appropriate
{
	kRUConditionalReturn_ReturnValueNil(self.state != SMBBeamEntityTileNode__state_ready, NO);

	SMBGameBoardTile* const gameBoardTile = self.gameBoardTile;
	kRUConditionalReturn_ReturnValueNil(gameBoardTile == nil, NO);

	SMBGameBoardTile__direction const beamExitDirection = self.beamExitDirection;
	kRUConditionalReturn_ReturnValueNil(beamExitDirection == SMBGameBoardTile__direction_none, NO);
	kRUConditionalReturn_ReturnValueNil(SMBGameBoardTile__direction__isInRange(beamExitDirection) == false, YES);

	SMBGameBoardTile* const gameBoardTile_next = [gameBoardTile gameBoardTile_next_with_direction:beamExitDirection];
	kRUConditionalReturn_ReturnValueNil(gameBoardTile_next == nil, NO);

	SMBBeamEntity* const beamEntity = self.beamEntity;
	kRUConditionalReturn_ReturnValueNil(beamEntity == nil, YES);

	SMBGameBoardTilePosition* const gameBoardTilePosition = gameBoardTile.gameBoardTilePosition;
	kRUConditionalReturn_ReturnValueNil(gameBoardTilePosition == nil, NO);

	NSArray<SMBBeamEntityTileNode*>* const beamEntityTileNodes_at_samePosition =
	[beamEntity beamEntityTileNodes_contained_at_position:gameBoardTilePosition
								   with_beamExitDirection:beamExitDirection];
	/* This node should be included in these nodes already. */
	kRUConditionalReturn_ReturnValueNil((beamEntityTileNodes_at_samePosition == nil)
										||
										([beamEntityTileNodes_at_samePosition containsObject:self] == false),
										YES);

	kRUConditionalReturn_ReturnValueNil(beamEntityTileNodes_at_samePosition.firstObject != self, NO)

	return gameBoardTile_next.gameBoardTilePosition;
}

-(nullable SMBGameBoardTile*)node_next_gameTile_for_position
{
	SMBGameBoardTilePosition* const node_next_gameTilePosition = self.node_next_gameTilePosition;
	kRUConditionalReturn_ReturnValueNil(node_next_gameTilePosition == nil, NO);

	SMBGameBoardTile* const gameBoardTile = self.gameBoardTile;
	kRUConditionalReturn_ReturnValueNil(gameBoardTile == nil, YES);

	SMBGameBoard* const gameBoard = gameBoardTile.gameBoard;
	kRUConditionalReturn_ReturnValueNil(gameBoard == nil, YES);

	return [gameBoard gameBoardTile_at_position:node_next_gameTilePosition];
}

#pragma mark - gameBoardTile_allows_beamEnterDirection
-(void)setGameBoardTile_allows_beamEnterDirection:(BOOL)gameBoardTile_allows_beamEnterDirection
{
	kRUConditionalReturn(self.gameBoardTile_allows_beamEnterDirection == gameBoardTile_allows_beamEnterDirection, NO);

	_gameBoardTile_allows_beamEnterDirection = gameBoardTile_allows_beamEnterDirection;

	[self beamExitDirection_update];
	[self providesPower_update];
	[self setNeedsRedraw];
}

-(void)gameBoardTile_allows_beamEnterDirection_update
{
	[self setGameBoardTile_allows_beamEnterDirection:[self gameBoardTile_allows_beamEnterDirection_appropriate]];
}

-(BOOL)gameBoardTile_allows_beamEnterDirection_appropriate
{
	SMBGameBoardTile* const gameBoardTile = self.gameBoardTile;
	kRUConditionalReturn_ReturnValueFalse(gameBoardTile == nil, NO);

	SMBGameBoardTile__direction const beamEnterDirection = self.beamEnterDirection;
	kRUConditionalReturn_ReturnValueFalse(SMBGameBoardTile__direction__isInRange(self.beamEnterDirection) == false, NO);
	kRUConditionalReturn_ReturnValueFalse((gameBoardTile.beamEnterDirections_blocked & beamEnterDirection), NO);

	return YES;
}

#pragma mark - beamEnterDirection
+(SMBGameBoardTile__direction)beamEnterDirection_for_node_previous_exitDirection:(SMBGameBoardTile__direction)node_previous_exitDirection
{
	return SMBGameBoardTile__direction__opposite(node_previous_exitDirection);
}

#pragma mark - SMBGameBoardGeneralEntity: draw
-(void)draw_in_rect:(CGRect)rect
{
	[super draw_in_rect:rect];

	CGContextRef const context = UIGraphicsGetCurrentContext();

	CGContextSaveGState(context);

	CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
	CGContextSetLineWidth(context, [[self class] half_line_width_in_rect:rect]);

	SMBBeamEntityTileNode_DrawHalfLineProperties* const drawHalfLineProperties_enter =
	[self half_line_draw_enter_in_rect:rect];

	SMBBeamEntityTileNode_DrawHalfLineProperties* const drawHalfLineProperties_exit =
	[self half_line_draw_exit_in_rect:rect];

	if ((drawHalfLineProperties_enter != nil)
		&&
		(drawHalfLineProperties_exit != nil)
		&&
		(CGPointEqualToPoint(drawHalfLineProperties_enter.startPoint, drawHalfLineProperties_exit.startPoint) == false))
	{
		CGContextMoveToPoint(context, drawHalfLineProperties_enter.startPoint.x, drawHalfLineProperties_enter.startPoint.y);
		CGContextAddLineToPoint(context, drawHalfLineProperties_exit.startPoint.x, drawHalfLineProperties_exit.startPoint.y);
	}

	CGContextStrokePath(context);

	CGContextRestoreGState(context);
}

#pragma mark - half_line
-(nullable SMBBeamEntityTileNode_DrawHalfLineProperties*)half_line_draw_in_rect:(CGRect)rect
																	  direction:(SMBGameBoardTile__direction)direction
																		 offset:(UIOffset)offset
																		  inset:(UIEdgeInsets)inset
{
	kRUConditionalReturn_ReturnValueNil(SMBGameBoardTile__direction__isInRange(direction) == false, YES);

	CGContextRef const context = UIGraphicsGetCurrentContext();

	CGPoint(^point_offset)(CGPoint point) = ^CGPoint(CGPoint point){
		return (CGPoint){
			.x	= point.x	+ offset.horizontal,
			.y	= point.y	+ offset.vertical,
		};
	};

	CGPoint const startPoint_raw = point_offset([self draw_point_center_with_rect:rect]);
	CGPoint const startPoint_inset = (CGPoint){
		.x	= startPoint_raw.x - inset.right + inset.left,
		.y	= startPoint_raw.y + inset.top - inset.bottom,
	};

	SMBBeamEntityTileNode_DrawHalfLineProperties* const drawHalfLineProperties =
	[[SMBBeamEntityTileNode_DrawHalfLineProperties alloc] init_with_startPoint:startPoint_inset
																	  endPoint:point_offset([self draw_point_edgeMiddle_with_rect:rect direction:direction])];

	CGContextMoveToPoint(context, drawHalfLineProperties.startPoint.x, drawHalfLineProperties.startPoint.y);
	CGContextAddLineToPoint(context, drawHalfLineProperties.endPoint.x, drawHalfLineProperties.endPoint.y);

	return drawHalfLineProperties;
}

+(CGFloat)half_line_width_in_rect:(CGRect)rect
{
	return 1.0f;
}

+(CGFloat)half_line_offset_amount_for_rect:(CGRect)rect
{
	return
#if kSMBBeamEntityTileNode__beamDrawing_shouldBeOnRightSide
	CGRectGetWidth(rect) / 20.0f;
#else
	0;
#endif
}

-(UIOffset)half_line_offset_in_rect:(CGRect)rect
						  direction:(SMBGameBoardTile__direction)direction
							   exit:(BOOL)exit
{
	CGFloat const offset_for_road = [[self class] half_line_offset_amount_for_rect:rect];

	switch (direction)
	{
		case SMBGameBoardTile__direction_unknown:
		case SMBGameBoardTile__direction_none:
			break;

		case SMBGameBoardTile__direction_up:
			return (UIOffset){
				.horizontal		= (exit ? offset_for_road : -offset_for_road),
			};
			break;

		case SMBGameBoardTile__direction_right:
			return (UIOffset){
				.vertical		= (exit ? offset_for_road : -offset_for_road),
			};
			break;

		case SMBGameBoardTile__direction_down:
			return (UIOffset){
				.horizontal		= (exit ? -offset_for_road : offset_for_road),
			};
			break;

		case SMBGameBoardTile__direction_left:
			return (UIOffset){
				.vertical		= (exit ? -offset_for_road : offset_for_road),
			};
			break;
	}

	NSAssert(false, @"unhandled direction %li",(long)direction);
	return UIOffsetZero;
}

-(UIEdgeInsets)half_line_inset_in_rect:(CGRect)rect
							 direction:(SMBGameBoardTile__direction)direction
								isLong:(BOOL)isLong
{
	CGFloat const offset_for_road = [[self class] half_line_offset_amount_for_rect:rect];

	switch (direction)
	{
		case SMBGameBoardTile__direction_unknown:
		case SMBGameBoardTile__direction_none:
			break;

		case SMBGameBoardTile__direction_up:
			return (UIEdgeInsets){
				.bottom		= (isLong ? -offset_for_road : offset_for_road),
			};
			break;

		case SMBGameBoardTile__direction_right:
			return (UIEdgeInsets){
				.left		= (isLong ? -offset_for_road : offset_for_road),
			};
			break;

		case SMBGameBoardTile__direction_down:
			return (UIEdgeInsets){
				.top		= (isLong ? -offset_for_road : offset_for_road),
			};
			break;

		case SMBGameBoardTile__direction_left:
			return (UIEdgeInsets){
				.right		= (isLong ? -offset_for_road : offset_for_road),
			};
			break;
	}

	NSAssert(false, @"unhandled direction %li",(long)direction);
	return UIEdgeInsetsZero;
}

-(nullable SMBBeamEntityTileNode_DrawHalfLineProperties*)half_line_draw_enter_in_rect:(CGRect)rect
{
	kRUConditionalReturn_ReturnValueNil(self.gameBoardTile_allows_beamEnterDirection == false, NO);

	SMBGameBoardTile__direction const beamEnterDirection = self.beamEnterDirection;
	kRUConditionalReturn_ReturnValueNil(SMBGameBoardTile__direction__isInRange(beamEnterDirection) == false, NO);

	UIOffset const offset =
	[self half_line_offset_in_rect:rect
						 direction:beamEnterDirection
							  exit:NO];

	return
	[self half_line_draw_in_rect:rect
					   direction:beamEnterDirection
						  offset:offset
						   inset:
	 [self half_line_inset_in_rect:rect
						 direction:beamEnterDirection
							isLong:NO]
	 ];
}

-(nullable SMBBeamEntityTileNode_DrawHalfLineProperties*)half_line_draw_exit_in_rect:(CGRect)rect
{
	SMBGameBoardTile__direction const beamExitDirection = self.beamExitDirection;
	kRUConditionalReturn_ReturnValueNil(SMBGameBoardTile__direction__isInRange(beamExitDirection) == false, NO);

	SMBGameBoardTile__direction const beamEnterDirection = self.beamEnterDirection;

	return
	[self half_line_draw_in_rect:rect
					   direction:beamExitDirection
						  offset:
	 [self half_line_offset_in_rect:rect
						  direction:beamExitDirection
							   exit:YES]
						   inset:
	 (SMBGameBoardTile__direction__isInRange(beamEnterDirection)
	  ?
	  [self half_line_inset_in_rect:rect
						  direction:beamExitDirection
							 isLong:(SMBGameBoardTile__direction_rotation_direction_rotated_left(beamEnterDirection) != beamExitDirection)]
	  :
	  UIEdgeInsetsZero
	 )
	 ];
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

	[self providesPower_update];
	[self node_next_gameTilePosition_update];

	switch (self.state)
	{
		case SMBBeamEntityTileNode__state_finished:
			[self setNode_next:nil];
			break;

		default:
			break;
	}
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
			kRUConditionalReturn_ReturnValueFalse(self.state != SMBBeamEntityTileNode__state_created, NO);

			return YES;
		}
			break;

		case SMBBeamEntityTileNode__state_finished:
		{
			kRUConditionalReturn_ReturnValueTrue(self.state == SMBBeamEntityTileNode__state_ready, NO);
			kRUConditionalReturn_ReturnValueTrue(self.state == SMBBeamEntityTileNode__state_created, NO);

			return NO;
		}
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
		SMBGameBoardTile* const node_next_gameTile_for_position = [self node_next_gameTile_for_position];
		kRUConditionalReturn(node_next_gameTile_for_position == nil, YES);

		NSAssert(beamEntityTileNode.gameBoardTile == nil, @"Should be");
		[node_next_gameTile_for_position gameBoardTileEntities_add:beamEntityTileNode
														entityType:SMBGameBoardTile__entityType_many];

		NSAssert(beamEntityTileNode.gameBoardTile == node_next_gameTile_for_position, @"Should be");
	}
	else
	{
		SMBGameBoardTile* const beamEntityTileNode_gameTile = beamEntityTileNode.gameBoardTile;
		/*
		 Note about the assertion here:
		 The only scenario where `beamEntityTileNode_gameTile` can be nil at this point should be when
		 1) This node is getting removed from a dying tile.
		 2) This node is getting its state set to false.
		 Therefor, we crash only if:
		 1) `self.gameBoardTile` isn't nil
		 AND
		 2) `state` isn't `SMBBeamEntityTileNode__state_finished`.
		 */
		kRUConditionalReturn(beamEntityTileNode_gameTile == nil,
							 (self.gameBoardTile != nil)
							 &&
							 (self.state != SMBBeamEntityTileNode__state_finished));

		NSAssert(beamEntityTileNode.gameBoardTile == beamEntityTileNode_gameTile, @"Should be");
		[beamEntityTileNode_gameTile gameBoardTileEntities_remove:beamEntityTileNode
													   entityType:SMBGameBoardTile__entityType_many];
		NSAssert(beamEntityTileNode.gameBoardTile == nil, @"Should be");
	}
}

#pragma mark - SMBGameBoardTileEntity_PowerProvider
@synthesize providesPower = _providesPower;

#pragma mark - providesPower
-(void)providesPower_update
{
	[self setProvidesPower:[self providesPower_appropriate]];
}

-(BOOL)providesPower_appropriate
{
	kRUConditionalReturn_ReturnValueFalse(self.state != SMBBeamEntityTileNode__state_ready, NO);
	kRUConditionalReturn_ReturnValueFalse(self.gameBoardTile_allows_beamEnterDirection == false, NO);

	return SMBGameBoardTile__direction__isInRange(self.beamEnterDirection);
}

@end





@implementation SMBBeamEntityTileNode_PropertiesForKVO

+(nonnull NSString*)node_next{return NSStringFromSelector(_cmd);}
+(nonnull NSString*)node_next_gameTilePosition{return NSStringFromSelector(_cmd);}

@end
