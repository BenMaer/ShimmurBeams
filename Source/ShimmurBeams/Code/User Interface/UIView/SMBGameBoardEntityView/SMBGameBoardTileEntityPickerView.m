//
//  SMBGameBoardTileEntityPickerView.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/9/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardTileEntityPickerView.h"
#import "SMBGameBoardTileEntityPickerViewCollectionViewCell.h"
#import "SMBGameBoardTileEntity.h"
#import "SMBGameBoardTile.h"
#import "UIView+SMBCommonFraming.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/NSString+RUMacros.h>
#import <ResplendentUtilities/RUClassOrNilUtil.h>
#import <ResplendentUtilities/UIView+RUUtility.h>





kRUDefineNSStringConstant(SMBGameBoardTileEntityPickerView__cellIdentifier_SMBGameBoardTileEntityPickerViewCollectionViewCell);

typedef NS_ENUM(NSInteger, SMBGameBoardTileEntityPickerView__trashButton_type) {
	SMBGameBoardTileEntityPickerView__trashButton_type_none,
	SMBGameBoardTileEntityPickerView__trashButton_type_clear,
	SMBGameBoardTileEntityPickerView__trashButton_type_remove,

	SMBGameBoardTileEntityPickerView__trashButton_type__first	= SMBGameBoardTileEntityPickerView__trashButton_type_clear,
	SMBGameBoardTileEntityPickerView__trashButton_type__last	= SMBGameBoardTileEntityPickerView__trashButton_type_remove,
};





@interface SMBGameBoardTileEntityPickerView () <UICollectionViewDelegate, UICollectionViewDataSource>

#pragma mark - gameBoardTileEntities
-(nullable SMBGameBoardTileEntity*)gameBoardTileEntity_at_index:(NSUInteger)gameBoardTileEntity_index;
-(NSUInteger)gameBoardTileEntity_index_for_indexPathRow:(NSInteger)indexPathRow;
-(void)gameBoardTileEntities_removeFromTiles_and_deselect;
-(void)gameBoardTileEntity_removeFromTile:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity;

#pragma mark - selectedGameBoardTileEntity
-(void)selectedGameBoardTileEntity_removeFromTile_and_deselect;

#pragma mark - collectionView
@property (nonatomic, readonly, strong, nullable) UICollectionViewFlowLayout* collectionViewFlowLayout;
-(CGSize)collectionViewFlowLayout_itemSize;

#pragma mark - collectionView
@property (nonatomic, strong, nullable) UICollectionView* collectionView;
-(CGRect)collectionView_frame;
-(void)collectionView_visibleCells_gameBoardTileEntityPickerViewCollectionViewCell_gameBoardTileEntity_isSelected_update;

#pragma mark - trashButton
@property (nonatomic, readonly, strong, nullable) UIButton* trashButton;
-(CGRect)trashButton_frame;
-(void)trashButton_did_touchUpInside;
-(void)trashButton_title_update;
-(nullable NSString*)trashButton_title_appropriate;

#pragma mark - trashButton_type
@property (nonatomic, assign) SMBGameBoardTileEntityPickerView__trashButton_type trashButton_type;
-(void)trashButton_type_update;

@end





@implementation SMBGameBoardTileEntityPickerView

#pragma mark - UIView
-(instancetype)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame])
	{
		[self setBackgroundColor:[UIColor clearColor]];

		_collectionViewFlowLayout = [UICollectionViewFlowLayout new];
		[self.collectionViewFlowLayout setMinimumLineSpacing:10.0f];
		[self.collectionViewFlowLayout setMinimumInteritemSpacing:0.0f];
		[self.collectionViewFlowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];

		_collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.collectionViewFlowLayout];
		[self.collectionView setBackgroundColor:[UIColor clearColor]];
		[self.collectionView setDelegate:self];
		[self.collectionView setDataSource:self];
		[self.collectionView setScrollEnabled:YES];
		[self.collectionView registerClass:[SMBGameBoardTileEntityPickerViewCollectionViewCell class] forCellWithReuseIdentifier:SMBGameBoardTileEntityPickerView__cellIdentifier_SMBGameBoardTileEntityPickerViewCollectionViewCell];
		[self.collectionView setShowsHorizontalScrollIndicator:YES];
		[self addSubview:self.collectionView];

		_trashButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[self.trashButton setBackgroundColor:[UIColor clearColor]];
		[self.trashButton addTarget:self action:@selector(trashButton_did_touchUpInside) forControlEvents:UIControlEventTouchUpInside];
		[self.trashButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[self.trashButton.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
		[self.trashButton.layer setCornerRadius:[UIView smb_commonFraming_cornerRadius_general]];
		[self.trashButton.layer setBorderWidth:[UIView smb_commonFraming_borderWidth_general]];
		[self.trashButton.layer setBorderColor:[UIColor blackColor].CGColor];
		[self addSubview:self.trashButton];

		[self trashButton_type_update];
	}

	return self;
}

-(void)layoutSubviews
{
	[super layoutSubviews];

	[self.collectionViewFlowLayout setItemSize:[self collectionViewFlowLayout_itemSize]];
	[self.collectionView setFrame:[self collectionView_frame]];

	[self.trashButton setFrame:[self trashButton_frame]];
}

#pragma mark - gameBoardTileEntities
-(void)setGameBoardTileEntities:(nullable NSArray<SMBGameBoardTileEntity*>*)gameBoardTileEntities
{
	kRUConditionalReturn((self.gameBoardTileEntities == gameBoardTileEntities)
						 ||
						 [self.gameBoardTileEntities isEqual:gameBoardTileEntities], NO);

	_gameBoardTileEntities = (gameBoardTileEntities ? [NSArray<SMBGameBoardTileEntity*> arrayWithArray:gameBoardTileEntities] : nil);

	[self.collectionView reloadData];
}

-(nullable SMBGameBoardTileEntity*)gameBoardTileEntity_at_index:(NSUInteger)gameBoardTileEntity_index
{
	NSArray<SMBGameBoardTileEntity*>* const gameBoardTileEntities = self.gameBoardTileEntities;
	kRUConditionalReturn_ReturnValueNil(gameBoardTileEntity_index >= gameBoardTileEntities.count, YES);

	return [gameBoardTileEntities objectAtIndex:gameBoardTileEntity_index];
}

-(NSUInteger)gameBoardTileEntity_index_for_indexPathRow:(NSInteger)indexPathRow
{
	return indexPathRow;
}

-(void)gameBoardTileEntities_removeFromTiles_and_deselect
{
	[self.gameBoardTileEntities enumerateObjectsUsingBlock:^(SMBGameBoardTileEntity * _Nonnull gameBoardTileEntity, NSUInteger idx, BOOL * _Nonnull stop) {
		[self gameBoardTileEntity_removeFromTile:gameBoardTileEntity];
	}];

	[self setSelectedGameBoardTileEntity:nil];
}

-(void)gameBoardTileEntity_removeFromTile:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
{
	SMBGameBoardTile* const gameBoardTile = gameBoardTileEntity.gameBoardTile;
	kRUConditionalReturn(gameBoardTile == nil, NO);

	[gameBoardTile gameBoardTileEntities_remove:gameBoardTileEntity entityType:SMBGameBoardTile__entityType_beamInteractions];
}

#pragma mark - collectionView
-(CGSize)collectionViewFlowLayout_itemSize
{
	CGRect const collectionView_frame = self.collectionView_frame;

	CGFloat const dimension_length = CGRectGetHeight(collectionView_frame);

	return (CGSize){
		.width		= dimension_length,
		.height		= dimension_length,
	};
}

#pragma mark - collectionView
-(CGRect)collectionView_frame
{
	return CGRectCeilOrigin((CGRect){
		.size.width		= CGRectGetMinX([self trashButton_frame]) - 10.0f,
		.size.height	= CGRectGetHeight(self.bounds),
	});
}

-(void)collectionView_visibleCells_gameBoardTileEntityPickerViewCollectionViewCell_gameBoardTileEntity_isSelected_update
{
	[self.collectionView.visibleCells enumerateObjectsUsingBlock:^(__kindof UICollectionViewCell * _Nonnull collectionViewCell, NSUInteger idx, BOOL * _Nonnull stop) {
		SMBGameBoardTileEntityPickerViewCollectionViewCell* const gameBoardTileEntityPickerViewCollectionViewCell = kRUClassOrNil(collectionViewCell, SMBGameBoardTileEntityPickerViewCollectionViewCell);
		kRUConditionalReturn(gameBoardTileEntityPickerViewCollectionViewCell == nil, YES);

		[gameBoardTileEntityPickerViewCollectionViewCell setGameBoardTileEntity_isSelected:(gameBoardTileEntityPickerViewCollectionViewCell.gameBoardTileEntity == self.selectedGameBoardTileEntity)];
	}];
}

#pragma marl - UICollectionViewDelegate, UICollectionViewDataSource
-(NSInteger)collectionView:(nonnull UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section
{
	return self.gameBoardTileEntities.count;
}

-(nonnull UICollectionViewCell*)collectionView:(nonnull UICollectionView*)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath*)indexPath
{
	SMBGameBoardTileEntityPickerViewCollectionViewCell* const gameBoardTileEntityPickerViewCollectionViewCell =
	[collectionView dequeueReusableCellWithReuseIdentifier:SMBGameBoardTileEntityPickerView__cellIdentifier_SMBGameBoardTileEntityPickerViewCollectionViewCell forIndexPath:indexPath];

	SMBGameBoardTileEntity* const gameBoardTileEntity = [self gameBoardTileEntity_at_index:[self gameBoardTileEntity_index_for_indexPathRow:indexPath.row]];
	[gameBoardTileEntityPickerViewCollectionViewCell setGameBoardTileEntity:gameBoardTileEntity];
	[gameBoardTileEntityPickerViewCollectionViewCell setGameBoardTileEntity_isSelected:(gameBoardTileEntity == self.selectedGameBoardTileEntity)];

	return gameBoardTileEntityPickerViewCollectionViewCell;
}

-(void)collectionView:(nonnull UICollectionView*)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath*)indexPath
{
	SMBGameBoardTileEntity* const gameBoardTileEntity = [self gameBoardTileEntity_at_index:[self gameBoardTileEntity_index_for_indexPathRow:indexPath.row]];
	kRUConditionalReturn(gameBoardTileEntity == nil, YES);

	[self setSelectedGameBoardTileEntity:((self.selectedGameBoardTileEntity == gameBoardTileEntity) ? nil : gameBoardTileEntity)];

	[collectionView deselectItemAtIndexPath:indexPath animated:NO];
}

#pragma mark - selectedGameBoardTileEntity
-(void)setSelectedGameBoardTileEntity:(nullable SMBGameBoardTileEntity*)selectedGameBoardTileEntity
{
	kRUConditionalReturn(self.selectedGameBoardTileEntity == selectedGameBoardTileEntity, NO);

	_selectedGameBoardTileEntity = selectedGameBoardTileEntity;

	[self collectionView_visibleCells_gameBoardTileEntityPickerViewCollectionViewCell_gameBoardTileEntity_isSelected_update];
	[self trashButton_type_update];
}

-(void)selectedGameBoardTileEntity_removeFromTile_and_deselect
{
	SMBGameBoardTileEntity* const selectedGameBoardTileEntity = self.selectedGameBoardTileEntity;
	kRUConditionalReturn(selectedGameBoardTileEntity == nil, YES);

	[self gameBoardTileEntity_removeFromTile:selectedGameBoardTileEntity];

	[self setSelectedGameBoardTileEntity:nil];
}

#pragma mark - trashButton
-(CGRect)trashButton_frame
{
	CGFloat const height = CGRectGetHeight(self.bounds);
	CGFloat const width = 70.0f;

	return CGRectCeilOrigin((CGRect){
		.origin.x		= CGRectGetWidth(self.bounds) - width,
		.size.width		= width,
		.size.height	= height,
	});
}

-(void)trashButton_did_touchUpInside
{
	switch (self.trashButton_type)
	{
		case SMBGameBoardTileEntityPickerView__trashButton_type_none:
			NSAssert(false, @"unhandled trashButton_type %li",(long)self.trashButton_type);
			break;

		case SMBGameBoardTileEntityPickerView__trashButton_type_clear:
			[self gameBoardTileEntities_removeFromTiles_and_deselect];
			break;

		case SMBGameBoardTileEntityPickerView__trashButton_type_remove:
			[self selectedGameBoardTileEntity_removeFromTile_and_deselect];
			break;
	}
}

-(void)trashButton_title_update
{
	[self.trashButton setTitle:[self trashButton_title_appropriate]
					  forState:UIControlStateNormal];
}

-(nullable NSString*)trashButton_title_appropriate
{
	SMBGameBoardTileEntityPickerView__trashButton_type const trashButton_type = self.trashButton_type;
	switch (trashButton_type)
	{
		case SMBGameBoardTileEntityPickerView__trashButton_type_none:
			break;

		case SMBGameBoardTileEntityPickerView__trashButton_type_clear:
			return @"Clear";
			break;

		case SMBGameBoardTileEntityPickerView__trashButton_type_remove:
			return @"Remove";
			break;
	}

	NSAssert(false, @"unhandled trashButton_type %li",(long)trashButton_type);
	return nil;
}

#pragma mark - trashButton_type
-(void)setTrashButton_type:(SMBGameBoardTileEntityPickerView__trashButton_type)trashButton_type
{
	kRUConditionalReturn(self.trashButton_type == trashButton_type, NO);

	_trashButton_type = trashButton_type;

	[self trashButton_title_update];
}

-(void)trashButton_type_update
{
	[self setTrashButton_type:
	 ((self.selectedGameBoardTileEntity == nil)
	  ?
	  SMBGameBoardTileEntityPickerView__trashButton_type_clear
	  :
	  SMBGameBoardTileEntityPickerView__trashButton_type_remove
	 )];
}

@end





@implementation SMBGameBoardTileEntityPickerView_PropertiesForKVO

+(nonnull NSString*)selectedGameBoardTileEntity{return NSStringFromSelector(_cmd);}

@end
