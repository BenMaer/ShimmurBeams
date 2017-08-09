//
//  SMBViewController.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/3/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBViewController.h"
#import "SMBGameLevelView.h"
#import "SMBGameLevel+SMBTestLevel.h"
#import "SMBGameBoard.h"

#import <ResplendentUtilities/UIView+RUUtility.h>





@interface SMBViewController ()

#pragma mark - gameLevelView
@property (nonatomic, readonly, strong, nullable) SMBGameLevelView* gameLevelView;
-(CGRect)gameLevelView_frame;

@end





@implementation SMBViewController

#pragma mark - UIViewController
-(void)viewDidLoad
{
	[super viewDidLoad];

	[self.view setBackgroundColor:[UIColor whiteColor]];

	_gameLevelView = [SMBGameLevelView new];
	[self.gameLevelView setGameLevel:[SMBGameLevel smb_testLevel]];
	NSAssert(self.gameLevelView.gameLevel != nil, @"Unable to load level");
	[self.view addSubview:self.gameLevelView];
}

-(void)viewWillLayoutSubviews
{
	[super viewWillLayoutSubviews];

	[self.gameLevelView setFrame:[self gameLevelView_frame]];
}

#pragma mark - gameLevelView
-(CGRect)gameLevelView_frame
{
	CGFloat const inset = 10.0f;

	NSUInteger const numberOfColumns = [self.gameLevelView.gameLevel.gameBoard gameBoardTiles_numberOfColumns];
	NSUInteger const numberOfRows = [self.gameLevelView.gameLevel.gameBoard gameBoardTiles_numberOfRows];

	CGFloat const width_perItem_bounded = floor((CGRectGetWidth(self.view.bounds) - (inset * 2.0f)) / (CGFloat)numberOfColumns);
	CGFloat const height_perItem_bounded = floor((CGRectGetHeight(self.view.bounds) - (inset * 2.0f)) / (CGFloat)numberOfRows);

	CGFloat const dimension_length = MIN(width_perItem_bounded, height_perItem_bounded);

	CGFloat const width = dimension_length * (CGFloat)numberOfColumns;
	CGFloat const height = dimension_length * (CGFloat)numberOfRows;

	return CGRectCeilOrigin((CGRect){
		.origin.x		= CGRectGetHorizontallyAlignedXCoordForWidthOnWidth(width, CGRectGetWidth(self.view.bounds)),
		.origin.y		= CGRectGetVerticallyAlignedYCoordForHeightOnHeight(height, CGRectGetHeight(self.view.bounds)),
		.size.width		= width,
		.size.height	= height,
	});
}

@end
