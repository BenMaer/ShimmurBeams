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
#import "SMBGameLevelView_UserSelection_GameBoardTile_HighlightData.h"
#import "UIColor+SMBColors.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





static void* kSMBGameLevelView_UserSelection__KVOContext_selectedGameBoardTileEntitySpawner = &kSMBGameLevelView_UserSelection__KVOContext_selectedGameBoardTileEntitySpawner;
static void* kSMBGameLevelView_UserSelection__KVOContext_selectedGameBoardTileEntities = &kSMBGameLevelView_UserSelection__KVOContext_selectedGameBoardTileEntities;





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

-(void)SMBGameLevelView_UserSelection_selectedGameBoardTileEntitySpawner_setKVORegistered:(BOOL)registered;

#pragma mark - selectedGameBoardTileEntities
@property (nonatomic, copy, nullable) NSSet<SMBGameBoardTileEntity*>* selectedGameBoardTileEntities;
-(void)SMBGameLevelView_UserSelection_selectedGameBoardTileEntities_setKVORegistered:(BOOL)registered;
-(void)SMBGameLevelView_UserSelection_selectedGameBoardTileEntity:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
												 setKVORegistered:(BOOL)registered;
-(void)selectedGameBoardTileEntities_update;
-(nullable NSSet<SMBGameBoardTileEntity*>*)selectedGameBoardTileEntities_generate;

#pragma mark - selectedGameBoardTiles_HighlightData
@property (nonatomic, copy, nullable) NSSet<SMBGameLevelView_UserSelection_GameBoardTile_HighlightData*>* selectedGameBoardTiles_HighlightData;
-(void)selectedGameBoardTiles_update;
-(nullable NSSet<SMBGameLevelView_UserSelection_GameBoardTile_HighlightData*>*)selectedGameBoardTiles_generate;

@end





@implementation SMBGameLevelView_UserSelection

#pragma mark - NSObject
-(void)dealloc
{
	[self SMBGameLevelView_UserSelection_selectedGameBoardTileEntities_setKVORegistered:NO];
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
	SMBGameBoardTileEntitySpawner* const selectedGameBoardTileEntitySpawner = self.selectedGameBoardTileEntitySpawner;
	kRUConditionalReturn_ReturnValueNil(selectedGameBoardTileEntitySpawner == nil, YES);

	kRUConditionalReturn_ReturnValueNil([selectedGameBoardTileEntitySpawner spawnedGameBoardTileEntities_tracked_atCapacity] == false, NO);

	return selectedGameBoardTileEntitySpawner.spawnedGameBoardTileEntities_tracked.firstObject;
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
-(void)setSelectedGameBoardTileEntities:(nullable NSSet<SMBGameBoardTileEntity*>* const)selectedGameBoardTileEntities
{
	kRUConditionalReturn((self.selectedGameBoardTileEntities == selectedGameBoardTileEntities)
						 ||
						 [self.selectedGameBoardTileEntities isEqual:selectedGameBoardTileEntities], NO);

	[self SMBGameLevelView_UserSelection_selectedGameBoardTileEntities_setKVORegistered:NO];

	_selectedGameBoardTileEntities = (selectedGameBoardTileEntities ? [NSSet<SMBGameBoardTileEntity*> setWithSet:selectedGameBoardTileEntities] : nil);

	[self SMBGameLevelView_UserSelection_selectedGameBoardTileEntities_setKVORegistered:YES];

	[self selectedGameBoardTiles_update];
}

-(void)SMBGameLevelView_UserSelection_selectedGameBoardTileEntities_setKVORegistered:(BOOL)registered
{
	[self.selectedGameBoardTileEntities enumerateObjectsUsingBlock:^(SMBGameBoardTileEntity * _Nonnull gameBoardTileEntity, BOOL * _Nonnull stop) {
		[self SMBGameLevelView_UserSelection_selectedGameBoardTileEntity:gameBoardTileEntity
														setKVORegistered:registered];
	}];
}

-(void)SMBGameLevelView_UserSelection_selectedGameBoardTileEntity:(nonnull SMBGameBoardTileEntity* const)gameBoardTileEntity
												 setKVORegistered:(BOOL)registered
{
	kRUConditionalReturn(gameBoardTileEntity == nil, YES);
	
	NSMutableDictionary<NSNumber*,NSMutableArray<NSString*>*>* const KVOOptions_to_propertiesToObserve_mapping = [NSMutableDictionary<NSNumber*,NSMutableArray<NSString*>*> dictionary];
	
	NSMutableArray<NSString*>* const propertiesToObserve = [NSMutableArray<NSString*> array];
	/* Not doing initial for this property, because although we want it initially, we also want it when `selectedGameBoardTileEntitySpawner` is set to nil, and it's cleaner IMO to put the actions in the setter method without an if condition.*/
	[propertiesToObserve addObject:[SMBGameBoardTileEntity_PropertiesForKVO gameBoardTile]];
	[KVOOptions_to_propertiesToObserve_mapping setObject:propertiesToObserve forKey:@(0)];
	
	[KVOOptions_to_propertiesToObserve_mapping enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull KVOOptions_number, NSMutableArray<NSString *> * _Nonnull propertiesToObserve, BOOL * _Nonnull stop) {
		[propertiesToObserve enumerateObjectsUsingBlock:^(NSString * _Nonnull propertyToObserve, NSUInteger idx, BOOL * _Nonnull stop) {
			if (registered)
			{
				[gameBoardTileEntity addObserver:self
									  forKeyPath:propertyToObserve
										 options:(KVOOptions_number.unsignedIntegerValue)
										 context:&kSMBGameLevelView_UserSelection__KVOContext_selectedGameBoardTileEntities];
			}
			else
			{
				[gameBoardTileEntity removeObserver:self
										 forKeyPath:propertyToObserve
											context:&kSMBGameLevelView_UserSelection__KVOContext_selectedGameBoardTileEntities];
			}
		}];
	}];
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

#pragma mark - selectedGameBoardTiles_HighlightData
-(void)selectedGameBoardTiles_update
{
	[self setSelectedGameBoardTiles_HighlightData:[self selectedGameBoardTiles_generate]];
}

-(nullable NSSet<SMBGameLevelView_UserSelection_GameBoardTile_HighlightData*>*)selectedGameBoardTiles_generate
{
	NSSet<SMBGameBoardTileEntity*>* const selectedGameBoardTileEntities = self.selectedGameBoardTileEntities;
	kRUConditionalReturn_ReturnValueNil(selectedGameBoardTileEntities == nil, NO);

	NSMutableSet<SMBGameLevelView_UserSelection_GameBoardTile_HighlightData*>* const selectedGameBoardTiles = [NSMutableSet<SMBGameLevelView_UserSelection_GameBoardTile_HighlightData*> set];
	[selectedGameBoardTileEntities enumerateObjectsUsingBlock:^(SMBGameBoardTileEntity * _Nonnull gameBoardTileEntity, BOOL * _Nonnull stop) {
		SMBGameBoardTile* const gameBoardTile = gameBoardTileEntity.gameBoardTile;
		kRUConditionalReturn(gameBoardTile == nil, NO);

		SMBGameBoardTileEntity* const selectedGameBoardTileEntity = self.selectedGameBoardTileEntity;
		SMBGameLevelView_UserSelection_GameBoardTile_HighlightData* const gameLevelView_UserSelection_GameBoardTile_HighlightData =
		[[SMBGameLevelView_UserSelection_GameBoardTile_HighlightData alloc] init_with_gameBoardTile:gameBoardTile
																					 highlightColor:
		 (
		  selectedGameBoardTileEntity == gameBoardTileEntity
		  ?
		  [UIColor smb_selectedTileEntity_color_primary]
		  :
		  [UIColor smb_selectedTileEntity_color]
		 )];
		kRUConditionalReturn(gameLevelView_UserSelection_GameBoardTile_HighlightData == nil, YES);

		[selectedGameBoardTiles addObject:gameLevelView_UserSelection_GameBoardTile_HighlightData];
	}];

	return [NSSet<SMBGameLevelView_UserSelection_GameBoardTile_HighlightData*> setWithSet:selectedGameBoardTiles];
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
	else if (context == kSMBGameLevelView_UserSelection__KVOContext_selectedGameBoardTileEntities)
	{
		if ([self.selectedGameBoardTileEntities containsObject:object])
		{
			if ([keyPath isEqualToString:[SMBGameBoardTileEntity_PropertiesForKVO gameBoardTile]])
			{
				[self selectedGameBoardTiles_update];
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

+(nonnull NSString*)selectedGameBoardTiles_HighlightData{return NSStringFromSelector(_cmd);}

@end
