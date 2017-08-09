//
//  SMBGameBoardTileEntityPickerViewCollectionViewCell.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/9/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardTileEntityPickerViewCollectionViewCell.h"
#import "SMBGameBoardGeneralEntityView.h"
#import "SMBGameBoardTileEntity.h"
#import "UIView+SMBCommonFraming.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@interface SMBGameBoardTileEntityPickerViewCollectionViewCell ()

#pragma mark - layer
-(void)layer_borderColor_update;

#pragma mark - gameBoardGeneralEntityView
@property (nonatomic, strong, nullable) SMBGameBoardGeneralEntityView* gameBoardGeneralEntityView;
-(CGRect)gameBoardGeneralEntityView_frame;
-(void)gameBoardGeneralEntityView_update;
-(nullable SMBGameBoardGeneralEntityView*)gameBoardGeneralEntityView_generate_appropriate;

@end





@implementation SMBGameBoardTileEntityPickerViewCollectionViewCell

#pragma mark - UIView
-(instancetype)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame])
	{
		[self setBackgroundColor:[UIColor clearColor]];

		[self.layer setBorderWidth:2.0f];
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

	_gameBoardTileEntity = gameBoardTileEntity;

	[self gameBoardGeneralEntityView_update];
}

#pragma mark - layer
-(void)layer_borderColor_update
{
	[self.layer setBorderColor:(self.gameBoardTileEntity_isSelected ? [UIColor greenColor] : [UIColor blackColor]).CGColor];
}

#pragma mark - gameBoardGeneralEntityView
-(void)setGameBoardGeneralEntityView:(nullable SMBGameBoardGeneralEntityView*)gameBoardGeneralEntityView
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

-(nullable SMBGameBoardGeneralEntityView*)gameBoardGeneralEntityView_generate_appropriate
{
	SMBGameBoardTileEntity* const gameBoardTileEntity = self.gameBoardTileEntity;
	kRUConditionalReturn_ReturnValueNil(gameBoardTileEntity == nil, YES);

	return [[SMBGameBoardGeneralEntityView alloc] init_with_gameBoardGeneralEntity:gameBoardTileEntity];
}

@end
