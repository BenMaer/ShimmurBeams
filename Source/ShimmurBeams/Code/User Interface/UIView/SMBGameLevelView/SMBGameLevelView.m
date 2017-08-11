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
-(CGRect)gameBoardTileEntityPickerView_frame_with_boundingSize:(CGSize)boundingSize;

#pragma mark - gameBoardTileEntity_toMove
-(void)gameBoardTileEntityPickerView_selectedGameBoardTileEntity_move_to_tile:(nonnull SMBGameBoardTile*)gameBoardTile;

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
		[self gameBoardTileEntityPickerView_setKVORegistered:YES];
		[self addSubview:self.gameBoardTileEntityPickerView];

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

	[self.gameBoardView setFrame:[self gameBoardView_frame]];
}

-(CGSize)sizeThatFits:(CGSize)size
{
	CGRect const gameBoardTileEntityPickerView_frame = [self gameBoardTileEntityPickerView_frame_with_boundingSize:size];

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
	return
	[self gameBoardTileEntityPickerView_frame_with_boundingSize:self.bounds.size];
}

-(CGRect)gameBoardTileEntityPickerView_frame_with_boundingSize:(CGSize)boundingSize
{
	CGSize const gameBoardView_tileSize = [self gameBoardView_tileSize_with_boundingSize:boundingSize];

	return CGRectCeilOrigin((CGRect){
		.origin.y		= CGRectGetMaxY([self gameBoardView_frame_with_boundingSize:boundingSize]) + 20.0f,
		.size.width		= boundingSize.width,
		.size.height	= gameBoardView_tileSize.height,
	});
}

-(void)gameBoardTileEntityPickerView_selectedGameBoardTileEntity_move_to_tile:(nonnull SMBGameBoardTile*)gameBoardTile
{
	kRUConditionalReturn(gameBoardTile == nil, YES);
	
	SMBGameBoardTileEntity* const selectedGameBoardTileEntity = self.gameBoardTileEntityPickerView.selectedGameBoardTileEntity;
	kRUConditionalReturn(selectedGameBoardTileEntity == nil, NO);

	SMBGameBoardTile* const gameBoardTile_old = selectedGameBoardTileEntity.gameBoardTile;
	if (gameBoardTile_old)
	{
		kRUConditionalReturn(gameBoardTile_old.gameBoardTileEntity_for_beamInteractions != selectedGameBoardTileEntity, YES);
		[gameBoardTile_old setGameBoardTileEntity_for_beamInteractions:nil];
	}

	SMBGameBoardTileEntity* const gameBoardTileEntity_for_beamInteractions = gameBoardTile.gameBoardTileEntity_for_beamInteractions;
	/**
	 If the tile has has beam interaction, and it's pickable, let's take it off the tile so the new one can be added.
	 */
	if ((gameBoardTileEntity_for_beamInteractions != nil)
		&&
		[self.gameLevel.usableGameBoardTileEntities containsObject:gameBoardTileEntity_for_beamInteractions])
	{
		[gameBoardTile setGameBoardTileEntity_for_beamInteractions:nil];
	}

	[gameBoardTile setGameBoardTileEntity_for_beamInteractions:selectedGameBoardTileEntity];

	[self.gameBoardTileEntityPickerView setSelectedGameBoardTileEntity:nil];
}

#pragma mark - gameBoardView
-(CGRect)gameBoardView_frame
{
	return
	[self gameBoardView_frame_with_boundingSize:self.bounds.size];
}

-(CGRect)gameBoardView_frame_with_boundingSize:(CGSize)boundingSize
{
	CGFloat const inset = [self content_inset];

	CGSize const boundingSize_inset = (CGSize){
		.width		= boundingSize.width - (inset * 2.0f),
		.height		= boundingSize.height - (inset * 2.0f),
	};

	CGSize const gameBoardView_tileSize = [self gameBoardView_tileSize_with_boundingSize:boundingSize_inset];

	NSUInteger const numberOfColumns = [self.gameLevel.gameBoard gameBoardTiles_numberOfColumns];
	NSUInteger const numberOfRows = [self.gameLevel.gameBoard gameBoardTiles_numberOfRows];

	CGFloat const width = gameBoardView_tileSize.width * (CGFloat)numberOfColumns;
	CGFloat const height = gameBoardView_tileSize.height * (CGFloat)numberOfRows;

	return CGRectCeilOrigin((CGRect){
		.origin.x		= CGRectGetHorizontallyAlignedXCoordForWidthOnWidth(width, boundingSize.width),
		.size.width		= width,
		.size.height	= height,
	});;
}

-(CGSize)gameBoardView_tileSize_with_boundingSize:(CGSize)boundingSize
{
	CGFloat const inset = [self content_inset];

	NSUInteger const numberOfColumns = [self.gameLevel.gameBoard gameBoardTiles_numberOfColumns];
	NSUInteger const numberOfRows = [self.gameLevel.gameBoard gameBoardTiles_numberOfRows];

	CGFloat const width_perItem_bounded = floor((boundingSize.width - (inset * 2.0f)) / (CGFloat)numberOfColumns);
	CGFloat const height_perItem_bounded = floor((boundingSize.height - (inset * 2.0f)) / (CGFloat)numberOfRows);

	CGFloat const dimension_length = MIN(width_perItem_bounded, height_perItem_bounded);

	return (CGSize){
		.width		= dimension_length,
		.height		= dimension_length,
	};
}

#pragma mark - SMBGameBoardView_tileTapDelegate
-(void)gameBoardView:(nonnull SMBGameBoardView*)gameBoardView
	  tile_wasTapped:(nonnull SMBGameBoardTile*)gameBoardTile
{
	[self gameBoardTileEntityPickerView_selectedGameBoardTileEntity_move_to_tile:gameBoardTile];
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
