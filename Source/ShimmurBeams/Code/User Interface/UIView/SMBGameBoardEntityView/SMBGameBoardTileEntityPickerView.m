//
//  SMBGameBoardTileEntityPickerView.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/9/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardTileEntityPickerView.h"
#import "SMBGameBoardTileEntitySpawnerPickerCollectionViewCell.h"
#import "SMBGameBoardTileEntity.h"
#import "SMBGameBoardTile.h"
#import "UIView+SMBCommonFraming.h"
#import "SMBGameBoardTileEntitySpawner.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/NSString+RUMacros.h>
#import <ResplendentUtilities/RUClassOrNilUtil.h>
#import <ResplendentUtilities/UIView+RUUtility.h>





kRUDefineNSStringConstant(SMBGameBoardTileEntityPickerView__cellIdentifier_SMBGameBoardTileEntitySpawnerPickerCollectionViewCell);

typedef NS_ENUM(NSInteger, SMBGameBoardTileEntityPickerView__trashButton_type) {
	SMBGameBoardTileEntityPickerView__trashButton_type_none,
	SMBGameBoardTileEntityPickerView__trashButton_type_clearBoard,
	SMBGameBoardTileEntityPickerView__trashButton_type_remove,

	SMBGameBoardTileEntityPickerView__trashButton_type__first	= SMBGameBoardTileEntityPickerView__trashButton_type_clearBoard,
	SMBGameBoardTileEntityPickerView__trashButton_type__last	= SMBGameBoardTileEntityPickerView__trashButton_type_remove,
};





@interface SMBGameBoardTileEntityPickerView () <UICollectionViewDelegate, UICollectionViewDataSource>

#pragma mark - gameBoardTileEntitySpawners
-(nullable SMBGameBoardTileEntitySpawner*)gameBoardTileEntitySpawner_at_index:(NSUInteger)gameBoardTileEntitySpawner_index;
-(NSUInteger)gameBoardTileEntitySpawner_index_for_indexPathRow:(NSInteger)indexPathRow;
-(void)gameBoardTileEntitySpawners_removeAllEntitiesFromTiles;

#pragma mark - gameBoardTileEntities
//-(nullable SMBGameBoardTileEntity*)gameBoardTileEntity_at_index:(NSUInteger)gameBoardTileEntity_index;
//-(NSUInteger)gameBoardTileEntity_index_for_indexPathRow:(NSInteger)indexPathRow;
//-(void)gameBoardTileEntities_removeFromTiles_and_deselect;
-(void)gameBoardTileEntity_removeFromTile:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity;

#pragma mark - selectedGameBoardTileEntitySpawner
-(void)selectedGameBoardTileEntitySpawner_removeSpawnedEntitiesFromTile;

//#pragma mark - selectedGameBoardTileEntity
//-(void)selectedGameBoardTileEntity_removeFromTile_and_deselect;

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

#pragma mark - gameBoardTileEntitySpawnerPickerCollectionViewCell
-(nonnull SMBGameBoardTileEntitySpawnerPickerCollectionViewCell*)gameBoardTileEntitySpawnerPickerCollectionViewCell_for_collectionView:(nonnull UICollectionView*)collectionView
																													   itemAtIndexPath:(nonnull NSIndexPath*)indexPath;

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
		[self.collectionView registerClass:[SMBGameBoardTileEntitySpawnerPickerCollectionViewCell class] forCellWithReuseIdentifier:SMBGameBoardTileEntityPickerView__cellIdentifier_SMBGameBoardTileEntitySpawnerPickerCollectionViewCell];
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

#pragma mark - gameBoardTileEntitySpawners
-(void)setGameBoardTileEntitySpawners:(nullable NSArray<SMBGameBoardTileEntitySpawner*>*)gameBoardTileEntitySpawners
{
	kRUConditionalReturn((self.gameBoardTileEntitySpawners == gameBoardTileEntitySpawners)
						 ||
						 [self.gameBoardTileEntitySpawners isEqual:gameBoardTileEntitySpawners], NO);
	
	_gameBoardTileEntitySpawners = (gameBoardTileEntitySpawners ? [NSArray<SMBGameBoardTileEntitySpawner*> arrayWithArray:gameBoardTileEntitySpawners] : nil);
	
	[self.collectionView reloadData];
}

-(nullable SMBGameBoardTileEntitySpawner*)gameBoardTileEntitySpawner_at_index:(NSUInteger)gameBoardTileEntitySpawner_index
{
	NSArray<SMBGameBoardTileEntitySpawner*>* const gameBoardTileEntitySpawners = self.gameBoardTileEntitySpawners;
	kRUConditionalReturn_ReturnValueNil(gameBoardTileEntitySpawner_index >= gameBoardTileEntitySpawners.count, YES);
	
	return [gameBoardTileEntitySpawners objectAtIndex:gameBoardTileEntitySpawner_index];
}

-(NSUInteger)gameBoardTileEntitySpawner_index_for_indexPathRow:(NSInteger)indexPathRow
{
	return indexPathRow;
}

-(void)gameBoardTileEntitySpawners_removeAllEntitiesFromTiles
{
	[self.gameBoardTileEntitySpawners enumerateObjectsUsingBlock:^(SMBGameBoardTileEntitySpawner * _Nonnull gameBoardTileEntitySpawner, NSUInteger idx, BOOL * _Nonnull stop) {
		[[gameBoardTileEntitySpawner gameBoardTileEntities_spawned] enumerateObjectsUsingBlock:^(SMBGameBoardTileEntity * _Nonnull gameBoardTileEntity, NSUInteger idx, BOOL * _Nonnull stop) {
			[self gameBoardTileEntity_removeFromTile:gameBoardTileEntity];
		}];
	}];
}

#pragma mark - gameBoardTileEntities
//-(void)setGameBoardTileEntities:(nullable NSArray<SMBGameBoardTileEntity*>*)gameBoardTileEntities
//{
//	kRUConditionalReturn((self.gameBoardTileEntities == gameBoardTileEntities)
//						 ||
//						 [self.gameBoardTileEntities isEqual:gameBoardTileEntities], NO);
//
//	_gameBoardTileEntities = (gameBoardTileEntities ? [NSArray<SMBGameBoardTileEntity*> arrayWithArray:gameBoardTileEntities] : nil);
//
//	[self.collectionView reloadData];
//}
//
//-(nullable SMBGameBoardTileEntity*)gameBoardTileEntity_at_index:(NSUInteger)gameBoardTileEntity_index
//{
//	NSArray<SMBGameBoardTileEntity*>* const gameBoardTileEntities = self.gameBoardTileEntities;
//	kRUConditionalReturn_ReturnValueNil(gameBoardTileEntity_index >= gameBoardTileEntities.count, YES);
//
//	return [gameBoardTileEntities objectAtIndex:gameBoardTileEntity_index];
//}
//
//-(NSUInteger)gameBoardTileEntity_index_for_indexPathRow:(NSInteger)indexPathRow
//{
//	return indexPathRow;
//}
//
//-(void)gameBoardTileEntities_removeFromTiles_and_deselect
//{
//	[self.gameBoardTileEntities enumerateObjectsUsingBlock:^(SMBGameBoardTileEntity * _Nonnull gameBoardTileEntity, NSUInteger idx, BOOL * _Nonnull stop) {
//		[self gameBoardTileEntity_removeFromTile:gameBoardTileEntity];
//	}];
//
//	[self setSelectedGameBoardTileEntity:nil];
//}
//
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
		SMBGameBoardTileEntitySpawnerPickerCollectionViewCell* const gameBoardTileEntitySpawnerPickerCollectionViewCell = kRUClassOrNil(collectionViewCell, SMBGameBoardTileEntitySpawnerPickerCollectionViewCell);
		kRUConditionalReturn(gameBoardTileEntitySpawnerPickerCollectionViewCell == nil, YES);

		[self gameBoardTileEntitySpawnerPickerCollectionViewCell_isSelected_update:gameBoardTileEntitySpawnerPickerCollectionViewCell];
	}];
}

#pragma mark - gameBoardTileEntitySpawnerPickerCollectionViewCell
-(nonnull SMBGameBoardTileEntitySpawnerPickerCollectionViewCell*)gameBoardTileEntitySpawnerPickerCollectionViewCell_for_collectionView:(nonnull UICollectionView*)collectionView
																													   itemAtIndexPath:(nonnull NSIndexPath*)indexPath
{
	SMBGameBoardTileEntitySpawnerPickerCollectionViewCell* const gameBoardTileEntitySpawnerPickerCollectionViewCell =
	[collectionView dequeueReusableCellWithReuseIdentifier:SMBGameBoardTileEntityPickerView__cellIdentifier_SMBGameBoardTileEntitySpawnerPickerCollectionViewCell forIndexPath:indexPath];
	
	SMBGameBoardTileEntitySpawner* const gameBoardTileEntitySpawner = [self gameBoardTileEntitySpawner_at_index:[self gameBoardTileEntitySpawner_index_for_indexPathRow:indexPath.row]];
	[gameBoardTileEntitySpawnerPickerCollectionViewCell setGameBoardTileEntitySpawner:gameBoardTileEntitySpawner];
	[self gameBoardTileEntitySpawnerPickerCollectionViewCell_isSelected_update:gameBoardTileEntitySpawnerPickerCollectionViewCell];
	
	return gameBoardTileEntitySpawnerPickerCollectionViewCell;
}

-(void)gameBoardTileEntitySpawnerPickerCollectionViewCell_isSelected_update:(nonnull SMBGameBoardTileEntitySpawnerPickerCollectionViewCell*)gameBoardTileEntitySpawnerPickerCollectionViewCell
{
	kRUConditionalReturn(gameBoardTileEntitySpawnerPickerCollectionViewCell == nil, YES);

	[gameBoardTileEntitySpawnerPickerCollectionViewCell setGameBoardTileEntitySpawner_isSelected:(gameBoardTileEntitySpawnerPickerCollectionViewCell.gameBoardTileEntitySpawner == self.selectedGameBoardTileEntitySpawner)];
}

#pragma marl - UICollectionViewDelegate, UICollectionViewDataSource
-(NSInteger)collectionView:(nonnull UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section
{
	return self.gameBoardTileEntitySpawners.count;
}

-(nonnull UICollectionViewCell*)collectionView:(nonnull UICollectionView*)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath*)indexPath
{
	return
	[self gameBoardTileEntitySpawnerPickerCollectionViewCell_for_collectionView:collectionView
																itemAtIndexPath:indexPath];
}

-(void)collectionView:(nonnull UICollectionView*)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath*)indexPath
{
	SMBGameBoardTileEntitySpawner* const gameBoardTileEntitySpawner = [self gameBoardTileEntitySpawner_at_index:[self gameBoardTileEntitySpawner_index_for_indexPathRow:indexPath.row]];
	kRUConditionalReturn(gameBoardTileEntitySpawner == nil, YES);

	[self setSelectedGameBoardTileEntitySpawner:((self.selectedGameBoardTileEntitySpawner == gameBoardTileEntitySpawner) ? nil : gameBoardTileEntitySpawner)];

	[collectionView deselectItemAtIndexPath:indexPath animated:NO];
}

#pragma mark - selectedGameBoardTileEntitySpawner
-(void)setSelectedGameBoardTileEntitySpawner:(nullable SMBGameBoardTileEntitySpawner*)selectedGameBoardTileEntitySpawner
{
	kRUConditionalReturn(self.selectedGameBoardTileEntitySpawner == selectedGameBoardTileEntitySpawner, NO);

	_selectedGameBoardTileEntitySpawner = selectedGameBoardTileEntitySpawner;

	[self collectionView_visibleCells_gameBoardTileEntityPickerViewCollectionViewCell_gameBoardTileEntity_isSelected_update];
	[self trashButton_type_update];
}

-(void)selectedGameBoardTileEntitySpawner_removeSpawnedEntitiesFromTile
{
	SMBGameBoardTileEntitySpawner* const selectedGameBoardTileEntitySpawner = self.selectedGameBoardTileEntitySpawner;
	kRUConditionalReturn(selectedGameBoardTileEntitySpawner == nil, YES);

	[[selectedGameBoardTileEntitySpawner gameBoardTileEntities_spawned] enumerateObjectsUsingBlock:^(SMBGameBoardTileEntity * _Nonnull gameBoardTileEntity, NSUInteger idx, BOOL * _Nonnull stop) {
		[self gameBoardTileEntity_removeFromTile:gameBoardTileEntity];
	}];
	
	[self setSelectedGameBoardTileEntitySpawner:nil];
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

		case SMBGameBoardTileEntityPickerView__trashButton_type_clearBoard:
			[self gameBoardTileEntitySpawners_removeAllEntitiesFromTiles];
			break;

		case SMBGameBoardTileEntityPickerView__trashButton_type_remove:
			[self selectedGameBoardTileEntitySpawner_removeSpawnedEntitiesFromTile];
			[self setSelectedGameBoardTileEntitySpawner:nil];
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

		case SMBGameBoardTileEntityPickerView__trashButton_type_clearBoard:
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
	 ((self.selectedGameBoardTileEntitySpawner == nil)
	  ?
	  SMBGameBoardTileEntityPickerView__trashButton_type_clearBoard
	  :
	  SMBGameBoardTileEntityPickerView__trashButton_type_remove
	 )];
}

@end





@implementation SMBGameBoardTileEntityPickerView_PropertiesForKVO

+(nonnull NSString*)selectedGameBoardTileEntitySpawner{return NSStringFromSelector(_cmd);}

@end
