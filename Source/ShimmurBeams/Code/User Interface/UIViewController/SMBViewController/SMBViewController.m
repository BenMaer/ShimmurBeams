//
//  SMBViewController.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/3/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBViewController.h"
#import "SMBGameLevelView.h"

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
	
	[self.view setBackgroundColor:[UIColor yellowColor]];

	_gameLevelView = [SMBGameLevelView new];
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
	CGFloat const dimension_length = CGRectGetWidth(self.view.bounds);
	return CGRectCeilOrigin((CGRect){
		.origin.x		= CGRectGetHorizontallyAlignedXCoordForWidthOnWidth(dimension_length, CGRectGetWidth(self.view.bounds)),
		.origin.y		= CGRectGetVerticallyAlignedYCoordForHeightOnHeight(dimension_length, CGRectGetHeight(self.view.bounds)),
		.size.width		= dimension_length,
		.size.height	= dimension_length,
	});
}

@end
