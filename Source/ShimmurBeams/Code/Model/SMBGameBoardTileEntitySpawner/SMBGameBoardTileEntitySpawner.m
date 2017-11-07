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

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/NSMutableArray+RUAddObjectIfNotNil.h>
#import <ResplendentUtilities/RUConstants.h>
#import <ResplendentUtilities/RUClassOrNilUtil.h>





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
-(void)spawnedGameBoardTileEntities_tracked_remove_attempt:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity;

/**
 Attempts to remove the oldest game board tile entity.

 @return Returns YES if an entity was remove, otherwise returns NO.
 */
-(BOOL)spawnedGameBoardTileEntities_tracked_removeOldest;

#pragma mark - spawnEntityBlock
@property (nonatomic, copy, nullable) SMBGameBoardTileEntitySpawner_spawnEntityBlock spawnEntityBlock;

@end





@implementation SMBGameBoardTileEntitySpawner

#pragma mark - NSObject
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

	__weak typeof(self) const self_weak = self;
	__weak typeof(gameBoardTileEntity) const gameBoardTileEntity_weak = gameBoardTileEntity;
	SMBGameBoardTileEntity* const weakPointerMappableObject =
	[[SMBGameBoardTileEntity alloc] init_with_object:gameBoardTileEntity
																	   deallocBlock:
	 ^{
		 [self_weak spawnedGameBoardTileEntities_tracked_remove_attempt:gameBoardTileEntity_weak];
	 }];
	kRUConditionalReturn(gameBoardTileEntity_weak == nil, YES);

	[self.spawnedGameBoardTileEntities_tracked_mappedDataCollection mappableObject_add:weakPointerMappableObject];

	[self spawnedGameBoardTileEntities_tracked_update];
}

-(void)spawnedGameBoardTileEntities_tracked_mappedDataCollection_remove:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
{
	kRUConditionalReturn(gameBoardTileEntity == nil, YES);

	/* Should already be removed from the game board tile at this point. */
	kRUConditionalReturn(gameBoardTileEntity.gameBoardTile != nil, YES);

	SMBMutableMappedDataCollection<SMBGameBoardTileEntity*>* const spawnedGameBoardTileEntities_tracked_mappedDataCollection = self.spawnedGameBoardTileEntities_tracked_mappedDataCollection;
	kRUConditionalReturn(spawnedGameBoardTileEntities_tracked_mappedDataCollection == nil, YES);

	NSString* const gameBoardTileEntity_uniqueKey = [gameBoardTileEntity smb_uniqueKey];
	kRUConditionalReturn(gameBoardTileEntity_uniqueKey == nil, YES);

	SMBGameBoardTileEntity* const weakPointerMappableObject =
	[spawnedGameBoardTileEntities_tracked_mappedDataCollection mappableObject_for_uniqueKey:gameBoardTileEntity_uniqueKey];
	kRUConditionalReturn(weakPointerMappableObject == nil, YES);

	[spawnedGameBoardTileEntities_tracked_mappedDataCollection mappableObject_remove:weakPointerMappableObject];

	[self spawnedGameBoardTileEntities_tracked_update];
}

#pragma mark - spawnedGameBoardTileEntities_tracked
-(void)setSpawnedGameBoardTileEntities_tracked:(nullable NSArray<SMBGameBoardTileEntity*>*)spawnedGameBoardTileEntities_tracked
{
	kRUConditionalReturn((self.spawnedGameBoardTileEntities_tracked == spawnedGameBoardTileEntities_tracked)
						 ||
						 [self.spawnedGameBoardTileEntities_tracked isEqual:spawnedGameBoardTileEntities_tracked],
						 NO);

	_spawnedGameBoardTileEntities_tracked = (spawnedGameBoardTileEntities_tracked ? [NSArray<SMBGameBoardTileEntity*> arrayWithArray:spawnedGameBoardTileEntities_tracked] : nil);

	[self spawnNewEntityState_update];
}

-(void)spawnedGameBoardTileEntities_tracked_update
{
	[self setSpawnedGameBoardTileEntities_tracked:[self.spawnedGameBoardTileEntities_tracked_mappedDataCollection mappableObjects]];
}

-(void)spawnedGameBoardTileEntities_tracked_remove_attempt:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
{
	kRUConditionalReturn(gameBoardTileEntity == nil, YES);
	kRUConditionalReturn(gameBoardTileEntity.gameBoardTile != nil, YES);

	[self spawnedGameBoardTileEntities_tracked_mappedDataCollection_remove:gameBoardTileEntity];

//	/*
//	 We are using (gameBoardTileEntity.gameBoardTile == nil) to determine if the entity should be removed. But, since when an entity is moved from one tile to another, it's `gameBoardTile` is set to nil then not nil, we can't just discard it the moment `gameBoardTile` becomes nil. Instead, we will let the thread finishing the current code, before we attempt our final check to remove the entity from this spawner.
//	 */
//	__weak typeof(self) const self_weak = self;
//
//	dispatch_async(dispatch_get_main_queue(), ^{
//		kRUConditionalReturn(gameBoardTileEntity.gameBoardTile != nil, NO);
//		kRUConditionalReturn([self_weak.spawnedGameBoardTileEntities_tracked_mappedDataCollection mappableObject_exists:gameBoardTileEntity], NO);
//
//		[self_weak spawnedGameBoardTileEntities_tracked_mappedDataCollection_remove:gameBoardTileEntity];
//	});
}

-(BOOL)spawnedGameBoardTileEntities_tracked_removeOldest
{
	NSArray<SMBGameBoardTileEntity*>* const spawnedGameBoardTileEntities_tracked = self.spawnedGameBoardTileEntities_tracked;
	kRUConditionalReturn_ReturnValueFalse(spawnedGameBoardTileEntities_tracked == nil, YES);

	SMBGameBoardTileEntity* const weakPointerMappableObject = [spawnedGameBoardTileEntities_tracked firstObject];
	kRUConditionalReturn_ReturnValueFalse(weakPointerMappableObject == nil, YES);

	SMBGameBoardTileEntity* const gameBoardTileEntity = weakPointerMappableObject.object;
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
	kRUConditionalReturn_ReturnValueTrue(spawnedGameBoardTileEntities_tracked_maximum <= 0, NO);

	NSArray<SMBGameBoardTileEntity*>* const spawnedGameBoardTileEntities_tracked = [self spawnedGameBoardTileEntities_tracked];
	NSUInteger const spawnedGameBoardTileEntities_tracked_count = (spawnedGameBoardTileEntities_tracked ? spawnedGameBoardTileEntities_tracked.count : 0);
	kRUConditionalReturn_ReturnValueFalse(spawnedGameBoardTileEntities_tracked_count > spawnedGameBoardTileEntities_tracked_maximum, YES);

	return
	(
	 spawnedGameBoardTileEntities_tracked_count
	 >=
	 spawnedGameBoardTileEntities_tracked_maximum
	 );
}

@end





@implementation SMBGameBoardTileEntitySpawner_PropertiesForKVO

+(nonnull NSString*)spawnedGameBoardTileEntities_tracked{return NSStringFromSelector(_cmd);}

@end

