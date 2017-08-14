//
//  SMBGameLevelGeneratorViewController.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/14/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameLevelGeneratorViewController.h"
#import "SMBGameLevelGenerator.h"
#import "SMBGameLevelView.h"
#import "SMBGameLevel.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/UIView+RUUtility.h>
#import <ResplendentUtilities/RUConstants.h>





static void* kSMBGameLevelGeneratorViewController__KVOContext = &kSMBGameLevelGeneratorViewController__KVOContext;





@interface SMBGameLevelGeneratorViewController ()

#pragma mark - gameLevelGenerator_gameLevel
@property (nonatomic, strong, nullable) SMBGameLevel* gameLevelGenerator_gameLevel;
-(void)gameLevelGenerator_gameLevel_update;
-(nullable SMBGameLevel*)gameLevelGenerator_gameLevel_generate;
-(void)gameLevelGenerator_gameLevel_didComplete;
-(void)gameLevelGenerator_gameLevel_setKVORegistered:(BOOL)registered;

#pragma mark - gameLevelView
@property (nonatomic, readonly, strong, nullable) SMBGameLevelView* gameLevelView;
-(CGRect)gameLevelView_frame;
-(void)gameLevelView_level_update;

#pragma mark - navigationItem_title
-(void)navigationItem_title_update;
-(nullable NSString*)navigationItem_title_generate;

@end





@implementation SMBGameLevelGeneratorViewController

#pragma mark - NSObject
-(void)dealloc
{
	[self gameLevelGenerator_gameLevel_setKVORegistered:NO];
}

#pragma mark - UIViewController
-(void)viewDidLoad
{
	[super viewDidLoad];

	[self setAutomaticallyAdjustsScrollViewInsets:NO];

	[self.view setBackgroundColor:[UIColor whiteColor]];

	_gameLevelView = [SMBGameLevelView new];
	[self.view addSubview:self.gameLevelView];
	[self gameLevelView_level_update];

	[self navigationItem_title_update];
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

	[self navigationItem_title_update];
	[self gameLevelGenerator_gameLevel_update];
}

#pragma mark - gameLevelGenerator_gameLevel
-(void)setGameLevelGenerator_gameLevel:(nullable SMBGameLevel*)gameLevelGenerator_gameLevel
{
	kRUConditionalReturn(self.gameLevelGenerator_gameLevel == gameLevelGenerator_gameLevel, NO)

	[self gameLevelGenerator_gameLevel_setKVORegistered:NO];

	_gameLevelGenerator_gameLevel = gameLevelGenerator_gameLevel;

	[self gameLevelView_level_update];

	[self gameLevelGenerator_gameLevel_setKVORegistered:YES];
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

-(void)gameLevelGenerator_gameLevel_didComplete
{
	id<SMBGameLevelGeneratorViewController_gameLevelDidCompleteDelegate> const gameLevelDidCompleteDelegate = self.gameLevelDidCompleteDelegate;
	kRUConditionalReturn(gameLevelDidCompleteDelegate == nil, YES);

	SMBGameLevel* const gameLevelGenerator_gameLevel = self.gameLevelGenerator_gameLevel;
	kRUConditionalReturn(gameLevelGenerator_gameLevel == nil, YES);

	[gameLevelDidCompleteDelegate gameLevelGeneratorViewController:self
											  gameLevelDidComplete:gameLevelGenerator_gameLevel];
}

-(void)gameLevelGenerator_gameLevel_setKVORegistered:(BOOL)registered
{
	typeof(self.gameLevelGenerator_gameLevel) const gameLevelGenerator_gameLevel = self.gameLevelGenerator_gameLevel;
	kRUConditionalReturn(gameLevelGenerator_gameLevel == nil, NO);

	NSMutableArray<NSString*>* const propertiesToObserve = [NSMutableArray<NSString*> array];
	[propertiesToObserve addObject:[SMBGameLevel_PropertiesForKVO isComplete]];

	[propertiesToObserve enumerateObjectsUsingBlock:^(NSString * _Nonnull propertyToObserve, NSUInteger idx, BOOL * _Nonnull stop) {
		if (registered)
		{
			[gameLevelGenerator_gameLevel addObserver:self
										   forKeyPath:propertyToObserve
											  options:(NSKeyValueObservingOptionInitial)
											  context:&kSMBGameLevelGeneratorViewController__KVOContext];
		}
		else
		{
			[gameLevelGenerator_gameLevel removeObserver:self
											  forKeyPath:propertyToObserve
												 context:&kSMBGameLevelGeneratorViewController__KVOContext];
		}
	}];
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

-(void)gameLevelView_level_update
{
	SMBGameLevelView* const gameLevelView = self.gameLevelView;
	kRUConditionalReturn(gameLevelView == nil, NO);

	[gameLevelView setGameLevel:self.gameLevelGenerator_gameLevel];

	if ([self isViewLoaded])
	{
		[self.view setNeedsLayout];
	}
}

#pragma mark - navigationItem_title
-(void)navigationItem_title_update
{
	[self.navigationItem setTitle:[self navigationItem_title_generate]];
}

-(nullable NSString*)navigationItem_title_generate
{
	return self.gameLevelGenerator.name;
}

#pragma mark - KVO
-(void)observeValueForKeyPath:(nullable NSString*)keyPath ofObject:(nullable id)object change:(nullable NSDictionary*)change context:(nullable void*)context
{
	if (context == kSMBGameLevelGeneratorViewController__KVOContext)
	{
		if (object == self.gameLevelGenerator_gameLevel)
		{
			if ([keyPath isEqualToString:[SMBGameLevel_PropertiesForKVO isComplete]])
			{
				SMBGameLevel* const gameLevelGenerator_gameLevel = self.gameLevelGenerator_gameLevel;
				kRUConditionalReturn(gameLevelGenerator_gameLevel == nil, YES);

				kRUConditionalReturn(gameLevelGenerator_gameLevel.isComplete == NO, NO);

				[self gameLevelGenerator_gameLevel_didComplete];
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

@end
