//
//  SMBGameBoardTileEntitySpawnerManager.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 11/6/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardTileEntitySpawnerManager.h"
#import "SMBGameBoardTileEntity.h"
#import "SMBGameBoardTileEntitySpawner.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





static void* SMBGameBoardTileEntitySpawnerManager__KVOContext_gameBoardTileEntitySpawners = &SMBGameBoardTileEntitySpawnerManager__KVOContext_gameBoardTileEntitySpawners;





@interface SMBGameBoardTileEntitySpawnerManager ()

#pragma mark - gameBoardTileEntitySpawners
@property (nonatomic, copy, nullable) NSArray<SMBGameBoardTileEntitySpawner*>* gameBoardTileEntitySpawners;
-(void)SMBGameBoardTileEntitySpawnerManager_gameBoardTileEntitySpawners_setKVORegistered:(BOOL)registered;
-(void)SMBGameBoardTileEntitySpawnerManager_gameBoardTileEntitySpawner:(nonnull SMBGameBoardTileEntitySpawner*)gameBoardTileEntitySpawner
													  setKVORegistered:(BOOL)registered;

#pragma mark - gameBoardTileEntity_uniqueId_to_gameBoardTileEntitySpawner_mapping
@property (nonatomic, copy, nullable) NSDictionary<NSString*,SMBGameBoardTileEntitySpawner*>* gameBoardTileEntity_uniqueId_to_gameBoardTileEntitySpawner_mapping;
-(void)gameBoardTileEntity_uniqueId_to_gameBoardTileEntitySpawner_mapping_update;
-(nullable NSDictionary<NSString*,SMBGameBoardTileEntitySpawner*>*)gameBoardTileEntity_uniqueId_to_gameBoardTileEntitySpawner_mapping_generate;

@end





@implementation SMBGameBoardTileEntitySpawnerManager

#pragma mark - NSObject
-(void)dealloc
{
	[self SMBGameBoardTileEntitySpawnerManager_gameBoardTileEntitySpawners_setKVORegistered:NO];
}

-(instancetype)init
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);
	
#if __has_feature(nullability)
#pragma clang diagnostic push
#pragma GCC diagnostic ignored "-Wnullability-completeness"
#endif
	return [self init_with_gameBoardTileEntitySpawners:nil];
#if __has_feature(nullability)
#pragma clang diagnostic pop
#endif
}

#pragma mark - init
-(nullable instancetype)init_with_gameBoardTileEntitySpawners:(nullable NSArray<SMBGameBoardTileEntitySpawner*>*)gameBoardTileEntitySpawners
{
	if (self = [super init])
	{
		[self setGameBoardTileEntitySpawners:gameBoardTileEntitySpawners];
	}

	return self;
}

#pragma mark - gameBoardTileEntitySpawners
-(void)setGameBoardTileEntitySpawners:(nullable NSArray<SMBGameBoardTileEntitySpawner*>*)gameBoardTileEntitySpawners
{
	kRUConditionalReturn((self.gameBoardTileEntitySpawners == gameBoardTileEntitySpawners)
						 ||
						 [self.gameBoardTileEntitySpawners isEqual:gameBoardTileEntitySpawners], NO);

	[self SMBGameBoardTileEntitySpawnerManager_gameBoardTileEntitySpawners_setKVORegistered:NO];

	_gameBoardTileEntitySpawners = (gameBoardTileEntitySpawners ? [NSArray<SMBGameBoardTileEntitySpawner*> arrayWithArray:gameBoardTileEntitySpawners] : nil);

	[self SMBGameBoardTileEntitySpawnerManager_gameBoardTileEntitySpawners_setKVORegistered:YES];
}

-(void)SMBGameBoardTileEntitySpawnerManager_gameBoardTileEntitySpawners_setKVORegistered:(BOOL)registered
{
	[self.gameBoardTileEntitySpawners enumerateObjectsUsingBlock:^(SMBGameBoardTileEntitySpawner * _Nonnull gameBoardTileEntitySpawner, NSUInteger idx, BOOL * _Nonnull stop) {
		[self SMBGameBoardTileEntitySpawnerManager_gameBoardTileEntitySpawner:gameBoardTileEntitySpawner
															 setKVORegistered:registered];
	}];
}

-(void)SMBGameBoardTileEntitySpawnerManager_gameBoardTileEntitySpawner:(nonnull SMBGameBoardTileEntitySpawner*)gameBoardTileEntitySpawner
													  setKVORegistered:(BOOL)registered
{
	kRUConditionalReturn(gameBoardTileEntitySpawner == nil, YES);
	
	NSMutableDictionary<NSNumber*,NSMutableArray<NSString*>*>* const KVOOptions_to_propertiesToObserve_mapping = [NSMutableDictionary<NSNumber*,NSMutableArray<NSString*>*> dictionary];
	
	NSMutableArray<NSString*>* const propertiesToObserve_observe_initial = [NSMutableArray<NSString*> array];
	[propertiesToObserve_observe_initial addObject:[SMBGameBoardTileEntitySpawner_PropertiesForKVO gameBoardTileEntities_spawned]];
	[KVOOptions_to_propertiesToObserve_mapping setObject:propertiesToObserve_observe_initial forKey:@(NSKeyValueObservingOptionInitial)];
	
	[KVOOptions_to_propertiesToObserve_mapping enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull KVOOptions_number, NSMutableArray<NSString *> * _Nonnull propertiesToObserve, BOOL * _Nonnull stop) {
		[propertiesToObserve enumerateObjectsUsingBlock:^(NSString * _Nonnull propertyToObserve, NSUInteger idx, BOOL * _Nonnull stop) {
			if (registered)
			{
				[gameBoardTileEntitySpawner addObserver:self
											 forKeyPath:propertyToObserve
												options:(KVOOptions_number.unsignedIntegerValue)
												context:&SMBGameBoardTileEntitySpawnerManager__KVOContext_gameBoardTileEntitySpawners];
			}
			else
			{
				[gameBoardTileEntitySpawner removeObserver:self
												forKeyPath:propertyToObserve
												   context:&SMBGameBoardTileEntitySpawnerManager__KVOContext_gameBoardTileEntitySpawners];
			}
		}];
	}];
}

-(nullable SMBGameBoardTileEntitySpawner*)gameBoardTileEntitySpawner_for_entity:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
{
	kRUConditionalReturn_ReturnValueNil(gameBoardTileEntity == nil, YES);

	NSString* const uniqueId = gameBoardTileEntity.uniqueId;
	kRUConditionalReturn_ReturnValueNil(uniqueId == nil, YES);

	return [self.gameBoardTileEntity_uniqueId_to_gameBoardTileEntitySpawner_mapping objectForKey:uniqueId];
}

#pragma mark - gameBoardTileEntity_uniqueId_to_gameBoardTileEntitySpawner_mapping
-(void)setGameBoardTileEntity_uniqueId_to_gameBoardTileEntitySpawner_mapping:(nullable NSDictionary<NSString*,SMBGameBoardTileEntitySpawner*>*)gameBoardTileEntity_uniqueId_to_gameBoardTileEntitySpawner_mapping
{
	kRUConditionalReturn((self.gameBoardTileEntity_uniqueId_to_gameBoardTileEntitySpawner_mapping == gameBoardTileEntity_uniqueId_to_gameBoardTileEntitySpawner_mapping)
						 ||
						 [self.gameBoardTileEntity_uniqueId_to_gameBoardTileEntitySpawner_mapping isEqual:gameBoardTileEntity_uniqueId_to_gameBoardTileEntitySpawner_mapping]
						 , NO);

	_gameBoardTileEntity_uniqueId_to_gameBoardTileEntitySpawner_mapping =
	(gameBoardTileEntity_uniqueId_to_gameBoardTileEntitySpawner_mapping
	 ?
	 [NSDictionary<NSString*,SMBGameBoardTileEntitySpawner*> dictionaryWithDictionary:gameBoardTileEntity_uniqueId_to_gameBoardTileEntitySpawner_mapping]
	 :
	 nil
	 );

	
}

-(void)gameBoardTileEntity_uniqueId_to_gameBoardTileEntitySpawner_mapping_update
{
	[self setGameBoardTileEntity_uniqueId_to_gameBoardTileEntitySpawner_mapping:[self gameBoardTileEntity_uniqueId_to_gameBoardTileEntitySpawner_mapping_generate]];
}

-(nullable NSDictionary<NSString*,SMBGameBoardTileEntitySpawner*>*)gameBoardTileEntity_uniqueId_to_gameBoardTileEntitySpawner_mapping_generate
{
	NSArray<SMBGameBoardTileEntitySpawner*>* const gameBoardTileEntitySpawners = self.gameBoardTileEntitySpawners;
	kRUConditionalReturn_ReturnValueNil(gameBoardTileEntitySpawners == nil, YES);

	NSMutableDictionary<NSString*,SMBGameBoardTileEntitySpawner*>* const gameBoardTileEntity_uniqueId_to_gameBoardTileEntitySpawner_mapping = [NSMutableDictionary<NSString*,SMBGameBoardTileEntitySpawner*> dictionary];
	[gameBoardTileEntitySpawners enumerateObjectsUsingBlock:^(SMBGameBoardTileEntitySpawner * _Nonnull gameBoardTileEntitySpawner, NSUInteger idx, BOOL * _Nonnull stop) {
		[gameBoardTileEntitySpawner.gameBoardTileEntities_spawned enumerateObjectsUsingBlock:^(SMBGameBoardTileEntity * _Nonnull gameBoardTileEntity, NSUInteger idx, BOOL * _Nonnull stop) {
			NSString* const gameBoardTileEntity_uniqueId = gameBoardTileEntity.uniqueId;
			kRUConditionalReturn(gameBoardTileEntity_uniqueId == nil, YES);
			kRUConditionalReturn([gameBoardTileEntity_uniqueId_to_gameBoardTileEntitySpawner_mapping objectForKey:gameBoardTileEntity_uniqueId] != nil, YES);

			[gameBoardTileEntity_uniqueId_to_gameBoardTileEntitySpawner_mapping setObject:gameBoardTileEntitySpawner
																				   forKey:gameBoardTileEntity_uniqueId];
		}];
	}];

	return [NSDictionary<NSString*,SMBGameBoardTileEntitySpawner*> dictionaryWithDictionary:gameBoardTileEntity_uniqueId_to_gameBoardTileEntitySpawner_mapping];
}

#pragma mark - KVO
-(void)observeValueForKeyPath:(nullable NSString*)keyPath ofObject:(nullable id)object change:(nullable NSDictionary*)change context:(nullable void*)context
{
	if (context == SMBGameBoardTileEntitySpawnerManager__KVOContext_gameBoardTileEntitySpawners)
	{
		if ([self.gameBoardTileEntitySpawners containsObject:object])
		{
			if ([keyPath isEqualToString:[SMBGameBoardTileEntitySpawner_PropertiesForKVO gameBoardTileEntities_spawned]])
			{
				[self gameBoardTileEntity_uniqueId_to_gameBoardTileEntitySpawner_mapping_update];
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
