//
//  SMBGameBoardView.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/4/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardView.h"
#import "SMBGameBoard.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@interface SMBGameBoardView ()

#pragma mark - shapeLayer
@property (nonatomic, readonly, strong, nullable) CAShapeLayer* shapeLayer;
-(CGRect)shapeLayer_frame;
-(void)shapeLayer_path_update;

@end





@implementation SMBGameBoardView

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

		_shapeLayer = [CAShapeLayer layer];
		[self.shapeLayer setFillColor:nil];
		[self.shapeLayer setLineWidth:1.0f / [UIScreen mainScreen].scale];
		[self.shapeLayer setStrokeColor:[UIColor colorWithWhite:0.5f alpha:0.5f].CGColor];

		[self.layer addSublayer:self.shapeLayer];
	}

	return self;
}

-(void)layoutSubviews
{
	[super layoutSubviews];

	[self shapeLayer_path_update];
	[self.shapeLayer setFrame:[self shapeLayer_frame]];
}

#pragma mark - gameBoard
-(void)setGameBoard:(nullable SMBGameBoard*)gameBoard
{
	kRUConditionalReturn(self.gameBoard == gameBoard, NO);

	_gameBoard = gameBoard;

	[self shapeLayer_path_update];
}

#pragma mark - shapeLayer
-(CGRect)shapeLayer_frame
{
	return self.bounds;
}

-(void)shapeLayer_path_update
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
		CGFloat const horizontal_increment = CGRectGetWidth(self.bounds) / (CGFloat)numberOfColumns;
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

	[self.shapeLayer setPath:bezierPath.CGPath];
}

@end
