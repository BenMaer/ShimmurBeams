//
//  SMBBeamEntity.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/5/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBBeamEntity.h"
#import "SMBBeamEntityTileNode.h"
#import "SMBMutableMappedDataCollection.h"
#import "SMBGameBoardTile.h"
#import "SMBGameBoardView.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





static void* kSMBBeamEntity__KVOContext = &kSMBBeamEntity__KVOContext;





typedef NS_ENUM(NSInteger, SMBBeamEntity__drawingPiece) {
	SMBBeamEntity__drawingPiece_enter,
	SMBBeamEntity__drawingPiece_leave,

	SMBBeamEntity__drawingPiece__first	= SMBBeamEntity__drawingPiece_enter,
	SMBBeamEntity__drawingPiece__last	= SMBBeamEntity__drawingPiece_leave,
};





@interface SMBBeamEntity ()

#pragma mark - beamEntityTileNode_mappedDataCollection
@property (nonatomic, copy, nullable) SMBMappedDataCollection<SMBBeamEntityTileNode*>* beamEntityTileNode_mappedDataCollection;
-(void)beamEntityTileNode_mappedDataCollection_setKVORegistered:(BOOL)registered;
-(void)beamEntityTileNode:(nonnull SMBBeamEntityTileNode*)beamEntityTileNode
		 setKVORegistered:(BOOL)registered;
-(void)beamEntityTileNode_mappedDataCollection_update;
-(nullable SMBMappedDataCollection<SMBBeamEntityTileNode*>*)beamEntityTileNode_mappedDataCollection_generate;

#pragma mark - draw
-(void)draw_gameBoardTilePosition:(nonnull SMBGameBoardTilePosition*)gameBoardTilePosition
				 in_gameBoardView:(nonnull SMBGameBoardView*)gameBoardView
							 rect:(CGRect)rect
				  beamOrientation:(SMBBeamEntityTileNode__beamOrientation)beamOrientation;

-(CGPoint)draw_point_center_with_gameBoardTilePosition_frame_local:(CGRect)gameBoardTilePosition_frame_local;

-(CGPoint)draw_point_edgeMiddle_with_gameBoardTilePosition_frame_local:(CGRect)gameBoardTilePosition_frame_local
													   beamOrientation:(SMBBeamEntityTileNode__beamOrientation)beamOrientation;
-(CGFloat)draw_point_edgeMiddle_xCoord_with_gameBoardTilePosition_frame_local:(CGRect)gameBoardTilePosition_frame_local
															  beamOrientation:(SMBBeamEntityTileNode__beamOrientation)beamOrientation;
-(CGFloat)draw_point_edgeMiddle_yCoord_with_gameBoardTilePosition_frame_local:(CGRect)gameBoardTilePosition_frame_local
															  beamOrientation:(SMBBeamEntityTileNode__beamOrientation)beamOrientation;

@end





@implementation SMBBeamEntity

#pragma mark - NSObject
-(void)dealloc
{
	[self beamEntityTileNode_mappedDataCollection_setKVORegistered:NO];
}

-(instancetype)init
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wno-nullability-completeness"
	return [self init_with_gameBoardTile:nil];
#pragma clang diagnostic pop
}

#pragma mark - init
-(nullable instancetype)init_with_gameBoardTile:(nonnull SMBGameBoardTile*)gameBoardTile
{
	kRUConditionalReturn_ReturnValueNil(gameBoardTile == nil, YES);

	if (self = [super init])
	{
		_beamEntityTileNode_initial =
		[[SMBBeamEntityTileNode alloc] init_with_gameBoardTile:gameBoardTile
													beamEntity:self
												 node_previous:nil];

		[self beamEntityTileNode_mappedDataCollection_update];
	}

	return self;
}

#pragma mark - beamEntityTileNode_mappedDataCollection
-(void)setBeamEntityTileNode_mappedDataCollection:(nullable SMBMappedDataCollection<SMBBeamEntityTileNode*>*)beamEntityTileNode_mappedDataCollection
{
	kRUConditionalReturn((self.beamEntityTileNode_mappedDataCollection == beamEntityTileNode_mappedDataCollection)
						 ||
						 [self.beamEntityTileNode_mappedDataCollection isEqual_to_mappedDataCollection:beamEntityTileNode_mappedDataCollection], NO);

	[self beamEntityTileNode_mappedDataCollection_setKVORegistered:NO];

	_beamEntityTileNode_mappedDataCollection = beamEntityTileNode_mappedDataCollection;

	[self beamEntityTileNode_mappedDataCollection_setKVORegistered:YES];
}

-(void)beamEntityTileNode_mappedDataCollection_setKVORegistered:(BOOL)registered
{
	typeof(self.beamEntityTileNode_mappedDataCollection) const beamEntityTileNode_mappedDataCollection = self.beamEntityTileNode_mappedDataCollection;
	kRUConditionalReturn(beamEntityTileNode_mappedDataCollection == nil, NO);

	[[beamEntityTileNode_mappedDataCollection mappableObjects] enumerateObjectsUsingBlock:^(SMBBeamEntityTileNode * _Nonnull beamEntityTileNode, NSUInteger idx, BOOL * _Nonnull stop) {
		[self beamEntityTileNode:beamEntityTileNode
				setKVORegistered:registered];
	}];
}

-(void)beamEntityTileNode:(nonnull SMBBeamEntityTileNode*)beamEntityTileNode
		 setKVORegistered:(BOOL)registered
{
	kRUConditionalReturn(beamEntityTileNode == nil, NO);

	NSMutableArray<NSString*>* const propertiesToObserve = [NSMutableArray<NSString*> array];
	[propertiesToObserve addObject:[SMBBeamEntityTileNode_PropertiesForKVO node_next]];

	[propertiesToObserve enumerateObjectsUsingBlock:^(NSString * _Nonnull propertyToObserve, NSUInteger idx, BOOL * _Nonnull stop) {
		if (registered)
		{
			[beamEntityTileNode addObserver:self
								 forKeyPath:propertyToObserve
									options:(0)
									context:&kSMBBeamEntity__KVOContext];
		}
		else
		{
			[beamEntityTileNode removeObserver:self
									forKeyPath:propertyToObserve
									   context:&kSMBBeamEntity__KVOContext];
		}
	}];
}

-(void)beamEntityTileNode_mappedDataCollection_update
{
	[self setBeamEntityTileNode_mappedDataCollection:[self beamEntityTileNode_mappedDataCollection_generate]];
}

-(nullable SMBMappedDataCollection<SMBBeamEntityTileNode*>*)beamEntityTileNode_mappedDataCollection_generate
{
	SMBBeamEntityTileNode* const beamEntityTileNode_initial = self.beamEntityTileNode_initial;
	kRUConditionalReturn_ReturnValueNil(beamEntityTileNode_initial == nil, YES);

	SMBMutableMappedDataCollection<SMBBeamEntityTileNode*>* const beamEntityTileNode_mappedDataCollection = [SMBMutableMappedDataCollection<SMBBeamEntityTileNode*> new];

	for (SMBBeamEntityTileNode* beamEntityTileNode = beamEntityTileNode_initial;
		 beamEntityTileNode != nil;
		 beamEntityTileNode = beamEntityTileNode.node_next)
	{
		[beamEntityTileNode_mappedDataCollection mappableObject_add:beamEntityTileNode];
	}

	return [beamEntityTileNode_mappedDataCollection copy];
}

#pragma mark - KVO
-(void)observeValueForKeyPath:(nullable NSString*)keyPath ofObject:(nullable id)object change:(nullable NSDictionary*)change context:(nullable void*)context
{
	if (context == kSMBBeamEntity__KVOContext)
	{
		if ([self.beamEntityTileNode_mappedDataCollection mappableObject_exists:object])
		{
			if ([keyPath isEqualToString:[SMBBeamEntityTileNode_PropertiesForKVO node_next]])
			{
				[self beamEntityTileNode_mappedDataCollection_update];
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

#pragma mark - SMBGameBoardGeneralEntity: draw
-(void)draw_in_gameBoardView:(nonnull SMBGameBoardView*)gameBoardView
						rect:(CGRect)rect
{
	[super draw_in_gameBoardView:gameBoardView
							rect:rect];

	CGContextRef const context = UIGraphicsGetCurrentContext();

	CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
	CGContextSetLineWidth(context, 1.0f);

	[[self.beamEntityTileNode_mappedDataCollection mappableObjects] enumerateObjectsUsingBlock:^(SMBBeamEntityTileNode * _Nonnull beamEntityTileNode, NSUInteger idx, BOOL * _Nonnull stop) {
		SMBGameBoardTilePosition* const gameBoardTilePosition = beamEntityTileNode.gameBoardTile.gameBoardTilePosition;
		if (beamEntityTileNode.node_previous != nil)
		{
			[self draw_gameBoardTilePosition:gameBoardTilePosition
							in_gameBoardView:gameBoardView
										rect:rect
							 beamOrientation:beamEntityTileNode.beamEnterOrientation];
		}

		[self draw_gameBoardTilePosition:gameBoardTilePosition
						in_gameBoardView:gameBoardView
									rect:rect
						 beamOrientation:beamEntityTileNode.beamExitOrientation];
	}];

	CGContextStrokePath(context);
}

#pragma mark - draw
-(void)draw_gameBoardTilePosition:(nonnull SMBGameBoardTilePosition*)gameBoardTilePosition
				 in_gameBoardView:(nonnull SMBGameBoardView*)gameBoardView
							 rect:(CGRect)rect
				  beamOrientation:(SMBBeamEntityTileNode__beamOrientation)beamOrientation
{
	kRUConditionalReturn(gameBoardTilePosition == nil, YES);
	kRUConditionalReturn(gameBoardView == nil, YES);
	kRUConditionalReturn(SMBBeamEntityTileNode__beamOrientation__isInRange(beamOrientation) == false, YES);

	CGContextRef const context = UIGraphicsGetCurrentContext();

	CGRect const gameBoardTilePosition_frame = [gameBoardView gameBoardTilePosition_frame:gameBoardTilePosition];

	CGRect const gameBoardTilePosition_frame_local = (CGRect){
		.origin.x	= CGRectGetMinX(rect) + CGRectGetMinX(gameBoardTilePosition_frame),
		.origin.y	= CGRectGetMinY(rect) + CGRectGetMinY(gameBoardTilePosition_frame),
		.size		= gameBoardTilePosition_frame.size,
	};

	CGPoint const point_center = [self draw_point_center_with_gameBoardTilePosition_frame_local:gameBoardTilePosition_frame_local];
	CGPoint const point_edge = [self draw_point_edgeMiddle_with_gameBoardTilePosition_frame_local:gameBoardTilePosition_frame_local beamOrientation:beamOrientation];

	CGContextMoveToPoint(context, point_center.x, point_center.y);
	CGContextAddLineToPoint(context, point_edge.x, point_edge.y);
}

-(CGPoint)draw_point_center_with_gameBoardTilePosition_frame_local:(CGRect)gameBoardTilePosition_frame_local
{
	return (CGPoint){
		.x	= CGRectGetMidX(gameBoardTilePosition_frame_local),
		.y	= CGRectGetMidY(gameBoardTilePosition_frame_local),
	};
}

-(CGPoint)draw_point_edgeMiddle_with_gameBoardTilePosition_frame_local:(CGRect)gameBoardTilePosition_frame_local
													   beamOrientation:(SMBBeamEntityTileNode__beamOrientation)beamOrientation
{
	return (CGPoint){
		.x	= [self draw_point_edgeMiddle_xCoord_with_gameBoardTilePosition_frame_local:gameBoardTilePosition_frame_local beamOrientation:beamOrientation],
		.y	= [self draw_point_edgeMiddle_yCoord_with_gameBoardTilePosition_frame_local:gameBoardTilePosition_frame_local beamOrientation:beamOrientation],
	};
}

-(CGFloat)draw_point_edgeMiddle_xCoord_with_gameBoardTilePosition_frame_local:(CGRect)gameBoardTilePosition_frame_local
															  beamOrientation:(SMBBeamEntityTileNode__beamOrientation)beamOrientation
{
	switch (beamOrientation)
	{
		case SMBBeamEntityTileNode__beamOrientation_none:
			break;

		case SMBBeamEntityTileNode__beamOrientation_up:
		case SMBBeamEntityTileNode__beamOrientation_down:
			return CGRectGetMidX(gameBoardTilePosition_frame_local);
			break;

		case SMBBeamEntityTileNode__beamOrientation_right:
			return CGRectGetMaxX(gameBoardTilePosition_frame_local);
			break;

		case SMBBeamEntityTileNode__beamOrientation_left:
			return CGRectGetMinX(gameBoardTilePosition_frame_local);
			break;
	}

	NSAssert(false, @"unhandled beamOrientation %li",(long)beamOrientation);
	return 0.0f;
}

-(CGFloat)draw_point_edgeMiddle_yCoord_with_gameBoardTilePosition_frame_local:(CGRect)gameBoardTilePosition_frame_local
															  beamOrientation:(SMBBeamEntityTileNode__beamOrientation)beamOrientation
{
	switch (beamOrientation)
	{
		case SMBBeamEntityTileNode__beamOrientation_none:
			break;

		case SMBBeamEntityTileNode__beamOrientation_up:
			return CGRectGetMinY(gameBoardTilePosition_frame_local);
			break;

		case SMBBeamEntityTileNode__beamOrientation_right:
		case SMBBeamEntityTileNode__beamOrientation_left:
			return CGRectGetMidY(gameBoardTilePosition_frame_local);
			break;

		case SMBBeamEntityTileNode__beamOrientation_down:
			return CGRectGetMaxY(gameBoardTilePosition_frame_local);
			break;
	}

	NSAssert(false, @"unhandled beamOrientation %li",(long)beamOrientation);
	return 0.0f;
}

@end
