//
//  SMBGameLevelView_UserSelection.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 11/8/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameLevelView_UserSelection.h"
#import "SMBGameBoardTileEntitySpawner.h"
#import "SMBGameBoardTileEntity.h"
#import "SMBGameBoardTileEntitySpawnerManager.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





static void* kSMBGameLevelView_UserSelection__KVOContext_selectedGameBoardTileEntitySpawner = &kSMBGameLevelView_UserSelection__KVOContext_selectedGameBoardTileEntitySpawner;





@interface SMBGameLevelView_UserSelection ()

#pragma mark - gameBoardTileEntitySpawnerManager
@property (nonatomic, readonly, strong, nullable) SMBGameBoardTileEntitySpawnerManager* gameBoardTileEntitySpawnerManager;

#pragma mark - selectedGameBoardTileEntity
@property (nonatomic, strong, nullable) SMBGameBoardTileEntity* selectedGameBoardTileEntity;
-(void)selectedGameBoardTileEntity_update_from_selectedGameBoardTileEntitySpawner;
-(nullable SMBGameBoardTileEntity*)selectedGameBoardTileEntity_appropriate_from_selectedGameBoardTileEntitySpawner;
#warning Can likely do without `selectedGameBoardTileEntity_isSetting`.
@property (nonatomic, assign) BOOL selectedGameBoardTileEntity_isSetting;

#pragma mark - selectedGameBoardTileEntitySpawner
@property (nonatomic, strong, nullable) SMBGameBoardTileEntitySpawner* selectedGameBoardTileEntitySpawner;
-(void)selectedGameBoardTileEntitySpawner_update_from_selectedGameBoardTileEntity;
-(nullable SMBGameBoardTileEntitySpawner*)selectedGameBoardTileEntitySpawner_from_selectedGameBoardTileEntity;

//-(void)selectedGameBoardTileEntitySpawner_update;
//-(nullable SMBGameBoardTileEntitySpawner*)selectedGameBoardTileEntitySpawner_appropriate;
-(void)SMBGameLevelView_UserSelection_selectedGameBoardTileEntitySpawner_setKVORegistered:(BOOL)registered;

#pragma mark - selectedGameBoardTileEntities
@property (nonatomic, copy, nullable) NSSet<SMBGameBoardTileEntity*>* selectedGameBoardTileEntities;
-(void)selectedGameBoardTileEntities_update;
-(nullable NSSet<SMBGameBoardTileEntity*>*)selectedGameBoardTileEntities_generate;

#pragma mark - selectedGameBoardTiles
@property (nonatomic, copy, nullable) NSSet<SMBGameBoardTile*>* selectedGameBoardTiles;
-(void)selectedGameBoardTiles_update;
-(nullable NSSet<SMBGameBoardTile*>*)selectedGameBoardTiles_generate;

@end





@implementation SMBGameLevelView_UserSelection

#pragma mark - NSObject
-(void)dealloc
{
	[self SMBGameLevelView_UserSelection_selectedGameBoardTileEntitySpawner_setKVORegistered:NO];
}

#pragma mark - NSObject
-(instancetype)init
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);

#if __has_feature(nullability)
#pragma clang diagnostic push
#pragma GCC diagnostic ignored "-Wnullability-completeness"
#endif
	return [self init_with_gameBoardTileEntitySpawnerManager:nil
								 selectedGameBoardTileEntity:nil];
#if __has_feature(nullability)
#pragma clang diagnostic pop
#endif
}

#pragma mark - init
-(nullable instancetype)init_with_gameBoardTileEntitySpawnerManager:(nonnull SMBGameBoardTileEntitySpawnerManager*)gameBoardTileEntitySpawnerManager
										selectedGameBoardTileEntity:(nonnull SMBGameBoardTileEntity*)selectedGameBoardTileEntity
{
	kRUConditionalReturn_ReturnValueNil(gameBoardTileEntitySpawnerManager == nil, YES);
	kRUConditionalReturn_ReturnValueNil(selectedGameBoardTileEntity == nil, YES);

	if (self = [super init])
	{
		_gameBoardTileEntitySpawnerManager = gameBoardTileEntitySpawnerManager;
		[self setSelectedGameBoardTileEntity:selectedGameBoardTileEntity];
	}

	return self;
}

-(nullable instancetype)init_with_gameBoardTileEntitySpawnerManager:(nonnull SMBGameBoardTileEntitySpawnerManager*)gameBoardTileEntitySpawnerManager
								 selectedGameBoardTileEntitySpawner:(nonnull SMBGameBoardTileEntitySpawner*)selectedGameBoardTileEntitySpawner
{
	kRUConditionalReturn_ReturnValueNil(gameBoardTileEntitySpawnerManager == nil, YES);
	kRUConditionalReturn_ReturnValueNil(selectedGameBoardTileEntitySpawner == nil, YES);

	if (self = [super init])
	{
		_gameBoardTileEntitySpawnerManager = gameBoardTileEntitySpawnerManager;
		[self setSelectedGameBoardTileEntitySpawner:selectedGameBoardTileEntitySpawner];
	}

	return self;
}

#pragma mark - selectedGameBoardTileEntity
-(void)setSelectedGameBoardTileEntity:(nullable SMBGameBoardTileEntity*)selectedGameBoardTileEntity
{
	kRUConditionalReturn(self.selectedGameBoardTileEntity_isSetting == YES, YES);
	kRUConditionalReturn(self.selectedGameBoardTileEntity == selectedGameBoardTileEntity, NO);

	[self setSelectedGameBoardTileEntity_isSetting:YES];

	_selectedGameBoardTileEntity = selectedGameBoardTileEntity;

	if (self.selectedGameBoardTileEntity != nil)
	{
		[self selectedGameBoardTileEntitySpawner_update_from_selectedGameBoardTileEntity];
	}

	[self setSelectedGameBoardTileEntity_isSetting:NO];
}

-(void)selectedGameBoardTileEntity_update_from_selectedGameBoardTileEntitySpawner
{
	[self setSelectedGameBoardTileEntity:[self selectedGameBoardTileEntity_appropriate_from_selectedGameBoardTileEntitySpawner]];
}

-(nullable SMBGameBoardTileEntity*)selectedGameBoardTileEntity_appropriate_from_selectedGameBoardTileEntitySpawner
{
	return nil;
}

#pragma mark - selectedGameBoardTileEntitySpawner
-(void)setSelectedGameBoardTileEntitySpawner:(nullable SMBGameBoardTileEntitySpawner*)selectedGameBoardTileEntitySpawner
{
	kRUConditionalReturn(self.selectedGameBoardTileEntitySpawner == selectedGameBoardTileEntitySpawner, NO);

	[self SMBGameLevelView_UserSelection_selectedGameBoardTileEntitySpawner_setKVORegistered:NO];

	_selectedGameBoardTileEntitySpawner = selectedGameBoardTileEntitySpawner;

	[self SMBGameLevelView_UserSelection_selectedGameBoardTileEntitySpawner_setKVORegistered:YES];

	if (self.selectedGameBoardTileEntity_isSetting == false)
	{
		[self selectedGameBoardTileEntity_update_from_selectedGameBoardTileEntitySpawner];
	}

	[self selectedGameBoardTileEntities_update];
}

-(void)selectedGameBoardTileEntitySpawner_update_from_selectedGameBoardTileEntity
{
	[self setSelectedGameBoardTileEntitySpawner:[self selectedGameBoardTileEntitySpawner_from_selectedGameBoardTileEntity]];
}

-(nullable SMBGameBoardTileEntitySpawner*)selectedGameBoardTileEntitySpawner_from_selectedGameBoardTileEntity
{
	SMBGameBoardTileEntity* const selectedGameBoardTileEntity = self.selectedGameBoardTileEntity;
	kRUConditionalReturn_ReturnValueNil(selectedGameBoardTileEntity == nil, YES);

	SMBGameBoardTileEntitySpawnerManager* const gameBoardTileEntitySpawnerManager = self.gameBoardTileEntitySpawnerManager;
	kRUConditionalReturn_ReturnValueNil(gameBoardTileEntitySpawnerManager == nil, YES);

	SMBGameBoardTileEntitySpawner* const gameBoardTileEntitySpawner = [gameBoardTileEntitySpawnerManager gameBoardTileEntitySpawner_for_entity:selectedGameBoardTileEntity];
	kRUConditionalReturn_ReturnValueNil(gameBoardTileEntitySpawner == nil, YES);

	return gameBoardTileEntitySpawner;
}

//-(void)selectedGameBoardTileEntitySpawner_update
//{
//	[self setSelectedGameBoardTileEntitySpawner:[self selectedGameBoardTileEntitySpawner_appropriate]];
//}
//
//-(nullable SMBGameBoardTileEntitySpawner*)selectedGameBoardTileEntitySpawner_appropriate
//{
//	return self.gameBoardTileEntityPickerView.selectedGameBoardTileEntitySpawner;
//}

-(void)SMBGameLevelView_UserSelection_selectedGameBoardTileEntitySpawner_setKVORegistered:(BOOL)registered
{
	typeof(self.selectedGameBoardTileEntitySpawner) const selectedGameBoardTileEntitySpawner = self.selectedGameBoardTileEntitySpawner;
	kRUConditionalReturn(selectedGameBoardTileEntitySpawner == nil, NO);

	NSMutableDictionary<NSNumber*,NSMutableArray<NSString*>*>* const KVOOptions_to_propertiesToObserve_mapping = [NSMutableDictionary<NSNumber*,NSMutableArray<NSString*>*> dictionary];

	NSMutableArray<NSString*>* const propertiesToObserve = [NSMutableArray<NSString*> array];
	/* Not doing initial for this property, because although we want it initially, we also want it when `selectedGameBoardTileEntitySpawner` is set to nil, and it's cleaner IMO to put the actions in the setter method without an if condition.*/
	[propertiesToObserve addObject:[SMBGameBoardTileEntitySpawner_PropertiesForKVO spawnedGameBoardTileEntities_tracked]];
	[KVOOptions_to_propertiesToObserve_mapping setObject:propertiesToObserve forKey:@(0)];

	[KVOOptions_to_propertiesToObserve_mapping enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull KVOOptions_number, NSMutableArray<NSString *> * _Nonnull propertiesToObserve, BOOL * _Nonnull stop) {
		[propertiesToObserve enumerateObjectsUsingBlock:^(NSString * _Nonnull propertyToObserve, NSUInteger idx, BOOL * _Nonnull stop) {
			if (registered)
			{
				[selectedGameBoardTileEntitySpawner addObserver:self
													 forKeyPath:propertyToObserve
														options:(KVOOptions_number.unsignedIntegerValue)
														context:&kSMBGameLevelView_UserSelection__KVOContext_selectedGameBoardTileEntitySpawner];
			}
			else
			{
				[selectedGameBoardTileEntitySpawner removeObserver:self
														forKeyPath:propertyToObserve
														   context:&kSMBGameLevelView_UserSelection__KVOContext_selectedGameBoardTileEntitySpawner];
			}
		}];
	}];
}

#pragma mark - selectedGameBoardTileEntities
-(void)setSelectedGameBoardTileEntities:(nullable NSSet<SMBGameBoardTileEntity*>*)selectedGameBoardTileEntities
{
	kRUConditionalReturn((self.selectedGameBoardTileEntities == selectedGameBoardTileEntities)
						 ||
						 [self.selectedGameBoardTileEntities isEqual:selectedGameBoardTileEntities], NO);

	_selectedGameBoardTileEntities = (selectedGameBoardTileEntities ? [NSSet<SMBGameBoardTileEntity*> setWithSet:selectedGameBoardTileEntities] : nil);

	[self selectedGameBoardTiles_update];
}

-(void)selectedGameBoardTileEntities_update
{
	[self setSelectedGameBoardTileEntities:[self selectedGameBoardTileEntities_generate]];
}

-(nullable NSSet<SMBGameBoardTileEntity*>*)selectedGameBoardTileEntities_generate
{
	SMBGameBoardTileEntitySpawner* const selectedGameBoardTileEntitySpawner = self.selectedGameBoardTileEntitySpawner;
	kRUConditionalReturn_ReturnValueNil(selectedGameBoardTileEntitySpawner == nil, NO);

	NSArray<SMBGameBoardTileEntity*>* const spawnedGameBoardTileEntities_tracked = selectedGameBoardTileEntitySpawner.spawnedGameBoardTileEntities_tracked;
	kRUConditionalReturn_ReturnValueNil(spawnedGameBoardTileEntities_tracked == nil, NO);

	return [NSSet<SMBGameBoardTileEntity*> setWithArray:spawnedGameBoardTileEntities_tracked];
}

#pragma mark - selectedGameBoardTiles
-(void)selectedGameBoardTiles_update
{
	[self setSelectedGameBoardTiles:[self selectedGameBoardTiles_generate]];
}

-(nullable NSSet<SMBGameBoardTile*>*)selectedGameBoardTiles_generate
{
	NSSet<SMBGameBoardTileEntity*>* const selectedGameBoardTileEntities = self.selectedGameBoardTileEntities;
	kRUConditionalReturn_ReturnValueNil(selectedGameBoardTileEntities == nil, NO);

	NSMutableSet<SMBGameBoardTile*>* const selectedGameBoardTiles = [NSMutableSet<SMBGameBoardTile*> set];
	[selectedGameBoardTileEntities enumerateObjectsUsingBlock:^(SMBGameBoardTileEntity * _Nonnull gameBoardTileEntity, BOOL * _Nonnull stop) {
		SMBGameBoardTile* const gameBoardTile = gameBoardTileEntity.gameBoardTile;
		kRUConditionalReturn(gameBoardTile == nil, YES);

		[selectedGameBoardTiles addObject:gameBoardTile];
	}];

	return [NSSet<SMBGameBoardTile*> setWithSet:selectedGameBoardTiles];
}

#pragma mark - KVO
-(void)observeValueForKeyPath:(nullable NSString*)keyPath ofObject:(nullable id)object change:(nullable NSDictionary*)change context:(nullable void*)context
{
	if (context == kSMBGameLevelView_UserSelection__KVOContext_selectedGameBoardTileEntitySpawner)
	{
		if (object == self.selectedGameBoardTileEntitySpawner)
		{
			if ([keyPath isEqualToString:[SMBGameBoardTileEntitySpawner_PropertiesForKVO spawnedGameBoardTileEntities_tracked]])
			{
				[self selectedGameBoardTileEntities_update];
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





@implementation SMBGameLevelView_UserSelection_PropertiesForKVO : NSObject

+(nonnull NSString*)selectedGameBoardTiles{return NSStringFromSelector(_cmd);}

@end
