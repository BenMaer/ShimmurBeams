//
//  SMBGameBoardTileEntityPickerViewCollectionViewCell.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/9/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardTileEntityPickerViewCollectionViewCell.h"
#import "SMBDrawableObjectView.h"
#import "SMBGameBoardTileEntity.h"
#import "UIView+SMBCommonFraming.h"
#import "UIColor+SMBColors.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





static void* kSMBGameBoardTileEntityPickerViewCollectionViewCell__KVOContext = &kSMBGameBoardTileEntityPickerViewCollectionViewCell__KVOContext;





@interface SMBGameBoardTileEntityPickerViewCollectionViewCell ()

#pragma mark - gameBoardTileEntity
-(void)gameBoardTileEntity_setKVORegistered:(BOOL)registered;

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

@end





@implementation SMBGameBoardTileEntityPickerViewCollectionViewCell

#pragma mark - NSObject
-(void)dealloc
{
	[self gameBoardTileEntity_setKVORegistered:NO];
}

#pragma mark - UIView
-(instancetype)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame])
	{
		[self.layer setBorderWidth:1.0f];
		[self layer_borderColor_update];

		[self.layer setCornerRadius:[UIView smb_commonFraming_cornerRadius_general]];
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
}

#pragma mark - gameBoardTileEntity
-(void)setGameBoardTileEntity:(nullable SMBGameBoardTileEntity*)gameBoardTileEntity
{
	kRUConditionalReturn(self.gameBoardTileEntity == gameBoardTileEntity, NO);

	[self gameBoardTileEntity_setKVORegistered:NO];

	_gameBoardTileEntity = gameBoardTileEntity;

	[self gameBoardTileEntity_setKVORegistered:YES];

	[self gameBoardGeneralEntityView_update];
}

-(void)gameBoardTileEntity_setKVORegistered:(BOOL)registered
{
	typeof(self.gameBoardTileEntity) const gameBoardTileEntity = self.gameBoardTileEntity;
	kRUConditionalReturn(gameBoardTileEntity == nil, NO);
	
	NSMutableArray<NSString*>* const propertiesToObserve = [NSMutableArray<NSString*> array];
	[propertiesToObserve addObject:[SMBGameBoardTileEntity_PropertiesForKVO gameBoardTile]];
	
	[propertiesToObserve enumerateObjectsUsingBlock:^(NSString * _Nonnull propertyToObserve, NSUInteger idx, BOOL * _Nonnull stop) {
		if (registered)
		{
			[gameBoardTileEntity addObserver:self
								  forKeyPath:propertyToObserve
									 options:(NSKeyValueObservingOptionInitial)
									 context:&kSMBGameBoardTileEntityPickerViewCollectionViewCell__KVOContext];
		}
		else
		{
			[gameBoardTileEntity removeObserver:self
									 forKeyPath:propertyToObserve
										context:&kSMBGameBoardTileEntityPickerViewCollectionViewCell__KVOContext];
		}
	}];
}

#pragma mark - layer
-(void)layer_borderColor_update
{
	[self.layer setBorderColor:(self.gameBoardTileEntity_isSelected ? [UIColor smb_selectedTileEntity_color] : [UIColor blackColor]).CGColor];
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

-(void)setGameBoardTileEntity_isSelected:(BOOL)gameBoardTileEntity_isSelected
{
	kRUConditionalReturn(self.gameBoardTileEntity_isSelected == gameBoardTileEntity_isSelected, NO);

	_gameBoardTileEntity_isSelected = gameBoardTileEntity_isSelected;

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
	SMBGameBoardTileEntity* const gameBoardTileEntity = self.gameBoardTileEntity;
	kRUConditionalReturn_ReturnValueNil(gameBoardTileEntity == nil, YES);

	return [[SMBDrawableObjectView alloc] init_with_drawableObject:gameBoardTileEntity];
}

#pragma mark - KVO
-(void)observeValueForKeyPath:(nullable NSString*)keyPath ofObject:(nullable id)object change:(nullable NSDictionary*)change context:(nullable void*)context
{
	if (context == kSMBGameBoardTileEntityPickerViewCollectionViewCell__KVOContext)
	{
		if (self.gameBoardTileEntity == object)
		{
			if ([keyPath isEqualToString:[SMBGameBoardTileEntity_PropertiesForKVO gameBoardTile]])
			{
				[self backgroundColor_update];
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

#pragma mark - backgroundColor
-(void)backgroundColor_update
{
	[self setBackgroundColor:[self backgroundColor_appropriate]];
}

-(nullable UIColor*)backgroundColor_appropriate
{
	SMBGameBoardTileEntity* const gameBoardTileEntity = self.gameBoardTileEntity;
	kRUConditionalReturn_ReturnValueNil(gameBoardTileEntity == nil, NO);

	return
	((gameBoardTileEntity.gameBoardTile == nil)
	 ?
	 [UIColor whiteColor]
	 :
	 [UIColor lightGrayColor]
	);
}

@end
