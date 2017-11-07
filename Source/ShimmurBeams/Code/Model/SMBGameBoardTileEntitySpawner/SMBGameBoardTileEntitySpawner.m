//
//  SMBGameBoardTileEntitySpawner.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 11/6/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardTileEntitySpawner.h"
#import "SMBMutableMappedDataCollection.h"
#import "SMBGameBoardTileEntity.h"
#import "SMBGameBoardTile.h"
#import "SMBWeakPointerObject.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/NSMutableArray+RUAddObjectIfNotNil.h>
#import <ResplendentUtilities/RUConstants.h>
#import <ResplendentUtilities/RUClassOrNilUtil.h>





static void* SMBGameBoardTileEntitySpawner__KVOContext_gameBoardTileEntities_spawned = &SMBGameBoardTileEntitySpawner__KVOContext_gameBoardTileEntities_spawned;

typedef NS_ENUM(NSInteger, SMBGameBoardTileEntitySpawner__spawnNewEntityState) {
	SMBGameBoardTileEntitySpawner__spawnNewEntityState_ready,
	SMBGameBoardTileEntitySpawner__spawnNewEntityState_atCapacity,

	SMBGameBoardTileEntitySpawner__spawnNewEntityState__first	= SMBGameBoardTileEntitySpawner__spawnNewEntityState_ready,
	SMBGameBoardTileEntitySpawner__spawnNewEntityState__last	= SMBGameBoardTileEntitySpawner__spawnNewEntityState_atCapacity,
};





@interface SMBGameBoardTileEntitySpawner ()

#pragma mark - spawnNewEntityState
@property (nonatomic, assign) SMBGameBoardTileEntitySpawner__spawnNewEntityState spawnNewEntityState;
-(void)spawnNewEntityState_update;
-(SMBGameBoardTileEntitySpawner__spawnNewEntityState)spawnNewEntityState_appropriate;

#pragma mark - gameBoardTileEntities
-(nullable SMBGameBoardTileEntity*)gameBoardTileEntity_spawnNew_withStateHandling_on_gameBoardTile:(nullable SMBGameBoardTile*)gameBoardTile
																							 track:(BOOL)track;
-(nullable SMBGameBoardTileEntity*)gameBoardTileEntity_spawnNew_tracked_on_gameBoardTile:(nullable SMBGameBoardTile*)gameBoardTile
																				   track:(BOOL)track;

#pragma mark - gameBoardTileEntities_spawned_mappedDataCollection
@property (nonatomic, readonly, strong, nonnull) SMBMutableMappedDataCollection<SMBGameBoardTileEntity*>* gameBoardTileEntities_spawned_mappedDataCollection;
-(void)gameBoardTileEntities_spawned_mappedDataCollection_add:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity;
-(void)gameBoardTileEntities_spawned_mappedDataCollection_remove:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity;

#pragma mark - gameBoardTileEntities_spawned
@property (nonatomic, copy, nullable) NSArray<SMBGameBoardTileEntity*>* gameBoardTileEntities_spawned;
-(void)SMBGameBoardTileEntitySpawner_gameBoardTileEntities_spawned_setKVORegistered:(BOOL)registered;
-(void)SMBGameBoardTileEntitySpawner_gameBoardTileEntity:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
										setKVORegistered:(BOOL)registered;
-(void)gameBoardTileEntities_spawned_update;
-(void)gameBoardTileEntities_spawned_remove_attempt:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity;

/**
 Attempts to remove the oldest game board tile entity.

 @return Returns YES if an entity was remove, otherwise returns NO.
 */
-(BOOL)gameBoardTileEntities_spawned_removeOldest;

#pragma mark - spawnEntityBlock
@property (nonatomic, copy, nullable) SMBGameBoardTileEntitySpawner_spawnEntityBlock spawnEntityBlock;

@end





@implementation SMBGameBoardTileEntitySpawner

#pragma mark - NSObject
-(void)dealloc
{
	[self SMBGameBoardTileEntitySpawner_gameBoardTileEntities_spawned_setKVORegistered:NO];
}

-(instancetype)init
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);

#if __has_feature(nullability)
#pragma clang diagnostic push
#pragma GCC diagnostic ignored "-Wnullability-completeness"
#endif
	return [self init_with_gameBoardTileEntities_maximum:0
										spawnEntityBlock:nil];
#if __has_feature(nullability)
#pragma clang diagnostic pop
#endif
}

-(nonnull NSString*)description
{
	NSMutableArray<NSString*>* const description_lines = [NSMutableArray<NSString*> array];
	[description_lines ru_addObjectIfNotNil:[super description]];
	[description_lines ru_addObjectIfNotNil:RUStringWithFormat(@"gameBoardTileEntities_maximum: %lu",(unsigned long)self.gameBoardTileEntities_maximum)];

	return [description_lines componentsJoinedByString:@"\n"];
}

#pragma mark - init
-(nullable instancetype)init_with_gameBoardTileEntities_maximum:(NSUInteger)gameBoardTileEntities_maximum
											   spawnEntityBlock:(nonnull SMBGameBoardTileEntitySpawner_spawnEntityBlock)spawnEntityBlock
{
	kRUConditionalReturn_ReturnValueNil(spawnEntityBlock == nil, YES);

	if (self = [super init])
	{
		_gameBoardTileEntities_maximum = gameBoardTileEntities_maximum;
		[self setSpawnEntityBlock:spawnEntityBlock];
	}

	return self;
}

#pragma mark - spawnNewEntityState
-(void)spawnNewEntityState_update
{
	[self setSpawnNewEntityState:[self spawnNewEntityState_appropriate]];
}

-(SMBGameBoardTileEntitySpawner__spawnNewEntityState)spawnNewEntityState_appropriate
{
	if ([self gameBoardTileEntities_spawned_atCapacity])
	{
		return SMBGameBoardTileEntitySpawner__spawnNewEntityState_atCapacity;
	}

	return SMBGameBoardTileEntitySpawner__spawnNewEntityState_ready;
}

#pragma mark - gameBoardTileEntities
-(nullable SMBGameBoardTileEntity*)gameBoardTileEntity_spawnNew_tracked_on_gameBoardTile:(nonnull SMBGameBoardTile*)gameBoardTile
{
	kRUConditionalReturn_ReturnValueNil(gameBoardTile == nil, YES);
	
	return [self gameBoardTileEntity_spawnNew_withStateHandling_on_gameBoardTile:gameBoardTile track:YES];
}

-(nullable SMBGameBoardTileEntity*)gameBoardTileEntity_spawnNew_untracked
{
	return [self gameBoardTileEntity_spawnNew_withStateHandling_on_gameBoardTile:nil track:NO];
}

-(nullable SMBGameBoardTileEntity*)gameBoardTileEntity_spawnNew_withStateHandling_on_gameBoardTile:(nullable SMBGameBoardTile*)gameBoardTile
																							 track:(BOOL)track
{
	if (track)
	{
		SMBGameBoardTileEntitySpawner__spawnNewEntityState const spawnNewEntityState = self.spawnNewEntityState;
		switch (spawnNewEntityState)
		{
			case SMBGameBoardTileEntitySpawner__spawnNewEntityState_atCapacity:
			{
				kRUConditionalReturn_ReturnValueNil([self gameBoardTileEntities_spawned_removeOldest] == false, YES);
				kRUConditionalReturn_ReturnValueNil(self.spawnNewEntityState != SMBGameBoardTileEntitySpawner__spawnNewEntityState_ready, YES);
				
				return [self gameBoardTileEntity_spawnNew_withStateHandling_on_gameBoardTile:gameBoardTile track:YES];
			}
				break;
				
			case SMBGameBoardTileEntitySpawner__spawnNewEntityState_ready:
				break;
		}
	}
	
	return [self gameBoardTileEntity_spawnNew_tracked_on_gameBoardTile:gameBoardTile
																 track:track];
}

-(nullable SMBGameBoardTileEntity*)gameBoardTileEntity_spawnNew_tracked_on_gameBoardTile:(nullable SMBGameBoardTile*)gameBoardTile
																				   track:(BOOL)track
{
	kRUConditionalReturn_ReturnValueNil((track == YES)
										&&
										(
										 (gameBoardTile == nil)
										 ||
										 ([self spawnNewEntityState] != SMBGameBoardTileEntitySpawner__spawnNewEntityState_ready)
										 )
										, YES);
	
	SMBGameBoardTileEntitySpawner_spawnEntityBlock const spawnEntityBlock = self.spawnEntityBlock;
	kRUConditionalReturn_ReturnValueNil(spawnEntityBlock == nil, YES);
	
	SMBGameBoardTileEntity* const gameBoardTileEntity = spawnEntityBlock();
	kRUConditionalReturn_ReturnValueNil(gameBoardTileEntity == nil, YES);
	
	if (track)
	{
		[gameBoardTile gameBoardTileEntities_add:gameBoardTileEntity
									  entityType:SMBGameBoardTile__entityType_beamInteractions];
		
		[self gameBoardTileEntities_spawned_mappedDataCollection_add:gameBoardTileEntity];
	}
	
	
	return gameBoardTileEntity;
}

#pragma mark - gameBoardTileEntities_spawned_mappedDataCollection
@synthesize gameBoardTileEntities_spawned_mappedDataCollection = _gameBoardTileEntities_spawned_mappedDataCollection;
-(nonnull SMBMutableMappedDataCollection<SMBGameBoardTileEntity*>*)gameBoardTileEntities_spawned_mappedDataCollection
{
	if (_gameBoardTileEntities_spawned_mappedDataCollection == nil)
	{
		_gameBoardTileEntities_spawned_mappedDataCollection = [SMBMutableMappedDataCollection<SMBGameBoardTileEntity*> new];
	}

	return _gameBoardTileEntities_spawned_mappedDataCollection;
}

-(void)gameBoardTileEntities_spawned_mappedDataCollection_add:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
{
	kRUConditionalReturn(gameBoardTileEntity == nil, YES);

	/* Should already be added to a game board tile at this point. */
	kRUConditionalReturn(gameBoardTileEntity.gameBoardTile == nil, YES);

	[self.gameBoardTileEntities_spawned_mappedDataCollection mappableObject_add:gameBoardTileEntity];

	[self gameBoardTileEntities_spawned_update];
}

-(void)gameBoardTileEntities_spawned_mappedDataCollection_remove:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
{
	kRUConditionalReturn(gameBoardTileEntity == nil, YES);

	/* Should already be removed from the game board tile at this point. */
	kRUConditionalReturn(gameBoardTileEntity.gameBoardTile != nil, YES);

	[self.gameBoardTileEntities_spawned_mappedDataCollection mappableObject_remove:gameBoardTileEntity];

	[self gameBoardTileEntities_spawned_update];
}

#pragma mark - gameBoardTileEntities_spawned
-(void)setGameBoardTileEntities_spawned:(nullable NSArray<SMBGameBoardTileEntity*>*)gameBoardTileEntities_spawned
{
	kRUConditionalReturn((self.gameBoardTileEntities_spawned == gameBoardTileEntities_spawned)
						 ||
						 [self.gameBoardTileEntities_spawned isEqual:gameBoardTileEntities_spawned],
						 NO);

	[self SMBGameBoardTileEntitySpawner_gameBoardTileEntities_spawned_setKVORegistered:NO];

	_gameBoardTileEntities_spawned = (gameBoardTileEntities_spawned ? [NSArray<SMBGameBoardTileEntity*> arrayWithArray:gameBoardTileEntities_spawned] : nil);

	[self SMBGameBoardTileEntitySpawner_gameBoardTileEntities_spawned_setKVORegistered:YES];

	[self spawnNewEntityState_update];
}

-(void)SMBGameBoardTileEntitySpawner_gameBoardTileEntities_spawned_setKVORegistered:(BOOL)registered
{
	[self.gameBoardTileEntities_spawned enumerateObjectsUsingBlock:^(SMBGameBoardTileEntity * _Nonnull gameBoardTileEntity, NSUInteger idx, BOOL * _Nonnull stop) {
		[self SMBGameBoardTileEntitySpawner_gameBoardTileEntity:gameBoardTileEntity
											   setKVORegistered:registered];
	}];
}

-(void)SMBGameBoardTileEntitySpawner_gameBoardTileEntity:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
										setKVORegistered:(BOOL)registered
{
	kRUConditionalReturn(gameBoardTileEntity == nil, YES);

	NSMutableDictionary<NSNumber*,NSMutableArray<NSString*>*>* const KVOOptions_to_propertiesToObserve_mapping = [NSMutableDictionary<NSNumber*,NSMutableArray<NSString*>*> dictionary];

	NSMutableArray<NSString*>* const propertiesToObserve = [NSMutableArray<NSString*> array];
	[propertiesToObserve addObject:[SMBGameBoardTileEntity_PropertiesForKVO gameBoardTile]];
	[KVOOptions_to_propertiesToObserve_mapping setObject:propertiesToObserve forKey:@(0)];

	[KVOOptions_to_propertiesToObserve_mapping enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull KVOOptions_number, NSMutableArray<NSString *> * _Nonnull propertiesToObserve, BOOL * _Nonnull stop) {
		[propertiesToObserve enumerateObjectsUsingBlock:^(NSString * _Nonnull propertyToObserve, NSUInteger idx, BOOL * _Nonnull stop) {
			if (registered)
			{
				[gameBoardTileEntity addObserver:self
									  forKeyPath:propertyToObserve
										 options:(KVOOptions_number.unsignedIntegerValue)
										 context:&SMBGameBoardTileEntitySpawner__KVOContext_gameBoardTileEntities_spawned];
			}
			else
			{
				[gameBoardTileEntity removeObserver:self
										 forKeyPath:propertyToObserve
											context:&SMBGameBoardTileEntitySpawner__KVOContext_gameBoardTileEntities_spawned];
			}
		}];
	}];
}

-(void)gameBoardTileEntities_spawned_update
{
	[self setGameBoardTileEntities_spawned:[self.gameBoardTileEntities_spawned_mappedDataCollection mappableObjects]];
}

-(void)gameBoardTileEntities_spawned_remove_attempt:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
{
	kRUConditionalReturn(gameBoardTileEntity == nil, YES);

	kRUConditionalReturn(gameBoardTileEntity.gameBoardTile != nil, YES);

	/*
	 We are using (gameBoardTileEntity.gameBoardTile == nil) to determine if the entity should be removed. But, since when an entity is moved from one tile to another, it's `gameBoardTile` is set to nil then not nil, we can't just discard it the moment `gameBoardTile` becomes nil. Instead, we will let the thread finishing the current code, before we attempt our final check to remove the entity from this spawner.
	 */
	__weak typeof(self) const self_weak = self;

	dispatch_async(dispatch_get_main_queue(), ^{
		kRUConditionalReturn(gameBoardTileEntity.gameBoardTile != nil, NO);
		kRUConditionalReturn([self_weak.gameBoardTileEntities_spawned_mappedDataCollection mappableObject_exists:gameBoardTileEntity], NO);

		[self_weak gameBoardTileEntities_spawned_mappedDataCollection_remove:gameBoardTileEntity];
	});
}

-(BOOL)gameBoardTileEntities_spawned_removeOldest
{
	NSArray<SMBGameBoardTileEntity*>* const gameBoardTileEntities_spawned = self.gameBoardTileEntities_spawned;
	kRUConditionalReturn_ReturnValueFalse(gameBoardTileEntities_spawned == nil, YES);

	SMBGameBoardTileEntity* const gameBoardTileEntity = [gameBoardTileEntities_spawned firstObject];
	kRUConditionalReturn_ReturnValueFalse(gameBoardTileEntity == nil, YES);

	SMBGameBoardTile* const gameBoardTile = gameBoardTileEntity.gameBoardTile;
	kRUConditionalReturn_ReturnValueFalse(gameBoardTile == nil, YES);

	[gameBoardTile gameBoardTileEntities_remove:gameBoardTileEntity
									 entityType:SMBGameBoardTile__entityType_beamInteractions];

	return YES;
}

-(BOOL)gameBoardTileEntities_spawned_atCapacity
{
	NSUInteger const gameBoardTileEntities_maximum = self.gameBoardTileEntities_maximum;
	kRUConditionalReturn_ReturnValueTrue(gameBoardTileEntities_maximum <= 0, NO);
	
	NSArray<SMBGameBoardTileEntity*>* const gameBoardTileEntities_spawned = [self gameBoardTileEntities_spawned];
	NSUInteger const gameBoardTileEntities_spawned_count = (gameBoardTileEntities_spawned ? gameBoardTileEntities_spawned.count : 0);
	kRUConditionalReturn_ReturnValueFalse(gameBoardTileEntities_spawned_count > gameBoardTileEntities_maximum, YES);
	
	return
	(
	 gameBoardTileEntities_spawned_count
	 >=
	 gameBoardTileEntities_maximum
	 );
}

#pragma mark - KVO
-(void)observeValueForKeyPath:(nullable NSString*)keyPath ofObject:(nullable id)object change:(nullable NSDictionary*)change context:(nullable void*)context
{
	if (context == SMBGameBoardTileEntitySpawner__KVOContext_gameBoardTileEntities_spawned)
	{
		if ([self.gameBoardTileEntities_spawned containsObject:object])
		{
			if ([keyPath isEqualToString:[SMBGameBoardTileEntity_PropertiesForKVO gameBoardTile]])
			{
				[self gameBoardTileEntities_spawned_remove_attempt:kRUClassOrNil(object, SMBGameBoardTileEntity)];
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

@end





@implementation SMBGameBoardTileEntitySpawner_PropertiesForKVO

+(nonnull NSString*)gameBoardTileEntities_spawned{return NSStringFromSelector(_cmd);}

@end

