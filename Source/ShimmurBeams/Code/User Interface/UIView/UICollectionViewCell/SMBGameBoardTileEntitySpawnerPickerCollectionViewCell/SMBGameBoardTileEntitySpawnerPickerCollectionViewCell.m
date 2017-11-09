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

@end





@implementation SMBGameBoardTileEntitySpawnerPickerCollectionViewCell

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

#pragma mark - gameBoardTileEntitySpawner
-(void)setGameBoardTileEntitySpawner:(nullable SMBGameBoardTileEntitySpawner*)gameBoardTileEntitySpawner
{
	kRUConditionalReturn(self.gameBoardTileEntitySpawner == gameBoardTileEntitySpawner, NO);

	_gameBoardTileEntitySpawner = gameBoardTileEntitySpawner;

	[self gameBoardTileEntity_for_drawing_update];
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
	return [UIColor whiteColor];
//	SMBGameBoardTileEntity* const gameBoardTileEntity = self.gameBoardTileEntity;
//	kRUConditionalReturn_ReturnValueNil(gameBoardTileEntity == nil, NO);
//
//	return
//	((gameBoardTileEntity.gameBoardTile == nil)
//	 ?
//	 [UIColor whiteColor]
//	 :
//	 [UIColor lightGrayColor]
//	 );
}


@end
