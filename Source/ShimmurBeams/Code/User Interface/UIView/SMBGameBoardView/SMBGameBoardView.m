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

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/RUClassOrNilUtil.h>





static void* kSMBGameBoardView__KVOContext = &kSMBGameBoardView__KVOContext;





@interface SMBGameBoardView ()

#pragma mark - gameBoard
-(void)gameBoard_setKVORegistered:(BOOL)registered;

#pragma mark - grid_shapeLayer
@property (nonatomic, readonly, strong, nullable) CAShapeLayer* grid_shapeLayer;
-(CGRect)grid_shapeLayer_frame;
-(void)grid_shapeLayer_path_update;

#pragma mark - gameBoardTileEntityView_mappedDataCollection
@property (nonatomic, copy, nullable) SMBMappedDataCollection<SMBGameBoardGeneralEntityView*>* gameBoardTileEntityView_mappedDataCollection;
-(void)gameBoardTileEntityView_mappedDataCollection_update;

-(void)gameBoardTileEntityView_mappedDataCollection_layout;

-(void)gameBoardTileEntityView_layout:(nonnull SMBGameBoardGeneralEntityView*)gameBoardGeneralEntityView;
-(CGRect)gameBoardTileEntityView_frame_with_gameBoardTileEntity:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity;

-(CGFloat)gameBoardTileEntityView_width;
-(CGFloat)gameBoardTileEntityView_height;

#pragma mark - gameBoardEntityView_mappedDataCollection
@property (nonatomic, copy, nullable) SMBMappedDataCollection<SMBGameBoardGeneralEntityView*>* gameBoardEntityView_mappedDataCollection;
-(void)gameBoardEntityView_mappedDataCollection_update;

-(void)gameBoardEntityView_mappedDataCollection_layout;

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

	[self gameBoardTileEntityView_mappedDataCollection_layout];

	[self gameBoardEntityView_mappedDataCollection_layout];
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
	[propertiesToObserve addObject:[SMBGameBoard_PropertiesForKVO gameBoardEntities]];

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
		CGFloat const horizontal_increment = [self gameBoardTileEntityView_width];
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

#pragma mark - gameBoardTileEntityView_mappedDataCollection
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
		NSAssert(gameBoardEntityView.superview == self, @"Should be self");
		NSAssert([gameBoardTileEntityView_mappedDataCollection_old mappableObject_exists:gameBoardEntityView], @"Should be removed.");
		NSAssert([self.gameBoardTileEntityView_mappedDataCollection mappableObject_exists:gameBoardEntityView] == false, @"Should be removed.");

		[gameBoardEntityView removeFromSuperview];
	}];

	[newObjects enumerateObjectsUsingBlock:^(SMBGameBoardGeneralEntityView * _Nonnull gameBoardEntityView, NSUInteger idx, BOOL * _Nonnull stop) {
		NSAssert(gameBoardEntityView.superview == nil, @"Should have no superview");
		NSAssert([gameBoardTileEntityView_mappedDataCollection_old mappableObject_exists:gameBoardEntityView] == false, @"Should be new.");
		NSAssert([self.gameBoardTileEntityView_mappedDataCollection mappableObject_exists:gameBoardEntityView], @"Should be new.");

		[self addSubview:gameBoardEntityView];
	}];
}

-(void)gameBoardTileEntityView_mappedDataCollection_update
{
	SMBMutableMappedDataCollection<SMBGameBoardGeneralEntityView*>* const gameBoardTileEntityView_mappedDataCollection_new = [[SMBMutableMappedDataCollection<SMBGameBoardGeneralEntityView*> alloc] init_with_mappedDataCollection:self.gameBoardTileEntityView_mappedDataCollection];

	[self.gameBoard.gameBoardTileEntities enumerateObjectsUsingBlock:^(SMBGameBoardTileEntity * _Nonnull gameBoardTileEntity, NSUInteger idx, BOOL * _Nonnull stop) {
		NSString* const uniqueKey = [gameBoardTileEntity smb_uniqueKey];
		
		if ([gameBoardTileEntityView_mappedDataCollection_new mappableObject_for_uniqueKey:uniqueKey] == nil)
		{
			[gameBoardTileEntityView_mappedDataCollection_new mappableObject_add:[[SMBGameBoardGeneralEntityView alloc] init_with_gameBoardView:self
																														 gameBoardGeneralEntity:gameBoardTileEntity]];
		}
	}];

	[self setGameBoardTileEntityView_mappedDataCollection:[gameBoardTileEntityView_mappedDataCollection_new copy]];
}

-(void)gameBoardTileEntityView_mappedDataCollection_layout
{
	[[self.gameBoardTileEntityView_mappedDataCollection mappableObjects] enumerateObjectsUsingBlock:^(SMBGameBoardGeneralEntityView * _Nonnull gameBoardTileEntityView, NSUInteger idx, BOOL * _Nonnull stop) {
		[self gameBoardTileEntityView_layout:gameBoardTileEntityView];
	}];
}

-(void)gameBoardTileEntityView_layout:(nonnull SMBGameBoardGeneralEntityView*)gameBoardGeneralEntityView
{
	[gameBoardGeneralEntityView setFrame:[self gameBoardTileEntityView_frame_with_gameBoardTileEntity:kRUClassOrNil(gameBoardGeneralEntityView.gameBoardGeneralEntity, SMBGameBoardTileEntity)]];
}

-(CGRect)gameBoardTileEntityView_frame_with_gameBoardTileEntity:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
{
	kRUConditionalReturn_ReturnValue(gameBoardTileEntity == nil, YES, CGRectZero);

	SMBGameBoardTilePosition* const gameBoardTilePosition = gameBoardTileEntity.gameBoardTile.gameBoardTilePosition;
	return [self gameBoardTilePosition_frame:gameBoardTilePosition];
}

-(CGFloat)gameBoardTileEntityView_width
{
	SMBGameBoard* const gameBoard = self.gameBoard;
	kRUConditionalReturn_ReturnValue(gameBoard == nil, YES, 0.0f);

	NSUInteger const numberOfColumns = [gameBoard gameBoardTiles_numberOfColumns];
	kRUConditionalReturn_ReturnValue(numberOfColumns <= 0, YES, 0.0f);

	return CGRectGetWidth(self.bounds) / numberOfColumns;
}

-(CGFloat)gameBoardTileEntityView_height
{
	SMBGameBoard* const gameBoard = self.gameBoard;
	kRUConditionalReturn_ReturnValue(gameBoard == nil, YES, 0.0f);

	NSUInteger const numberOfRows = [gameBoard gameBoardTiles_numberOfRows];
	kRUConditionalReturn_ReturnValue(numberOfRows <= 0, YES, 0.0f);

	return CGRectGetHeight(self.bounds) / numberOfRows;
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
		NSAssert(gameBoardEntityView.superview == self, @"Should be self");
		NSAssert([gameBoardEntityView_mappedDataCollection_old mappableObject_exists:gameBoardEntityView], @"Should be removed.");
		NSAssert([self.gameBoardEntityView_mappedDataCollection mappableObject_exists:gameBoardEntityView] == false, @"Should be removed.");

		[gameBoardEntityView removeFromSuperview];
	}];

	[newObjects enumerateObjectsUsingBlock:^(SMBGameBoardGeneralEntityView * _Nonnull gameBoardEntityView, NSUInteger idx, BOOL * _Nonnull stop) {
		NSAssert(gameBoardEntityView.superview == nil, @"Should have no superview");
		NSAssert([gameBoardEntityView_mappedDataCollection_old mappableObject_exists:gameBoardEntityView] == false, @"Should be new.");
		NSAssert([self.gameBoardEntityView_mappedDataCollection mappableObject_exists:gameBoardEntityView], @"Should be new.");

		[self addSubview:gameBoardEntityView];
	}];
}

-(void)gameBoardEntityView_mappedDataCollection_update
{
	SMBMutableMappedDataCollection<SMBGameBoardGeneralEntityView*>* const gameBoardEntityView_mappedDataCollection_new = [[SMBMutableMappedDataCollection<SMBGameBoardGeneralEntityView*> alloc] init_with_mappedDataCollection:self.gameBoardEntityView_mappedDataCollection];

	[self.gameBoard.gameBoardEntities enumerateObjectsUsingBlock:^(SMBGameBoardEntity * _Nonnull gameBoardEntity, NSUInteger idx, BOOL * _Nonnull stop) {
		NSString* const uniqueKey = [gameBoardEntity smb_uniqueKey];

		if ([gameBoardEntityView_mappedDataCollection_new mappableObject_for_uniqueKey:uniqueKey] == nil)
		{
			[gameBoardEntityView_mappedDataCollection_new mappableObject_add:[[SMBGameBoardGeneralEntityView alloc] init_with_gameBoardView:self
																													 gameBoardGeneralEntity:gameBoardEntity]];
		}
	}];

	[self setGameBoardEntityView_mappedDataCollection:[gameBoardEntityView_mappedDataCollection_new copy]];
}

-(void)gameBoardEntityView_mappedDataCollection_layout
{
	[[self.gameBoardEntityView_mappedDataCollection mappableObjects] enumerateObjectsUsingBlock:^(SMBGameBoardGeneralEntityView* _Nonnull gameBoardGeneralEntityView, NSUInteger idx, BOOL * _Nonnull stop) {
		NSAssert(gameBoardGeneralEntityView.superview == self, @"Should be by now.");
		[gameBoardGeneralEntityView setFrame:self.bounds];
	}];
}

#pragma mark - gameBoardTilePosition
-(CGRect)gameBoardTilePosition_frame:(nonnull SMBGameBoardTilePosition*)gameBoardTilePosition
{
	kRUConditionalReturn_ReturnValue(gameBoardTilePosition == nil, YES, CGRectZero);

	CGFloat const gameBoardEntityView_width = [self gameBoardTileEntityView_width];
	CGFloat const gameBoardEntityView_height = [self gameBoardTileEntityView_height];

	return (CGRect){
		.origin.x		= gameBoardEntityView_width * gameBoardTilePosition.column,
		.origin.y		= gameBoardEntityView_height * gameBoardTilePosition.row,
		.size.width		= gameBoardEntityView_width,
		.size.height	= gameBoardEntityView_height,
	};
}

@end
