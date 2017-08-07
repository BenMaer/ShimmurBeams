//
//  SMBGameBoardView.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/4/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardView.h"
#import "SMBGameBoard.h"
#import "SMBGameBoardTileEntityView.h"
#import "SMBGameBoardTileEntity.h"
#import "SMBGameBoardTile.h"
#import "SMBGameBoardTilePosition.h"
#import "SMBMutableMappedDataCollection.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





static void* kSMBGameBoardView__KVOContext = &kSMBGameBoardView__KVOContext;





@interface SMBGameBoardView ()

#pragma mark - gameBoard
-(void)gameBoard_setKVORegistered:(BOOL)registered;

#pragma mark - grid_shapeLayer
@property (nonatomic, readonly, strong, nullable) CAShapeLayer* grid_shapeLayer;
-(CGRect)grid_shapeLayer_frame;
-(void)grid_shapeLayer_path_update;

#pragma mark - gameBoardTileEntityView_mappedDataCollection
@property (nonatomic, copy, nullable) SMBMappedDataCollection<SMBGameBoardTileEntityView*>* gameBoardTileEntityView_mappedDataCollection;
-(void)gameBoardTileEntityView_mappedDataCollection_update;

#pragma mark - gameBoardEntityViews
-(void)gameBoardEntityViews_layout;

-(void)gameBoardEntityView_layout:(nonnull SMBGameBoardTileEntityView*)gameBoardEntityView;
-(CGRect)gameBoardEntityView_frame:(nonnull SMBGameBoardTileEntityView*)gameBoardEntityView;

-(CGFloat)gameBoardEntityView_width;
-(CGFloat)gameBoardEntityView_height;

#pragma mark - gameBoardTilePosition
-(CGRect)gameBoardTilePosition_frame:(nonnull SMBGameBoardTilePosition*)gameBoardTilePosition;

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
		[self setBackgroundColor:[UIColor cyanColor]];

		[self.layer setCornerRadius:10.0f];
		[self.layer setMasksToBounds:YES];

		[self.layer setBorderWidth:1.0f];
		[self.layer setBorderColor:[UIColor blackColor].CGColor];

		_grid_shapeLayer = [CAShapeLayer layer];
		[self.grid_shapeLayer setFillColor:nil];
		[self.grid_shapeLayer setLineWidth:1.0f / [UIScreen mainScreen].scale];
		[self.grid_shapeLayer setStrokeColor:[UIColor colorWithWhite:0.5f alpha:0.5f].CGColor];
		[self.layer addSublayer:self.grid_shapeLayer];


	}

	return self;
}

-(void)layoutSubviews
{
	[super layoutSubviews];

	[self grid_shapeLayer_path_update];
	[self.grid_shapeLayer setFrame:[self grid_shapeLayer_frame]];

	[self gameBoardEntityViews_layout];
}

#pragma mark - gameBoard
-(void)setGameBoard:(nullable SMBGameBoard*)gameBoard
{
	kRUConditionalReturn(self.gameBoard == gameBoard, NO);

	[self gameBoard_setKVORegistered:NO];

	_gameBoard = gameBoard;

	[self gameBoard_setKVORegistered:YES];

	[self grid_shapeLayer_path_update];
}

-(void)gameBoard_setKVORegistered:(BOOL)registered
{
	typeof(self.gameBoard) const gameBoard = self.gameBoard;
	kRUConditionalReturn(gameBoard == nil, NO);

	NSMutableArray<NSString*>* const propertiesToObserve = [NSMutableArray<NSString*> array];
	[propertiesToObserve addObject:[SMBGameBoard_PropertiesForKVO gameBoardTileEntities]];

	[propertiesToObserve enumerateObjectsUsingBlock:^(NSString * _Nonnull propertyToObserve, NSUInteger idx, BOOL * _Nonnull stop) {
		if (registered)
		{
			[gameBoard addObserver:self
						forKeyPath:propertyToObserve
						   options:(NSKeyValueObservingOptionInitial)
						   context:&kSMBGameBoardView__KVOContext];
		}
		else
		{
			[gameBoard removeObserver:self
						   forKeyPath:propertyToObserve
							  context:&kSMBGameBoardView__KVOContext];
		}
	}];
}

#pragma mark - grid_shapeLayer
-(CGRect)grid_shapeLayer_frame
{
	return self.bounds;
}

-(void)grid_shapeLayer_path_update
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
		CGFloat const horizontal_increment = [self gameBoardEntityView_width];
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
		CGFloat const vertical_increment = CGRectGetWidth(self.bounds) / (CGFloat)numberOfRows;
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
			if ([keyPath isEqualToString:[SMBGameBoard_PropertiesForKVO gameBoardTileEntities]])
			{
				[self gameBoardTileEntityView_mappedDataCollection_update];
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

#pragma mark - gameBoardTileEntityView_mappedDataCollection
-(void)setGameBoardTileEntityView_mappedDataCollection:(nullable SMBMappedDataCollection<SMBGameBoardTileEntityView*>*)gameBoardTileEntityView_mappedDataCollection
{
	kRUConditionalReturn((self.gameBoardTileEntityView_mappedDataCollection == gameBoardTileEntityView_mappedDataCollection)
						 ||
						 [self.gameBoardTileEntityView_mappedDataCollection isEqual:gameBoardTileEntityView_mappedDataCollection], NO);

	SMBMappedDataCollection<SMBGameBoardTileEntityView*>* const gameBoardTileEntityView_mappedDataCollection_old = self.gameBoardTileEntityView_mappedDataCollection;
	_gameBoardTileEntityView_mappedDataCollection = (gameBoardTileEntityView_mappedDataCollection ? [gameBoardTileEntityView_mappedDataCollection copy] : nil);

	NSArray<SMBGameBoardTileEntityView*>* removedObjects = nil;
	NSArray<SMBGameBoardTileEntityView*>* newObjects = nil;
	[SMBMappedDataCollection<SMBGameBoardTileEntityView*> changes_from_mappedDataCollection:gameBoardTileEntityView_mappedDataCollection_old
																	to_mappedDataCollection:self.gameBoardTileEntityView_mappedDataCollection
																			 removedObjects:&removedObjects
																				 newObjects:&newObjects];

	[removedObjects enumerateObjectsUsingBlock:^(SMBGameBoardTileEntityView * _Nonnull gameBoardEntityView, NSUInteger idx, BOOL * _Nonnull stop) {
		NSAssert(gameBoardEntityView.superview == self, @"Should be self");
		NSAssert([gameBoardTileEntityView_mappedDataCollection_old mappableObject_exists:gameBoardEntityView], @"Should be removed.");
		NSAssert([self.gameBoardTileEntityView_mappedDataCollection mappableObject_exists:gameBoardEntityView] == false, @"Should be removed.");
		
		[gameBoardEntityView removeFromSuperview];
	}];

	[[self.gameBoardTileEntityView_mappedDataCollection mappableObjects] enumerateObjectsUsingBlock:^(SMBGameBoardTileEntityView * _Nonnull gameBoardEntityView, NSUInteger idx, BOOL * _Nonnull stop) {
		NSAssert(gameBoardEntityView.superview == nil, @"Should have no superview");
		NSAssert([gameBoardTileEntityView_mappedDataCollection_old mappableObject_exists:gameBoardEntityView] == false, @"Should be new.");
		NSAssert([self.gameBoardTileEntityView_mappedDataCollection mappableObject_exists:gameBoardEntityView], @"Should be new.");

		[self addSubview:gameBoardEntityView];
	}];
}

-(void)gameBoardTileEntityView_mappedDataCollection_update
{
	SMBMutableMappedDataCollection<SMBGameBoardTileEntityView*>* const gameBoardTileEntityView_mappedDataCollection_new = [[SMBMutableMappedDataCollection<SMBGameBoardTileEntityView*> alloc] init];

	[self.gameBoard.gameBoardTileEntities enumerateObjectsUsingBlock:^(SMBGameBoardTileEntity * _Nonnull gameBoardEntity, NSUInteger idx, BOOL * _Nonnull stop) {
		NSString* const uniqueKey = [gameBoardEntity smb_uniqueKey];

		if ([gameBoardTileEntityView_mappedDataCollection_new mappableObject_for_uniqueKey:uniqueKey] == nil)
		{
			[gameBoardTileEntityView_mappedDataCollection_new mappableObject_add:[[SMBGameBoardTileEntityView alloc] init_with_gameBoardEntity:gameBoardEntity]];
		}
	}];

	[self setGameBoardTileEntityView_mappedDataCollection:[gameBoardTileEntityView_mappedDataCollection_new copy]];
}

#pragma mark - gameBoardEntityViews
-(void)gameBoardEntityViews_layout
{
	[[self.gameBoardTileEntityView_mappedDataCollection mappableObjects] enumerateObjectsUsingBlock:^(SMBGameBoardTileEntityView * _Nonnull gameBoardEntityView, NSUInteger idx, BOOL * _Nonnull stop) {
		[self gameBoardEntityView_layout:gameBoardEntityView];
	}];
}

-(void)gameBoardEntityView_layout:(nonnull SMBGameBoardTileEntityView*)gameBoardEntityView
{
	kRUConditionalReturn(gameBoardEntityView == nil, YES);

	[gameBoardEntityView setFrame:[self gameBoardEntityView_frame:gameBoardEntityView]];
}

-(CGRect)gameBoardEntityView_frame:(nonnull SMBGameBoardTileEntityView*)gameBoardEntityView
{
	kRUConditionalReturn_ReturnValue(gameBoardEntityView == nil, YES, CGRectZero);

	SMBGameBoardTilePosition* const gameBoardTilePosition = gameBoardEntityView.gameBoardEntity.gameBoardTile.gameBoardTilePosition;
	return [self gameBoardTilePosition_frame:gameBoardTilePosition];
}

-(CGFloat)gameBoardEntityView_width
{
	SMBGameBoard* const gameBoard = self.gameBoard;
	kRUConditionalReturn_ReturnValue(gameBoard == nil, YES, 0.0f);

	NSUInteger const numberOfColumns = [gameBoard gameBoardTiles_numberOfColumns];
	kRUConditionalReturn_ReturnValue(numberOfColumns <= 0, YES, 0.0f);

	return CGRectGetWidth(self.bounds) / numberOfColumns;
}

-(CGFloat)gameBoardEntityView_height
{
	SMBGameBoard* const gameBoard = self.gameBoard;
	kRUConditionalReturn_ReturnValue(gameBoard == nil, YES, 0.0f);

	NSUInteger const numberOfRows = [gameBoard gameBoardTiles_numberOfRows];
	kRUConditionalReturn_ReturnValue(numberOfRows <= 0, YES, 0.0f);

	return CGRectGetHeight(self.bounds) / numberOfRows;
}

#pragma mark - gameBoardTilePosition
-(CGRect)gameBoardTilePosition_frame:(nonnull SMBGameBoardTilePosition*)gameBoardTilePosition
{
	kRUConditionalReturn_ReturnValue(gameBoardTilePosition == nil, YES, CGRectZero);

	CGFloat const gameBoardEntityView_width = [self gameBoardEntityView_width];
	CGFloat const gameBoardEntityView_height = [self gameBoardEntityView_height];

	return (CGRect){
		.origin.x		= gameBoardEntityView_width * gameBoardTilePosition.column,
		.origin.y		= gameBoardEntityView_height * gameBoardTilePosition.row,
		.size.width		= gameBoardEntityView_width,
		.size.height	= gameBoardEntityView_height,
	};
}

@end
