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
		[[SMBBeamEntityTileNode alloc] init_with_beamEntity:self
											  node_previous:nil];
		[gameBoardTile gameBoardTileEntities_add:self.beamEntityTileNode_initial];
		[self.beamEntityTileNode_initial setState_ready];

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
	kRUConditionalReturn(gameBoardTile == nil, YES);

	[gameBoardTile gameBoardTileEntities_remove:beamEntityTileNode_initial];
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

#pragma mark - beamEntityTileNodes
-(BOOL)beamEntityTileNode_contains:(nonnull SMBBeamEntityTileNode*)beamEntityTileNode
{
	kRUConditionalReturn_ReturnValueFalse(beamEntityTileNode == nil, YES);

	kRUConditionalReturn_ReturnValueTrue(beamEntityTileNode == self.beamEntityTileNode_initial, NO);
	kRUConditionalReturn_ReturnValueTrue([self.beamEntityTileNode_mappedDataCollection mappableObject_exists:beamEntityTileNode], NO);

	return NO;
}

@end





@implementation SMBBeamEntity_PropertiesForKVO

+(nonnull NSString*)beamEntityTileNode_mappedDataCollection{return NSStringFromSelector(_cmd);}

@end
