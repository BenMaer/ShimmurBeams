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

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/UIView+RUUtility.h>

#define kSMBGameLevelView__beamEntityManager_beamEntity_forMarkingNodesReady_validation_enabled (kSMBEnvironment__SMBGameLevelView_beamEntityManager_beamEntity_forMarkingNodesReady_validation_enabled && 1)

#if kSMBGameLevelView__beamEntityManager_beamEntity_forMarkingNodesReady_validation_enabled
#import "SMBBeamEntityManager.h"
#endif





static void* kSMBGameLevelView__KVOContext = &kSMBGameLevelView__KVOContext;





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
-(void)gameBoardTileEntityPickerView_selectedGameBoardTileEntity_move_to_tile:(nonnull SMBGameBoardTile*)gameBoardTile;

#pragma mark - gameBoardTileEntityPickerView_borderColorView
@property (nonatomic, readonly, strong, nullable) UIView* gameBoardTileEntityPickerView_borderColorView;
-(CGRect)gameBoardTileEntityPickerView_borderColorView_frame;

@property (nonatomic, strong, nullable) NSObject* gameBoardTileEntityPickerView_borderColorView_animationPointer;
-(void)gameBoardTileEntityPickerView_borderColorView_animate;
-(void)gameBoardTileEntityPickerView_borderColorView_animate_to_highlightedColor_with_animationPointer:(nonnull NSObject*)animationPointer;
-(void)gameBoardTileEntityPickerView_borderColorView_animate_back_with_animationPointer:(nonnull NSObject*)animationPointer;
-(void)gameBoardTileEntityPickerView_borderColorView_animate_cancel;
-(void)gameBoardTileEntityPickerView_borderColorView_alpha_update_selected:(BOOL)selected;

#pragma mark - gameBoardTile
@property (nonatomic, strong, nullable) SMBGameBoardTile* gameBoardTile_selected;
-(void)gameBoardTile_selected_update;
-(nullable SMBGameBoardTile*)gameBoardTile_selected_appropriate;

@end





@implementation SMBGameLevelView

#pragma mark - NSObject
-(void)dealloc
{
	[self gameBoardTileEntityPickerView_setKVORegistered:NO];
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
		.width		= CGRectGetWidth(gameBoardTileEntityPickerView_frame),
		.height		= CGRectGetMaxY(gameBoardTileEntityPickerView_frame),
	};
}

#pragma mark - gameLevel
-(void)setGameLevel:(nullable SMBGameLevel*)gameLevel
{
	kRUConditionalReturn(self.gameLevel == gameLevel, NO);

	_gameLevel = gameLevel;

	[self.gameBoardTileEntityPickerView setGameBoardTileEntities:self.gameLevel.usableGameBoardTileEntities];
	[self.gameBoardView setGameBoard:self.gameLevel.gameBoard];

#if kSMBGameLevelView__beamEntityManager_beamEntity_forMarkingNodesReady_validation_enabled
	[self.gameLevel.gameBoard.beamEntityManager beamEntity_forMarkingNodesReady_isNil_validate];
#endif
}

#pragma mark - content_inset
-(CGFloat)content_inset
{
	return 10.0f;
}

#pragma mark - gameBoardTileEntityPickerView
-(void)gameBoardTileEntityPickerView_setKVORegistered:(BOOL)registered
{
	typeof(self.gameBoardTileEntityPickerView) const gameBoardTileEntityPickerView = self.gameBoardTileEntityPickerView;
	kRUConditionalReturn(gameBoardTileEntityPickerView == nil, NO);
	
	NSMutableArray<NSString*>* const propertiesToObserve = [NSMutableArray<NSString*> array];
	[propertiesToObserve addObject:[SMBGameBoardTileEntityPickerView_PropertiesForKVO selectedGameBoardTileEntity]];
	
	[propertiesToObserve enumerateObjectsUsingBlock:^(NSString * _Nonnull propertyToObserve, NSUInteger idx, BOOL * _Nonnull stop) {
		if (registered)
		{
			[gameBoardTileEntityPickerView addObserver:self
											forKeyPath:propertyToObserve
											   options:(NSKeyValueObservingOptionInitial)
											   context:&kSMBGameLevelView__KVOContext];
		}
		else
		{
			[gameBoardTileEntityPickerView removeObserver:self
											   forKeyPath:propertyToObserve
												  context:&kSMBGameLevelView__KVOContext];
		}
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
	CGFloat const height = 80.0f;

	return CGRectCeilOrigin((CGRect){
		.origin.y		= gameBoardView_frame_maxY + 20.0f,
		.size.width		= boundingWidth,
		.size.height	= height,
	});
}

-(void)gameBoardTileEntityPickerView_selectedGameBoardTileEntity_move_to_tile:(nonnull SMBGameBoardTile*)gameBoardTile
{
	kRUConditionalReturn(gameBoardTile == nil, YES);
	
	SMBGameBoardTileEntity* const gameBoardTileEntityPickerView_selectedGameBoardTileEntity = self.gameBoardTileEntityPickerView.selectedGameBoardTileEntity;
	kRUConditionalReturn(gameBoardTileEntityPickerView_selectedGameBoardTileEntity == nil, NO);

	SMBGameBoardTileEntity* const gameBoardTileEntity_for_beamInteractions_old = gameBoardTile.gameBoardTileEntity_for_beamInteractions;
	kRUConditionalReturn((gameBoardTileEntity_for_beamInteractions_old != nil)
						 &&
						 ([self.gameBoardTileEntityPickerView.gameBoardTileEntities containsObject:gameBoardTileEntity_for_beamInteractions_old] == false), NO);

	[gameBoardTile gameBoardTileEntities_add:gameBoardTileEntityPickerView_selectedGameBoardTileEntity
								  entityType:SMBGameBoardTile__entityType_beamInteractions];

	[self.gameBoardTileEntityPickerView setSelectedGameBoardTileEntity:nil];
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
	/**
	 If we are tapping a game board tile, and `gameBoardTileEntityPickerView` has a non nil `selectedGameBoardTileEntity`, let's move that `selectedGameBoardTileEntity` to the game board tile.
	 */
	if (self.gameBoardTileEntityPickerView.selectedGameBoardTileEntity)
	{
		[self gameBoardTileEntityPickerView_selectedGameBoardTileEntity_move_to_tile:gameBoardTile];
		return;
	}

	SMBGameBoardTileEntity* const gameBoardTileEntity = gameBoardTile.gameBoardTileEntity_for_beamInteractions;
	if ((gameBoardTileEntity == nil)
		||
		([self.gameLevel.usableGameBoardTileEntities containsObject:gameBoardTileEntity] == false))
	{
		[self gameBoardTileEntityPickerView_borderColorView_animate];
		return;
	}

	[self.gameBoardTileEntityPickerView setSelectedGameBoardTileEntity:gameBoardTileEntity];
	
#if kSMBGameLevelView__beamEntityManager_beamEntity_forMarkingNodesReady_validation_enabled
	[self.gameLevel.gameBoard.beamEntityManager beamEntity_forMarkingNodesReady_isNil_validate];
#endif
}

#pragma mark - KVO
-(void)observeValueForKeyPath:(nullable NSString*)keyPath ofObject:(nullable id)object change:(nullable NSDictionary*)change context:(nullable void*)context
{
	if (context == kSMBGameLevelView__KVOContext)
	{
		if (object == self.gameBoardTileEntityPickerView)
		{
			if ([keyPath isEqualToString:[SMBGameBoardTileEntityPickerView_PropertiesForKVO selectedGameBoardTileEntity]])
			{
				[self gameBoardTile_selected_update];
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

#pragma mark - gameBoardTile
-(void)setGameBoardTile_selected:(nullable SMBGameBoardTile*)gameBoardTile_selected
{
	kRUConditionalReturn(self.gameBoardTile_selected == gameBoardTile_selected, NO);

	if (self.gameBoardTile_selected)
	{
		[self.gameBoardTile_selected setIsHighlighted:NO];
	}

	_gameBoardTile_selected = gameBoardTile_selected;

	if (self.gameBoardTile_selected)
	{
		[self.gameBoardTile_selected setIsHighlighted:YES];
	}
}

-(void)gameBoardTile_selected_update
{
	[self setGameBoardTile_selected:[self gameBoardTile_selected_appropriate]];
}

-(nullable SMBGameBoardTile*)gameBoardTile_selected_appropriate
{
	SMBGameBoardTileEntityPickerView* const gameBoardTileEntityPickerView = self.gameBoardTileEntityPickerView;
	kRUConditionalReturn_ReturnValueNil(gameBoardTileEntityPickerView == nil, YES);

	SMBGameBoardTileEntity* const selectedGameBoardTileEntity = gameBoardTileEntityPickerView.selectedGameBoardTileEntity;
	kRUConditionalReturn_ReturnValueNil(selectedGameBoardTileEntity == nil, NO);

	return selectedGameBoardTileEntity.gameBoardTile;
}

@end
