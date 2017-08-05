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

#pragma mark - draw
-(void)draw_grid_in_rect:(CGRect)rect;
-(void)draw_edges_in_rect:(CGRect)rect;

@end





@implementation SMBGameBoardView

#pragma mark - UIView
-(instancetype)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame])
	{
		[self setBackgroundColor:[UIColor clearColor]];
	}
	
	return self;
}

-(void)drawRect:(CGRect)rect
{
	[super drawRect:rect];

	CGContextClearRect(UIGraphicsGetCurrentContext(), rect);

	[self draw_grid_in_rect:rect];
	[self draw_edges_in_rect:rect];
}

#pragma mark - gameBoard
-(void)setGameBoard:(nullable SMBGameBoard*)gameBoard
{
	kRUConditionalReturn(self.gameBoard == gameBoard, NO);

	_gameBoard = gameBoard;

	[self setNeedsDisplay];
}

#pragma mark - draw
-(void)draw_grid_in_rect:(CGRect)rect
{
	SMBGameBoard* const gameBoard = self.gameBoard;
	kRUConditionalReturn(gameBoard == nil, NO);

	NSUInteger const numberOfColumns = [gameBoard gameBoardTiles_numberOfColumns];
	kRUConditionalReturn(numberOfColumns <= 0, YES);

	NSUInteger const numberOfRows = [gameBoard gameBoardTiles_numberOfRows];
	kRUConditionalReturn(numberOfRows <= 0, YES);

	CGContextRef const context = UIGraphicsGetCurrentContext();

	CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:0.5f alpha:0.5f].CGColor);
	CGContextSetLineWidth(context, 1.0f / [UIScreen mainScreen].scale);

	if (numberOfColumns > 1)
	{
		CGFloat const horizontal_increment = CGRectGetWidth(rect) / (CGFloat)numberOfColumns;
		for (NSUInteger columnToDraw = 1;
			 columnToDraw < numberOfColumns;
			 columnToDraw++)
		{
			CGFloat const xCoord = CGRectGetMinX(rect) + (horizontal_increment * (CGFloat)columnToDraw);
			CGContextMoveToPoint(context, xCoord, CGRectGetMinY(rect));
			CGContextAddLineToPoint(context, xCoord, CGRectGetMaxY(rect));
		}
	}

	if (numberOfRows > 1)
	{
		CGFloat const vertical_increment = CGRectGetWidth(rect) / (CGFloat)numberOfRows;
		for (NSUInteger rowToDraw = 1;
			 rowToDraw < numberOfRows;
			 rowToDraw++)
		{
			CGFloat const yCoord = CGRectGetMinY(rect) + (vertical_increment * (CGFloat)rowToDraw);
			CGContextMoveToPoint(context, CGRectGetMinX(rect), yCoord);
			CGContextAddLineToPoint(context, CGRectGetMaxX(rect), yCoord);
		}
	}

	CGContextStrokePath(context);
}

-(void)draw_edges_in_rect:(CGRect)rect
{
	CGContextRef const context = UIGraphicsGetCurrentContext();

	CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
	CGContextSetLineWidth(context, 1.0f);

	CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMinY(rect));	/* Top left */
	CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMinY(rect));	/* Top right */
	CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect));	/* Bottom right */
	CGContextAddLineToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect));	/* Bottom left */

	CGContextClosePath(context);

	CGContextStrokePath(context);
}

@end
