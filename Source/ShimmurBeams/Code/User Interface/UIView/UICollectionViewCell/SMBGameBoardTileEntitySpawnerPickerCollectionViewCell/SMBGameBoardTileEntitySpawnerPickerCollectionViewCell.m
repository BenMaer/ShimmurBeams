//
//  SMBGameBoardTileEntitySpawnerCollectionViewCell.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 11/6/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardTileEntitySpawnerPickerCollectionViewCell.h"
#import "UIView+SMBCommonFraming.h"
#import "SMBGameBoardTileEntity.h"
#import "SMBGameBoardTileEntitySpawner.h"
#import "SMBDrawableObjectView.h"
#import "UIColor+SMBColors.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/UIView+RUUtility.h>

#import <RUTextSize/UILabel+RUTextSize.h>





static void* SMBGameBoardTileEntitySpawnerPickerCollectionViewCell__KVOContext_gameBoardTileEntitySpawners = &SMBGameBoardTileEntitySpawnerPickerCollectionViewCell__KVOContext_gameBoardTileEntitySpawners;





@interface SMBGameBoardTileEntitySpawnerPickerCollectionViewCell ()

#pragma mark - gameBoardTileEntity_for_drawing
@property (nonatomic, strong, nullable) SMBGameBoardTileEntity* gameBoardTileEntity_for_drawing;
-(void)gameBoardTileEntity_for_drawing_update;
-(nullable SMBGameBoardTileEntity*)gameBoardTileEntity_for_drawing_generate;

#pragma mark - layer
-(void)layer_borderColor_update;

#pragma mark - gameBoardGeneralEntityView
@property (nonatomic, strong, nullable) SMBDrawableObjectView* gameBoardGeneralEntityView;
-(CGRect)gameBoardGeneralEntityView_frame;
-(void)gameBoardGeneralEntityView_update;
-(nullable SMBDrawableObjectView*)gameBoardGeneralEntityView_generate_appropriate;

#pragma mark - backgroundColor
-(void)backgroundColor_update;
-(nullable UIColor*)backgroundColor_appropriate;

#pragma mark - amountUsedLabel
@property (nonatomic, readonly, strong, nullable) UILabel* amountUsedLabel;
-(CGRect)amountUsedLabel_frame;
-(void)amountUsedLabel_text_update;
-(nullable NSString*)amountUsedLabel_text_generate;

@end





@implementation SMBGameBoardTileEntitySpawnerPickerCollectionViewCell

#pragma mark - NSObject
-(void)dealloc
{
	[self SMBGameBoardTileEntitySpawnerPickerCollectionViewCell_gameBoardTileEntitySpawner_setKVORegistered:NO];
}

#pragma mark - UIView
-(instancetype)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame])
	{
		[self.layer setBorderWidth:1.0f];
		[self layer_borderColor_update];

		[self.layer setCornerRadius:[UIView smb_commonFraming_cornerRadius_general]];

		_amountUsedLabel = [UILabel new];
		[self.amountUsedLabel setBackgroundColor:[UIColor clearColor]];
		[self.amountUsedLabel setFont:[UIFont systemFontOfSize:8.0f weight:UIFontWeightRegular]];
		[self.amountUsedLabel setTextColor:[UIColor blackColor]];
		[self.contentView addSubview:self.amountUsedLabel];
	}

	return self;
}

-(void)layoutSubviews
{
	[super layoutSubviews];

	if (self.gameBoardGeneralEntityView)
	{
		[self.gameBoardGeneralEntityView setFrame:[self gameBoardGeneralEntityView_frame]];
	}

	[self.amountUsedLabel setFrame:[self amountUsedLabel_frame]];
}

#pragma mark - gameBoardTileEntitySpawner
-(void)setGameBoardTileEntitySpawner:(nullable SMBGameBoardTileEntitySpawner*)gameBoardTileEntitySpawner
{
	kRUConditionalReturn(self.gameBoardTileEntitySpawner == gameBoardTileEntitySpawner, NO);

	[self SMBGameBoardTileEntitySpawnerPickerCollectionViewCell_gameBoardTileEntitySpawner_setKVORegistered:NO];

	_gameBoardTileEntitySpawner = gameBoardTileEntitySpawner;

	[self SMBGameBoardTileEntitySpawnerPickerCollectionViewCell_gameBoardTileEntitySpawner_setKVORegistered:YES];

	[self gameBoardTileEntity_for_drawing_update];
}

-(void)SMBGameBoardTileEntitySpawnerPickerCollectionViewCell_gameBoardTileEntitySpawner_setKVORegistered:(BOOL)registered
{
	SMBGameBoardTileEntitySpawner* const gameBoardTileEntitySpawner = self.gameBoardTileEntitySpawner;
	kRUConditionalReturn(gameBoardTileEntitySpawner == nil, NO);
	
	NSMutableDictionary<NSNumber*,NSMutableArray<NSString*>*>* const KVOOptions_to_propertiesToObserve_mapping = [NSMutableDictionary<NSNumber*,NSMutableArray<NSString*>*> dictionary];
	
	NSMutableArray<NSString*>* const propertiesToObserve_observe_initial = [NSMutableArray<NSString*> array];
	[propertiesToObserve_observe_initial addObject:[SMBGameBoardTileEntitySpawner_PropertiesForKVO spawnedGameBoardTileEntities_tracked]];
	[KVOOptions_to_propertiesToObserve_mapping setObject:propertiesToObserve_observe_initial forKey:@(NSKeyValueObservingOptionInitial)];
	
	[KVOOptions_to_propertiesToObserve_mapping enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull KVOOptions_number, NSMutableArray<NSString *> * _Nonnull propertiesToObserve, BOOL * _Nonnull stop) {
		[propertiesToObserve enumerateObjectsUsingBlock:^(NSString * _Nonnull propertyToObserve, NSUInteger idx, BOOL * _Nonnull stop) {
			if (registered)
			{
				[gameBoardTileEntitySpawner addObserver:self
											 forKeyPath:propertyToObserve
												options:(KVOOptions_number.unsignedIntegerValue)
												context:&SMBGameBoardTileEntitySpawnerPickerCollectionViewCell__KVOContext_gameBoardTileEntitySpawners];
			}
			else
			{
				[gameBoardTileEntitySpawner removeObserver:self
												forKeyPath:propertyToObserve
												   context:&SMBGameBoardTileEntitySpawnerPickerCollectionViewCell__KVOContext_gameBoardTileEntitySpawners];
			}
		}];
	}];
}

#pragma mark - gameBoardTileEntity_for_drawing
-(void)setGameBoardTileEntity_for_drawing:(nullable SMBGameBoardTileEntity*)gameBoardTileEntity_for_drawing
{
	kRUConditionalReturn(self.gameBoardTileEntity_for_drawing == gameBoardTileEntity_for_drawing, NO);

	_gameBoardTileEntity_for_drawing = gameBoardTileEntity_for_drawing;

	[self gameBoardGeneralEntityView_update];
}

-(void)gameBoardTileEntity_for_drawing_update
{
	[self setGameBoardTileEntity_for_drawing:[self gameBoardTileEntity_for_drawing_generate]];
}

-(nullable SMBGameBoardTileEntity*)gameBoardTileEntity_for_drawing_generate
{
	SMBGameBoardTileEntitySpawner* const gameBoardTileEntitySpawner = self.gameBoardTileEntitySpawner;
	kRUConditionalReturn_ReturnValueNil(gameBoardTileEntitySpawner == nil, YES);

	return [gameBoardTileEntitySpawner gameBoardTileEntity_spawnNew_untracked];
}

#pragma mark - layer
-(void)layer_borderColor_update
{
	[self.layer setBorderColor:(self.gameBoardTileEntitySpawner_isSelected ? [UIColor smb_selectedTileEntity_color] : [UIColor blackColor]).CGColor];
}

#pragma mark - gameBoardGeneralEntityView
-(void)setGameBoardGeneralEntityView:(nullable SMBDrawableObjectView*)gameBoardGeneralEntityView
{
	kRUConditionalReturn(self.gameBoardGeneralEntityView == gameBoardGeneralEntityView, NO);

	if (self.gameBoardGeneralEntityView)
	{
		NSAssert(self.gameBoardGeneralEntityView.superview == self, @"superview should be self");
		[self.gameBoardGeneralEntityView removeFromSuperview];
	}

	_gameBoardGeneralEntityView = gameBoardGeneralEntityView;

	if (self.gameBoardGeneralEntityView)
	{
		NSAssert(self.gameBoardGeneralEntityView.superview == nil, @"superview should be nil");
		[self addSubview:self.gameBoardGeneralEntityView];
	}
}

-(void)setGameBoardTileEntitySpawner_isSelected:(BOOL)gameBoardTileEntitySpawner_isSelected
{
	kRUConditionalReturn(self.gameBoardTileEntitySpawner_isSelected == gameBoardTileEntitySpawner_isSelected, NO);

	_gameBoardTileEntitySpawner_isSelected = gameBoardTileEntitySpawner_isSelected;

	[self layer_borderColor_update];
}

-(CGRect)gameBoardGeneralEntityView_frame
{
	return self.bounds;
}

-(void)gameBoardGeneralEntityView_update
{
	[self setGameBoardGeneralEntityView:[self gameBoardGeneralEntityView_generate_appropriate]];
}

-(nullable SMBDrawableObjectView*)gameBoardGeneralEntityView_generate_appropriate
{
	SMBGameBoardTileEntity* const gameBoardTileEntity_for_drawing = self.gameBoardTileEntity_for_drawing;
	kRUConditionalReturn_ReturnValueNil(gameBoardTileEntity_for_drawing == nil, YES);

	return [[SMBDrawableObjectView alloc] init_with_drawableObject:gameBoardTileEntity_for_drawing];
}

#pragma mark - backgroundColor
-(void)backgroundColor_update
{
	[self setBackgroundColor:[self backgroundColor_appropriate]];
}

-(nullable UIColor*)backgroundColor_appropriate
{
	UIColor* const color_default = [UIColor whiteColor];
	SMBGameBoardTileEntitySpawner* const gameBoardTileEntitySpawner = self.gameBoardTileEntitySpawner;
	kRUConditionalReturn_ReturnValue(gameBoardTileEntitySpawner == nil, NO, color_default);
	kRUConditionalReturn_ReturnValue([gameBoardTileEntitySpawner spawnedGameBoardTileEntities_tracked_atCapacity] == false, NO, color_default);

	return [UIColor lightGrayColor];
}

#pragma mark - KVO
-(void)observeValueForKeyPath:(nullable NSString*)keyPath ofObject:(nullable id)object change:(nullable NSDictionary*)change context:(nullable void*)context
{
	if (context == SMBGameBoardTileEntitySpawnerPickerCollectionViewCell__KVOContext_gameBoardTileEntitySpawners)
	{
		if (self.gameBoardTileEntitySpawner == object)
		{
			if ([keyPath isEqualToString:[SMBGameBoardTileEntitySpawner_PropertiesForKVO spawnedGameBoardTileEntities_tracked]])
			{
				[self backgroundColor_update];
				[self amountUsedLabel_text_update];
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

#pragma mark - amountUsedLabel
-(CGRect)amountUsedLabel_frame
{
	CGSize const textSize = [self.amountUsedLabel ruTextSize];
	CGFloat const padding_right = 3.0f;
	CGFloat const padding_bottom = 3.0f;

	return CGRectCeilOrigin((CGRect){
		.origin.x	= CGRectGetWidth(self.contentView.bounds) - textSize.width - padding_right,
		.origin.y	= CGRectGetHeight(self.contentView.bounds) - textSize.height - padding_bottom,
		.size		= textSize,
	});
}

-(void)amountUsedLabel_text_update
{
	[self.amountUsedLabel setText:[self amountUsedLabel_text_generate]];
	[self setNeedsLayout];
}

-(nullable NSString*)amountUsedLabel_text_generate
{
	SMBGameBoardTileEntitySpawner* const gameBoardTileEntitySpawner = self.gameBoardTileEntitySpawner;
	kRUConditionalReturn_ReturnValueNil(gameBoardTileEntitySpawner == nil, NO);

	NSUInteger const spawnedGameBoardTileEntities_tracked_maximum = gameBoardTileEntitySpawner.spawnedGameBoardTileEntities_tracked_maximum;
	kRUConditionalReturn_ReturnValueNil(spawnedGameBoardTileEntities_tracked_maximum == 1, NO);

	NSMutableString* const amountUsedLabel_text = [NSMutableString string];

	NSArray<SMBGameBoardTileEntity*>* const spawnedGameBoardTileEntities_tracked = gameBoardTileEntitySpawner.spawnedGameBoardTileEntities_tracked;
	[amountUsedLabel_text appendFormat:
	 @"%lu",
	 (unsigned long)(spawnedGameBoardTileEntities_tracked ? spawnedGameBoardTileEntities_tracked.count : 0)];

	if (spawnedGameBoardTileEntities_tracked_maximum > 1)
	{
		[amountUsedLabel_text appendFormat:
		 @"/%lu",
		 (unsigned long)spawnedGameBoardTileEntities_tracked_maximum];
	}

	return [NSString stringWithString:amountUsedLabel_text];
}

@end
