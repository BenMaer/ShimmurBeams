//
//  SMBGameLevelGeneratorSetViewController.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/10/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameLevelGeneratorSetViewController.h"
#import "SMBGameLevelView.h"
#import "SMBGameLevelGeneratorSet.h"
#import "SMBGameLevelGenerator.h"

#import <ResplendentUtilities/UIView+RUUtility.h>
#import <ResplendentUtilities/RUConditionalReturn.h>





@interface SMBGameLevelGeneratorSetViewController ()

#pragma mark - gameLevelView
@property (nonatomic, readonly, strong, nullable) SMBGameLevelView* gameLevelView;
-(CGRect)gameLevelView_frame;
-(void)gameLevelView_leve_update;

@end





@implementation SMBGameLevelGeneratorSetViewController

#pragma mark - UIViewController
-(void)viewDidLoad
{
	[super viewDidLoad];
	
	[self setAutomaticallyAdjustsScrollViewInsets:NO];

	[self.view setBackgroundColor:[UIColor whiteColor]];

	_gameLevelView = [SMBGameLevelView new];
	[self gameLevelView_leve_update];
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

-(void)gameLevelView_leve_update
{
	SMBGameLevelView* const gameLevelView = self.gameLevelView;
	kRUConditionalReturn(gameLevelView == nil, NO);

	SMBGameLevelGeneratorSet* const gameLevelGeneratorSet = self.gameLevelGeneratorSet;
	kRUConditionalReturn(gameLevelGeneratorSet == nil, NO);

	[gameLevelView setGameLevel:[[[gameLevelGeneratorSet gameLevelGenerators] firstObject] gameLevel_generate]];
	NSAssert(gameLevelView.gameLevel != nil, @"Should have generated a level");
}

#pragma mark - gameLevelGeneratorSet
-(void)setGameLevelGeneratorSet:(nullable SMBGameLevelGeneratorSet*)gameLevelGeneratorSet
{
	kRUConditionalReturn(self.gameLevelGeneratorSet == gameLevelGeneratorSet, NO);

	_gameLevelGeneratorSet = gameLevelGeneratorSet;

	[self gameLevelView_leve_update];
}

@end
