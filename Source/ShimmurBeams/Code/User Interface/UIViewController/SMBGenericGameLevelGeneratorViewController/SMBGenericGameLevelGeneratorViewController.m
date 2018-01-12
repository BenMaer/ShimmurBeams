//
//  SMBGenericGameLevelGeneratorViewController.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 1/11/18.
//  Copyright © 2018 Shimmur. All rights reserved.
//

#import "SMBGenericGameLevelGeneratorViewController.h"
#import "SMBGameLevelGenerator.h"
#import "SMBGameLevelView.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/UIView+RUUtility.h>
#import <ResplendentUtilities/NSMutableArray+RUAddObjectIfNotNil.h>





@interface SMBGenericGameLevelGeneratorViewController ()

#pragma mark - gameLevelGenerator_gameLevel
@property (nonatomic, strong, nullable) SMBGameLevel* gameLevelGenerator_gameLevel;
-(void)gameLevelGenerator_gameLevel_update;
-(nullable SMBGameLevel*)gameLevelGenerator_gameLevel_generate;

#pragma mark - gameLevelView
@property (nonatomic, readonly, strong, nullable) SMBGameLevelView* gameLevelView;
-(CGRect)gameLevelView_frame;
-(void)gameLevelView_level_update;

#pragma mark - resetBarButtonItem
@property (nonatomic, readonly, strong, nullable) UIBarButtonItem* resetBarButtonItem;
-(void)resetBarButtonItem_action_didFire;

@end





@implementation SMBGenericGameLevelGeneratorViewController

#pragma mark - UIViewController
-(void)viewDidLoad
{
	[super viewDidLoad];

	[self setEdgesForExtendedLayout:UIRectEdgeNone];
	[self setAutomaticallyAdjustsScrollViewInsets:NO];
	[self.navigationItem setLeftItemsSupplementBackButton:YES];
	
	[self.view setBackgroundColor:[UIColor whiteColor]];

	_resetBarButtonItem =
	[[UIBarButtonItem alloc] initWithTitle:@"Reset"
									 style:UIBarButtonItemStylePlain
									target:self
									action:@selector(resetBarButtonItem_action_didFire)];

	[self navigationItem_rightBarButtonItems_update];

	_gameLevelView = [SMBGameLevelView new];
	[self.view addSubview:self.gameLevelView];
	[self gameLevelView_level_update];
}

-(void)viewWillLayoutSubviews
{
	[super viewWillLayoutSubviews];
	
	[self.gameLevelView setFrame:[self gameLevelView_frame]];
}

#pragma mark - gameLevelGenerator
-(void)setGameLevelGenerator:(nullable SMBGameLevelGenerator*)gameLevelGenerator
{
	kRUConditionalReturn(self.gameLevelGenerator == gameLevelGenerator, NO);
	
	_gameLevelGenerator = gameLevelGenerator;

	[self gameLevelGenerator_gameLevel_update];
}

#pragma mark - gameLevelGenerator_gameLevel
-(void)setGameLevelGenerator_gameLevel:(nullable SMBGameLevel*)gameLevelGenerator_gameLevel
{
	kRUConditionalReturn(self.gameLevelGenerator_gameLevel == gameLevelGenerator_gameLevel, NO)

	[self gameLevelGenerator_gameLevel_will_update];

	_gameLevelGenerator_gameLevel = gameLevelGenerator_gameLevel;

	[self gameLevelGenerator_gameLevel_did_update];
}

-(void)gameLevelGenerator_gameLevel_update
{
	[self setGameLevelGenerator_gameLevel:[self gameLevelGenerator_gameLevel_generate]];
}

-(nullable SMBGameLevel*)gameLevelGenerator_gameLevel_generate
{
	SMBGameLevelGenerator* const gameLevelGenerator = self.gameLevelGenerator;
	kRUConditionalReturn_ReturnValueNil(gameLevelGenerator == nil, NO);
	
	return [gameLevelGenerator gameLevel_generate];
}

-(void)gameLevelGenerator_gameLevel_regenerate
{
	kRUConditionalReturn(self.gameLevelGenerator == nil, YES);
	kRUConditionalReturn(self.gameLevelGenerator_gameLevel == nil, YES);

	[self gameLevelGenerator_gameLevel_update];
}

-(void)gameLevelGenerator_gameLevel_will_update{}

-(void)gameLevelGenerator_gameLevel_did_update
{
	[self gameLevelView_level_update];
}

#pragma mark - gameLevelView
-(void)setGameLevelView_frame_insets:(UIEdgeInsets)gameLevelView_frame_insets
{
	kRUConditionalReturn(UIEdgeInsetsEqualToEdgeInsets(self.gameLevelView_frame_insets, gameLevelView_frame_insets), NO);

	_gameLevelView_frame_insets = gameLevelView_frame_insets;

	if (self.isViewLoaded)
	{
		[self.view setNeedsLayout];
	}
}

-(CGRect)gameLevelView_frame
{
	UIEdgeInsets const gameLevelView_frame_insets = self.gameLevelView_frame_insets;
	CGRect const bounds = self.view.bounds;

	CGRect const bounds_inset = UIEdgeInsetsInsetRect(bounds,
													  gameLevelView_frame_insets);
//	CGSize const gameLevelView_boundingSize = bounds_inset.size;
	
	CGSize const size =
	[self.gameLevelView sizeThatFits:bounds_inset.size];
	
	return CGRectCeilOrigin((CGRect){
		.origin.x	= CGRectGetHorizontallyAlignedXCoordForWidthOnWidth(size.width, CGRectGetWidth(bounds)),
		.origin.y	= CGRectGetMinY(bounds_inset),
		.size		= size,
	});
}

-(void)gameLevelView_level_update
{
	SMBGameLevelView* const gameLevelView = self.gameLevelView;
	kRUConditionalReturn(gameLevelView == nil, NO);
	
	[gameLevelView setGameLevel:self.gameLevelGenerator_gameLevel];
	
	if ([self isViewLoaded])
	{
		[self.view setUserInteractionEnabled:YES];
		[self.view setNeedsLayout];
	}
}

#pragma mark - resetBarButtonItem
-(void)resetBarButtonItem_action_didFire
{
	[self gameLevelGenerator_gameLevel_update];
}

#pragma mark - navigationItem_rightBarButtonItems
-(void)navigationItem_rightBarButtonItems_update
{
	[self.navigationItem setRightBarButtonItems:[self navigationItem_rightBarButtonItems_generate]];
}

-(nullable NSArray<UIBarButtonItem*>*)navigationItem_rightBarButtonItems_generate
{
	NSMutableArray<UIBarButtonItem*>* const navigationItem_rightBarButtonItems = [NSMutableArray<UIBarButtonItem*> array];
	[navigationItem_rightBarButtonItems ru_addObjectIfNotNil:self.resetBarButtonItem];

	return [NSArray<UIBarButtonItem*> arrayWithArray:navigationItem_rightBarButtonItems];
}

@end
