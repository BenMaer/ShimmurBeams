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
#import "SMBMutableMappedDataCollection.h"
#import "SMBGameBoardTileEntity+SMBProvidesPower.h"
#import "SMBBeamBlockerTileEntity.h"
#import "SMBGameBoardTileEntity_PowerProvider.h"
#import "UIColor+SMBColors.h"
#import "SMBGameBoardTileEntity_PowerProvider_PropertiesForKVO.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/NSMutableArray+RUAddObjectIfNotNil.h>
#import <ResplendentUtilities/RUConstants.h>
#import <ResplendentUtilities/UIGeometry+RUUtility.h>
#import <ResplendentUtilities/RUClassOrNilUtil.h>





static void* kSMBGameBoardTile__KVOContext = &kSMBGameBoardTile__KVOContext;





@interface SMBGameBoardTile ()

#pragma mark - gameBoardTileEntities_many
@property (nonatomic, copy, nullable) NSArray<SMBGameBoardTileEntity*>* gameBoardTileEntities_many;
-(void)gameBoardTileEntities_many_update;
@property (nonatomic, readonly, strong, nullable) SMBMutableMappedDataCollection<SMBGameBoardTileEntity*>* gameBoardTileEntities_many_mappedDataCollection;

#pragma mark - gameBoardTileEntities_many_powerProviders_mappedDataCollection
@property (nonatomic, readonly, strong, nullable) SMBMutableMappedDataCollection<SMBGameBoardTileEntity<SMBGameBoardTileEntity_PowerProvider>*>* gameBoardTileEntities_many_powerProviders_mappedDataCollection;
-(void)gameBoardTileEntities_many_powerProviders_mappedDataCollection_add:(nonnull SMBGameBoardTileEntity<SMBGameBoardTileEntity_PowerProvider>*)gameBoardTileEntity;
-(void)gameBoardTileEntities_many_powerProviders_mappedDataCollection_remove:(nonnull SMBGameBoardTileEntity<SMBGameBoardTileEntity_PowerProvider>*)gameBoardTileEntity;
-(void)gameBoardTileEntity:(nonnull SMBGameBoardTileEntity<SMBGameBoardTileEntity_PowerProvider>*)gameBoardTileEntity
		  setKVORegistered:(BOOL)registered;

#pragma mark - gameBoardTileEntities_many_powerProviders_providesPower_mappedDataCollection
@property (nonatomic, readonly, strong, nullable) SMBMutableMappedDataCollection<SMBGameBoardTileEntity<SMBGameBoardTileEntity_PowerProvider>*>* gameBoardTileEntities_many_powerProviders_providesPower_mappedDataCollection;
-(void)gameBoardTileEntities_many_powerProviders_providesPower_mappedDataCollection_add:(nonnull SMBGameBoardTileEntity<SMBGameBoardTileEntity_PowerProvider>*)gameBoardTileEntity;
-(void)gameBoardTileEntities_many_powerProviders_providesPower_mappedDataCollection_remove:(nonnull SMBGameBoardTileEntity<SMBGameBoardTileEntity_PowerProvider>*)gameBoardTileEntity;
-(void)gameBoardTileEntities_many_powerProviders_providesPower_mappedDataCollection_add_ifProvidesPower_else_remove:(nonnull SMBGameBoardTileEntity<SMBGameBoardTileEntity_PowerProvider>*)gameBoardTileEntity;

#pragma mark - isPowered
@property (nonatomic, assign) BOOL isPowered;
-(void)isPowered_update;

@end





@implementation SMBGameBoardTile

#pragma mark - NSObject
-(void)dealloc
{
	[[self.gameBoardTileEntities_many_mappedDataCollection mappableObjects] enumerateObjectsUsingBlock:^(SMBGameBoardTileEntity<SMBMappedDataCollection_MappableObject>*  _Nonnull gameBoardTileEntity, NSUInteger idx, BOOL * _Nonnull stop) {
		[self gameBoardTileEntities_many_remove:gameBoardTileEntity];
	}];

	[self setGameBoardTileEntity_for_beamInteractions:nil];
}

#pragma mark - NSObject
-(instancetype)init
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wno-nullability-completeness"
	return [self init_with_gameBoardTilePosition:nil
									   gameBoard:nil];
#pragma clang diagnostic pop
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
											  gameBoard:(nonnull SMBGameBoard*)gameBoard
{
	kRUConditionalReturn_ReturnValueNil(gameBoardTilePosition == nil, YES);
	kRUConditionalReturn_ReturnValueNil(gameBoard == nil, YES);

	if (self = [super init])
	{
		_gameBoardTilePosition = gameBoardTilePosition;
		_gameBoard = gameBoard;

		_gameBoardTileEntities_many_mappedDataCollection = [SMBMutableMappedDataCollection<SMBGameBoardTileEntity*> new];
		_gameBoardTileEntities_many_powerProviders_mappedDataCollection = [SMBMutableMappedDataCollection<SMBGameBoardTileEntity<SMBGameBoardTileEntity_PowerProvider>*> new];
		_gameBoardTileEntities_many_powerProviders_providesPower_mappedDataCollection = [SMBMutableMappedDataCollection<SMBGameBoardTileEntity<SMBGameBoardTileEntity_PowerProvider>*> new];
	}

	return self;
}

#pragma mark - gameBoardTileEntity
-(void)gameBoardTileEntity:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
		updateRelationship:(BOOL)hasRelationship
{
	kRUConditionalReturn(gameBoardTileEntity == nil, YES);
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
	_gameBoardTileEntity_for_beamInteractions = gameBoardTileEntity_for_beamInteractions;

	if (gameBoardTileEntity_for_beamInteractions_old)
	{
		[self gameBoardTileEntity:gameBoardTileEntity_for_beamInteractions_old
			   updateRelationship:NO];
	}

	if (self.gameBoardTileEntity_for_beamInteractions)
	{
		if (self.gameBoardTileEntity_for_beamInteractions.gameBoardTile)
		{
			[self.gameBoardTileEntity_for_beamInteractions.gameBoardTile gameBoardTileEntities_remove:self.gameBoardTileEntity_for_beamInteractions];
		}

		[self gameBoardTileEntity:self.gameBoardTileEntity_for_beamInteractions
			   updateRelationship:YES];
	}
}

#pragma mark - gameBoardTileEntities_many
-(void)gameBoardTileEntities_many_update
{
	[self setGameBoardTileEntities_many:[self.gameBoardTileEntities_many_mappedDataCollection mappableObjects]];
}

-(void)gameBoardTileEntities_many_add:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
{
	kRUConditionalReturn(gameBoardTileEntity == nil, YES);

	[self.gameBoardTileEntities_many_mappedDataCollection mappableObject_add:gameBoardTileEntity];

	if ([gameBoardTileEntity smb_providesPower_selfOrNull])
	{
		[self gameBoardTileEntities_many_powerProviders_mappedDataCollection_add:[gameBoardTileEntity smb_providesPower_selfOrNull]];
	}

	[self gameBoardTileEntities_many_update];

	[self gameBoardTileEntity:gameBoardTileEntity
		   updateRelationship:YES];
}

-(void)gameBoardTileEntities_many_remove:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
{
	kRUConditionalReturn(gameBoardTileEntity == nil, YES);

	[self.gameBoardTileEntities_many_mappedDataCollection mappableObject_remove:gameBoardTileEntity];

	if ([gameBoardTileEntity smb_providesPower_selfOrNull])
	{
		[self gameBoardTileEntities_many_powerProviders_mappedDataCollection_remove:[gameBoardTileEntity smb_providesPower_selfOrNull]];
	}

	[self gameBoardTileEntities_many_update];

	[self gameBoardTileEntity:gameBoardTileEntity
		   updateRelationship:NO];
}

#pragma mark - gameBoardTileEntities
-(void)gameBoardTileEntities_add:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
					  entityType:(SMBGameBoardTile__entityType)entityType
{
	switch (entityType)
	{
		case SMBGameBoardTile__entityType_none:
			NSAssert(false, @"unhandled entityType %li",(long)entityType);
			break;

		case SMBGameBoardTile__entityType_many:
			[self gameBoardTileEntities_many_add:gameBoardTileEntity];
			break;

		case SMBGameBoardTile__entityType_beamInteractions:
			[self setGameBoardTileEntity_for_beamInteractions:gameBoardTileEntity];
			break;
	}
}

-(void)gameBoardTileEntities_remove:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
						 entityType:(SMBGameBoardTile__entityType)entityType
{
	switch (entityType)
	{
		case SMBGameBoardTile__entityType_none:
			NSAssert(false, @"unhandled entityType %li",(long)entityType);
			break;

		case SMBGameBoardTile__entityType_many:
			[self gameBoardTileEntities_many_remove:gameBoardTileEntity];
			break;

		case SMBGameBoardTile__entityType_beamInteractions:
		{
			kRUConditionalReturn(self.gameBoardTileEntity_for_beamInteractions != gameBoardTileEntity, YES);
			[self setGameBoardTileEntity_for_beamInteractions:nil];
		}
			break;
	}
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

#pragma mark - gameBoardTileEntities_many_powerProviders_mappedDataCollection
-(void)gameBoardTileEntities_many_powerProviders_mappedDataCollection_add:(nonnull SMBGameBoardTileEntity<SMBGameBoardTileEntity_PowerProvider>*)gameBoardTileEntity
{
	kRUConditionalReturn(gameBoardTileEntity == nil, YES);
	kRUConditionalReturn([self.gameBoardTileEntities_many_mappedDataCollection mappableObject_exists:gameBoardTileEntity] == false, YES);

	[self.gameBoardTileEntities_many_powerProviders_mappedDataCollection mappableObject_add:gameBoardTileEntity];

	[self gameBoardTileEntity:gameBoardTileEntity
			 setKVORegistered:YES];
}

-(void)gameBoardTileEntities_many_powerProviders_mappedDataCollection_remove:(nonnull SMBGameBoardTileEntity<SMBGameBoardTileEntity_PowerProvider>*)gameBoardTileEntity
{
	kRUConditionalReturn(gameBoardTileEntity == nil, YES);
	kRUConditionalReturn([self.gameBoardTileEntities_many_mappedDataCollection mappableObject_exists:gameBoardTileEntity], YES);

	BOOL const gameBoardTileEntity_providesPower = [gameBoardTileEntity smb_providesPower];
	[self gameBoardTileEntity:gameBoardTileEntity
			 setKVORegistered:NO];

	[self.gameBoardTileEntities_many_powerProviders_mappedDataCollection mappableObject_remove:gameBoardTileEntity];

	if (gameBoardTileEntity_providesPower)
	{
		[self gameBoardTileEntities_many_powerProviders_providesPower_mappedDataCollection_remove:gameBoardTileEntity];
	}
}

-(void)gameBoardTileEntity:(nonnull SMBGameBoardTileEntity<SMBGameBoardTileEntity_PowerProvider>*)gameBoardTileEntity
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
										 context:&kSMBGameBoardTile__KVOContext];
			}
			else
			{
				[gameBoardTileEntity removeObserver:self
										 forKeyPath:propertyToObserve
											context:&kSMBGameBoardTile__KVOContext];
			}
		}];
	}];
}

-(void)gameBoardTileEntities_many_powerProviders_providesPower_mappedDataCollection_add:(nonnull SMBGameBoardTileEntity<SMBGameBoardTileEntity_PowerProvider>*)gameBoardTileEntity
{
	kRUConditionalReturn(gameBoardTileEntity == nil, YES);
	kRUConditionalReturn(([gameBoardTileEntity smb_providesPower] == false)
						 ||
						 ([self.gameBoardTileEntities_many_powerProviders_mappedDataCollection mappableObject_exists:gameBoardTileEntity] == false), YES);

	[self.gameBoardTileEntities_many_powerProviders_providesPower_mappedDataCollection mappableObject_add:gameBoardTileEntity];

	[self isPowered_update];
}

-(void)gameBoardTileEntities_many_powerProviders_providesPower_mappedDataCollection_remove:(nonnull SMBGameBoardTileEntity<SMBGameBoardTileEntity_PowerProvider>*)gameBoardTileEntity
{
	kRUConditionalReturn(gameBoardTileEntity == nil, YES);
	kRUConditionalReturn([self.gameBoardTileEntities_many_powerProviders_mappedDataCollection mappableObject_exists:gameBoardTileEntity]
						 &&
						 [gameBoardTileEntity smb_providesPower], YES);

	[self.gameBoardTileEntities_many_powerProviders_providesPower_mappedDataCollection mappableObject_remove:gameBoardTileEntity];

	[self isPowered_update];
}

-(void)gameBoardTileEntities_many_powerProviders_providesPower_mappedDataCollection_add_ifProvidesPower_else_remove:(nonnull SMBGameBoardTileEntity<SMBGameBoardTileEntity_PowerProvider>*)gameBoardTileEntity
{
	kRUConditionalReturn(gameBoardTileEntity == nil, YES);

	BOOL const providesPower = [gameBoardTileEntity smb_providesPower];
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
	kRUConditionalReturn_ReturnValueNil(gameBoard == nil, YES);

	return [gameBoard gameBoardTile_next_from_gameBoardTile:self
												  direction:direction];
}

#pragma mark - isPowered
-(void)isPowered_update
{
	[self setIsPowered:([self.gameBoardTileEntities_many_powerProviders_providesPower_mappedDataCollection mappableObjects].count > 0)];
}

#pragma mark - isHighlighted
-(void)setIsHighlighted:(BOOL)isHighlighted
{
	kRUConditionalReturn(self.isHighlighted == isHighlighted, NO);

	_isHighlighted = isHighlighted;

	[self setNeedsRedraw:YES];
}

#pragma mark - SMBGameBoardGeneralEntity: draw
-(void)draw_in_rect:(CGRect)rect
{
	[super draw_in_rect:rect];

	if (self.isHighlighted)
	{
		CGContextRef const context = UIGraphicsGetCurrentContext();

		CGContextSaveGState(context);

		CGFloat const lineWidth = 1.0f;

		CGContextSetStrokeColorWithColor(context, [UIColor smb_selectedTileEntity_color].CGColor);

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
	if (context == kSMBGameBoardTile__KVOContext)
	{
		if ([[self.gameBoardTileEntities_many_powerProviders_mappedDataCollection mappableObjects] containsObject:object])
		{
			if ([keyPath isEqualToString:[SMBGameBoardTileEntity_PowerProvider_PropertiesForKVO providesPower]])
			{
				[self gameBoardTileEntities_many_powerProviders_providesPower_mappedDataCollection_add_ifProvidesPower_else_remove:[object smb_providesPower_selfOrNull]];
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





@implementation SMBGameBoardTile_PropertiesForKVO

+(nonnull NSString*)gameBoardTileEntity_for_beamInteractions{return NSStringFromSelector(_cmd);}
+(nonnull NSString*)gameBoardTileEntities_many{return NSStringFromSelector(_cmd);}
+(nonnull NSString*)beamDirectionsBlocked{return NSStringFromSelector(_cmd);}
+(nonnull NSString*)isPowered{return NSStringFromSelector(_cmd);}

@end
