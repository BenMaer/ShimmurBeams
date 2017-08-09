//
//  SMBGameBoardTileEntityPickerView.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/9/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardTileEntityPickerView.h"
#import "SMBGameBoardTileEntityPickerViewCollectionViewCell.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/NSString+RUMacros.h>





kRUDefineNSStringConstant(SMBGameBoardTileEntityPickerView__cellIdentifier_SMBGameBoardTileEntityPickerViewCollectionViewCell);





@interface SMBGameBoardTileEntityPickerView () <UICollectionViewDelegate, UICollectionViewDataSource>

#pragma mark - gameBoardTileEntities
-(nullable SMBGameBoardTileEntity*)gameBoardTileEntity_at_index:(NSUInteger)gameBoardTileEntity_index;
-(NSUInteger)gameBoardTileEntity_index_for_indexPathRow:(NSInteger)indexPathRow;

#pragma mark - collectionView
@property (nonatomic, readonly, strong, nullable) UICollectionViewFlowLayout* collectionViewFlowLayout;
-(CGSize)collectionViewFlowLayout_itemSize;

#pragma mark - collectionView
@property (nonatomic, strong, nullable) UICollectionView* collectionView;
-(CGRect)collectionView_frame;

@end





@implementation SMBGameBoardTileEntityPickerView

#pragma mark - UIView
-(instancetype)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame])
	{
		[self setBackgroundColor:[UIColor clearColor]];

		_collectionViewFlowLayout = [UICollectionViewFlowLayout new];
		[self.collectionViewFlowLayout setMinimumLineSpacing:0.0f];
		[self.collectionViewFlowLayout setMinimumInteritemSpacing:0.0f];
		[self.collectionViewFlowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];

		_collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.collectionViewFlowLayout];
		[self.collectionView setBackgroundColor:[UIColor clearColor]];
		[self.collectionView setDelegate:self];
		[self.collectionView setDataSource:self];
		[self.collectionView setScrollEnabled:YES];
		[self.collectionView registerClass:[SMBGameBoardTileEntityPickerViewCollectionViewCell class] forCellWithReuseIdentifier:SMBGameBoardTileEntityPickerView__cellIdentifier_SMBGameBoardTileEntityPickerViewCollectionViewCell];
		[self addSubview:self.collectionView];
	}
	
	return self;
}

-(void)layoutSubviews
{
	[super layoutSubviews];

	[self.collectionViewFlowLayout setItemSize:[self collectionViewFlowLayout_itemSize]];
	[self.collectionView setFrame:[self collectionView_frame]];
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
	return self.bounds;
}

#pragma marl - UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)collectionView:(nonnull UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section
{
	return self.gameBoardTileEntities.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(nonnull UICollectionView*)collectionView
{
	return 1;
}

- (nonnull UICollectionViewCell*)collectionView:(nonnull UICollectionView*)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath*)indexPath
{
	SMBGameBoardTileEntityPickerViewCollectionViewCell* const gameBoardTileEntityPickerViewCollectionViewCell =
	[collectionView dequeueReusableCellWithReuseIdentifier:SMBGameBoardTileEntityPickerView__cellIdentifier_SMBGameBoardTileEntityPickerViewCollectionViewCell forIndexPath:indexPath];

	SMBGameBoardTileEntity* const gameBoardTileEntity = [self gameBoardTileEntity_at_index:[self gameBoardTileEntity_index_for_indexPathRow:indexPath.row]];
	[gameBoardTileEntityPickerViewCollectionViewCell setGameBoardTileEntity:gameBoardTileEntity];

	return gameBoardTileEntityPickerViewCollectionViewCell;
}

-(void)collectionView:(nonnull UICollectionView*)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath*)indexPath
{
}

@end
