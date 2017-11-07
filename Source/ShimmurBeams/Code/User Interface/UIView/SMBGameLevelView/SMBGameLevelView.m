//
//  SMBGameLevelView.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/3/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameLevelView.h"
#import "SMBGameBoardView.h"
#import "SMBGameLevel.h"
#import "SMBGameBoardTileEntityPickerView.h"
#import "SMBGameBoard.h"
#import "SMBGameBoardTile.h"
#import "SMBGameBoardTileEntity.h"
#import "SMBGameBoard+SMBAddEntity.h"
#import "SMBGameBoardTileEntitySpawnerManager.h"
#import "SMBGameBoardTileEntitySpawner.h"
#import "UIColor+SMBColors.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/UIView+RUUtility.h>

#define kSMBGameLevelView__beamEntityManager_beamEntity_forMarkingNodesReady_validation_enabled (kSMBEnvironment__SMBGameLevelView_beamEntityManager_beamEntity_forMarkingNodesReady_validation_enabled && 1)

#if kSMBGameLevelView__beamEntityManager_beamEntity_forMarkingNodesReady_validation_enabled
#import "SMBBeamEntityManager.h"
#endif





static void* kSMBGameLevelView__KVOContext_gameBoardTileEntityPickerView = &kSMBGameLevelView__KVOContext_gameBoardTileEntityPickerView;
static void* kSMBGameLevelView__KVOContext_selectedGameBoardTileEntitySpawner = &kSMBGameLevelView__KVOContext_selectedGameBoardTileEntitySpawner;





@interface SMBGameLevelView () <SMBGameBoardView_tileTapDelegate>

#pragma mark - content_inset
-(CGFloat)content_inset;

#pragma mark - gameBoardView
@property (nonatomic, readonly, strong, nullable) SMBGameBoardView* gameBoardView;
-(CGRect)gameBoardView_frame;
-(CGRect)gameBoardView_frame_with_boundingSize:(CGSize)boundingSize;

#pragma mark - gameBoardTileEntityPickerView
-(void)gameBoardTileEntityPickerView_setKVORegistered:(BOOL)registered;
@property (nonatomic, readonly, strong, nullable) SMBGameBoardTileEntityPickerView* gameBoardTileEntityPickerView;
-(CGRect)gameBoardTileEntityPickerView_frame;
-(CGRect)gameBoardTileEntityPickerView_frame_with_boundingWidth:(CGFloat)boundingWidth
									   gameBoardView_frame_maxY:(CGFloat)gameBoardView_frame_maxY;
-(void)gameBoardTileEntityPickerView_selectedGameBoardTileEntitySpawner_spawn_attempt_on_tile:(nonnull SMBGameBoardTile*)gameBoardTile;

#pragma mark - gameBoardTileEntityPickerView_borderColorView
@property (nonatomic, readonly, strong, nullable) UIView* gameBoardTileEntityPickerView_borderColorView;
-(CGRect)gameBoardTileEntityPickerView_borderColorView_frame;

@property (nonatomic, strong, nullable) NSObject* gameBoardTileEntityPickerView_borderColorView_animationPointer;
-(void)gameBoardTileEntityPickerView_borderColorView_animate;
-(void)gameBoardTileEntityPickerView_borderColorView_animate_to_highlightedColor_with_animationPointer:(nonnull NSObject*)animationPointer;
-(void)gameBoardTileEntityPickerView_borderColorView_animate_back_with_animationPointer:(nonnull NSObject*)animationPointer;
-(void)gameBoardTileEntityPickerView_borderColorView_animate_cancel;
-(void)gameBoardTileEntityPickerView_borderColorView_alpha_update_selected:(BOOL)selected;

#pragma mark - selectedGameBoardTileEntity
@property (nonatomic, strong, nullable) SMBGameBoardTileEntity* selectedGameBoardTileEntity;
@property (nonatomic, assign) BOOL selectedGameBoardTileEntity_isSetting;

#pragma mark - selectedGameBoardTileEntitySpawner
@property (nonatomic, strong, nullable) SMBGameBoardTileEntitySpawner* selectedGameBoardTileEntitySpawner;
-(void)selectedGameBoardTileEntitySpawner_update;
-(nullable SMBGameBoardTileEntitySpawner*)selectedGameBoardTileEntitySpawner_appropriate;
-(void)SMBGameLevelView_selectedGameBoardTileEntitySpawner_setKVORegistered:(BOOL)registered;

#pragma mark - selectedGameBoardTileEntities
@property (nonatomic, copy, nullable) NSSet<SMBGameBoardTileEntity*>* selectedGameBoardTileEntities;
-(void)selectedGameBoardTileEntities_update;
-(nullable NSSet<SMBGameBoardTileEntity*>*)selectedGameBoardTileEntities_generate;

#pragma mark - gameBoardTileEntity
-(void)gameBoardTileEntity_update:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
					isHighlighted:(BOOL)isHighlighted;

@end





@implementation SMBGameLevelView

#pragma mark - NSObject
-(void)dealloc
{
	[self gameBoardTileEntityPickerView_setKVORegistered:NO];
	[self SMBGameLevelView_selectedGameBoardTileEntitySpawner_setKVORegistered:NO];
}

#pragma mark - UIView
-(instancetype)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame])
	{
		[self setBackgroundColor:[UIColor clearColor]];

		_gameBoardTileEntityPickerView = [SMBGameBoardTileEntityPickerView new];
		[self.gameBoardTileEntityPickerView setBackgroundColor:[UIColor clearColor]];
		[self gameBoardTileEntityPickerView_setKVORegistered:YES];
		[self addSubview:self.gameBoardTileEntityPickerView];

		_gameBoardTileEntityPickerView_borderColorView = [UIView new];
		[self.gameBoardTileEntityPickerView_borderColorView setBackgroundColor:[UIColor clearColor]];
		[self.gameBoardTileEntityPickerView_borderColorView setUserInteractionEnabled:NO];
		[self.gameBoardTileEntityPickerView_borderColorView.layer setBorderWidth:2.0f];
		[self gameBoardTileEntityPickerView_borderColorView_alpha_update_selected:NO];
		[self.gameBoardTileEntityPickerView_borderColorView.layer setBorderColor:[UIColor redColor].CGColor];
		[self.gameBoardTileEntityPickerView addSubview:self.gameBoardTileEntityPickerView_borderColorView];

		_gameBoardView = [SMBGameBoardView new];
		[self.gameBoardView setTileTapDelegate:self];
		[self addSubview:self.gameBoardView];
	}

	return self;
}

-(void)layoutSubviews
{
	[super layoutSubviews];

	[self.gameBoardTileEntityPickerView setFrame:[self gameBoardTileEntityPickerView_frame]];
	[self.gameBoardTileEntityPickerView_borderColorView setFrame:[self gameBoardTileEntityPickerView_borderColorView_frame]];

	[self.gameBoardView setFrame:[self gameBoardView_frame]];
}

-(CGSize)sizeThatFits:(CGSize)size
{
	CGRect const gameBoardTileEntityPickerView_frame =
	[self gameBoardTileEntityPickerView_frame_with_boundingWidth:size.width
										gameBoardView_frame_maxY:CGRectGetMaxY([self gameBoardView_frame_with_boundingSize:size])];

	return (CGSize){
		.width		= size.width,
		.height		= CGRectGetMaxY(gameBoardTileEntityPickerView_frame),
	};
}

#pragma mark - gameLevel
-(void)setGameLevel:(nullable SMBGameLevel*)gameLevel
{
	kRUConditionalReturn(self.gameLevel == gameLevel, NO);

	_gameLevel = gameLevel;

	[self.gameBoardTileEntityPickerView setGameBoardTileEntitySpawners:self.gameLevel.gameBoardTileEntitySpawnerManager.gameBoardTileEntitySpawners];
	[self.gameBoardView setGameBoard:self.gameLevel.gameBoard];

#if kSMBGameLevelView__beamEntityManager_beamEntity_forMarkingNodesReady_validation_enabled
	[self.gameLevel.gameBoard.beamEntityManager beamEntity_forMarkingNodesReady_isNil_validate];
#endif
}

#pragma mark - content_inset
-(CGFloat)content_inset
{
	return 6.0f;
}

#pragma mark - gameBoardTileEntityPickerView
-(void)gameBoardTileEntityPickerView_setKVORegistered:(BOOL)registered
{
	typeof(self.gameBoardTileEntityPickerView) const gameBoardTileEntityPickerView = self.gameBoardTileEntityPickerView;
	kRUConditionalReturn(gameBoardTileEntityPickerView == nil, NO);

	NSMutableDictionary<NSNumber*,NSMutableArray<NSString*>*>* const KVOOptions_to_propertiesToObserve_mapping = [NSMutableDictionary<NSNumber*,NSMutableArray<NSString*>*> dictionary];

	NSMutableArray<NSString*>* const propertiesToObserve_observe_initial = [NSMutableArray<NSString*> array];
	[propertiesToObserve_observe_initial addObject:[SMBGameBoardTileEntityPickerView_PropertiesForKVO selectedGameBoardTileEntitySpawner]];
	[KVOOptions_to_propertiesToObserve_mapping setObject:propertiesToObserve_observe_initial forKey:@(NSKeyValueObservingOptionInitial)];

	[KVOOptions_to_propertiesToObserve_mapping enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull KVOOptions_number, NSMutableArray<NSString *> * _Nonnull propertiesToObserve, BOOL * _Nonnull stop) {
		[propertiesToObserve enumerateObjectsUsingBlock:^(NSString * _Nonnull propertyToObserve, NSUInteger idx, BOOL * _Nonnull stop) {
			if (registered)
			{
				[gameBoardTileEntityPickerView addObserver:self
												forKeyPath:propertyToObserve
												   options:(KVOOptions_number.unsignedIntegerValue)
												   context:&kSMBGameLevelView__KVOContext_gameBoardTileEntityPickerView];
			}
			else
			{
				[gameBoardTileEntityPickerView removeObserver:self
												   forKeyPath:propertyToObserve
													  context:&kSMBGameLevelView__KVOContext_gameBoardTileEntityPickerView];
			}
		}];
	}];
}

-(CGRect)gameBoardTileEntityPickerView_frame
{
	CGSize const boundingSize = self.bounds.size;
	return
	[self gameBoardTileEntityPickerView_frame_with_boundingWidth:boundingSize.width
										gameBoardView_frame_maxY:CGRectGetMaxY([self gameBoardView_frame_with_boundingSize:boundingSize])];
}

-(CGRect)gameBoardTileEntityPickerView_frame_with_boundingWidth:(CGFloat)boundingWidth
									   gameBoardView_frame_maxY:(CGFloat)gameBoardView_frame_maxY
{
	CGFloat const content_inset = [self content_inset];
	CGFloat const inset_top = content_inset;
	CGFloat const inset_horizontal = content_inset;
	CGFloat const height = 50.0f;

	return CGRectCeilOrigin((CGRect){
		.origin.x		= inset_horizontal,
		.origin.y		= gameBoardView_frame_maxY + inset_top,
		.size.width		= boundingWidth - (2.0f * inset_horizontal),
		.size.height	= height,
	});
}

-(void)gameBoardTileEntityPickerView_selectedGameBoardTileEntitySpawner_spawn_attempt_on_tile:(nonnull SMBGameBoardTile*)gameBoardTile
{
	/*
	 Refer to document `User facing actions` for details on expected logic.
	 https://docs.google.com/a/shimmur.com/document/d/1XXJqmIBKHtOcW3BhYKM5rFmT7ciu0J8-2ZjjPGTynUg/edit?usp=sharing

	 This is covering: User taps: 2.a...
	 */

	kRUConditionalReturn(gameBoardTile == nil, YES);

	SMBGameBoardTileEntitySpawner* const gameBoardTileEntityPickerView_selectedGameBoardTileEntitySpawner = self.gameBoardTileEntityPickerView.selectedGameBoardTileEntitySpawner;
	kRUConditionalReturn(gameBoardTileEntityPickerView_selectedGameBoardTileEntitySpawner == nil, YES);

	SMBGameBoardTileEntity* const gameBoardTileEntity_for_beamInteractions_old = gameBoardTile.gameBoardTileEntity_for_beamInteractions;

	/* User taps: 2.a.i */
	if (gameBoardTileEntity_for_beamInteractions_old)
	{
		/* User taps: 2.a.ii.2.a */
		SMBGameBoardTileEntitySpawner* const gameBoardTileEntitySpawner = [self.gameLevel.gameBoardTileEntitySpawnerManager gameBoardTileEntitySpawner_for_entity:gameBoardTileEntity_for_beamInteractions_old];
		kRUConditionalReturn(gameBoardTileEntitySpawner == nil, NO);

		/* User taps: 2.a.ii.1.a.i */
		kRUConditionalReturn(gameBoardTileEntityPickerView_selectedGameBoardTileEntitySpawner
							 ==
							 gameBoardTileEntitySpawner
							 ,
							 NO);
	}

	/*
	 User taps: 2.a.i.1
	 User taps: 2.a.ii.1.b.i
	 */
	[gameBoardTileEntityPickerView_selectedGameBoardTileEntitySpawner gameBoardTileEntity_spawnNew_tracked_on_gameBoardTile:gameBoardTile];
}

#pragma mark - gameBoardTileEntityPickerView_borderColorView
-(CGRect)gameBoardTileEntityPickerView_borderColorView_frame
{
	return (CGRect){
		.size	= [self gameBoardTileEntityPickerView_frame].size,
	};
}

-(void)gameBoardTileEntityPickerView_borderColorView_animate
{
	[self gameBoardTileEntityPickerView_borderColorView_animate_cancel];

	NSObject* const gameBoardTileEntityPickerView_borderColorView_animationPointer = self.gameBoardTileEntityPickerView_borderColorView_animationPointer;
	[self setGameBoardTileEntityPickerView_borderColorView_animationPointer:gameBoardTileEntityPickerView_borderColorView_animationPointer];

	[self gameBoardTileEntityPickerView_borderColorView_animate_to_highlightedColor_with_animationPointer:gameBoardTileEntityPickerView_borderColorView_animationPointer];
}

-(void)gameBoardTileEntityPickerView_borderColorView_animate_to_highlightedColor_with_animationPointer:(nonnull NSObject*)animationPointer
{
	kRUConditionalReturn(self.gameBoardTileEntityPickerView_borderColorView_animationPointer != animationPointer, NO);

	__weak typeof(self) const self_weak = self;
	[UIView animateWithDuration:0.25
					 animations:
	 ^{
		kRUConditionalReturn(self_weak.gameBoardTileEntityPickerView_borderColorView_animationPointer != animationPointer, NO);

		 [self_weak gameBoardTileEntityPickerView_borderColorView_alpha_update_selected:YES];
	}
		completion:
	 ^(BOOL finished) {
		 [self_weak gameBoardTileEntityPickerView_borderColorView_animate_back_with_animationPointer:animationPointer];
	 }];
}

-(void)gameBoardTileEntityPickerView_borderColorView_animate_back_with_animationPointer:(nonnull NSObject*)animationPointer
{
	kRUConditionalReturn(self.gameBoardTileEntityPickerView_borderColorView_animationPointer != animationPointer, NO);

	__weak typeof(self) const self_weak = self;
	[UIView animateWithDuration:0.25
						  delay:0.5f
						options:(0)
					 animations:
	 ^{
		 kRUConditionalReturn(self_weak.gameBoardTileEntityPickerView_borderColorView_animationPointer != animationPointer, NO);

		 [self_weak gameBoardTileEntityPickerView_borderColorView_alpha_update_selected:NO];
	 }
					 completion:
	 ^(BOOL finished) {
		 kRUConditionalReturn(self_weak.gameBoardTileEntityPickerView_borderColorView_animationPointer != animationPointer, NO);

		 [self_weak setGameBoardTileEntityPickerView_borderColorView_animationPointer:nil];
	 }];
}

-(void)gameBoardTileEntityPickerView_borderColorView_animate_cancel
{
	[self setGameBoardTileEntityPickerView_borderColorView_animationPointer:nil];
}

-(void)gameBoardTileEntityPickerView_borderColorView_alpha_update_selected:(BOOL)selected
{
	[self.gameBoardTileEntityPickerView_borderColorView setAlpha:(selected ? 1.0f : 0.0f)];
}

#pragma mark - gameBoardView
-(CGRect)gameBoardView_frame
{
	return
	[self gameBoardView_frame_with_boundingSize:self.bounds.size];
}

-(CGRect)gameBoardView_frame_with_boundingSize:(CGSize)boundingSize
{
	CGFloat const inset_top = [self content_inset];
	CGFloat const inset_horizontal = [self content_inset];

	CGFloat const gameBoardTileEntityPickerView_frame_with_gameBoardView_frame_maxY_0 =
	CGRectGetMaxY([self gameBoardTileEntityPickerView_frame_with_boundingWidth:boundingSize.width
													  gameBoardView_frame_maxY:0.0f]);

	CGSize const boundingSize_inset = (CGSize){
		.width		= boundingSize.width - (inset_horizontal * 2.0f),
		.height		= boundingSize.height - inset_top - gameBoardTileEntityPickerView_frame_with_gameBoardView_frame_maxY_0,
	};

	CGSize const size = [self.gameBoardView sizeThatFits:boundingSize_inset];

	return CGRectCeilOrigin((CGRect){
		.origin.x	= CGRectGetHorizontallyAlignedXCoordForWidthOnWidth(size.width, boundingSize.width),
		.origin.y	= inset_top,
		.size		= size,
	});
}

#pragma mark - SMBGameBoardView_tileTapDelegate
-(void)gameBoardView:(nonnull SMBGameBoardView*)gameBoardView
	  tile_wasTapped:(nonnull SMBGameBoardTile*)gameBoardTile
{
	/*
	 Refer to document `User facing actions` for details on expected logic.
	 https://docs.google.com/a/shimmur.com/document/d/1XXJqmIBKHtOcW3BhYKM5rFmT7ciu0J8-2ZjjPGTynUg/edit?usp=sharing

	 This is covering: User taps: 2
	 */

	/* User taps: 2.a */
	if (self.gameBoardTileEntityPickerView.selectedGameBoardTileEntitySpawner)
	{
		/* User taps: 2.a... */
		[self gameBoardTileEntityPickerView_selectedGameBoardTileEntitySpawner_spawn_attempt_on_tile:gameBoardTile];

		/* User actions: 5.a */
		if ([self.gameBoardTileEntityPickerView.selectedGameBoardTileEntitySpawner spawnedGameBoardTileEntities_tracked_atCapacity])
		{
			/* User actions: 5.a.i */
			[self.gameBoardTileEntityPickerView setSelectedGameBoardTileEntitySpawner:nil];
		}
	}
	/* User taps: 2.b */
	else
	{
		SMBGameBoardTileEntity* const gameBoardTileEntity = gameBoardTile.gameBoardTileEntity_for_beamInteractions;
		/* User taps: 2.b.i */
		if (gameBoardTileEntity)
		{
			SMBGameBoardTileEntitySpawner* const gameBoardTileEntitySpawner = [self.gameLevel.gameBoardTileEntitySpawnerManager gameBoardTileEntitySpawner_for_entity:gameBoardTileEntity];

			/* User taps: 2.b.i.1 */
			if (gameBoardTileEntitySpawner)
			{
				/* User taps: 2.b.i.1.a */
				if (self.selectedGameBoardTileEntity == gameBoardTileEntity)
				{
					/* User taps: 2.b.i.1.a.i */
					[self setSelectedGameBoardTileEntity:nil];
				}
				/* User taps: 2.b.i.1.b */
				else
				{
					/* User taps: 2.b.i.1.b.i */
					[self setSelectedGameBoardTileEntity:gameBoardTileEntity];
				}
			}
			/* User taps: 2.b.i.2.a */
		}
		/* User taps: 2.b.ii */
		else
		{
			/* User taps: 2.b.ii.1 */
			[self gameBoardTileEntityPickerView_borderColorView_animate];
		}
	}

#if kSMBGameLevelView__beamEntityManager_beamEntity_forMarkingNodesReady_validation_enabled
	[self.gameLevel.gameBoard.beamEntityManager beamEntity_forMarkingNodesReady_isNil_validate];
#endif
}

#pragma mark - KVO
-(void)observeValueForKeyPath:(nullable NSString*)keyPath ofObject:(nullable id)object change:(nullable NSDictionary*)change context:(nullable void*)context
{
	if (context == kSMBGameLevelView__KVOContext_gameBoardTileEntityPickerView)
	{
		if (object == self.gameBoardTileEntityPickerView)
		{
			if ([keyPath isEqualToString:[SMBGameBoardTileEntityPickerView_PropertiesForKVO selectedGameBoardTileEntitySpawner]])
			{
				[self selectedGameBoardTileEntitySpawner_update];
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
	else if (context == kSMBGameLevelView__KVOContext_selectedGameBoardTileEntitySpawner)
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

#pragma mark - selectedGameBoardTileEntity
-(void)setSelectedGameBoardTileEntity:(nullable SMBGameBoardTileEntity*)selectedGameBoardTileEntity
{
	kRUConditionalReturn(self.selectedGameBoardTileEntity_isSetting == YES, YES);
	kRUConditionalReturn(self.selectedGameBoardTileEntity == selectedGameBoardTileEntity, NO);

	[self setSelectedGameBoardTileEntity_isSetting:YES];

	_selectedGameBoardTileEntity = selectedGameBoardTileEntity;

	if (self.selectedGameBoardTileEntity != nil)
	{
		SMBGameBoardTileEntitySpawner* const gameBoardTileEntitySpawner = [self.gameLevel.gameBoardTileEntitySpawnerManager gameBoardTileEntitySpawner_for_entity:self.selectedGameBoardTileEntity];
		[self.gameBoardTileEntityPickerView setSelectedGameBoardTileEntitySpawner:gameBoardTileEntitySpawner];
	}

	[self setSelectedGameBoardTileEntity_isSetting:NO];
}

#pragma mark - selectedGameBoardTileEntitySpawner
-(void)setSelectedGameBoardTileEntitySpawner:(nullable SMBGameBoardTileEntitySpawner*)selectedGameBoardTileEntitySpawner
{
	kRUConditionalReturn(self.gameBoardTileEntityPickerView.selectedGameBoardTileEntitySpawner != selectedGameBoardTileEntitySpawner, YES);
	kRUConditionalReturn(self.selectedGameBoardTileEntitySpawner == selectedGameBoardTileEntitySpawner, NO);

	[self SMBGameLevelView_selectedGameBoardTileEntitySpawner_setKVORegistered:NO];

	_selectedGameBoardTileEntitySpawner = selectedGameBoardTileEntitySpawner;

	[self SMBGameLevelView_selectedGameBoardTileEntitySpawner_setKVORegistered:YES];

	if (self.selectedGameBoardTileEntity_isSetting == false)
	{
		[self setSelectedGameBoardTileEntity:nil];
	}

	/* Make up for methods not called in KVO observe... */
	if (self.selectedGameBoardTileEntitySpawner == nil)
	{
		[self selectedGameBoardTileEntities_update];
	}
}

-(void)selectedGameBoardTileEntitySpawner_update
{
	[self setSelectedGameBoardTileEntitySpawner:[self selectedGameBoardTileEntitySpawner_appropriate]];
}

-(nullable SMBGameBoardTileEntitySpawner*)selectedGameBoardTileEntitySpawner_appropriate
{
	return self.gameBoardTileEntityPickerView.selectedGameBoardTileEntitySpawner;
}

-(void)SMBGameLevelView_selectedGameBoardTileEntitySpawner_setKVORegistered:(BOOL)registered
{
	typeof(self.selectedGameBoardTileEntitySpawner) const selectedGameBoardTileEntitySpawner = self.selectedGameBoardTileEntitySpawner;
	kRUConditionalReturn(selectedGameBoardTileEntitySpawner == nil, NO);

	NSMutableDictionary<NSNumber*,NSMutableArray<NSString*>*>* const KVOOptions_to_propertiesToObserve_mapping = [NSMutableDictionary<NSNumber*,NSMutableArray<NSString*>*> dictionary];

	NSMutableArray<NSString*>* const propertiesToObserve_observe_initial = [NSMutableArray<NSString*> array];
	[propertiesToObserve_observe_initial addObject:[SMBGameBoardTileEntitySpawner_PropertiesForKVO spawnedGameBoardTileEntities_tracked]];
	[KVOOptions_to_propertiesToObserve_mapping setObject:propertiesToObserve_observe_initial forKey:@(NSKeyValueObservingOptionInitial)];

	[KVOOptions_to_propertiesToObserve_mapping enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull KVOOptions_number, NSMutableArray<NSString *> * _Nonnull propertiesToObserve, BOOL * _Nonnull stop) {
		[propertiesToObserve enumerateObjectsUsingBlock:^(NSString * _Nonnull propertyToObserve, NSUInteger idx, BOOL * _Nonnull stop) {
			if (registered)
			{
				[selectedGameBoardTileEntitySpawner addObserver:self
													 forKeyPath:propertyToObserve
														options:(KVOOptions_number.unsignedIntegerValue)
														context:&kSMBGameLevelView__KVOContext_selectedGameBoardTileEntitySpawner];
			}
			else
			{
				[selectedGameBoardTileEntitySpawner removeObserver:self
														forKeyPath:propertyToObserve
														   context:&kSMBGameLevelView__KVOContext_selectedGameBoardTileEntitySpawner];
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

	[self.selectedGameBoardTileEntities enumerateObjectsUsingBlock:^(SMBGameBoardTileEntity * _Nonnull gameBoardTileEntity, BOOL * _Nonnull stop) {
		[self gameBoardTileEntity_update:gameBoardTileEntity isHighlighted:NO];
	}];

	_selectedGameBoardTileEntities = (selectedGameBoardTileEntities ? [NSSet<SMBGameBoardTileEntity*> setWithSet:selectedGameBoardTileEntities] : nil);

	[self.selectedGameBoardTileEntities enumerateObjectsUsingBlock:^(SMBGameBoardTileEntity * _Nonnull gameBoardTileEntity, BOOL * _Nonnull stop) {
		[self gameBoardTileEntity_update:gameBoardTileEntity isHighlighted:YES];
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

#pragma mark - gameBoardTileEntity
-(void)gameBoardTileEntity_update:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
					isHighlighted:(BOOL)isHighlighted
{
	kRUConditionalReturn(gameBoardTileEntity == nil, YES);

	SMBGameBoardTile* const gameBoardTile = gameBoardTileEntity.gameBoardTile;
	kRUConditionalReturn(gameBoardTile == nil, YES);
	
	[gameBoardTile setHighlightColor:
	 (isHighlighted
	  ?
	  (gameBoardTileEntity == self.selectedGameBoardTileEntity
	   ?
	   [UIColor greenColor]
	   :
	   [UIColor smb_selectedTileEntity_color]
	   )
	  :
	  nil
	  )];
}

@end
