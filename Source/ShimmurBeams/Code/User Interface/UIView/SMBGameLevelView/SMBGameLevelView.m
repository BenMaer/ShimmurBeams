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
#import "SMBGameLevelView_UserSelection.h"
#import "SMBGameLevelView_UserSelection_GameBoardTile_HighlightData.h"
#import "SMBMoveEntityToTileGameBoardMove.h"
#import "SMBSpawnEntityOnTileGameBoardMove.h"
#import "SMBRemoveEntityFromTileGameBoardMove.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/UIView+RUUtility.h>
#import <ResplendentUtilities/RUClassOrNilUtil.h>


#define kSMBGameLevelView__beamEntityManager_beamEntity_forMarkingNodesReady_validation_enabled (kSMBEnvironment__SMBGameLevelView_beamEntityManager_beamEntity_forMarkingNodesReady_validation_enabled && 1)

#if kSMBGameLevelView__beamEntityManager_beamEntity_forMarkingNodesReady_validation_enabled
#import "SMBBeamEntityManager.h"
#endif





static void* kSMBGameLevelView__KVOContext_gameLevelView_UserSelection = &kSMBGameLevelView__KVOContext_gameLevelView_UserSelection;





@interface SMBGameLevelView () <SMBGameBoardView_tileTapDelegate, SMBGameBoardTileEntityPickerView__GameBoardTileEntitySpawner_TapDelegate, SMBGameBoardTileEntityPickerView__TrashButton_TapDelegate>

#pragma mark - content_inset
-(CGFloat)content_inset;

#pragma mark - gameBoardView
@property (nonatomic, readonly, strong, nullable) SMBGameBoardView* gameBoardView;
-(CGRect)gameBoardView_frame;
-(CGRect)gameBoardView_frame_with_boundingSize:(CGSize)boundingSize;

#pragma mark - gameBoard
-(void)gameBoard_move_perform:(nonnull id<SMBGameBoardMove>)gameBoardMove;

#pragma mark - gameBoardTileEntityPickerView
@property (nonatomic, strong, nullable) SMBGameBoardTileEntityPickerView* gameBoardTileEntityPickerView;
-(void)gameBoardTileEntityPickerView_generate;
-(CGRect)gameBoardTileEntityPickerView_frame;
-(CGRect)gameBoardTileEntityPickerView_frame_with_boundingWidth:(CGFloat)boundingWidth
									   gameBoardView_frame_maxY:(CGFloat)gameBoardView_frame_maxY;
-(void)gameBoardTileEntityPickerView_selectedGameBoardTileEntitySpawner_update_from_gameLevelView_UserSelection;
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

#pragma mark - gameLevelView_UserSelection
@property (nonatomic, strong, nullable) SMBGameLevelView_UserSelection* gameLevelView_UserSelection;
-(void)gameLevelView_UserSelection_setKVORegistered:(BOOL)registered;

-(void)gameLevelView_UserSelection_update_from_selectedGameBoardTileEntity:(nullable SMBGameBoardTileEntity*)selectedGameBoardTileEntity;
-(void)gameLevelView_UserSelection_update_from_selectedGameBoardTileEntitySpawner:(nullable SMBGameBoardTileEntitySpawner*)selectedGameBoardTileEntitySpawner;

-(void)gameLevelView_UserSelection_removeSelectedEntitiesFromBoard;

#pragma mark - selectedGameBoardTiles_HighlightData
@property (nonatomic, copy, nullable) NSSet<SMBGameLevelView_UserSelection_GameBoardTile_HighlightData*>* selectedGameBoardTiles_HighlightData;
-(void)selectedGameBoardTiles_HighlightData_update;

#pragma mark - gameBoardTile
-(void)gameBoardTile_update_from_highlightData:(nonnull SMBGameLevelView_UserSelection_GameBoardTile_HighlightData*)gameBoardTile_HighlightData
								 isHighlighted:(BOOL)isHighlighted;

#pragma mark - gameBoardTileEntitySpawners
-(void)gameBoardTileEntitySpawners_removeAllEntitiesFromTiles;

#pragma mark - gameBoardTileEntities
-(void)gameBoardTileEntity_removeFromTile:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity;

@end





@implementation SMBGameLevelView

#pragma mark - NSObject
-(void)dealloc
{
	[self gameLevelView_UserSelection_setKVORegistered:NO];
}

#pragma mark - UIView
-(instancetype)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame])
	{
		[self setBackgroundColor:[UIColor clearColor]];

		[self gameBoardTileEntityPickerView_generate];

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

	[self setGameLevelView_UserSelection:nil];

	[self gameBoardTileEntityPickerView_generate];
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
-(void)setGameBoardTileEntityPickerView:(nullable SMBGameBoardTileEntityPickerView*)gameBoardTileEntityPickerView
{
	kRUConditionalReturn(self.gameBoardTileEntityPickerView == gameBoardTileEntityPickerView, NO);

	if (self.gameBoardTileEntityPickerView)
	{
		[self.gameBoardTileEntityPickerView removeFromSuperview];
	}

	_gameBoardTileEntityPickerView = gameBoardTileEntityPickerView;

	if (self.gameBoardTileEntityPickerView)
	{
		[self addSubview:self.gameBoardTileEntityPickerView];
	}
}

-(void)gameBoardTileEntityPickerView_generate
{
	SMBGameBoardTileEntityPickerView* const gameBoardTileEntityPickerView = [SMBGameBoardTileEntityPickerView new];
	[gameBoardTileEntityPickerView setBackgroundColor:[UIColor clearColor]];
	[gameBoardTileEntityPickerView setGameBoardTileEntitySpawner_tapDelegate:self];
	[gameBoardTileEntityPickerView setTrashButton_tapDelegate:self];

	[self setGameBoardTileEntityPickerView:gameBoardTileEntityPickerView];
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

-(void)gameBoardTileEntityPickerView_selectedGameBoardTileEntitySpawner_update_from_gameLevelView_UserSelection
{
	[self.gameBoardTileEntityPickerView setSelectedGameBoardTileEntitySpawner:self.gameLevelView_UserSelection.selectedGameBoardTileEntitySpawner];
}

-(void)gameBoardTileEntityPickerView_selectedGameBoardTileEntitySpawner_spawn_attempt_on_tile:(nonnull SMBGameBoardTile*)gameBoardTile
{
	/*
	 Refer to document `User facing actions` for details on expected logic.
	 https://docs.google.com/a/shimmur.com/document/d/1XXJqmIBKHtOcW3BhYKM5rFmT7ciu0J8-2ZjjPGTynUg/edit?usp=sharing

	 This is covering User actions:
	 - 5

	 Coming from User taps:
	 - 2.b.i.1
	 */

	kRUConditionalReturn(gameBoardTile == nil, YES);

	SMBGameBoardTileEntitySpawner* const gameBoardTileEntityPickerView_selectedGameBoardTileEntitySpawner = self.gameBoardTileEntityPickerView.selectedGameBoardTileEntitySpawner;
	kRUConditionalReturn(gameBoardTileEntityPickerView_selectedGameBoardTileEntitySpawner == nil, YES);

	SMBSpawnEntityOnTileGameBoardMove* const spawnEntityOnTileGameBoardMove =
	[[SMBSpawnEntityOnTileGameBoardMove alloc] init_with_gameBoardTilePosition:gameBoardTile.gameBoardTilePosition
													gameBoardTileEntitySpawner:gameBoardTileEntityPickerView_selectedGameBoardTileEntitySpawner];
	
	[self gameBoard_move_perform:spawnEntityOnTileGameBoardMove];

	[self gameLevelView_UserSelection_update_from_selectedGameBoardTileEntitySpawner:gameBoardTileEntityPickerView_selectedGameBoardTileEntitySpawner];
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

#pragma mark - gameBoard
-(void)gameBoard_move_perform:(nonnull id<SMBGameBoardMove>)gameBoardMove
{
	kRUConditionalReturn(gameBoardMove == nil, YES);
	
	SMBGameBoard* const gameBoard = self.gameBoardView.gameBoard;
	kRUConditionalReturn(gameBoard == nil, YES);
	
	[gameBoard gameBoardMove_perform:gameBoardMove];
}

#pragma mark - SMBGameBoardView_tileTapDelegate
-(void)gameBoardView:(nonnull SMBGameBoardView*)gameBoardView
	  tile_wasTapped:(nonnull SMBGameBoardTile*)gameBoardTile
{
	/*
	 Refer to flowchart `Game Level user interactions` for details on expected logic.
	 https://drive.google.com/open?id=1Z5-msMLVy2HWi4XcrrWzJ6bWIYCU_Bz0

	 This is covering:
	  - Tap game level view
	   - 2)
	 */

	SMBGameBoardTileEntity* const gameBoardTileEntity = gameBoardTile.gameBoardTileEntity_for_beamInteractions;
	/*
	 Game Level user interactions - Tap game level view - 2.a) Does the board tile have an entity for beam interactions?
	 Game Level user interactions - Tap game level view - 2.a.i) Yes
	 */
	if (gameBoardTileEntity)
	{
		SMBGameBoardTileEntitySpawner* const gameBoardTileEntitySpawner = [self.gameLevel.gameBoardTileEntitySpawnerManager gameBoardTileEntitySpawner_for_entity:gameBoardTileEntity];
		/*
		 Game Level user interactions - Tap game level view - 2.a.i.1) Was that entity spawned from an entity spawner?
		 Game Level user interactions - Tap game level view - 2.a.i.1.a) Yes
		 */
		if (gameBoardTileEntitySpawner)
		{
			SMBGameLevelView_UserSelection* const gameLevelView_UserSelection = self.gameLevelView_UserSelection;
			/*
			 Game Level user interactions - Tap game level view - 2.a.i.1.a.i) Is that entity selected?
			 Game Level user interactions - Tap game level view - 2.a.i.1.a.i.1) Is that entity selected?
			 */
			if ((gameLevelView_UserSelection != nil)
				&&
				(gameLevelView_UserSelection.selectedGameBoardTileEntity == gameBoardTileEntity))
			{
				/*
				 Game Level user interactions - Tap game level view - 2.a.i.1.a.i.1.a) Deselect that entity
				 */
				[self gameLevelView_UserSelection_update_from_selectedGameBoardTileEntity:nil];
			}
			/*
			 Game Level user interactions - Tap game level view - 2.a.i.1.a.i.2) No
			 */
			else
			{
				/*
				 Game Level user interactions - Tap game level view - 2.a.i.1.a.i.2.a) Select that entity
				 */
				[self gameLevelView_UserSelection_update_from_selectedGameBoardTileEntity:gameBoardTileEntity];
			}
		}
		/*
		 Game Level user interactions - Tap game level view - 2.a.i.1.b) No
		 Game Level user interactions - Tap game level view - 2.a.i.1.b.i) Do Nothing
		 */
	}
	/*
	 Game Level user interactions - Tap game level view - 2.a.ii) No
	 */
	else
	{
		SMBGameLevelView_UserSelection* const gameLevelView_UserSelection = self.gameLevelView_UserSelection;
		SMBGameBoardTileEntity* const selectedGameBoardTileEntity = gameLevelView_UserSelection.selectedGameBoardTileEntity;
		/*
		 Game Level user interactions - Tap game level view - 2.a.ii.1) Is an entity selected?
		 Game Level user interactions - Tap game level view - 2.a.ii.1.a) Yes
		 */
		if (selectedGameBoardTileEntity)
		{
			/*
			 Game Level user interactions - Tap game level view - 2.a.ii.1.a.i) Move the selected entity to this tile.
			 */
			SMBMoveEntityToTileGameBoardMove* const moveEntityToTileGameBoardMove =
			[[SMBMoveEntityToTileGameBoardMove alloc] init_with_gameBoardTilePosition:gameBoardTile.gameBoardTilePosition
																  gameBoardTileEntity:selectedGameBoardTileEntity];

			[self gameBoard_move_perform:moveEntityToTileGameBoardMove];
		}
		/*
		 Game Level user interactions - Tap game level view - 2.a.ii.1.b) No
		 */
		else
		{
			SMBGameBoardTileEntitySpawner* const selectedGameBoardTileEntitySpawner = gameLevelView_UserSelection.selectedGameBoardTileEntitySpawner;
			/*
			 Game Level user interactions - Tap game level view - 2.a.ii.1.b.i) Is an entity spawner selected?
			 Game Level user interactions - Tap game level view - 2.a.ii.1.b.i.1) Yes
			 */
			if (selectedGameBoardTileEntitySpawner)
			{
				/*
				 Game Level user interactions - Tap game level view - 2.a.ii.1.b.i.1.a) Spawn an entity on that tile.
				 */
				[self gameBoardTileEntityPickerView_selectedGameBoardTileEntitySpawner_spawn_attempt_on_tile:gameBoardTile];
			}
			/*
			 Game Level user interactions - Tap game level view - 2.a.ii.1.b.i.2) No
			 */
			else
			{
				/*
				 Game Level user interactions - Tap game level view - 2.a.ii.1.b.i.2.a) Animate the picker view
				 */
				[self gameBoardTileEntityPickerView_borderColorView_animate];
			}
		}
	}

#if kSMBGameLevelView__beamEntityManager_beamEntity_forMarkingNodesReady_validation_enabled
	[self.gameLevel.gameBoard.beamEntityManager beamEntity_forMarkingNodesReady_isNil_validate];
#endif
}

#pragma mark - KVO
-(void)observeValueForKeyPath:(nullable NSString*)keyPath ofObject:(nullable id)object change:(nullable NSDictionary*)change context:(nullable void*)context
{
	if (context == kSMBGameLevelView__KVOContext_gameLevelView_UserSelection)
	{
		if (object == self.gameLevelView_UserSelection)
		{
			if ([keyPath isEqualToString:[SMBGameLevelView_UserSelection_PropertiesForKVO selectedGameBoardTiles_HighlightData]])
			{
				[self selectedGameBoardTiles_HighlightData_update];
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

#pragma mark - gameLevelView_UserSelection
-(void)setGameLevelView_UserSelection:(nullable SMBGameLevelView_UserSelection*)gameLevelView_UserSelection
{
	kRUConditionalReturn(self.gameLevelView_UserSelection == gameLevelView_UserSelection, NO);

	[self gameLevelView_UserSelection_setKVORegistered:NO];

	_gameLevelView_UserSelection = gameLevelView_UserSelection;

	[self gameLevelView_UserSelection_setKVORegistered:YES];

	[self selectedGameBoardTiles_HighlightData_update];
	[self gameBoardTileEntityPickerView_selectedGameBoardTileEntitySpawner_update_from_gameLevelView_UserSelection];
}

-(void)gameLevelView_UserSelection_setKVORegistered:(BOOL)registered
{
	typeof(self.gameLevelView_UserSelection) const gameLevelView_UserSelection = self.gameLevelView_UserSelection;
	kRUConditionalReturn(gameLevelView_UserSelection == nil, NO);

	NSMutableDictionary<NSNumber*,NSMutableArray<NSString*>*>* const KVOOptions_to_propertiesToObserve_mapping = [NSMutableDictionary<NSNumber*,NSMutableArray<NSString*>*> dictionary];

	NSMutableArray<NSString*>* const propertiesToObserve = [NSMutableArray<NSString*> array];
	[propertiesToObserve addObject:[SMBGameLevelView_UserSelection_PropertiesForKVO selectedGameBoardTiles_HighlightData]];
	[KVOOptions_to_propertiesToObserve_mapping setObject:propertiesToObserve forKey:@(0)];

	[KVOOptions_to_propertiesToObserve_mapping enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull KVOOptions_number, NSMutableArray<NSString *> * _Nonnull propertiesToObserve, BOOL * _Nonnull stop) {
		[propertiesToObserve enumerateObjectsUsingBlock:^(NSString * _Nonnull propertyToObserve, NSUInteger idx, BOOL * _Nonnull stop) {
			if (registered)
			{
				[gameLevelView_UserSelection addObserver:self
											  forKeyPath:propertyToObserve
												 options:(KVOOptions_number.unsignedIntegerValue)
												 context:&kSMBGameLevelView__KVOContext_gameLevelView_UserSelection];
			}
			else
			{
				[gameLevelView_UserSelection removeObserver:self
												 forKeyPath:propertyToObserve
													context:&kSMBGameLevelView__KVOContext_gameLevelView_UserSelection];
			}
		}];
	}];
}

-(void)gameLevelView_UserSelection_update_from_selectedGameBoardTileEntity:(nullable SMBGameBoardTileEntity*)selectedGameBoardTileEntity
{
	[self setGameLevelView_UserSelection:
	 (selectedGameBoardTileEntity
	  ?
	  [[SMBGameLevelView_UserSelection alloc] init_with_gameBoardTileEntitySpawnerManager:self.gameLevel.gameBoardTileEntitySpawnerManager
															  selectedGameBoardTileEntity:selectedGameBoardTileEntity]
	  :
	  nil
	 )];
}

-(void)gameLevelView_UserSelection_update_from_selectedGameBoardTileEntitySpawner:(nullable SMBGameBoardTileEntitySpawner*)selectedGameBoardTileEntitySpawner
{
	[self setGameLevelView_UserSelection:
	 (selectedGameBoardTileEntitySpawner
	  ?
	  [[SMBGameLevelView_UserSelection alloc] init_with_gameBoardTileEntitySpawnerManager:self.gameLevel.gameBoardTileEntitySpawnerManager
													   selectedGameBoardTileEntitySpawner:selectedGameBoardTileEntitySpawner]
	  :
	  nil
	  )];
}

-(void)gameLevelView_UserSelection_removeSelectedEntitiesFromBoard
{
	SMBGameLevelView_UserSelection* const gameLevelView_UserSelection = self.gameLevelView_UserSelection;
	kRUConditionalReturn(gameLevelView_UserSelection == nil, YES);

	SMBGameBoardTileEntity* const selectedGameBoardTileEntity = gameLevelView_UserSelection.selectedGameBoardTileEntity;
	/* 3.a */
	/* 3.a.i */
	if (selectedGameBoardTileEntity)
	{
		
		/* 3.a.i.1 */
		[self gameBoardTileEntity_removeFromTile:selectedGameBoardTileEntity];
	}
	/* 3.a.ii.1.a */
	else
	{
		SMBGameBoardTileEntitySpawner* const selectedGameBoardTileEntitySpawner = gameLevelView_UserSelection.selectedGameBoardTileEntitySpawner;
		kRUConditionalReturn(selectedGameBoardTileEntitySpawner == nil, YES);

		/* 3.a.ii.1.a.i */
		[[selectedGameBoardTileEntitySpawner spawnedGameBoardTileEntities_tracked] enumerateObjectsUsingBlock:^(SMBGameBoardTileEntity * _Nonnull gameBoardTileEntity, NSUInteger idx, BOOL * _Nonnull stop) {
			[self gameBoardTileEntity_removeFromTile:gameBoardTileEntity];
		}];
	}
}

#pragma mark - selectedGameBoardTiles_HighlightData
-(void)setSelectedGameBoardTiles_HighlightData:(nullable NSSet<SMBGameLevelView_UserSelection_GameBoardTile_HighlightData*>*)selectedGameBoardTiles_HighlightData
{
	kRUConditionalReturn((self.selectedGameBoardTiles_HighlightData == selectedGameBoardTiles_HighlightData)
						 ||
						 [self.selectedGameBoardTiles_HighlightData isEqual:selectedGameBoardTiles_HighlightData], NO);

	[self.selectedGameBoardTiles_HighlightData enumerateObjectsUsingBlock:^(SMBGameLevelView_UserSelection_GameBoardTile_HighlightData * _Nonnull gameBoardTile_HighlightData, BOOL * _Nonnull stop) {
		[self gameBoardTile_update_from_highlightData:gameBoardTile_HighlightData isHighlighted:NO];
	}];

	_selectedGameBoardTiles_HighlightData = (selectedGameBoardTiles_HighlightData ? [NSSet<SMBGameLevelView_UserSelection_GameBoardTile_HighlightData*> setWithSet:selectedGameBoardTiles_HighlightData] : nil);

	[self.selectedGameBoardTiles_HighlightData enumerateObjectsUsingBlock:^(SMBGameLevelView_UserSelection_GameBoardTile_HighlightData * _Nonnull gameBoardTile_HighlightData, BOOL * _Nonnull stop) {
		[self gameBoardTile_update_from_highlightData:gameBoardTile_HighlightData isHighlighted:YES];
	}];
}

-(void)selectedGameBoardTiles_HighlightData_update
{
	[self setSelectedGameBoardTiles_HighlightData:[self.gameLevelView_UserSelection selectedGameBoardTiles_HighlightData]];
}

#pragma mark - gameBoardTile
-(void)gameBoardTile_update_from_highlightData:(nonnull SMBGameLevelView_UserSelection_GameBoardTile_HighlightData*)gameBoardTile_HighlightData
								 isHighlighted:(BOOL)isHighlighted
{
	kRUConditionalReturn(gameBoardTile_HighlightData == nil, YES);

	SMBGameBoardTile* const gameBoardTile = gameBoardTile_HighlightData.gameBoardTile;
	kRUConditionalReturn(gameBoardTile == nil, YES);

	[gameBoardTile setHighlightColor:
	 (isHighlighted
	  ?
	  gameBoardTile_HighlightData.highlightColor
	  :
	  nil
	  )];
}

#pragma mark - SMBGameBoardTileEntityPickerView__GameBoardTileEntitySpawner_TapDelegate
-(void)gameBoardTileEntityPickerView:(nonnull SMBGameBoardTileEntityPickerView*)gameBoardTileEntityPickerView
   didTap_gameBoardTileEntitySpawner:(nonnull SMBGameBoardTileEntitySpawner*)gameBoardTileEntitySpawner
{
	kRUConditionalReturn(gameBoardTileEntitySpawner == nil, YES);

	/*
	 Refer to document `User facing actions` for details on expected logic.
	 https://docs.google.com/a/shimmur.com/document/d/1XXJqmIBKHtOcW3BhYKM5rFmT7ciu0J8-2ZjjPGTynUg/edit?usp=sharing

	 This is covering: User taps: 1)
	 */

	SMBGameLevelView_UserSelection* const gameLevelView_UserSelection = self.gameLevelView_UserSelection;
	/* User actions: 1.a) */
	/* User actions: 1.a.i) */
	if ((gameLevelView_UserSelection != nil)
		&&
		(gameLevelView_UserSelection.selectedGameBoardTileEntitySpawner == gameBoardTileEntitySpawner)
		)
	{
		/* User actions: 1.a.i.1) */
		/* User actions: 1.a.i.1.a) */
		if (gameLevelView_UserSelection.selectedGameBoardTileEntity)
		{
			/* User actions: 1.a.i.1.a.i) */
			[self gameLevelView_UserSelection_update_from_selectedGameBoardTileEntitySpawner:gameBoardTileEntitySpawner];
		}
		/* User actions: 1.a.i.1.b) */
		else
		{
			/* User actions: 1.a.i.1.b.i) */
			[self gameLevelView_UserSelection_update_from_selectedGameBoardTileEntitySpawner:nil];
		}
	}
	/* User actions: 1.a.ii) */
	else
	{
		[self gameLevelView_UserSelection_update_from_selectedGameBoardTileEntitySpawner:gameBoardTileEntitySpawner];
	}
}

#pragma mark - SMBGameBoardTileEntityPickerView__TrashButton_TapDelegate
-(void)gameBoardTileEntityPickerView:(nonnull SMBGameBoardTileEntityPickerView*)gameBoardTileEntityPickerView
		didTap_trashButton_with_type:(SMBGameBoardTileEntityPickerView__trashButton_type)trashButton_type
{
	switch (trashButton_type)
	{
		case SMBGameBoardTileEntityPickerView__trashButton_type_none:
			NSAssert(false, @"unhandled trashButton_type %li",(long)trashButton_type);
			break;
			
		case SMBGameBoardTileEntityPickerView__trashButton_type_clearBoard:
			/* 3.a.ii.1.b.i */
			[self gameBoardTileEntitySpawners_removeAllEntitiesFromTiles];
			break;
			
		case SMBGameBoardTileEntityPickerView__trashButton_type_remove:
			[self gameLevelView_UserSelection_removeSelectedEntitiesFromBoard];
			break;
	}

	[self setGameLevelView_UserSelection:nil];
}

#pragma mark - gameBoardTileEntitySpawners
-(void)gameBoardTileEntitySpawners_removeAllEntitiesFromTiles
{
	[self.gameLevel.gameBoardTileEntitySpawnerManager.gameBoardTileEntitySpawners enumerateObjectsUsingBlock:^(SMBGameBoardTileEntitySpawner * _Nonnull gameBoardTileEntitySpawner, NSUInteger idx, BOOL * _Nonnull stop) {
		[[gameBoardTileEntitySpawner spawnedGameBoardTileEntities_tracked] enumerateObjectsUsingBlock:^(SMBGameBoardTileEntity * _Nonnull gameBoardTileEntity, NSUInteger idx, BOOL * _Nonnull stop) {
			[self gameBoardTileEntity_removeFromTile:gameBoardTileEntity];
		}];
	}];

}

#pragma mark - gameBoardTileEntities
-(void)gameBoardTileEntity_removeFromTile:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
{
	kRUConditionalReturn(gameBoardTileEntity == nil, YES);

	SMBRemoveEntityFromTileGameBoardMove* const removeEntityFromTileGameBoardMove =
	[[SMBRemoveEntityFromTileGameBoardMove alloc] init_with_gameBoardTileEntity:gameBoardTileEntity];

	[self gameBoard_move_perform:removeEntityFromTileGameBoardMove];
}

@end
