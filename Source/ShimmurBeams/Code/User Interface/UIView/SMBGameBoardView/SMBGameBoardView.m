//
//  SMBGameBoardView.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/4/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardView.h"
#import "SMBGameBoard.h"
#import "SMBGameBoardGeneralEntityView.h"
#import "SMBGameBoardTileEntity.h"
#import "SMBGameBoardTile.h"
#import "SMBGameBoardTilePosition.h"
#import "SMBMutableMappedDataCollection.h"
#import "SMBGameBoardEntity.h"
#import "UIView+SMBCommonFraming.h"
#import "SMBGameBoardTileView.h"
#import "NSString+SMBColumnNames.h"
#import "NSString+SMBRowNames.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/RUClassOrNilUtil.h>
#import <ResplendentUtilities/UIView+RUUtility.h>
#import <ResplendentUtilities/RUConstants.h>

#import <RUTextSize/NSString+RUTextSize.h>
#import <RUTextSize/RUAttributesDictionaryBuilder.h>
#import <RUTextSize/UILabel+RUAttributesDictionaryBuilder.h>





static void* kSMBGameBoardView__KVOContext = &kSMBGameBoardView__KVOContext;





@interface SMBGameBoardView () <SMBGameBoardTileView__tapDelegate>

#pragma mark - gameBoard
-(void)gameBoard_setKVORegistered:(BOOL)registered;

#pragma mark - grid_shapeLayer
@property (nonatomic, readonly, strong, nullable) CAShapeLayer* grid_shapeLayer;
-(CGRect)grid_shapeLayer_frame_with_contentView_frame:(CGRect)contentView_frame;
-(void)grid_shapeLayer_path_update_with_gameBoardTileEntityView_size:(CGSize)gameBoardTileEntityView_size;

#pragma mark - gameBoardTileEntityView
@property (nonatomic, copy, nullable) SMBMappedDataCollection<SMBGameBoardGeneralEntityView*>* gameBoardTileEntityView_mappedDataCollection;
-(void)gameBoardTileEntityView_mappedDataCollection_update;

-(void)gameBoardTileEntityView_mappedDataCollection_layout_with_gameBoardTileEntityView_size:(CGSize)gameBoardTileEntityView_size;

-(void)gameBoardTileEntityView_layout:(nonnull SMBGameBoardGeneralEntityView*)gameBoardGeneralEntityView
		 gameBoardTileEntityView_size:(CGSize)gameBoardTileEntityView_size;
-(CGRect)gameBoardTileEntityView_frame_with_gameBoardTileEntity:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
								   gameBoardTileEntityView_size:(CGSize)gameBoardTileEntityView_size;

-(CGSize)gameBoardTileEntityView_size;

#pragma mark - gameBoardEntityView_mappedDataCollection
@property (nonatomic, copy, nullable) SMBMappedDataCollection<SMBGameBoardGeneralEntityView*>* gameBoardEntityView_mappedDataCollection;
-(void)gameBoardEntityView_mappedDataCollection_update;

-(void)gameBoardEntityView_mappedDataCollection_layout;

#pragma mark - contentView
@property (nonatomic, readonly, strong, nullable) UIView* contentView;
-(CGRect)contentView_frame_with_gameBoardTileEntityView_size:(CGSize)gameBoardTileEntityView_size
																  boundingSize:(CGSize)boundingSize;

#pragma mark - gameBoardTileViews
@property (nonatomic, copy, nullable) NSArray<SMBGameBoardTileView*>* gameBoardTileViews;
-(void)gameBoardTileViews_update;
-(nullable NSArray<SMBGameBoardTileView*>*)gameBoardTileViews_generate;
-(void)gameBoardTileViews_layout_with_gameBoardTileEntityView_size:(CGSize)gameBoardTileEntityView_size;

#pragma mark - gameBoardTilePosition
-(CGFloat)gameBoardTilePosition_frame_origin_x_with_column:(NSUInteger)column
							  gameBoardTileEntityView_size:(CGSize)gameBoardTileEntityView_size;
-(CGFloat)gameBoardTilePosition_frame_origin_y_with_row:(NSUInteger)row
						   gameBoardTileEntityView_size:(CGSize)gameBoardTileEntityView_size;
-(CGRect)gameBoardTilePosition_frame:(nonnull SMBGameBoardTilePosition*)gameBoardTilePosition
		gameBoardTileEntityView_size:(CGSize)gameBoardTileEntityView_size;

#if kSMBEnvironment__SMBGameBoardView_showColumnAndRowValues_enabled

#pragma mark - columnAndRowLabels
-(nonnull RUAttributesDictionaryBuilder*)columnAndRowLabels_attributesDictionaryBuilder;
-(nonnull UILabel*)columnAndRowLabel_generate;

#pragma mark - columnLabels
@property (nonatomic, copy, nullable) NSArray<UILabel*>* columnLabels;
-(CGRect)columnLabel_frame_for_column:(NSUInteger)column
		 gameBoardTileEntityView_size:(CGSize)gameBoardTileEntityView_size
						   textHeight:(CGFloat)textHeight;
-(void)columnLabels_layout_with_gameBoardTileEntityView_size:(CGSize)gameBoardTileEntityView_size;
-(void)columnLabels_update;
-(nonnull NSArray<UILabel*>*)columnLabels_generate;

#pragma mark - rowLabels
@property (nonatomic, copy, nullable) NSArray<UILabel*>* rowLabels;
-(CGRect)rowLabel_frame_for_row:(NSUInteger)row
   gameBoardTileEntityView_size:(CGSize)gameBoardTileEntityView_size
					  textWidth:(CGFloat)textWidth;
-(void)rowLabels_layout_with_gameBoardTileEntityView_size:(CGSize)gameBoardTileEntityView_size;
-(void)rowLabels_update;
-(nonnull NSArray<UILabel*>*)rowLabels_generate;

#endif

@end





@implementation SMBGameBoardView

#pragma mark - NSObject
-(void)dealloc
{
	[self gameBoard_setKVORegistered:NO];
}

#pragma mark - UIView
-(instancetype)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame])
	{
		[self setBackgroundColor:[UIColor clearColor]];
		[self setClipsToBounds:NO];

		_contentView = [UIView new];
		[self.contentView setBackgroundColor:[UIColor colorWithWhite:0.9f alpha:1.0f]];
		[self.contentView.layer setCornerRadius:[UIView smb_commonFraming_cornerRadius_general]];
		[self.contentView.layer setMasksToBounds:YES];
		[self.contentView.layer setBorderWidth:1.0f];
		[self.contentView.layer setBorderColor:[UIColor blackColor].CGColor];
		[self addSubview:self.contentView];

		_grid_shapeLayer = [CAShapeLayer layer];
		[self.grid_shapeLayer setFillColor:nil];
		[self.grid_shapeLayer setLineWidth:1.0f];
		[self.grid_shapeLayer setStrokeColor:[UIColor colorWithWhite:0.5f alpha:0.5f].CGColor];
		[self.contentView.layer addSublayer:self.grid_shapeLayer];
	}

	return self;
}

-(void)layoutSubviews
{
	[super layoutSubviews];

	CGSize const gameBoardTileEntityView_size = [self gameBoardTileEntityView_size];

	CGRect const contentView_frame = [self contentView_frame_with_gameBoardTileEntityView_size:gameBoardTileEntityView_size
																													  boundingSize:self.bounds.size];
	[self.contentView setFrame:contentView_frame];

	[self grid_shapeLayer_path_update_with_gameBoardTileEntityView_size:gameBoardTileEntityView_size];
	[self.grid_shapeLayer setFrame:[self grid_shapeLayer_frame_with_contentView_frame:contentView_frame]];

	[self gameBoardTileViews_layout_with_gameBoardTileEntityView_size:gameBoardTileEntityView_size];
	[self gameBoardTileEntityView_mappedDataCollection_layout_with_gameBoardTileEntityView_size:gameBoardTileEntityView_size];
	[self columnLabels_layout_with_gameBoardTileEntityView_size:gameBoardTileEntityView_size];
	[self rowLabels_layout_with_gameBoardTileEntityView_size:gameBoardTileEntityView_size];

	[self gameBoardEntityView_mappedDataCollection_layout];
}

-(CGSize)sizeThatFits:(CGSize)size
{
	CGSize const gameBoardTileEntityView_size = [self gameBoardTileEntityView_size_with_boundingSize:size];

	return (CGSize){
		.width		= size.width,
		.height		=
		CGRectGetHeight([self contentView_frame_with_gameBoardTileEntityView_size:gameBoardTileEntityView_size
																					   boundingSize:size]),
	};
}

#pragma mark - gameBoard
-(void)setGameBoard:(nullable SMBGameBoard*)gameBoard
{
	kRUConditionalReturn(self.gameBoard == gameBoard, NO);

	[self gameBoard_setKVORegistered:NO];

	_gameBoard = gameBoard;

	[self gameBoard_setKVORegistered:YES];

	[self columnLabels_update];
	[self rowLabels_update];

	[self setNeedsLayout];
}

-(void)gameBoard_setKVORegistered:(BOOL)registered
{
	typeof(self.gameBoard) const gameBoard = self.gameBoard;
	kRUConditionalReturn(gameBoard == nil, NO);

	NSMutableDictionary<NSNumber*,NSMutableArray<NSString*>*>* const KVOOptions_to_propertiesToObserve_mapping = [NSMutableDictionary<NSNumber*,NSMutableArray<NSString*>*> dictionary];

	NSMutableArray<NSString*>* const propertiesToObserve_observe_initial = [NSMutableArray<NSString*> array];
	[propertiesToObserve_observe_initial addObject:[SMBGameBoard_PropertiesForKVO gameBoardTiles]];
	[propertiesToObserve_observe_initial addObject:[SMBGameBoard_PropertiesForKVO gameBoardTileEntities]];
	[propertiesToObserve_observe_initial addObject:[SMBGameBoard_PropertiesForKVO gameBoardEntities]];
	[KVOOptions_to_propertiesToObserve_mapping setObject:propertiesToObserve_observe_initial forKey:@(NSKeyValueObservingOptionInitial)];

	[KVOOptions_to_propertiesToObserve_mapping enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull KVOOptions_number, NSMutableArray<NSString *> * _Nonnull propertiesToObserve, BOOL * _Nonnull stop) {
		[propertiesToObserve enumerateObjectsUsingBlock:^(NSString * _Nonnull propertyToObserve, NSUInteger idx, BOOL * _Nonnull stop) {
			if (registered)
			{
				[gameBoard addObserver:self
							forKeyPath:propertyToObserve
							   options:(KVOOptions_number.unsignedIntegerValue)
							   context:&kSMBGameBoardView__KVOContext];
			}
			else
			{
				[gameBoard removeObserver:self
							   forKeyPath:propertyToObserve
								  context:&kSMBGameBoardView__KVOContext];
			}
		}];
	}];
}

#pragma mark - grid_shapeLayer
-(CGRect)grid_shapeLayer_frame_with_contentView_frame:(CGRect)contentView_frame
{
	return (CGRect){
		.size	= contentView_frame.size,
	};
}

-(void)grid_shapeLayer_path_update_with_gameBoardTileEntityView_size:(CGSize)gameBoardTileEntityView_size
{
	UIBezierPath* const bezierPath = [UIBezierPath bezierPath];

	SMBGameBoard* const gameBoard = self.gameBoard;
	kRUConditionalReturn(gameBoard == nil, NO);

	NSUInteger const numberOfColumns = [gameBoard gameBoardTiles_numberOfColumns];
	kRUConditionalReturn(numberOfColumns <= 0, YES);

	NSUInteger const numberOfRows = [gameBoard gameBoardTiles_numberOfRows];
	kRUConditionalReturn(numberOfRows <= 0, YES);

	if (numberOfColumns > 1)
	{
		CGFloat const horizontal_increment = gameBoardTileEntityView_size.width;
		for (NSUInteger columnToDraw = 1;
			 columnToDraw < numberOfColumns;
			 columnToDraw++)
		{
			CGFloat const xCoord = (horizontal_increment * (CGFloat)columnToDraw);
			[bezierPath moveToPoint:(CGPoint){
				.x	= xCoord,
				.y	= 0.0f,
			}];
			[bezierPath addLineToPoint:(CGPoint){
				.x	= xCoord,
				.y	= CGRectGetHeight(self.bounds),
			}];
		}
	}

	if (numberOfRows > 1)
	{
		CGFloat const vertical_increment = gameBoardTileEntityView_size.height;
		for (NSUInteger rowToDraw = 1;
			 rowToDraw < numberOfRows;
			 rowToDraw++)
		{
			CGFloat const yCoord = (vertical_increment * (CGFloat)rowToDraw);
			[bezierPath moveToPoint:(CGPoint){
				.x	= 0.0f,
				.y	= yCoord,
			}];
			[bezierPath addLineToPoint:(CGPoint){
				.x	= CGRectGetWidth(self.bounds),
				.y	= yCoord,
			}];
		}
	}

	[self.grid_shapeLayer setPath:bezierPath.CGPath];
}

#pragma mark - KVO
-(void)observeValueForKeyPath:(nullable NSString*)keyPath ofObject:(nullable id)object change:(nullable NSDictionary*)change context:(nullable void*)context
{
	if (context == kSMBGameBoardView__KVOContext)
	{
		if (object == self.gameBoard)
		{
			if ([keyPath isEqualToString:[SMBGameBoard_PropertiesForKVO gameBoardTiles]])
			{
				[self gameBoardTileViews_update];
			}
			else if ([keyPath isEqualToString:[SMBGameBoard_PropertiesForKVO gameBoardTileEntities]])
			{
				[self gameBoardTileEntityView_mappedDataCollection_update];
			}
			else if ([keyPath isEqualToString:[SMBGameBoard_PropertiesForKVO gameBoardEntities]])
			{
				[self gameBoardEntityView_mappedDataCollection_update];
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

#pragma mark - gameBoardTileEntityView
-(void)setGameBoardTileEntityView_mappedDataCollection:(nullable SMBMappedDataCollection<SMBGameBoardGeneralEntityView*>*)gameBoardTileEntityView_mappedDataCollection
{
	kRUConditionalReturn((self.gameBoardTileEntityView_mappedDataCollection == gameBoardTileEntityView_mappedDataCollection)
						 ||
						 [self.gameBoardTileEntityView_mappedDataCollection isEqual:gameBoardTileEntityView_mappedDataCollection], NO);

	SMBMappedDataCollection<SMBGameBoardGeneralEntityView*>* const gameBoardTileEntityView_mappedDataCollection_old = self.gameBoardTileEntityView_mappedDataCollection;
	_gameBoardTileEntityView_mappedDataCollection = (gameBoardTileEntityView_mappedDataCollection ? [gameBoardTileEntityView_mappedDataCollection copy] : nil);

	NSArray<SMBGameBoardGeneralEntityView*>* removedObjects = nil;
	NSArray<SMBGameBoardGeneralEntityView*>* newObjects = nil;
	[SMBMappedDataCollection<SMBGameBoardGeneralEntityView*> changes_from_mappedDataCollection:gameBoardTileEntityView_mappedDataCollection_old
																	to_mappedDataCollection:self.gameBoardTileEntityView_mappedDataCollection
																			 removedObjects:&removedObjects
																				 newObjects:&newObjects];

	[removedObjects enumerateObjectsUsingBlock:^(SMBGameBoardGeneralEntityView * _Nonnull gameBoardEntityView, NSUInteger idx, BOOL * _Nonnull stop) {
		NSAssert(gameBoardEntityView.superview == self.contentView, @"Should be contentView");
		NSAssert([gameBoardTileEntityView_mappedDataCollection_old mappableObject_exists:gameBoardEntityView], @"Should be removed.");
		NSAssert([self.gameBoardTileEntityView_mappedDataCollection mappableObject_exists:gameBoardEntityView] == false, @"Should be removed.");

		[gameBoardEntityView removeFromSuperview];
	}];

	[newObjects enumerateObjectsUsingBlock:^(SMBGameBoardGeneralEntityView * _Nonnull gameBoardEntityView, NSUInteger idx, BOOL * _Nonnull stop) {
		NSAssert(gameBoardEntityView.superview == nil, @"Should have no superview");
		NSAssert([gameBoardTileEntityView_mappedDataCollection_old mappableObject_exists:gameBoardEntityView] == false, @"Should be new.");
		NSAssert([self.gameBoardTileEntityView_mappedDataCollection mappableObject_exists:gameBoardEntityView], @"Should be new.");

		[self.contentView addSubview:gameBoardEntityView];
	}];

	[self setNeedsLayout];
}

-(void)gameBoardTileEntityView_mappedDataCollection_update
{
	SMBMutableMappedDataCollection<SMBGameBoardGeneralEntityView*>* const gameBoardTileEntityView_mappedDataCollection_new = [SMBMutableMappedDataCollection<SMBGameBoardGeneralEntityView*> new];
	SMBMappedDataCollection<SMBGameBoardGeneralEntityView*>* const gameBoardTileEntityView_mappedDataCollection_old = self.gameBoardTileEntityView_mappedDataCollection;

	[self.gameBoard.gameBoardTileEntities enumerateObjectsUsingBlock:^(SMBGameBoardTileEntity * _Nonnull gameBoardTileEntity, NSUInteger idx, BOOL * _Nonnull stop) {
		NSString* const uniqueKey = [gameBoardTileEntity smb_uniqueKey];

		SMBGameBoardGeneralEntityView* const gameBoardGeneralEntityView =
		([gameBoardTileEntityView_mappedDataCollection_old mappableObject_for_uniqueKey:uniqueKey]
		 ?:
		 [[SMBGameBoardGeneralEntityView alloc] init_with_gameBoardGeneralEntity:gameBoardTileEntity]
		);

		[gameBoardGeneralEntityView setUserInteractionEnabled:NO];

		[gameBoardTileEntityView_mappedDataCollection_new mappableObject_add:gameBoardGeneralEntityView];
	}];

	[self setGameBoardTileEntityView_mappedDataCollection:[gameBoardTileEntityView_mappedDataCollection_new copy]];
}

-(void)gameBoardTileEntityView_mappedDataCollection_layout_with_gameBoardTileEntityView_size:(CGSize)gameBoardTileEntityView_size
{
	[[self.gameBoardTileEntityView_mappedDataCollection mappableObjects] enumerateObjectsUsingBlock:^(SMBGameBoardGeneralEntityView * _Nonnull gameBoardTileEntityView, NSUInteger idx, BOOL * _Nonnull stop) {
		[self gameBoardTileEntityView_layout:gameBoardTileEntityView
				gameBoardTileEntityView_size:gameBoardTileEntityView_size];
	}];
}

-(void)gameBoardTileEntityView_layout:(nonnull SMBGameBoardGeneralEntityView*)gameBoardGeneralEntityView
		 gameBoardTileEntityView_size:(CGSize)gameBoardTileEntityView_size
{
	[gameBoardGeneralEntityView setFrame:
	 [self gameBoardTileEntityView_frame_with_gameBoardTileEntity:kRUClassOrNil(gameBoardGeneralEntityView.drawableObject, SMBGameBoardTileEntity)
									 gameBoardTileEntityView_size:gameBoardTileEntityView_size]];
}

-(CGRect)gameBoardTileEntityView_frame_with_gameBoardTileEntity:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
								   gameBoardTileEntityView_size:(CGSize)gameBoardTileEntityView_size
{
	kRUConditionalReturn_ReturnValue(gameBoardTileEntity == nil, YES, CGRectZero);

	return [self gameBoardTilePosition_frame:gameBoardTileEntity.gameBoardTile.gameBoardTilePosition
				gameBoardTileEntityView_size:gameBoardTileEntityView_size];
}

-(CGSize)gameBoardTileEntityView_size_with_boundingSize:(CGSize)boundingSize
{
	NSUInteger const numberOfColumns = [self.gameBoard gameBoardTiles_numberOfColumns];
	kRUConditionalReturn_ReturnValue(numberOfColumns == 0, NO, CGSizeZero);

	NSUInteger const numberOfRows = [self.gameBoard gameBoardTiles_numberOfRows];
	kRUConditionalReturn_ReturnValue(numberOfRows == 0, NO, CGSizeZero);

	CGFloat const width_perItem_bounded = floor((boundingSize.width) / (CGFloat)numberOfColumns);
	CGFloat const height_perItem_bounded = floor((boundingSize.height) / (CGFloat)numberOfRows);

	CGFloat const dimension_length = MIN(width_perItem_bounded, height_perItem_bounded);

	return (CGSize){
		.width		= dimension_length,
		.height		= dimension_length,
	};
}

-(CGSize)gameBoardTileEntityView_size
{
	return [self gameBoardTileEntityView_size_with_boundingSize:self.bounds.size];
}

#pragma mark - gameBoardEntityView_mappedDataCollection
-(void)setGameBoardEntityView_mappedDataCollection:(nullable SMBMappedDataCollection<SMBGameBoardGeneralEntityView*>*)gameBoardEntityView_mappedDataCollection
{
	kRUConditionalReturn((self.gameBoardEntityView_mappedDataCollection == gameBoardEntityView_mappedDataCollection)
						 ||
						 [self.gameBoardEntityView_mappedDataCollection isEqual:gameBoardEntityView_mappedDataCollection], NO);

	SMBMappedDataCollection<SMBGameBoardGeneralEntityView*>* const gameBoardEntityView_mappedDataCollection_old = self.gameBoardEntityView_mappedDataCollection;
	_gameBoardEntityView_mappedDataCollection = [gameBoardEntityView_mappedDataCollection copy];

	NSArray<SMBGameBoardGeneralEntityView*>* removedObjects = nil;
	NSArray<SMBGameBoardGeneralEntityView*>* newObjects = nil;
	[SMBMappedDataCollection<SMBGameBoardGeneralEntityView*> changes_from_mappedDataCollection:gameBoardEntityView_mappedDataCollection_old
																	   to_mappedDataCollection:self.gameBoardEntityView_mappedDataCollection
																				removedObjects:&removedObjects
																					newObjects:&newObjects];

	[removedObjects enumerateObjectsUsingBlock:^(SMBGameBoardGeneralEntityView * _Nonnull gameBoardEntityView, NSUInteger idx, BOOL * _Nonnull stop) {
		NSAssert(gameBoardEntityView.superview == self.contentView, @"Should be contentView");
		NSAssert([gameBoardEntityView_mappedDataCollection_old mappableObject_exists:gameBoardEntityView], @"Should be removed.");
		NSAssert([self.gameBoardEntityView_mappedDataCollection mappableObject_exists:gameBoardEntityView] == false, @"Should be removed.");

		[gameBoardEntityView removeFromSuperview];
	}];

	[newObjects enumerateObjectsUsingBlock:^(SMBGameBoardGeneralEntityView * _Nonnull gameBoardEntityView, NSUInteger idx, BOOL * _Nonnull stop) {
		NSAssert(gameBoardEntityView.superview == nil, @"Should have no superview");
		NSAssert([gameBoardEntityView_mappedDataCollection_old mappableObject_exists:gameBoardEntityView] == false, @"Should be new.");
		NSAssert([self.gameBoardEntityView_mappedDataCollection mappableObject_exists:gameBoardEntityView], @"Should be new.");

		[self.contentView addSubview:gameBoardEntityView];
	}];
}

-(void)gameBoardEntityView_mappedDataCollection_update
{
	SMBMutableMappedDataCollection<SMBGameBoardGeneralEntityView*>* const gameBoardEntityView_mappedDataCollection_new = [SMBMutableMappedDataCollection<SMBGameBoardGeneralEntityView*> new];
	SMBMappedDataCollection<SMBGameBoardGeneralEntityView*>* const gameBoardEntityView_mappedDataCollection_old = self.gameBoardEntityView_mappedDataCollection;

	[self.gameBoard.gameBoardEntities enumerateObjectsUsingBlock:^(SMBGameBoardEntity * _Nonnull gameBoardEntity, NSUInteger idx, BOOL * _Nonnull stop) {
		NSString* const uniqueKey = [gameBoardEntity smb_uniqueKey];

		SMBGameBoardGeneralEntityView* const gameBoardGeneralEntityView =
		(
		 [gameBoardEntityView_mappedDataCollection_old mappableObject_for_uniqueKey:uniqueKey]
		 ?:
		 [[SMBGameBoardGeneralEntityView alloc] init_with_gameBoardGeneralEntity:gameBoardEntity]
		 );

		[gameBoardGeneralEntityView setUserInteractionEnabled:NO];

		[gameBoardEntityView_mappedDataCollection_new mappableObject_add:gameBoardGeneralEntityView];
	}];

	[self setGameBoardEntityView_mappedDataCollection:[gameBoardEntityView_mappedDataCollection_new copy]];
}

-(void)gameBoardEntityView_mappedDataCollection_layout
{
	[[self.gameBoardEntityView_mappedDataCollection mappableObjects] enumerateObjectsUsingBlock:^(SMBGameBoardGeneralEntityView* _Nonnull gameBoardGeneralEntityView, NSUInteger idx, BOOL * _Nonnull stop) {
		NSAssert(gameBoardGeneralEntityView.superview == self.contentView, @"Should be by now.");
		[gameBoardGeneralEntityView setFrame:self.bounds];
	}];
}

#pragma mark - gameBoardTilePosition
-(CGFloat)gameBoardTilePosition_frame_origin_x_with_column:(NSUInteger)column
							  gameBoardTileEntityView_size:(CGSize)gameBoardTileEntityView_size
{
	return gameBoardTileEntityView_size.width * column;
}

-(CGFloat)gameBoardTilePosition_frame_origin_y_with_row:(NSUInteger)row
						   gameBoardTileEntityView_size:(CGSize)gameBoardTileEntityView_size
{
	return gameBoardTileEntityView_size.height * row;
}

-(CGRect)gameBoardTilePosition_frame:(nonnull SMBGameBoardTilePosition*)gameBoardTilePosition
		gameBoardTileEntityView_size:(CGSize)gameBoardTileEntityView_size
{
	kRUConditionalReturn_ReturnValue(gameBoardTilePosition == nil, YES, CGRectZero);

	return (CGRect){
		.origin.x	=
		[self gameBoardTilePosition_frame_origin_x_with_column:gameBoardTilePosition.column
								  gameBoardTileEntityView_size:gameBoardTileEntityView_size],
		.origin.y	=
		[self gameBoardTilePosition_frame_origin_y_with_row:gameBoardTilePosition.row
							   gameBoardTileEntityView_size:gameBoardTileEntityView_size],
		.size		= gameBoardTileEntityView_size,
	};
}

#pragma mark - contentView
-(CGRect)contentView_frame_with_gameBoardTileEntityView_size:(CGSize)gameBoardTileEntityView_size
																  boundingSize:(CGSize)boundingSize
{
	CGSize const size = (CGSize){
		.width		= gameBoardTileEntityView_size.width * (CGFloat)[self.gameBoard gameBoardTiles_numberOfColumns],
		.height		= gameBoardTileEntityView_size.height * (CGFloat)[self.gameBoard gameBoardTiles_numberOfRows],
	};

	return CGRectCeilOrigin((CGRect){
		.origin.x	= CGRectGetHorizontallyAlignedXCoordForWidthOnWidth(size.width, boundingSize.width),
		.origin.y	= CGRectGetVerticallyAlignedYCoordForHeightOnHeight(size.height, boundingSize.height),
		.size		= size,
	});;
}

#pragma mark - gameBoardTileViews
-(void)setGameBoardTileViews:(nullable NSArray<SMBGameBoardTileView*>*)gameBoardTileViews
{
	kRUConditionalReturn((self.gameBoardTileViews == gameBoardTileViews)
						 ||
						 [self.gameBoardTileViews isEqual:gameBoardTileViews], NO);

	[self.gameBoardTileViews enumerateObjectsUsingBlock:^(SMBGameBoardTileView * _Nonnull gameBoardTileView, NSUInteger idx, BOOL * _Nonnull stop) {
		NSAssert(gameBoardTileView.superview == self.contentView, @"superview should be content view");

		[gameBoardTileView removeFromSuperview];
	}];

	_gameBoardTileViews = (gameBoardTileViews ? [NSArray<SMBGameBoardTileView*> arrayWithArray:gameBoardTileViews] : nil);

	[self.gameBoardTileViews enumerateObjectsUsingBlock:^(SMBGameBoardTileView * _Nonnull gameBoardTileView, NSUInteger idx, BOOL * _Nonnull stop) {
		NSAssert(gameBoardTileView.superview == nil, @"superview should be nil");

		[self.contentView addSubview:gameBoardTileView];
	}];

	[self setNeedsLayout];
}

-(void)gameBoardTileViews_update
{
	[self setGameBoardTileViews:[self gameBoardTileViews_generate]];
}

-(nullable NSArray<SMBGameBoardTileView*>*)gameBoardTileViews_generate
{
	NSMutableArray<SMBGameBoardTileView*>* const gameBoardTileViews = [NSMutableArray<SMBGameBoardTileView*> array];;

	[self.gameBoard gameBoardTiles_enumerate:^(SMBGameBoardTile * _Nonnull gameBoardTile, NSUInteger column, NSUInteger row, BOOL * _Nonnull stop) {
		SMBGameBoardTileView* const gameBoardTileView = [[SMBGameBoardTileView alloc] init_with_gameBoardTile:gameBoardTile];
		kRUConditionalReturn(gameBoardTileView == nil, YES);

		[gameBoardTileView setTapDelegate:self];

		[gameBoardTileViews addObject:gameBoardTileView];
	}];

	return [NSArray<SMBGameBoardTileView*> arrayWithArray:gameBoardTileViews];
}

-(void)gameBoardTileViews_layout_with_gameBoardTileEntityView_size:(CGSize)gameBoardTileEntityView_size
{
	[self.gameBoardTileViews enumerateObjectsUsingBlock:^(SMBGameBoardTileView * _Nonnull gameBoardTileView, NSUInteger idx, BOOL * _Nonnull stop) {
		[gameBoardTileView setFrame:
		 [self gameBoardTilePosition_frame:gameBoardTileView.gameBoardTile.gameBoardTilePosition
			  gameBoardTileEntityView_size:gameBoardTileEntityView_size]];
	}];
}

#pragma mark - SMBGameBoardTileView__tapDelegate
-(void)gameBoardTileView_wasTapped:(nonnull SMBGameBoardTileView*)gameBoardTileView
{
	kRUConditionalReturn(gameBoardTileView == nil, YES);

	SMBGameBoardTile* const gameBoardTile = gameBoardTileView.gameBoardTile;
	kRUConditionalReturn(gameBoardTile == nil, YES);

	id<SMBGameBoardView_tileTapDelegate> const tileTapDelegate = self.tileTapDelegate;
	kRUConditionalReturn(tileTapDelegate == nil, YES);

	[tileTapDelegate gameBoardView:self tile_wasTapped:gameBoardTile];
}

#if kSMBEnvironment__SMBGameBoardView_showColumnAndRowValues_enabled

#pragma mark - columnAndRowLabels
-(nonnull RUAttributesDictionaryBuilder*)columnAndRowLabels_attributesDictionaryBuilder
{
	RUAttributesDictionaryBuilder* const attributesDictionaryBuilder = [RUAttributesDictionaryBuilder new];
	[attributesDictionaryBuilder setFont:[UIFont boldSystemFontOfSize:8.0f]];
	[attributesDictionaryBuilder setTextColor:[UIColor blackColor]];
	[attributesDictionaryBuilder setTextAlignment:NSTextAlignmentCenter];

	return attributesDictionaryBuilder;
}

-(nonnull UILabel*)columnAndRowLabel_generate
{
	UILabel* const label = [UILabel new];
	[label setUserInteractionEnabled:NO];
	[label setBackgroundColor:[UIColor clearColor]];
	[label ru_absorb_attributesDictionaryBuilder:[self columnAndRowLabels_attributesDictionaryBuilder]];
	
	return label;
}

#pragma mark - columnLabels
-(void)setColumnLabels:(nullable NSArray<UILabel*>*)columnLabels
{
	kRUConditionalReturn(self.columnLabels == columnLabels, NO);

	[self.columnLabels enumerateObjectsUsingBlock:^(UILabel * _Nonnull columnLabel, NSUInteger idx, BOOL * _Nonnull stop) {
		[columnLabel removeFromSuperview];
	}];

	_columnLabels = (columnLabels ? [NSArray<UILabel*> arrayWithArray:columnLabels] : nil);

	[self.columnLabels enumerateObjectsUsingBlock:^(UILabel * _Nonnull columnLabel, NSUInteger idx, BOOL * _Nonnull stop) {
		[self addSubview:columnLabel];
	}];

	[self setNeedsLayout];
}

-(CGRect)columnLabel_frame_for_column:(NSUInteger)column
		 gameBoardTileEntityView_size:(CGSize)gameBoardTileEntityView_size
						   textHeight:(CGFloat)textHeight
{
	CGFloat const height = textHeight;
	CGRect const contentView_frame =
	[self contentView_frame_with_gameBoardTileEntityView_size:gameBoardTileEntityView_size
																   boundingSize:self.bounds.size];

	return (CGRect){
		.origin.x		=
		(
		 CGRectGetMinX(contentView_frame)
		 +
		 [self gameBoardTilePosition_frame_origin_x_with_column:column
								   gameBoardTileEntityView_size:gameBoardTileEntityView_size]
		),
		.origin.y		=
		(
		 CGRectGetMinY(contentView_frame)
		 -
		 height
		),
		.size.width		= gameBoardTileEntityView_size.width,
		.size.height	= height,
	};
}

-(void)columnLabels_layout_with_gameBoardTileEntityView_size:(CGSize)gameBoardTileEntityView_size
{
	CGFloat const textHeight =
	[@"" ruTextSizeWithBoundingWidth:CGFLOAT_MAX
						  attributes:[[self columnAndRowLabels_attributesDictionaryBuilder] attributesDictionary_generate]].height;

	[self.columnLabels enumerateObjectsUsingBlock:^(UILabel * _Nonnull columnLabel, NSUInteger column, BOOL * _Nonnull stop) {
		[columnLabel setFrame:[self columnLabel_frame_for_column:column
									gameBoardTileEntityView_size:gameBoardTileEntityView_size
													  textHeight:textHeight]];
	}];
}

-(void)columnLabels_update
{
	[self setColumnLabels:[self columnLabels_generate]];
}

-(nonnull NSArray<UILabel*>*)columnLabels_generate
{
	NSUInteger const numberOfColumns = [self.gameBoard gameBoardTiles_numberOfColumns];
	NSMutableArray<UILabel*>* const columnLabels = [NSMutableArray<UILabel*> arrayWithCapacity:numberOfColumns];

	for (NSUInteger column = 0;
		 column < numberOfColumns;
		 column++)
	{
		UILabel* const label = [self columnAndRowLabel_generate];
		[label setText:[NSString smb_columnName_for_columnIndex:column]];
		[columnLabels addObject:label];
	}

	return [NSArray<UILabel*> arrayWithArray:columnLabels];
}

#pragma mark - rowLabels
-(void)setRowLabels:(nullable NSArray<UILabel*>*)rowLabels
{
	kRUConditionalReturn(self.rowLabels == rowLabels, NO);
	
	[self.rowLabels enumerateObjectsUsingBlock:^(UILabel * _Nonnull rowLabel, NSUInteger idx, BOOL * _Nonnull stop) {
		[rowLabel removeFromSuperview];
	}];
	
	_rowLabels = (rowLabels ? [NSArray<UILabel*> arrayWithArray:rowLabels] : nil);
	
	[self.rowLabels enumerateObjectsUsingBlock:^(UILabel * _Nonnull rowLabel, NSUInteger idx, BOOL * _Nonnull stop) {
		[self addSubview:rowLabel];
	}];
	
	[self setNeedsLayout];
}

-(CGRect)rowLabel_frame_for_row:(NSUInteger)row
   gameBoardTileEntityView_size:(CGSize)gameBoardTileEntityView_size
					  textWidth:(CGFloat)textWidth
{
	CGFloat const width = textWidth;
	CGRect const contentView_frame =
	[self contentView_frame_with_gameBoardTileEntityView_size:gameBoardTileEntityView_size
												 boundingSize:self.bounds.size];

	return (CGRect){
		.origin.x		=
		(
		 CGRectGetMinX(contentView_frame)
		 -
		 width
		),
		.origin.y		=
		(
		 CGRectGetMinY(contentView_frame)
		 +
		 [self gameBoardTilePosition_frame_origin_y_with_row:row
								gameBoardTileEntityView_size:gameBoardTileEntityView_size]
		),
		.size.width		= width,
		.size.height	= gameBoardTileEntityView_size.height,
	};
}

-(void)rowLabels_layout_with_gameBoardTileEntityView_size:(CGSize)gameBoardTileEntityView_size
{
	NSString* const text = RUStringWithFormat(@"%lu",(unsigned long)[self.gameBoard gameBoardTiles_numberOfRows]);
	CGFloat const textWidth =
	[text ruTextSizeWithBoundingWidth:CGFLOAT_MAX
						   attributes:[[self columnAndRowLabels_attributesDictionaryBuilder]
									   attributesDictionary_generate]].width;
	
	[self.rowLabels enumerateObjectsUsingBlock:^(UILabel * _Nonnull rowLabel, NSUInteger row, BOOL * _Nonnull stop) {
		[rowLabel setFrame:[self rowLabel_frame_for_row:row
						   gameBoardTileEntityView_size:gameBoardTileEntityView_size
											 textWidth:textWidth]];
	}];
}

-(void)rowLabels_update
{
	[self setRowLabels:[self rowLabels_generate]];
}

-(nonnull NSArray<UILabel*>*)rowLabels_generate
{
	NSUInteger const numberOfRows = [self.gameBoard gameBoardTiles_numberOfRows];
	NSMutableArray<UILabel*>* const rowLabels = [NSMutableArray<UILabel*> arrayWithCapacity:numberOfRows];
	
	for (NSUInteger row = 0;
		 row < numberOfRows;
		 row++)
	{
		UILabel* const label = [self columnAndRowLabel_generate];
		[label setText:[NSString smb_rowName_for_rowIndex:row]];
		[rowLabels addObject:label];
	}
	
	return [NSArray<UILabel*> arrayWithArray:rowLabels];
}

#endif

@end
