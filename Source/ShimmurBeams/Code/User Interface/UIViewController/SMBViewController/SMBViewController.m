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
	CGSize const size = [self.gameLevelView sizeThatFits:self.view.bounds.size];

	return CGRectCeilOrigin((CGRect){
		.origin.x	= CGRectGetHorizontallyAlignedXCoordForWidthOnWidth(size.width, CGRectGetWidth(self.view.bounds)),
		.origin.y	= CGRectGetVerticallyAlignedYCoordForHeightOnHeight(size.height, CGRectGetHeight(self.view.bounds)),
		.size		= size,
	});
}

@end
