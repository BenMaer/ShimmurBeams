//
//  SMBGameBoardTile.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/3/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardTile.h"
#import "SMBGameBoardTileEntity.h"
#import "SMBGameBoard.h"
#import "SMBMappedDataCollection.h"
#import "SMBMutableMappedDataCollection.h"
#import "SMBGameBoardTileEntity+SMBProvidesPower.h"
#import "SMBBeamBlockerTileEntity.h"
#import "SMBGameBoardTileEntity_PowerProvider.h"
#import "SMBGameBoardTileEntity_PowerProvider_PropertiesForKVO.h"
#import "NSArray+SMBChanges.h"
#import "SMBGameBoardTileEntity+SMBBeamBlocker.h"
#import "SMBBeamBlockerTileEntity_PropertiesForKVO.h"
#import "SMBBeamEntityTileNode.h"
#import "SMBGeneralBeamEnterToExitDirectionRedirectTileEntity.h"
#import "SMBGameBoardTileBeamEnterToExitDirectionMapping.h"
#import "SMBGeneralBeamEnterToExitDirectionRedirectTileEntity_PropertiesForKVO.h"
#import "SMBBeamEntityManager.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/NSMutableArray+RUAddObjectIfNotNil.h>
#import <ResplendentUtilities/RUConstants.h>
#import <ResplendentUtilities/UIGeometry+RUUtility.h>
#import <ResplendentUtilities/RUClassOrNilUtil.h>
#import <ResplendentUtilities/RUProtocolOrNil.h>





static void* kSMBGameBoardTile__KVOContext_gameBoardTileEntities_many_powerProviders_mappedDataCollection = &kSMBGameBoardTile__KVOContext_gameBoardTileEntities_many_powerProviders_mappedDataCollection;
static void* kSMBGameBoardTile__KVOContext_gameBoardTileEntities_beamBlockers_mappedDataCollection = &kSMBGameBoardTile__KVOContext_gameBoardTileEntities_beamBlockers_mappedDataCollection;
static void* kSMBGameBoardTile__KVOContext_generalBeamEnterToExitDirectionRedirectTileEntity = &kSMBGameBoardTile__KVOContext_generalBeamEnterToExitDirectionRedirectTileEntity;





@interface SMBGameBoardTile ()

#pragma mark - gameBoardTileEntity
-(void)gameBoardTileEntity_updateRelationship:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity;

#pragma mark - gameBoardTileEntity_for_beamInteractions
@property (nonatomic, strong, nullable) SMBGameBoardTileEntity* gameBoardTileEntity_for_beamInteractions;

#pragma mark - gameBoardTileEntities_many
@property (nonatomic, copy, nullable) NSArray<SMBGameBoardTileEntity*>* gameBoardTileEntities_many;
-(void)gameBoardTileEntities_many_add:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity;
-(BOOL)gameBoardTileEntities_many_remove:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity;
-(void)gameBoardTileEntities_many_update;
@property (nonatomic, readonly, strong, nullable) SMBMutableMappedDataCollection<SMBGameBoardTileEntity*>* gameBoardTileEntities_many_mappedDataCollection;

#pragma mark - gameBoardTileEntities_all
/**
 This is going to be used for meta data per tile (power, entry blockings, etc).
 */
@property (nonatomic, strong, nullable) SMBMappedDataCollection<SMBGameBoardTileEntity*>* gameBoardTileEntities_all;
@property (nonatomic, assign) BOOL gameBoardTileEntities_all_isUpdating;
-(void)gameBoardTileEntities_all_update;
-(SMBMappedDataCollection<SMBGameBoardTileEntity*>*)gameBoardTileEntities_all_generate;

#pragma mark - gameBoardTileEntities_many_powerProviders_mappedDataCollection
@property (nonatomic, readonly, strong, nullable) SMBMutableMappedDataCollection<SMBGameBoardTileEntity<SMBGameBoardTileEntity_PowerProvider>*>* gameBoardTileEntities_many_powerProviders_mappedDataCollection;
-(void)gameBoardTileEntities_many_powerProviders_mappedDataCollection_add:(nonnull SMBGameBoardTileEntity<SMBGameBoardTileEntity_PowerProvider>*)gameBoardTileEntity;
-(void)gameBoardTileEntities_many_powerProviders_mappedDataCollection_remove:(nonnull SMBGameBoardTileEntity<SMBGameBoardTileEntity_PowerProvider>*)gameBoardTileEntity;
-(void)gameBoardTileEntities_many_powerProvider:(nonnull SMBGameBoardTileEntity<SMBGameBoardTileEntity_PowerProvider>*)gameBoardTileEntity
							   setKVORegistered:(BOOL)registered;

#pragma mark - gameBoardTileEntities_many_powerProviders_providesPower_mappedDataCollection
@property (nonatomic, readonly, strong, nullable) SMBMutableMappedDataCollection<SMBGameBoardTileEntity<SMBGameBoardTileEntity_PowerProvider>*>* gameBoardTileEntities_many_powerProviders_providesPower_mappedDataCollection;
-(void)gameBoardTileEntities_many_powerProviders_providesPower_mappedDataCollection_add:(nonnull SMBGameBoardTileEntity<SMBGameBoardTileEntity_PowerProvider>*)gameBoardTileEntity;
-(void)gameBoardTileEntities_many_powerProviders_providesPower_mappedDataCollection_remove:(nonnull SMBGameBoardTileEntity<SMBGameBoardTileEntity_PowerProvider>*)gameBoardTileEntity;
-(void)gameBoardTileEntities_many_powerProviders_providesPower_mappedDataCollection_add_ifProvidesPower_else_remove:(nonnull SMBGameBoardTileEntity<SMBGameBoardTileEntity_PowerProvider>*)gameBoardTileEntity;

#pragma mark - isPowered
@property (nonatomic, assign) BOOL isPowered;
-(void)isPowered_update;

#pragma mark - isPowered_notByBeam
@property (nonatomic, assign) BOOL isPowered_notByBeam;
-(void)isPowered_notByBeam_update;
-(BOOL)isPowered_notByBeam_appropriate;

#pragma mark - gameBoardTileEntities_beamBlockers_mappedDataCollection
@property (nonatomic, readonly, strong, nullable) SMBMutableMappedDataCollection<SMBGameBoardTileEntity<SMBBeamBlockerTileEntity>*>* gameBoardTileEntities_beamBlockers_mappedDataCollection;
-(void)gameBoardTileEntities_beamBlockers_mappedDataCollection_add:(nonnull SMBGameBoardTileEntity<SMBBeamBlockerTileEntity>*)gameBoardTileEntity;
-(void)gameBoardTileEntities_beamBlockers_mappedDataCollection_remove:(nonnull SMBGameBoardTileEntity<SMBBeamBlockerTileEntity>*)gameBoardTileEntity;
-(void)gameBoardTileEntity_beamBlockers:(nonnull SMBGameBoardTileEntity<SMBBeamBlockerTileEntity>*)gameBoardTileEntity_beamBlocker
					   setKVORegistered:(BOOL)registered;

#pragma mark - beamEnterDirections_blocked
@property (nonatomic, assign) SMBGameBoardTile__direction beamEnterDirections_blocked;
-(void)beamEnterDirections_blocked_update;
-(SMBGameBoardTile__direction)beamEnterDirections_blocked_generate;

#pragma mark - generalBeamEnterToExitDirectionRedirectTileEntity
@property (nonatomic, strong, nullable) SMBGameBoardTileEntity<SMBGeneralBeamEnterToExitDirectionRedirectTileEntity>* generalBeamEnterToExitDirectionRedirectTileEntity;
-(void)generalBeamEnterToExitDirectionRedirectTileEntity_update;
-(nullable SMBGameBoardTileEntity<SMBGeneralBeamEnterToExitDirectionRedirectTileEntity>*)generalBeamEnterToExitDirectionRedirectTileEntity_appropriate;
-(void)generalBeamEnterToExitDirectionRedirectTileEntity_setKVORegistered:(BOOL)registered;

#pragma mark - beamEnterToExitDirectionMapping
@property (nonatomic, strong, nullable) SMBGameBoardTileBeamEnterToExitDirectionMapping* beamEnterToExitDirectionMapping;
-(void)beamEnterToExitDirectionMapping_update;
-(nonnull SMBGameBoardTileBeamEnterToExitDirectionMapping*)beamEnterToExitDirectionMapping_appropriate;
-(nonnull SMBGameBoardTileBeamEnterToExitDirectionMapping*)beamEnterToExitDirectionMapping_generate;

@end

@interface SMBGameBoardTile_Attributes_For_NSCoding : NSObject
+(nonnull NSString*)gameBoardTilePosition;
@end





@implementation SMBGameBoardTile

#pragma mark - NSObject
-(void)dealloc
{
	[[self.gameBoardTileEntities_many_mappedDataCollection mappableObjects] enumerateObjectsUsingBlock:^(SMBGameBoardTileEntity<SMBMappedDataCollection_MappableObject>*  _Nonnull gameBoardTileEntity, NSUInteger idx, BOOL * _Nonnull stop) {
		kRUConditionalReturn(gameBoardTileEntity.gameBoardTile == nil, NO);

		[self gameBoardTileEntities_many_remove:gameBoardTileEntity];
	}];

	[self setGameBoardTileEntity_for_beamInteractions:nil];
}

#pragma mark - NSObject
-(instancetype)init
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);

#if __has_feature(nullability)
#pragma clang diagnostic push
#pragma GCC diagnostic ignored "-Wnullability-completeness"
#endif
	return [self init_with_gameBoardTilePosition:nil];
#if __has_feature(nullability)
#pragma clang diagnostic pop
#endif
}

-(nonnull NSString*)description
{
	NSMutableArray<NSString*>* const description_lines = [NSMutableArray<NSString*> array];
	[description_lines ru_addObjectIfNotNil:[super description]];
	[description_lines ru_addObjectIfNotNil:RUStringWithFormat(@"gameBoardTilePosition: %@",self.gameBoardTilePosition)];

	return [description_lines componentsJoinedByString:@"\n"];
}

#pragma mark - init
-(nullable instancetype)init_with_gameBoardTilePosition:(nonnull SMBGameBoardTilePosition*)gameBoardTilePosition
{
	kRUConditionalReturn_ReturnValueNil(gameBoardTilePosition == nil, YES);

	if (self = [super init])
	{
		_gameBoardTilePosition = gameBoardTilePosition;

		_gameBoardTileEntities_many_mappedDataCollection = [SMBMutableMappedDataCollection<SMBGameBoardTileEntity*> new];
		_gameBoardTileEntities_many_powerProviders_mappedDataCollection = [SMBMutableMappedDataCollection<SMBGameBoardTileEntity<SMBGameBoardTileEntity_PowerProvider>*> new];
		_gameBoardTileEntities_many_powerProviders_providesPower_mappedDataCollection = [SMBMutableMappedDataCollection<SMBGameBoardTileEntity<SMBGameBoardTileEntity_PowerProvider>*> new];
		_gameBoardTileEntities_beamBlockers_mappedDataCollection = [SMBMutableMappedDataCollection<SMBGameBoardTileEntity<SMBBeamBlockerTileEntity>*> new];

		[self beamEnterToExitDirectionMapping_update];
	}

	return self;
}

#pragma mark - gameBoardTileEntity
-(void)gameBoardTileEntity_updateRelationship:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
{
	kRUConditionalReturn(gameBoardTileEntity == nil, YES);

	BOOL const hasRelationship = [self.gameBoardTileEntities_all mappableObject_exists:gameBoardTileEntity];
	kRUConditionalReturn((hasRelationship == false)
						 &&
						 (gameBoardTileEntity.gameBoardTile != self), NO);

	[gameBoardTileEntity setGameBoardTile:(hasRelationship ? self : nil)];
}

#pragma mark - gameBoardTileEntity_for_beamInteractions
-(void)setGameBoardTileEntity_for_beamInteractions:(nullable SMBGameBoardTileEntity*)gameBoardTileEntity_for_beamInteractions
{
	kRUConditionalReturn(self.gameBoardTileEntity_for_beamInteractions == gameBoardTileEntity_for_beamInteractions, NO);

	SMBGameBoardTileEntity* const gameBoardTileEntity_for_beamInteractions_old = self.gameBoardTileEntity_for_beamInteractions;

	void(^gameBoardTileEntity_change_action)(SMBGameBoardTileEntity* _Nonnull gameBoardTileEntity, BOOL added) = ^(SMBGameBoardTileEntity* _Nonnull gameBoardTileEntity, BOOL added) {
		SMBGameBoardTileEntity<SMBBeamBlockerTileEntity>* const gameBoardTileEntity_beamBlocker_orNull = [gameBoardTileEntity smb_beamBlocker_selfOrNull];
		if (gameBoardTileEntity_beamBlocker_orNull)
		{
			if (added)
			{
				[self gameBoardTileEntities_beamBlockers_mappedDataCollection_add:gameBoardTileEntity_beamBlocker_orNull];
			}
			else
			{
				[self gameBoardTileEntities_beamBlockers_mappedDataCollection_remove:gameBoardTileEntity_beamBlocker_orNull];
			}
		}
	};

	if (gameBoardTileEntity_for_beamInteractions_old)
	{
		gameBoardTileEntity_change_action(gameBoardTileEntity_for_beamInteractions_old, NO);
	}

	if (gameBoardTileEntity_for_beamInteractions)
	{
		if (gameBoardTileEntity_for_beamInteractions.gameBoardTile)
		{
			[gameBoardTileEntity_for_beamInteractions.gameBoardTile gameBoardTileEntities_remove:gameBoardTileEntity_for_beamInteractions
																					  entityType:SMBGameBoardTile__entityType_beamInteractions];
		}
	}

	_gameBoardTileEntity_for_beamInteractions = gameBoardTileEntity_for_beamInteractions;

	if (self.gameBoardTileEntity_for_beamInteractions)
	{
		gameBoardTileEntity_change_action(self.gameBoardTileEntity_for_beamInteractions, YES);
	}

	[self gameBoardTileEntities_all_update];
	[self generalBeamEnterToExitDirectionRedirectTileEntity_update];
}

#pragma mark - gameBoardTileEntities_many
-(void)setGameBoardTileEntities_many:(nullable NSArray<SMBGameBoardTileEntity*>*)gameBoardTileEntities_many
{
	kRUConditionalReturn((self.gameBoardTileEntities_many == gameBoardTileEntities_many)
						 ||
						 [self.gameBoardTileEntities_many isEqual:gameBoardTileEntities_many], NO);

	_gameBoardTileEntities_many = (gameBoardTileEntities_many ? [NSArray<SMBGameBoardTileEntity*> arrayWithArray:gameBoardTileEntities_many] : nil);

	[self gameBoardTileEntities_all_update];
}

-(void)gameBoardTileEntities_many_update
{
	[self setGameBoardTileEntities_many:[self.gameBoardTileEntities_many_mappedDataCollection mappableObjects]];
}

-(void)gameBoardTileEntities_many_add:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
{
	kRUConditionalReturn(gameBoardTileEntity == nil, YES);

	[self.gameBoardTileEntities_many_mappedDataCollection mappableObject_add:gameBoardTileEntity];

	[self gameBoardTileEntities_many_update];
}

-(BOOL)gameBoardTileEntities_many_remove:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
{
	kRUConditionalReturn_ReturnValueFalse(gameBoardTileEntity == nil, YES);

	[self.gameBoardTileEntities_many_mappedDataCollection mappableObject_remove:gameBoardTileEntity];

	[self gameBoardTileEntities_many_update];

	return YES;
}

#pragma mark - gameBoardTileEntities
-(void)gameBoardTileEntities_add:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
					  entityType:(SMBGameBoardTile__entityType)entityType
{
	BOOL const beamEntityManager_shouldPause = (self.gameBoard.beamEntityManager.isPaused == false);
	if (beamEntityManager_shouldPause)
	{
		[self.gameBoard.beamEntityManager setIsPaused:YES];
	}

	switch (entityType)
	{
		case SMBGameBoardTile__entityType_none:
			NSAssert(false, @"unhandled entityType %li",(long)entityType);
			return;
			break;

		case SMBGameBoardTile__entityType_many:
			[self gameBoardTileEntities_many_add:gameBoardTileEntity];
			break;

		case SMBGameBoardTile__entityType_beamInteractions:
			[self setGameBoardTileEntity_for_beamInteractions:gameBoardTileEntity];
			break;
	}

	if (beamEntityManager_shouldPause)
	{
		NSAssert(self.gameBoard.beamEntityManager.isPaused == YES, @"Should be paused from pausing it above.");
		[self.gameBoard.beamEntityManager setIsPaused:NO];
	}
}

-(BOOL)gameBoardTileEntities_remove:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
						 entityType:(SMBGameBoardTile__entityType)entityType
{
	switch (entityType)
	{
		case SMBGameBoardTile__entityType_none:
			break;

		case SMBGameBoardTile__entityType_many:
			return [self gameBoardTileEntities_many_remove:gameBoardTileEntity];
			break;

		case SMBGameBoardTile__entityType_beamInteractions:
		{
			kRUConditionalReturn_ReturnValueFalse(self.gameBoardTileEntity_for_beamInteractions != gameBoardTileEntity, YES);
			[self setGameBoardTileEntity_for_beamInteractions:nil];
			BOOL const success = (self.gameBoardTileEntity_for_beamInteractions == nil);
			NSAssert(success, @"should have set `gameBoardTileEntity_for_beamInteractions` to nil");
			return success;
		}
			break;
	}

	NSAssert(false, @"unhandled entityType %li",(long)entityType);
	return NO;
}

-(SMBGameBoardTile__entityType)gameBoardTileEntity_currentType:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
{
	kRUConditionalReturn_ReturnValue(gameBoardTileEntity == nil, YES, SMBGameBoardTile__entityType_none);

	kRUConditionalReturn_ReturnValue(self.gameBoardTileEntity_for_beamInteractions == gameBoardTileEntity, NO, SMBGameBoardTile__entityType_beamInteractions);
	kRUConditionalReturn_ReturnValue([self.gameBoardTileEntities_many_mappedDataCollection mappableObject_exists:gameBoardTileEntity], NO, SMBGameBoardTile__entityType_many);

	return SMBGameBoardTile__entityType_none;
}

-(void)gameBoardTileEntities_remove:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
{
	kRUConditionalReturn(gameBoardTileEntity == nil, YES);

	SMBGameBoardTile__entityType const entityType = [self gameBoardTileEntity_currentType:gameBoardTileEntity];
	kRUConditionalReturn(entityType == SMBGameBoardTile__entityType_none, NO);
	kRUConditionalReturn(SMBGameBoardTile__entityType__isInRange(entityType) == false, YES);

	[self gameBoardTileEntities_remove:gameBoardTileEntity
							entityType:entityType];
}

#pragma mark - gameBoardTileEntities_all
-(void)setGameBoardTileEntities_all:(nullable SMBMappedDataCollection<SMBGameBoardTileEntity*>*)gameBoardTileEntities_all
{
	kRUConditionalReturn((self.gameBoardTileEntities_all == gameBoardTileEntities_all)
						 ||
						 [self.gameBoardTileEntities_all isEqual:gameBoardTileEntities_all],
						 NO);

	BOOL gameBoardTileEntities_all_isUpdating_shouldSet = (self.gameBoardTileEntities_all_isUpdating == false);

	if (gameBoardTileEntities_all_isUpdating_shouldSet)
	{
		[self setGameBoardTileEntities_all_isUpdating:YES];
	}

	SMBMappedDataCollection<SMBGameBoardTileEntity*>* const gameBoardTileEntities_all_old = self.gameBoardTileEntities_all;
	_gameBoardTileEntities_all = gameBoardTileEntities_all;

	NSArray<SMBGameBoardTileEntity*>* gameBoardTileEntities_removed = nil;
	NSArray<SMBGameBoardTileEntity*>* gameBoardTileEntities_added = nil;
	[NSArray<SMBGameBoardTileEntity*> smb_changes_from_objects:[gameBoardTileEntities_all_old mappableObjects]
													to_objects:[gameBoardTileEntities_all mappableObjects]
												removedObjects:&gameBoardTileEntities_removed
													newObjects:&gameBoardTileEntities_added];

	void(^gameBoardTileEntity_change_action)(SMBGameBoardTileEntity* _Nonnull gameBoardTileEntity, BOOL added) = ^(SMBGameBoardTileEntity* _Nonnull gameBoardTileEntity, BOOL added) {
		SMBGameBoardTileEntity<SMBGameBoardTileEntity_PowerProvider>* const gameBoardTileEntity_powerProvider_orNull = [gameBoardTileEntity smb_powerProvider_selfOrNull];
		if (gameBoardTileEntity_powerProvider_orNull)
		{
			if (added)
			{
				[self gameBoardTileEntities_many_powerProviders_mappedDataCollection_add:gameBoardTileEntity_powerProvider_orNull];
			}
			else
			{
				[self gameBoardTileEntities_many_powerProviders_mappedDataCollection_remove:gameBoardTileEntity_powerProvider_orNull];
			}
		}

		[self gameBoardTileEntity_updateRelationship:gameBoardTileEntity];
	};

	[gameBoardTileEntities_removed enumerateObjectsUsingBlock:^(SMBGameBoardTileEntity * _Nonnull gameBoardTileEntity_removed, NSUInteger idx, BOOL * _Nonnull stop) {
		gameBoardTileEntity_change_action(gameBoardTileEntity_removed,NO);
	}];

	[gameBoardTileEntities_added enumerateObjectsUsingBlock:^(SMBGameBoardTileEntity * _Nonnull gameBoardTileEntity_added, NSUInteger idx, BOOL * _Nonnull stop) {
		gameBoardTileEntity_change_action(gameBoardTileEntity_added,YES);
	}];

	if (gameBoardTileEntities_all_isUpdating_shouldSet)
	{
		[self setGameBoardTileEntities_all_isUpdating:NO];
	}
}

-(void)gameBoardTileEntities_all_update
{
	[self setGameBoardTileEntities_all:[self gameBoardTileEntities_all_generate]];
}

-(SMBMappedDataCollection<SMBGameBoardTileEntity*>*)gameBoardTileEntities_all_generate
{
	SMBMutableMappedDataCollection<SMBGameBoardTileEntity*>* const gameBoardTileEntities_all = [SMBMutableMappedDataCollection<SMBGameBoardTileEntity*> new];

	SMBGameBoardTileEntity* const gameBoardTileEntity_for_beamInteractions = self.gameBoardTileEntity_for_beamInteractions;
	if (gameBoardTileEntity_for_beamInteractions)
	{
		[gameBoardTileEntities_all mappableObject_add:gameBoardTileEntity_for_beamInteractions];
	}

	NSArray<SMBGameBoardTileEntity*>* const gameBoardTileEntities_many = self.gameBoardTileEntities_many;
	[gameBoardTileEntities_many enumerateObjectsUsingBlock:^(SMBGameBoardTileEntity * _Nonnull gameBoardTileEntity, NSUInteger idx, BOOL * _Nonnull stop) {
		[gameBoardTileEntities_all mappableObject_add:gameBoardTileEntity];
	}];

	return [gameBoardTileEntities_all copy];
}

#pragma mark - gameBoardTileEntities_many_powerProviders_mappedDataCollection
-(void)gameBoardTileEntities_many_powerProviders_mappedDataCollection_add:(nonnull SMBGameBoardTileEntity<SMBGameBoardTileEntity_PowerProvider>*)gameBoardTileEntity
{
	kRUConditionalReturn(gameBoardTileEntity == nil, YES);
	kRUConditionalReturn([self.gameBoardTileEntities_many_mappedDataCollection mappableObject_exists:gameBoardTileEntity] == false, YES);
	kRUConditionalReturn([self.gameBoardTileEntities_many_powerProviders_mappedDataCollection mappableObject_exists:gameBoardTileEntity], YES);

	[self.gameBoardTileEntities_many_powerProviders_mappedDataCollection mappableObject_add:gameBoardTileEntity];

	[self gameBoardTileEntities_many_powerProvider:gameBoardTileEntity
								  setKVORegistered:YES];
}

-(void)gameBoardTileEntities_many_powerProviders_mappedDataCollection_remove:(nonnull SMBGameBoardTileEntity<SMBGameBoardTileEntity_PowerProvider>*)gameBoardTileEntity
{
	kRUConditionalReturn(gameBoardTileEntity == nil, YES);
	kRUConditionalReturn([self.gameBoardTileEntities_many_mappedDataCollection mappableObject_exists:gameBoardTileEntity], YES);
	kRUConditionalReturn([self.gameBoardTileEntities_many_powerProviders_mappedDataCollection mappableObject_exists:gameBoardTileEntity] == false, YES);

	BOOL const gameBoardTileEntity_providesPower = [gameBoardTileEntity smb_powerProvider_providesPower];
	[self gameBoardTileEntities_many_powerProvider:gameBoardTileEntity
								  setKVORegistered:NO];

	[self.gameBoardTileEntities_many_powerProviders_mappedDataCollection mappableObject_remove:gameBoardTileEntity];

	if (gameBoardTileEntity_providesPower)
	{
		[self gameBoardTileEntities_many_powerProviders_providesPower_mappedDataCollection_remove:gameBoardTileEntity];
	}
}

-(void)gameBoardTileEntities_many_powerProvider:(nonnull SMBGameBoardTileEntity<SMBGameBoardTileEntity_PowerProvider>*)gameBoardTileEntity
							   setKVORegistered:(BOOL)registered
{
	kRUConditionalReturn(gameBoardTileEntity == nil, YES);

	NSMutableArray<NSString*>* const propertiesToObserve_observe_old_and_initial = [NSMutableArray<NSString*> array];
	[propertiesToObserve_observe_old_and_initial addObject:[SMBGameBoardTileEntity_PowerProvider_PropertiesForKVO providesPower]];

	NSMutableDictionary<NSNumber*,NSMutableArray<NSString*>*>* const KVOOptions_to_propertiesToObserve_mapping = [NSMutableDictionary<NSNumber*,NSMutableArray<NSString*>*> dictionary];
	[KVOOptions_to_propertiesToObserve_mapping setObject:propertiesToObserve_observe_old_and_initial forKey:@(NSKeyValueObservingOptionInitial)];

	[KVOOptions_to_propertiesToObserve_mapping enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull KVOOptions_number, NSMutableArray<NSString *> * _Nonnull propertiesToObserve, BOOL * _Nonnull stop) {
		[propertiesToObserve enumerateObjectsUsingBlock:^(NSString * _Nonnull propertyToObserve, NSUInteger idx, BOOL * _Nonnull stop) {
			if (registered)
			{
				[gameBoardTileEntity addObserver:self
									  forKeyPath:propertyToObserve
										 options:(KVOOptions_number.unsignedIntegerValue)
										 context:&kSMBGameBoardTile__KVOContext_gameBoardTileEntities_many_powerProviders_mappedDataCollection];
			}
			else
			{
				[gameBoardTileEntity removeObserver:self
										 forKeyPath:propertyToObserve
											context:&kSMBGameBoardTile__KVOContext_gameBoardTileEntities_many_powerProviders_mappedDataCollection];
			}
		}];
	}];
}

#pragma mark - gameBoardTileEntities_many_powerProviders_providesPower_mappedDataCollection
-(void)gameBoardTileEntities_many_powerProviders_providesPower_mappedDataCollection_add:(nonnull SMBGameBoardTileEntity<SMBGameBoardTileEntity_PowerProvider>*)gameBoardTileEntity
{
	kRUConditionalReturn(gameBoardTileEntity == nil, YES);
	kRUConditionalReturn([self.gameBoardTileEntities_many_powerProviders_mappedDataCollection mappableObject_exists:gameBoardTileEntity] == false, YES);
	kRUConditionalReturn([gameBoardTileEntity smb_powerProvider_providesPower] == false, YES);
	kRUConditionalReturn([self.gameBoardTileEntities_many_powerProviders_providesPower_mappedDataCollection mappableObject_exists:gameBoardTileEntity], YES);

	[self.gameBoardTileEntities_many_powerProviders_providesPower_mappedDataCollection mappableObject_add:gameBoardTileEntity];

	[self isPowered_update];
	[self isPowered_notByBeam_update];
}

-(void)gameBoardTileEntities_many_powerProviders_providesPower_mappedDataCollection_remove:(nonnull SMBGameBoardTileEntity<SMBGameBoardTileEntity_PowerProvider>*)gameBoardTileEntity
{
	kRUConditionalReturn(gameBoardTileEntity == nil, YES);
	kRUConditionalReturn([self.gameBoardTileEntities_many_powerProviders_providesPower_mappedDataCollection mappableObject_exists:gameBoardTileEntity] == false, YES);

	[self.gameBoardTileEntities_many_powerProviders_providesPower_mappedDataCollection mappableObject_remove:gameBoardTileEntity];

	[self isPowered_update];
	[self isPowered_notByBeam_update];
}

-(void)gameBoardTileEntities_many_powerProviders_providesPower_mappedDataCollection_add_ifProvidesPower_else_remove:(nonnull SMBGameBoardTileEntity<SMBGameBoardTileEntity_PowerProvider>*)gameBoardTileEntity
{
	kRUConditionalReturn(gameBoardTileEntity == nil, YES);

	BOOL const providesPower = [gameBoardTileEntity smb_powerProvider_providesPower];
	kRUConditionalReturn(providesPower
						 ==
						 ([[self.gameBoardTileEntities_many_powerProviders_providesPower_mappedDataCollection mappableObjects] containsObject:gameBoardTileEntity]),
						 NO);

	if (providesPower)
	{
		[self gameBoardTileEntities_many_powerProviders_providesPower_mappedDataCollection_add:gameBoardTileEntity];
	}
	else
	{
		[self gameBoardTileEntities_many_powerProviders_providesPower_mappedDataCollection_remove:gameBoardTileEntity];
	}
}

#pragma mark - gameBoardTile
-(nullable SMBGameBoardTile*)gameBoardTile_next_with_direction:(SMBGameBoardTile__direction)direction
{
	SMBGameBoard* const gameBoard = self.gameBoard;
	kRUConditionalReturn_ReturnValueNil(gameBoard == nil, NO);

	return [gameBoard gameBoardTile_next_from_gameBoardTile:self
												  direction:direction];
}

#pragma mark - isPowered
-(void)isPowered_update
{
	[self setIsPowered:([self.gameBoardTileEntities_many_powerProviders_providesPower_mappedDataCollection mappableObjects].count > 0)];
}

#pragma mark - isPowered_notByBeam
-(void)isPowered_notByBeam_update
{
	[self setIsPowered_notByBeam:[self isPowered_notByBeam_appropriate]];
}

-(BOOL)isPowered_notByBeam_appropriate
{
	__block BOOL isPowered_notByBeam_appropriate = NO;

	[[self.gameBoardTileEntities_many_powerProviders_providesPower_mappedDataCollection mappableObjects] enumerateObjectsUsingBlock:^(SMBGameBoardTileEntity<SMBGameBoardTileEntity_PowerProvider>* _Nonnull gameBoardTileEntity_PowerProvider, NSUInteger idx, BOOL * _Nonnull stop) {
		if (kRUClassOrNil(gameBoardTileEntity_PowerProvider, SMBBeamEntityTileNode) == nil)
		{
			isPowered_notByBeam_appropriate = YES;
			*stop = YES;
		}
	}];

	return isPowered_notByBeam_appropriate;
}

#pragma mark - highlightColor
-(void)setHighlightColor:(nullable UIColor*)highlightColor
{
	kRUConditionalReturn(self.highlightColor == highlightColor, NO);

	_highlightColor = highlightColor;

	[self setNeedsRedraw];
}

#pragma mark - SMBGameBoardGeneralEntity: draw
-(void)draw_in_rect:(CGRect)rect
{
	[super draw_in_rect:rect];

	UIColor* const highlightColor = self.highlightColor;
	if (highlightColor != nil)
	{
		CGContextRef const context = UIGraphicsGetCurrentContext();

		CGContextSaveGState(context);

		CGFloat const lineWidth = MIN(CGRectGetWidth(rect) / 20.0f,
									  1.0f);

		CGContextSetStrokeColorWithColor(context, highlightColor.CGColor);

		CGRect const rect_inset = UIEdgeInsetsInsetRect(rect, RU_UIEdgeInsetsMakeAll(lineWidth / 2.0f));
		UIBezierPath* const path =
		[UIBezierPath bezierPathWithRoundedRect:rect_inset cornerRadius:CGRectGetHeight(rect) / 5.0f];

		[path setLineWidth:lineWidth];
		[path stroke];

		CGContextStrokePath(context);

		CGContextRestoreGState(context);
	}
}

#pragma mark - KVO
-(void)observeValueForKeyPath:(nullable NSString*)keyPath ofObject:(nullable id)object change:(nullable NSDictionary*)change context:(nullable void*)context
{
	if (context == kSMBGameBoardTile__KVOContext_gameBoardTileEntities_many_powerProviders_mappedDataCollection)
	{
		if ([[self.gameBoardTileEntities_many_powerProviders_mappedDataCollection mappableObjects] containsObject:object])
		{
			if ([keyPath isEqualToString:[SMBGameBoardTileEntity_PowerProvider_PropertiesForKVO providesPower]])
			{
				[self gameBoardTileEntities_many_powerProviders_providesPower_mappedDataCollection_add_ifProvidesPower_else_remove:[object smb_powerProvider_selfOrNull]];
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
	else if (context == kSMBGameBoardTile__KVOContext_gameBoardTileEntities_beamBlockers_mappedDataCollection)
	{
		if ([[self.gameBoardTileEntities_beamBlockers_mappedDataCollection mappableObjects] containsObject:object])
		{
			if ([keyPath isEqualToString:[SMBBeamBlockerTileEntity_PropertiesForKVO beamEnterDirections_blocked]])
			{
				[self beamEnterDirections_blocked_update];
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
	else if (context == kSMBGameBoardTile__KVOContext_generalBeamEnterToExitDirectionRedirectTileEntity)
	{
		if (self.generalBeamEnterToExitDirectionRedirectTileEntity == object)
		{
			if ([keyPath isEqualToString:[SMBGeneralBeamEnterToExitDirectionRedirectTileEntity_PropertiesForKVO beamEnterToExitDirectionMapping]])
			{
				[self beamEnterToExitDirectionMapping_update];
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

#pragma mark - gameBoardTileEntities_beamBlockers_mappedDataCollection
-(void)gameBoardTileEntities_beamBlockers_mappedDataCollection_add:(nonnull SMBGameBoardTileEntity<SMBBeamBlockerTileEntity>*)gameBoardTileEntity
{
	kRUConditionalReturn(gameBoardTileEntity == nil, YES);
	kRUConditionalReturn(self.gameBoardTileEntity_for_beamInteractions != gameBoardTileEntity, YES);
	kRUConditionalReturn([self.gameBoardTileEntities_beamBlockers_mappedDataCollection mappableObject_exists:gameBoardTileEntity], YES);

	[self.gameBoardTileEntities_beamBlockers_mappedDataCollection mappableObject_add:gameBoardTileEntity];

	[self gameBoardTileEntity_beamBlockers:gameBoardTileEntity
						  setKVORegistered:YES];
}

-(void)gameBoardTileEntities_beamBlockers_mappedDataCollection_remove:(nonnull SMBGameBoardTileEntity<SMBBeamBlockerTileEntity>*)gameBoardTileEntity
{
	kRUConditionalReturn(gameBoardTileEntity == nil, YES);
	kRUConditionalReturn([self.gameBoardTileEntities_beamBlockers_mappedDataCollection mappableObject_exists:gameBoardTileEntity] == false, YES);

	[self gameBoardTileEntity_beamBlockers:gameBoardTileEntity
						  setKVORegistered:NO];

	[self.gameBoardTileEntities_beamBlockers_mappedDataCollection mappableObject_remove:gameBoardTileEntity];

	[self beamEnterDirections_blocked_update];
}

-(void)gameBoardTileEntity_beamBlockers:(nonnull SMBGameBoardTileEntity<SMBBeamBlockerTileEntity>*)gameBoardTileEntity_beamBlocker
					   setKVORegistered:(BOOL)registered
{
	kRUConditionalReturn(gameBoardTileEntity_beamBlocker == nil, YES);

	NSMutableArray<NSString*>* const propertiesToObserve_observe_initial = [NSMutableArray<NSString*> array];
	[propertiesToObserve_observe_initial addObject:[SMBBeamBlockerTileEntity_PropertiesForKVO beamEnterDirections_blocked]];

	NSMutableDictionary<NSNumber*,NSMutableArray<NSString*>*>* const KVOOptions_to_propertiesToObserve_mapping = [NSMutableDictionary<NSNumber*,NSMutableArray<NSString*>*> dictionary];
	[KVOOptions_to_propertiesToObserve_mapping setObject:propertiesToObserve_observe_initial forKey:@(NSKeyValueObservingOptionInitial)];

	[KVOOptions_to_propertiesToObserve_mapping enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull KVOOptions_number, NSMutableArray<NSString *> * _Nonnull propertiesToObserve, BOOL * _Nonnull stop) {
		[propertiesToObserve enumerateObjectsUsingBlock:^(NSString * _Nonnull propertyToObserve, NSUInteger idx, BOOL * _Nonnull stop) {
			if (registered)
			{
				[gameBoardTileEntity_beamBlocker addObserver:self
												  forKeyPath:propertyToObserve
													 options:(KVOOptions_number.unsignedIntegerValue)
													 context:&kSMBGameBoardTile__KVOContext_gameBoardTileEntities_beamBlockers_mappedDataCollection];
			}
			else
			{
				[gameBoardTileEntity_beamBlocker removeObserver:self
													 forKeyPath:propertyToObserve
														context:&kSMBGameBoardTile__KVOContext_gameBoardTileEntities_beamBlockers_mappedDataCollection];
			}
		}];
	}];
}

#pragma mark - beamEnterDirections_blocked
-(void)beamEnterDirections_blocked_update
{
	[self setBeamEnterDirections_blocked:[self beamEnterDirections_blocked_generate]];
}

-(SMBGameBoardTile__direction)beamEnterDirections_blocked_generate
{
	__block SMBGameBoardTile__direction beamEnterDirections_blocked = 0;
	SMBGameBoardTile__direction const directions_all = SMBGameBoardTile__directions_all();

	[[self.gameBoardTileEntities_beamBlockers_mappedDataCollection mappableObjects] enumerateObjectsUsingBlock:^(SMBGameBoardTileEntity<SMBBeamBlockerTileEntity>*  _Nonnull gameBoardTileEntity_beamBlocker, NSUInteger idx, BOOL * _Nonnull gameBoardTileEntity_beamBlocker_stop) {
		SMBGameBoardTile__direction const gameBoardTileEntity_beamBlocker_beamEnterDirections_blocked = gameBoardTileEntity_beamBlocker.beamEnterDirections_blocked;
		kRUConditionalReturn(SMBGameBoardTile__direction__isInRange(gameBoardTileEntity_beamBlocker_beamEnterDirections_blocked) == false, NO);

		beamEnterDirections_blocked = beamEnterDirections_blocked | gameBoardTileEntity_beamBlocker_beamEnterDirections_blocked;

		if (beamEnterDirections_blocked & directions_all)
		{
			*gameBoardTileEntity_beamBlocker_stop = YES;
		}
	}];

	return
	((beamEnterDirections_blocked == 0)
	 ?
	 SMBGameBoardTile__direction_none
	 :
	 beamEnterDirections_blocked
	 );
}

#pragma mark - generalBeamEnterToExitDirectionRedirectTileEntity
-(void)setGeneralBeamEnterToExitDirectionRedirectTileEntity:(nullable SMBGameBoardTileEntity<SMBGeneralBeamEnterToExitDirectionRedirectTileEntity>*)generalBeamEnterToExitDirectionRedirectTileEntity
{
	kRUConditionalReturn(self.generalBeamEnterToExitDirectionRedirectTileEntity == generalBeamEnterToExitDirectionRedirectTileEntity, NO);

	[self generalBeamEnterToExitDirectionRedirectTileEntity_setKVORegistered:NO];

	_generalBeamEnterToExitDirectionRedirectTileEntity = generalBeamEnterToExitDirectionRedirectTileEntity;

	[self generalBeamEnterToExitDirectionRedirectTileEntity_setKVORegistered:YES];

	if (self.generalBeamEnterToExitDirectionRedirectTileEntity == nil)
	{
		[self beamEnterToExitDirectionMapping_update];
	}
}

-(void)generalBeamEnterToExitDirectionRedirectTileEntity_update
{
	[self setGeneralBeamEnterToExitDirectionRedirectTileEntity:[self generalBeamEnterToExitDirectionRedirectTileEntity_appropriate]];
}

-(nullable SMBGameBoardTileEntity<SMBGeneralBeamEnterToExitDirectionRedirectTileEntity>*)generalBeamEnterToExitDirectionRedirectTileEntity_appropriate
{
	SMBGameBoardTileEntity* const gameBoardTileEntity_for_beamInteractions = self.gameBoardTileEntity_for_beamInteractions;
	kRUConditionalReturn_ReturnValueNil(gameBoardTileEntity_for_beamInteractions == nil, NO);
	kRUConditionalReturn_ReturnValueNil(kRUProtocolOrNil(gameBoardTileEntity_for_beamInteractions, SMBGeneralBeamEnterToExitDirectionRedirectTileEntity) == nil, NO);

	return (SMBGameBoardTileEntity<SMBGeneralBeamEnterToExitDirectionRedirectTileEntity>*)gameBoardTileEntity_for_beamInteractions;
}

-(void)generalBeamEnterToExitDirectionRedirectTileEntity_setKVORegistered:(BOOL)registered
{
	SMBGameBoardTileEntity<SMBGeneralBeamEnterToExitDirectionRedirectTileEntity>* const generalBeamEnterToExitDirectionRedirectTileEntity = self.generalBeamEnterToExitDirectionRedirectTileEntity;
	kRUConditionalReturn(generalBeamEnterToExitDirectionRedirectTileEntity == nil, NO);

	NSMutableDictionary<NSNumber*,NSMutableArray<NSString*>*>* const KVOOptions_to_propertiesToObserve_mapping = [NSMutableDictionary<NSNumber*,NSMutableArray<NSString*>*> dictionary];

	NSMutableArray<NSString*>* const propertiesToObserve_observe_initial = [NSMutableArray<NSString*> array];
	[propertiesToObserve_observe_initial addObject:[SMBGeneralBeamEnterToExitDirectionRedirectTileEntity_PropertiesForKVO beamEnterToExitDirectionMapping]];
	[KVOOptions_to_propertiesToObserve_mapping setObject:propertiesToObserve_observe_initial forKey:@(NSKeyValueObservingOptionInitial)];

	[KVOOptions_to_propertiesToObserve_mapping enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull KVOOptions_number, NSMutableArray<NSString *> * _Nonnull propertiesToObserve, BOOL * _Nonnull stop) {
		[propertiesToObserve enumerateObjectsUsingBlock:^(NSString * _Nonnull propertyToObserve, NSUInteger idx, BOOL * _Nonnull stop) {
			if (registered)
			{
				[generalBeamEnterToExitDirectionRedirectTileEntity addObserver:self
																	forKeyPath:propertyToObserve
																	   options:(KVOOptions_number.unsignedIntegerValue)
																	   context:&kSMBGameBoardTile__KVOContext_generalBeamEnterToExitDirectionRedirectTileEntity];
			}
			else
			{
				[generalBeamEnterToExitDirectionRedirectTileEntity removeObserver:self
																	   forKeyPath:propertyToObserve
																		  context:&kSMBGameBoardTile__KVOContext_generalBeamEnterToExitDirectionRedirectTileEntity];
			}
		}];
	}];
}

#pragma mark - beamEnterToExitDirectionMapping
-(void)beamEnterToExitDirectionMapping_update
{
	[self setBeamEnterToExitDirectionMapping:[self beamEnterToExitDirectionMapping_appropriate]];
}

-(nonnull SMBGameBoardTileBeamEnterToExitDirectionMapping*)beamEnterToExitDirectionMapping_appropriate
{
	SMBGameBoardTileEntity<SMBGeneralBeamEnterToExitDirectionRedirectTileEntity>* const generalBeamEnterToExitDirectionRedirectTileEntity = self.generalBeamEnterToExitDirectionRedirectTileEntity;
	kRUConditionalReturn_ReturnValue(generalBeamEnterToExitDirectionRedirectTileEntity == nil, NO, [self beamEnterToExitDirectionMapping_generate]);

	SMBGameBoardTileBeamEnterToExitDirectionMapping* const beamEnterToExitDirectionMapping = generalBeamEnterToExitDirectionRedirectTileEntity.beamEnterToExitDirectionMapping;
	kRUConditionalReturn_ReturnValue(beamEnterToExitDirectionMapping == nil, YES, [self beamEnterToExitDirectionMapping_generate]);

	return beamEnterToExitDirectionMapping;
}

-(nonnull SMBGameBoardTileBeamEnterToExitDirectionMapping*)beamEnterToExitDirectionMapping_generate
{
	return
	[[SMBGameBoardTileBeamEnterToExitDirectionMapping alloc] init_with_beamEnterToExitDirectionMappingDictionary:nil];
}

#pragma mark - NSCoding
-(nullable instancetype)initWithCoder:(nonnull NSCoder*)aDecoder
{
	if (self = [self init_with_gameBoardTilePosition:[aDecoder decodeObjectForKey:[SMBGameBoardTile_Attributes_For_NSCoding gameBoardTilePosition]]])
	{
	}
	
	return self;
}

-(void)encodeWithCoder:(nonnull NSCoder*)aCoder
{
	[aCoder encodeObject:self.gameBoardTilePosition forKey:[SMBGameBoardTile_Attributes_For_NSCoding gameBoardTilePosition]];
}

@end





@implementation SMBGameBoardTile_PropertiesForKVO

+(nonnull NSString*)gameBoardTileEntity_for_beamInteractions{return NSStringFromSelector(_cmd);}
+(nonnull NSString*)gameBoardTileEntities_many{return NSStringFromSelector(_cmd);}
+(nonnull NSString*)gameBoardTileEntities_all{return NSStringFromSelector(_cmd);}
+(nonnull NSString*)isPowered{return NSStringFromSelector(_cmd);}
+(nonnull NSString*)isPowered_notByBeam{return NSStringFromSelector(_cmd);}
+(nonnull NSString*)beamEnterDirections_blocked{return NSStringFromSelector(_cmd);}
+(nonnull NSString*)beamEnterToExitDirectionMapping{return NSStringFromSelector(_cmd);}

@end

@implementation SMBGameBoardTile_Attributes_For_NSCoding
+(nonnull NSString*)gameBoardTilePosition{return NSStringFromSelector(_cmd);}
@end
