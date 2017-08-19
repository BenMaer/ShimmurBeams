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
#import "SMBGameBoardTilePosition.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





static void* kSMBBeamEntity__KVOContext = &kSMBBeamEntity__KVOContext;





typedef NS_ENUM(NSInteger, SMBBeamEntity__drawingPiece) {
	SMBBeamEntity__drawingPiece_enter,
	SMBBeamEntity__drawingPiece_leave,

	SMBBeamEntity__drawingPiece__first	= SMBBeamEntity__drawingPiece_enter,
	SMBBeamEntity__drawingPiece__last	= SMBBeamEntity__drawingPiece_leave,
};





@interface SMBBeamEntity ()

#pragma mark - beamEntityTileNode_initial
-(void)beamEntityTileNode_initial_removeFromTile;

#pragma mark - beamEntityTileNode_mappedDataCollection
@property (nonatomic, copy, nullable) SMBMappedDataCollection<SMBBeamEntityTileNode*>* beamEntityTileNode_mappedDataCollection;
-(void)beamEntityTileNode_mappedDataCollection_setKVORegistered:(BOOL)registered;
-(void)beamEntityTileNode:(nonnull SMBBeamEntityTileNode*)beamEntityTileNode
		 setKVORegistered:(BOOL)registered;
-(void)beamEntityTileNode_mappedDataCollection_update;
-(nullable SMBMappedDataCollection<SMBBeamEntityTileNode*>*)beamEntityTileNode_mappedDataCollection_generate;
@property (nonatomic, assign) BOOL beamEntityTileNode_mappedDataCollection_node_next_needsUpdate;
@property (nonatomic, assign) BOOL beamEntityTileNode_mappedDataCollection_node_next_isUpdating;
-(void)beamEntityTileNode_mappedDataCollection_node_next_update_if_needed;

@end





@implementation SMBBeamEntity

#pragma mark - NSObject
-(void)dealloc
{
	[self beamEntityTileNode_initial_removeFromTile];
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
		[[SMBBeamEntityTileNode alloc] init_with_beamEntity:self
										 beamEnterDirection:SMBGameBoardTile__direction_none];
		[gameBoardTile gameBoardTileEntities_many_add:self.beamEntityTileNode_initial];

		[self beamEntityTileNode_mappedDataCollection_update];
	}

	return self;
}

#pragma mark - beamEntityTileNode_initial
-(void)beamEntityTileNode_initial_removeFromTile
{
	SMBBeamEntityTileNode* const beamEntityTileNode_initial = self.beamEntityTileNode_initial;
	kRUConditionalReturn(beamEntityTileNode_initial == nil, YES);

	SMBGameBoardTile* const gameBoardTile = beamEntityTileNode_initial.gameBoardTile;
	kRUConditionalReturn(gameBoardTile == nil, NO);

	[gameBoardTile gameBoardTileEntities_many_remove:beamEntityTileNode_initial];
}

#pragma mark - beamEntityTileNode_mappedDataCollection
-(void)setBeamEntityTileNode_mappedDataCollection:(nullable SMBMappedDataCollection<SMBBeamEntityTileNode*>*)beamEntityTileNode_mappedDataCollection
{
	kRUConditionalReturn((self.beamEntityTileNode_mappedDataCollection == beamEntityTileNode_mappedDataCollection)
						 ||
						 [self.beamEntityTileNode_mappedDataCollection isEqual_to_mappedDataCollection:beamEntityTileNode_mappedDataCollection], NO);

	[self beamEntityTileNode_mappedDataCollection_setKVORegistered:NO];

	SMBMappedDataCollection<SMBBeamEntityTileNode*>* const beamEntityTileNode_mappedDataCollection_old = self.beamEntityTileNode_mappedDataCollection;
	_beamEntityTileNode_mappedDataCollection = beamEntityTileNode_mappedDataCollection;

	[self beamEntityTileNode_mappedDataCollection_setKVORegistered:YES];

	NSArray<SMBBeamEntityTileNode*>* beamEntityTileNode_mappedDataCollection_removedObjects = nil;
	NSArray<SMBBeamEntityTileNode*>* beamEntityTileNode_mappedDataCollection_newObjects = nil;
	[SMBMappedDataCollection<SMBBeamEntityTileNode*> changes_from_mappedDataCollection:beamEntityTileNode_mappedDataCollection_old
															   to_mappedDataCollection:self.beamEntityTileNode_mappedDataCollection
																		removedObjects:&beamEntityTileNode_mappedDataCollection_removedObjects
																			newObjects:&beamEntityTileNode_mappedDataCollection_newObjects];

	[beamEntityTileNode_mappedDataCollection_removedObjects enumerateObjectsUsingBlock:^(SMBBeamEntityTileNode * _Nonnull beamEntityTileNode, NSUInteger idx, BOOL * _Nonnull stop) {

		[beamEntityTileNode setState_finished];

	}];

	[beamEntityTileNode_mappedDataCollection_newObjects enumerateObjectsUsingBlock:^(SMBBeamEntityTileNode * _Nonnull beamEntityTileNode, NSUInteger idx, BOOL * _Nonnull stop) {

		[beamEntityTileNode setState_ready];

	}];
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
	[propertiesToObserve addObject:[SMBBeamEntityTileNode_PropertiesForKVO node_next_gameTilePosition]];

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

-(nullable NSArray<SMBBeamEntityTileNode*>*)beamEntityTileNodes_contained_at_position:(nonnull SMBGameBoardTilePosition*)gameBoardTilePosition
{
	kRUConditionalReturn_ReturnValueNil(gameBoardTilePosition == nil, YES);

	NSMutableArray<SMBBeamEntityTileNode*>* const beamEntityTileNodes_contained = [NSMutableArray<SMBBeamEntityTileNode*> array];

	[[self.beamEntityTileNode_mappedDataCollection mappableObjects] enumerateObjectsUsingBlock:^(SMBBeamEntityTileNode<SMBMappedDataCollection_MappableObject>*  _Nonnull beamEntityTileNode, NSUInteger idx, BOOL * _Nonnull stop) {
		SMBGameBoardTile* const gameBoardTile = beamEntityTileNode.gameBoardTile;
		kRUConditionalReturn(gameBoardTile == nil, YES);

		if ([gameBoardTilePosition isEqual_to_gameBoardTilePosition:gameBoardTile.gameBoardTilePosition])
		{
			[beamEntityTileNodes_contained addObject:beamEntityTileNode];
		}
	}];

	return [NSArray<SMBBeamEntityTileNode*> arrayWithArray:beamEntityTileNodes_contained];
}

-(nullable NSArray<SMBBeamEntityTileNode*>*)beamEntityTileNodes_contained_at_position:(nonnull SMBGameBoardTilePosition*)gameBoardTilePosition
															   with_beamExitDirection:(SMBGameBoardTile__direction)direction
{
	NSArray<SMBBeamEntityTileNode*>* const beamEntityTileNodes_at_position = [self beamEntityTileNodes_contained_at_position:gameBoardTilePosition];
	kRUConditionalReturn_ReturnValueNil((beamEntityTileNodes_at_position == nil)
										||
										(beamEntityTileNodes_at_position.count == 0), NO);

	NSMutableArray<SMBBeamEntityTileNode*>* const beamEntityTileNodes_contained = [NSMutableArray<SMBBeamEntityTileNode*> array];

	[beamEntityTileNodes_at_position enumerateObjectsUsingBlock:^(SMBBeamEntityTileNode * _Nonnull beamEntityTileNode_at_position, NSUInteger idx, BOOL * _Nonnull stop) {
		if (beamEntityTileNode_at_position.beamExitDirection == direction)
		{
			[beamEntityTileNodes_contained addObject:beamEntityTileNode_at_position];
		}
	}];


	return [NSArray<SMBBeamEntityTileNode*> arrayWithArray:beamEntityTileNodes_contained];
}

-(void)setBeamEntityTileNode_mappedDataCollection_node_next_needsUpdate:(BOOL)beamEntityTileNode_mappedDataCollection_node_next_needsUpdate
{
	kRUConditionalReturn(self.beamEntityTileNode_mappedDataCollection_node_next_needsUpdate == beamEntityTileNode_mappedDataCollection_node_next_needsUpdate, NO);

	_beamEntityTileNode_mappedDataCollection_node_next_needsUpdate = beamEntityTileNode_mappedDataCollection_node_next_needsUpdate;

	if ((self.beamEntityTileNode_mappedDataCollection_node_next_needsUpdate == true)
		&&
		(self.beamEntityTileNode_mappedDataCollection_node_next_isUpdating == false))
	{
		[self beamEntityTileNode_mappedDataCollection_node_next_update_if_needed];
	}
}

-(void)setBeamEntityTileNode_mappedDataCollection_node_next_isUpdating:(BOOL)beamEntityTileNode_mappedDataCollection_node_next_isUpdating
{
	kRUConditionalReturn(self.beamEntityTileNode_mappedDataCollection_node_next_isUpdating == beamEntityTileNode_mappedDataCollection_node_next_isUpdating, NO);

	_beamEntityTileNode_mappedDataCollection_node_next_isUpdating = beamEntityTileNode_mappedDataCollection_node_next_isUpdating;

	if ((self.beamEntityTileNode_mappedDataCollection_node_next_isUpdating == false)
		&&
		(self.beamEntityTileNode_mappedDataCollection_node_next_needsUpdate == true))
	{
		[self beamEntityTileNode_mappedDataCollection_node_next_update_if_needed];
	}
}

-(void)beamEntityTileNode_mappedDataCollection_node_next_update_if_needed
{
	kRUConditionalReturn(self.beamEntityTileNode_mappedDataCollection_node_next_needsUpdate == false, YES);
	kRUConditionalReturn(self.beamEntityTileNode_mappedDataCollection_node_next_isUpdating == YES, NO);

	[self setBeamEntityTileNode_mappedDataCollection_node_next_isUpdating:YES];
	[self setBeamEntityTileNode_mappedDataCollection_node_next_needsUpdate:NO];

	SMBBeamEntityTileNode* const beamEntityTileNode_initial = self.beamEntityTileNode_initial;
	kRUConditionalReturn(beamEntityTileNode_initial == nil, YES);

	for (SMBBeamEntityTileNode* beamEntityTileNode = beamEntityTileNode_initial;
		 beamEntityTileNode != nil;
		 beamEntityTileNode = beamEntityTileNode.node_next)
	{
		if (self.beamEntityTileNode_mappedDataCollection_node_next_needsUpdate)
		{
			break;
		}

		[beamEntityTileNode node_next_update_if_needed];
	}

	[self setBeamEntityTileNode_mappedDataCollection_node_next_isUpdating:NO];
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
			else if ([keyPath isEqualToString:[SMBBeamEntityTileNode_PropertiesForKVO node_next_gameTilePosition]])
			{
				[self setBeamEntityTileNode_mappedDataCollection_node_next_needsUpdate:YES];
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

#pragma mark - beamEntityTileNodes
-(BOOL)beamEntityTileNodes_contains:(nonnull SMBBeamEntityTileNode*)beamEntityTileNode
{
	kRUConditionalReturn_ReturnValueFalse(beamEntityTileNode == nil, YES);

	kRUConditionalReturn_ReturnValueTrue([self.beamEntityTileNode_mappedDataCollection mappableObject_exists:beamEntityTileNode], NO);

	return NO;
}

@end





@implementation SMBBeamEntity_PropertiesForKVO

+(nonnull NSString*)beamEntityTileNode_mappedDataCollection{return NSStringFromSelector(_cmd);}

@end
