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
#import "SMBWeakPointerMappableObject.h"
#import "NSObject+SMBGameBoardTileEntityDeallocNotifications.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/NSMutableArray+RUAddObjectIfNotNil.h>
#import <ResplendentUtilities/RUConstants.h>
#import <ResplendentUtilities/RUClassOrNilUtil.h>





static void* SMBGameBoardTileEntitySpawner__KVOContext_spawnedGameBoardTileEntities_tracked = &SMBGameBoardTileEntitySpawner__KVOContext_spawnedGameBoardTileEntities_tracked;
static void* SMBGameBoardTileEntitySpawner__KVOContext_spawnedGameBoardTileEntities_offBoard_tracked = &SMBGameBoardTileEntitySpawner__KVOContext_spawnedGameBoardTileEntities_offBoard_tracked;

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

#pragma mark - spawnedGameBoardTileEntities_tracked_mappedDataCollection
@property (nonatomic, readonly, strong, nonnull) SMBMutableMappedDataCollection<SMBGameBoardTileEntity*>* spawnedGameBoardTileEntities_tracked_mappedDataCollection;
-(void)spawnedGameBoardTileEntities_tracked_mappedDataCollection_add:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity;
-(void)spawnedGameBoardTileEntities_tracked_mappedDataCollection_remove:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity;

#pragma mark - spawnedGameBoardTileEntities_tracked
@property (nonatomic, copy, nullable) NSArray<SMBGameBoardTileEntity*>* spawnedGameBoardTileEntities_tracked;
-(void)spawnedGameBoardTileEntities_tracked_update;

-(void)SMBGameBoardTileEntitySpawner_spawnedGameBoardTileEntities_tracked_setKVORegistered:(BOOL)registered;
-(void)SMBGameBoardTileEntitySpawner_spawnedGameBoardTileEntities_tracked:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
										setKVORegistered:(BOOL)registered;

#pragma mark - spawnedGameBoardTileEntities_offBoard_tracked_mappedDataCollection
/**
 These entities are being held on to because they've been removed from the board, but haven't yet died. We want to give them a chance to be added back to the board before the spawner loses track of them.

 We will track each entity in this collection for two things:
 1) KVO on `gameBoardTile` to know if it was added back to a game board tile. If that happens, we add it back to `spawnedGameBoardTileEntities_tracked_mappedDataCollection`.
 2) Use a dealloc hook to know if this object is going to die. If that happens, we can remove it from this collection.
 */
@property (nonatomic, readonly, strong, nonnull) SMBMutableMappedDataCollection<SMBWeakPointerMappableObject<SMBGameBoardTileEntity*>*>* spawnedGameBoardTileEntities_offBoard_tracked_mappedDataCollection;
-(void)spawnedGameBoardTileEntities_offBoard_tracked_mappedDataCollection_add:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity;
-(void)spawnedGameBoardTileEntities_offBoard_tracked_mappedDataCollection_remove:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity;

/**
 Attempts to remove the oldest game board tile entity.

 @return Returns YES if an entity was remove, otherwise returns NO.
 */
-(BOOL)spawnedGameBoardTileEntities_tracked_removeOldest;

#pragma mark - spawnedGameBoardTileEntities_offBoard_tracked
@property (nonatomic, copy, nullable) NSArray<SMBWeakPointerMappableObject<SMBGameBoardTileEntity*>*>* spawnedGameBoardTileEntities_offBoard_tracked;
-(void)spawnedGameBoardTileEntities_offBoard_tracked_update;

-(void)SMBGameBoardTileEntitySpawner_spawnedGameBoardTileEntities_offBoard_tracked_setKVORegistered:(BOOL)registered;
-(void)SMBGameBoardTileEntitySpawner_spawnedGameBoardTileEntities_offBoard_tracked:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
																  setKVORegistered:(BOOL)registered;

-(void)SMBGameBoardTileEntitySpawner_spawnedGameBoardTileEntities_offBoard_tracked_setRegisteredToNotificationCenter:(BOOL)registered;
-(void)SMBGameBoardTileEntitySpawner_spawnedGameBoardTileEntities_offBoard_tracked:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
												 setRegisteredToNotificationCenter:(BOOL)registered;
-(void)spawnedGameBoardTileEntities_offBoard_tracked_notificationDidFire_didCallDealloc_with_notification:(nonnull NSNotification*)notification;

#pragma mark - spawnEntityBlock
@property (nonatomic, copy, nullable) SMBGameBoardTileEntitySpawner_spawnEntityBlock spawnEntityBlock;

@end





@implementation SMBGameBoardTileEntitySpawner

#pragma mark - NSObject
-(void)dealloc
{
	[self SMBGameBoardTileEntitySpawner_spawnedGameBoardTileEntities_tracked_setKVORegistered:NO];
	[self SMBGameBoardTileEntitySpawner_spawnedGameBoardTileEntities_offBoard_tracked_setKVORegistered:NO];
	[self SMBGameBoardTileEntitySpawner_spawnedGameBoardTileEntities_offBoard_tracked_setRegisteredToNotificationCenter:NO];
}

-(instancetype)init
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);

#if __has_feature(nullability)
#pragma clang diagnostic push
#pragma GCC diagnostic ignored "-Wnullability-completeness"
#endif
	return [self init_with_spawnedGameBoardTileEntities_tracked_maximum:0
													   spawnEntityBlock:nil];
#if __has_feature(nullability)
#pragma clang diagnostic pop
#endif
}

-(nonnull NSString*)description
{
	NSMutableArray<NSString*>* const description_lines = [NSMutableArray<NSString*> array];
	[description_lines ru_addObjectIfNotNil:[super description]];
	[description_lines ru_addObjectIfNotNil:RUStringWithFormat(@"spawnedGameBoardTileEntities_tracked_maximum: %lu",(unsigned long)self.spawnedGameBoardTileEntities_tracked_maximum)];

	return [description_lines componentsJoinedByString:@"\n"];
}

#pragma mark - init
-(nullable instancetype)init_with_spawnedGameBoardTileEntities_tracked_maximum:(NSUInteger)spawnedGameBoardTileEntities_tracked_maximum
															  spawnEntityBlock:(nonnull SMBGameBoardTileEntitySpawner_spawnEntityBlock)spawnEntityBlock
{
	kRUConditionalReturn_ReturnValueNil(spawnEntityBlock == nil, YES);

	if (self = [super init])
	{
		_spawnedGameBoardTileEntities_tracked_maximum = spawnedGameBoardTileEntities_tracked_maximum;
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
	if ([self spawnedGameBoardTileEntities_tracked_atCapacity])
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
				kRUConditionalReturn_ReturnValueNil([self spawnedGameBoardTileEntities_tracked_removeOldest] == false, YES);
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

		[self spawnedGameBoardTileEntities_tracked_mappedDataCollection_add:gameBoardTileEntity];
	}


	return gameBoardTileEntity;
}

#pragma mark - spawnedGameBoardTileEntities_tracked_mappedDataCollection
@synthesize spawnedGameBoardTileEntities_tracked_mappedDataCollection = _spawnedGameBoardTileEntities_tracked_mappedDataCollection;
-(nonnull SMBMutableMappedDataCollection<SMBGameBoardTileEntity*>*)spawnedGameBoardTileEntities_tracked_mappedDataCollection
{
	if (_spawnedGameBoardTileEntities_tracked_mappedDataCollection == nil)
	{
		_spawnedGameBoardTileEntities_tracked_mappedDataCollection = [SMBMutableMappedDataCollection<SMBGameBoardTileEntity*> new];
	}

	return _spawnedGameBoardTileEntities_tracked_mappedDataCollection;
}

-(void)spawnedGameBoardTileEntities_tracked_mappedDataCollection_add:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
{
	kRUConditionalReturn(gameBoardTileEntity == nil, YES);

	/* Should already be added to a game board tile at this point. */
	kRUConditionalReturn(gameBoardTileEntity.gameBoardTile == nil, YES);

	[self.spawnedGameBoardTileEntities_tracked_mappedDataCollection mappableObject_add:gameBoardTileEntity];

	[self spawnedGameBoardTileEntities_tracked_update];
}

-(void)spawnedGameBoardTileEntities_tracked_mappedDataCollection_remove:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
{
	kRUConditionalReturn(gameBoardTileEntity == nil, YES);

	/* Should already be removed from the game board tile at this point. */
	kRUConditionalReturn(gameBoardTileEntity.gameBoardTile != nil, YES);

	[self.spawnedGameBoardTileEntities_tracked_mappedDataCollection mappableObject_remove:gameBoardTileEntity];

	[self spawnedGameBoardTileEntities_tracked_update];

	[self spawnedGameBoardTileEntities_offBoard_tracked_mappedDataCollection_add:gameBoardTileEntity];
}

#pragma mark - spawnedGameBoardTileEntities_tracked
-(void)setSpawnedGameBoardTileEntities_tracked:(nullable NSArray<SMBGameBoardTileEntity*>*)spawnedGameBoardTileEntities_tracked
{
	kRUConditionalReturn((self.spawnedGameBoardTileEntities_tracked == spawnedGameBoardTileEntities_tracked)
						 ||
						 [self.spawnedGameBoardTileEntities_tracked isEqual:spawnedGameBoardTileEntities_tracked],
						 NO);

	[self SMBGameBoardTileEntitySpawner_spawnedGameBoardTileEntities_tracked_setKVORegistered:NO];

	_spawnedGameBoardTileEntities_tracked = (spawnedGameBoardTileEntities_tracked ? [NSArray<SMBGameBoardTileEntity*> arrayWithArray:spawnedGameBoardTileEntities_tracked] : nil);

	[self SMBGameBoardTileEntitySpawner_spawnedGameBoardTileEntities_tracked_setKVORegistered:YES];

	[self spawnNewEntityState_update];
}

-(void)spawnedGameBoardTileEntities_tracked_update
{
	[self setSpawnedGameBoardTileEntities_tracked:[self.spawnedGameBoardTileEntities_tracked_mappedDataCollection mappableObjects]];
}

-(void)SMBGameBoardTileEntitySpawner_spawnedGameBoardTileEntities_tracked_setKVORegistered:(BOOL)registered
{
	[self.spawnedGameBoardTileEntities_tracked enumerateObjectsUsingBlock:^(SMBGameBoardTileEntity * _Nonnull gameBoardTileEntity, NSUInteger idx, BOOL * _Nonnull stop) {
		[self SMBGameBoardTileEntitySpawner_spawnedGameBoardTileEntities_tracked:gameBoardTileEntity
											   setKVORegistered:registered];
	}];
}

-(void)SMBGameBoardTileEntitySpawner_spawnedGameBoardTileEntities_tracked:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
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
										 context:&SMBGameBoardTileEntitySpawner__KVOContext_spawnedGameBoardTileEntities_tracked];
			}
			else
			{
				[gameBoardTileEntity removeObserver:self
										 forKeyPath:propertyToObserve
											context:&SMBGameBoardTileEntitySpawner__KVOContext_spawnedGameBoardTileEntities_tracked];
			}
		}];
	}];
}

-(BOOL)spawnedGameBoardTileEntities_tracked_removeOldest
{
	NSArray<SMBGameBoardTileEntity*>* const spawnedGameBoardTileEntities_tracked = self.spawnedGameBoardTileEntities_tracked;
	kRUConditionalReturn_ReturnValueFalse(spawnedGameBoardTileEntities_tracked == nil, YES);

	SMBGameBoardTileEntity* const gameBoardTileEntity = [spawnedGameBoardTileEntities_tracked firstObject];
	kRUConditionalReturn_ReturnValueFalse(gameBoardTileEntity == nil, YES);

	SMBGameBoardTile* const gameBoardTile = gameBoardTileEntity.gameBoardTile;
	kRUConditionalReturn_ReturnValueFalse(gameBoardTile == nil, YES);

	[gameBoardTile gameBoardTileEntities_remove:gameBoardTileEntity
									 entityType:SMBGameBoardTile__entityType_beamInteractions];

	return YES;
}

-(BOOL)spawnedGameBoardTileEntities_tracked_atCapacity
{
	NSUInteger const spawnedGameBoardTileEntities_tracked_maximum = self.spawnedGameBoardTileEntities_tracked_maximum;
	kRUConditionalReturn_ReturnValueFalse(spawnedGameBoardTileEntities_tracked_maximum <= 0, NO);

	NSArray<SMBGameBoardTileEntity*>* const spawnedGameBoardTileEntities_tracked = [self spawnedGameBoardTileEntities_tracked];
	NSUInteger const spawnedGameBoardTileEntities_tracked_count = (spawnedGameBoardTileEntities_tracked ? spawnedGameBoardTileEntities_tracked.count : 0);
	kRUConditionalReturn_ReturnValueTrue(spawnedGameBoardTileEntities_tracked_count > spawnedGameBoardTileEntities_tracked_maximum, YES);

	return
	(
	 spawnedGameBoardTileEntities_tracked_count
	 >=
	 spawnedGameBoardTileEntities_tracked_maximum
	 );
}

#pragma mark - spawnedGameBoardTileEntities_offBoard_tracked_mappedDataCollection
@synthesize spawnedGameBoardTileEntities_offBoard_tracked_mappedDataCollection = _spawnedGameBoardTileEntities_offBoard_tracked_mappedDataCollection;
-(nonnull SMBMutableMappedDataCollection<SMBWeakPointerMappableObject<SMBGameBoardTileEntity*>*>*)spawnedGameBoardTileEntities_offBoard_tracked_mappedDataCollection
{
	if (_spawnedGameBoardTileEntities_offBoard_tracked_mappedDataCollection == nil)
	{
		_spawnedGameBoardTileEntities_offBoard_tracked_mappedDataCollection = [SMBMutableMappedDataCollection<SMBWeakPointerMappableObject<SMBGameBoardTileEntity*>*> new];
	}

	return _spawnedGameBoardTileEntities_offBoard_tracked_mappedDataCollection;
}

-(void)spawnedGameBoardTileEntities_offBoard_tracked_mappedDataCollection_add:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
{
	kRUConditionalReturn(gameBoardTileEntity == nil, YES);

	/* Should not have a game board tile. */
	kRUConditionalReturn(gameBoardTileEntity.gameBoardTile != nil, YES);

	SMBWeakPointerMappableObject<SMBGameBoardTileEntity*>* const weakPointerMappableObject =
	[[SMBWeakPointerMappableObject<SMBGameBoardTileEntity*> alloc] init_with_object:gameBoardTileEntity
											  deallocBlock:nil];

	kRUConditionalReturn(weakPointerMappableObject == nil, YES);

	[self.spawnedGameBoardTileEntities_offBoard_tracked_mappedDataCollection mappableObject_add:weakPointerMappableObject];

	[self spawnedGameBoardTileEntities_offBoard_tracked_update];
}

-(void)spawnedGameBoardTileEntities_offBoard_tracked_mappedDataCollection_remove:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
{
	kRUConditionalReturn(gameBoardTileEntity == nil, YES);

	SMBMutableMappedDataCollection<SMBWeakPointerMappableObject<SMBGameBoardTileEntity*>*>* const spawnedGameBoardTileEntities_offBoard_tracked_mappedDataCollection = self.spawnedGameBoardTileEntities_offBoard_tracked_mappedDataCollection;
	kRUConditionalReturn(spawnedGameBoardTileEntities_offBoard_tracked_mappedDataCollection == nil, YES);

	NSString* const gameBoardTileEntity_uniqueKey = [gameBoardTileEntity smb_uniqueKey];
	kRUConditionalReturn(gameBoardTileEntity_uniqueKey == nil, YES);

	SMBWeakPointerMappableObject<SMBGameBoardTileEntity*>* const weakPointerMappableObject =
	[spawnedGameBoardTileEntities_offBoard_tracked_mappedDataCollection mappableObject_for_uniqueKey:gameBoardTileEntity_uniqueKey];
	kRUConditionalReturn(weakPointerMappableObject == nil, YES);

	[spawnedGameBoardTileEntities_offBoard_tracked_mappedDataCollection mappableObject_remove:weakPointerMappableObject];

	[self spawnedGameBoardTileEntities_offBoard_tracked_update];

	if (gameBoardTileEntity.gameBoardTile != nil)
	{
		[self spawnedGameBoardTileEntities_tracked_mappedDataCollection_add:gameBoardTileEntity];
	}
}

#pragma mark - spawnedGameBoardTileEntities_offBoard_tracked
-(void)setSpawnedGameBoardTileEntities_offBoard_tracked:(NSArray<SMBWeakPointerMappableObject<SMBGameBoardTileEntity*>*>*)spawnedGameBoardTileEntities_offBoard_tracked
{
	kRUConditionalReturn((self.spawnedGameBoardTileEntities_offBoard_tracked == spawnedGameBoardTileEntities_offBoard_tracked)
						 ||
						 [self.spawnedGameBoardTileEntities_offBoard_tracked isEqual:spawnedGameBoardTileEntities_offBoard_tracked],
						 NO);

	[self SMBGameBoardTileEntitySpawner_spawnedGameBoardTileEntities_offBoard_tracked_setKVORegistered:NO];
	[self SMBGameBoardTileEntitySpawner_spawnedGameBoardTileEntities_offBoard_tracked_setRegisteredToNotificationCenter:NO];

	_spawnedGameBoardTileEntities_offBoard_tracked = (spawnedGameBoardTileEntities_offBoard_tracked ? [NSArray<SMBWeakPointerMappableObject<SMBGameBoardTileEntity*>*> arrayWithArray:spawnedGameBoardTileEntities_offBoard_tracked] : nil);

	[self SMBGameBoardTileEntitySpawner_spawnedGameBoardTileEntities_offBoard_tracked_setKVORegistered:YES];
	[self SMBGameBoardTileEntitySpawner_spawnedGameBoardTileEntities_offBoard_tracked_setRegisteredToNotificationCenter:YES];
}

-(void)spawnedGameBoardTileEntities_offBoard_tracked_update
{
	[self setSpawnedGameBoardTileEntities_offBoard_tracked:[self.spawnedGameBoardTileEntities_offBoard_tracked_mappedDataCollection mappableObjects]];
}

-(void)SMBGameBoardTileEntitySpawner_spawnedGameBoardTileEntities_offBoard_tracked_setKVORegistered:(BOOL)registered
{
	[self.spawnedGameBoardTileEntities_offBoard_tracked enumerateObjectsUsingBlock:^(SMBWeakPointerMappableObject<SMBGameBoardTileEntity *> * _Nonnull weakPointerMappableObject, NSUInteger idx, BOOL * _Nonnull stop) {
		SMBGameBoardTileEntity* const gameBoardTileEntity = weakPointerMappableObject.object;
		kRUConditionalReturn(gameBoardTileEntity == nil, YES);

		[self SMBGameBoardTileEntitySpawner_spawnedGameBoardTileEntities_offBoard_tracked:gameBoardTileEntity
																		 setKVORegistered:registered];
	}];
}

-(void)SMBGameBoardTileEntitySpawner_spawnedGameBoardTileEntities_offBoard_tracked:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
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
										 context:&SMBGameBoardTileEntitySpawner__KVOContext_spawnedGameBoardTileEntities_offBoard_tracked];
			}
			else
			{
				[gameBoardTileEntity removeObserver:self
										 forKeyPath:propertyToObserve
											context:&SMBGameBoardTileEntitySpawner__KVOContext_spawnedGameBoardTileEntities_offBoard_tracked];
			}
		}];
	}];
}

-(void)SMBGameBoardTileEntitySpawner_spawnedGameBoardTileEntities_offBoard_tracked_setRegisteredToNotificationCenter:(BOOL)registered
{
	[self.spawnedGameBoardTileEntities_offBoard_tracked enumerateObjectsUsingBlock:^(SMBWeakPointerMappableObject<SMBGameBoardTileEntity *> * _Nonnull weakPointerMappableObject, NSUInteger idx, BOOL * _Nonnull stop) {
		SMBGameBoardTileEntity* const gameBoardTileEntity = weakPointerMappableObject.object;
		kRUConditionalReturn(gameBoardTileEntity == nil, YES);
		
		[self SMBGameBoardTileEntitySpawner_spawnedGameBoardTileEntities_offBoard_tracked:gameBoardTileEntity
														setRegisteredToNotificationCenter:registered];
	}];
}

-(void)SMBGameBoardTileEntitySpawner_spawnedGameBoardTileEntities_offBoard_tracked:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
												 setRegisteredToNotificationCenter:(BOOL)registered
{
	if (registered)
	{
		[self setRegisteredFor_SMBGameBoardTileEntityDeallocNotification_didCallDeallocOnWithNotificationSelector:@selector(spawnedGameBoardTileEntities_offBoard_tracked_notificationDidFire_didCallDealloc_with_notification:) notificationObject:gameBoardTileEntity];
	}
	else
	{
		[self clearRegisteredFor_SMBGameBoardTileEntityDeallocNotification_didCallDealloc_with_notificationObject:gameBoardTileEntity];
	}
}

-(void)spawnedGameBoardTileEntities_offBoard_tracked_notificationDidFire_didCallDealloc_with_notification:(nonnull NSNotification*)notification
{
	id const notification_object = notification.object;
	kRUConditionalReturn(notification_object == nil, YES);

	SMBGameBoardTileEntity* const gameBoardTileEntity = kRUClassOrNil(notification_object, SMBGameBoardTileEntity);
	kRUConditionalReturn(gameBoardTileEntity == nil, YES);

#if kSMBEnvironment__SMBGameBoardTileEntitySpawner_deallocIsOccuring_enabled
	kRUConditionalReturn(gameBoardTileEntity.deallocIsOccuring == false, YES);
#endif

	[self spawnedGameBoardTileEntities_offBoard_tracked_mappedDataCollection_remove:gameBoardTileEntity];
}

#pragma mark - KVO
-(void)observeValueForKeyPath:(nullable NSString*)keyPath ofObject:(nullable id)object change:(nullable NSDictionary*)change context:(nullable void*)context
{
	if (context == SMBGameBoardTileEntitySpawner__KVOContext_spawnedGameBoardTileEntities_tracked)
	{
		if ([self.spawnedGameBoardTileEntities_tracked containsObject:object])
		{
			if ([keyPath isEqualToString:[SMBGameBoardTileEntity_PropertiesForKVO gameBoardTile]])
			{
				[self spawnedGameBoardTileEntities_tracked_mappedDataCollection_remove:kRUClassOrNil(object, SMBGameBoardTileEntity)];
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
	else if (context == SMBGameBoardTileEntitySpawner__KVOContext_spawnedGameBoardTileEntities_offBoard_tracked)
	{
		if ([self.spawnedGameBoardTileEntities_offBoard_tracked containsObject:object])
		{
			if ([keyPath isEqualToString:[SMBGameBoardTileEntity_PropertiesForKVO gameBoardTile]])
			{
				[self spawnedGameBoardTileEntities_offBoard_tracked_mappedDataCollection_remove:kRUClassOrNil(object, SMBGameBoardTileEntity)];
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

+(nonnull NSString*)spawnedGameBoardTileEntities_tracked{return NSStringFromSelector(_cmd);}

@end

