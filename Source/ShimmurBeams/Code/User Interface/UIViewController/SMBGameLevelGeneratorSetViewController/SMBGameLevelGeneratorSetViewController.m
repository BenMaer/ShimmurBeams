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
#import "SMBGameLevel.h"

#import <ResplendentUtilities/UIView+RUUtility.h>
#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/RUConstants.h>





static void* kSMBGameLevelGeneratorSetViewController__KVOContext = &kSMBGameLevelGeneratorSetViewController__KVOContext;





@interface SMBGameLevelGeneratorSetViewController ()

#pragma mark - gameLevelView_gameLevel
@property (nonatomic, readonly, strong, nullable) SMBGameLevel* gameLevelView_gameLevel;
-(void)gameLevelView_gameLevel_update;
-(nullable SMBGameLevel*)gameLevelView_gameLevel_appropriate;
-(nullable SMBGameLevelGenerator*)gameLevelView_gameLevel_generator_appropriate;

-(void)gameLevelView_gameLevel_didComplete;

#pragma mark - gameLevelView
@property (nonatomic, readonly, strong, nullable) SMBGameLevelView* gameLevelView;
@property (nonatomic, assign) BOOL gameLevelView_isBeingSet;
-(CGRect)gameLevelView_frame;
-(void)gameLevelView_update;

#pragma mark - gameLevelGeneratorSet
@property (nonatomic, assign) NSUInteger gameLevelGeneratorSet_levelIndex;

#pragma mark - navigationItem_title
-(void)navigationItem_title_update;
-(nullable NSString*)navigationItem_title_generate;

@end





@implementation SMBGameLevelGeneratorSetViewController

#pragma mark - NSObject
-(void)dealloc
{
	[self gameLevelView_gameLevel_setKVORegistered:NO];
}

#pragma mark - UIViewController
-(void)viewDidLoad
{
	[super viewDidLoad];
	
	[self setAutomaticallyAdjustsScrollViewInsets:NO];

	[self.view setBackgroundColor:[UIColor whiteColor]];

	_gameLevelView = [SMBGameLevelView new];
	[self gameLevelView_update];
	[self.view addSubview:self.gameLevelView];

	[self navigationItem_title_update];
}

-(void)viewWillLayoutSubviews
{
	[super viewWillLayoutSubviews];
	
	[self.gameLevelView setFrame:[self gameLevelView_frame]];
}

#pragma mark - gameLevelView_gameLevel
-(void)setGameLevelView_gameLevel:(nullable SMBGameLevel*)gameLevelView_gameLevel
{
	kRUConditionalReturn(self.gameLevelView_gameLevel == gameLevelView_gameLevel, NO);

	[self gameLevelView_gameLevel_setKVORegistered:NO];

	_gameLevelView_gameLevel = gameLevelView_gameLevel;

	[self gameLevelView_gameLevel_setKVORegistered:YES];

	[self gameLevelView_update];
}

-(void)gameLevelView_gameLevel_setKVORegistered:(BOOL)registered
{
	typeof(self.gameLevelView_gameLevel) const gameLevelView_gameLevel = self.gameLevelView_gameLevel;
	kRUConditionalReturn(gameLevelView_gameLevel == nil, NO);
	
	NSMutableArray<NSString*>* const propertiesToObserve = [NSMutableArray<NSString*> array];
	[propertiesToObserve addObject:[SMBGameLevel_PropertiesForKVO isComplete]];
	
	[propertiesToObserve enumerateObjectsUsingBlock:^(NSString * _Nonnull propertyToObserve, NSUInteger idx, BOOL * _Nonnull stop) {
		if (registered)
		{
			[gameLevelView_gameLevel addObserver:self
									  forKeyPath:propertyToObserve
										 options:(NSKeyValueObservingOptionInitial)
										 context:&kSMBGameLevelGeneratorSetViewController__KVOContext];
		}
		else
		{
			[gameLevelView_gameLevel removeObserver:self
										 forKeyPath:propertyToObserve
											context:&kSMBGameLevelGeneratorSetViewController__KVOContext];
		}
	}];
}

-(void)gameLevelView_gameLevel_update
{
	[self setGameLevelView_gameLevel:[self gameLevelView_gameLevel_appropriate]];
}

-(nullable SMBGameLevel*)gameLevelView_gameLevel_appropriate
{
	SMBGameLevelGenerator* const gameLevelView_gameLevel_generator_appropriate = [self gameLevelView_gameLevel_generator_appropriate];
	kRUConditionalReturn_ReturnValueNil(gameLevelView_gameLevel_generator_appropriate == nil, YES);
	
	SMBGameLevel* const gameLevel =
	[gameLevelView_gameLevel_generator_appropriate gameLevel_generate];
	NSAssert(gameLevel != nil, @"Should have generated a level");
	
	return gameLevel;
}

-(nullable SMBGameLevelGenerator*)gameLevelView_gameLevel_generator_appropriate
{
	kRUConditionalReturn_ReturnValueNil(self.gameLevelView_isBeingSet == YES, NO);
	
	SMBGameLevelGeneratorSet* const gameLevelGeneratorSet = self.gameLevelGeneratorSet;
	kRUConditionalReturn_ReturnValueNil(gameLevelGeneratorSet == nil, NO);
	
	NSArray<SMBGameLevelGenerator*>* const gameLevelGenerators = gameLevelGeneratorSet.gameLevelGenerators;
	kRUConditionalReturn_ReturnValueNil(gameLevelGenerators == nil, NO);
	
	NSUInteger const gameLevelGeneratorSet_levelIndex = self.gameLevelGeneratorSet_levelIndex;
	kRUConditionalReturn_ReturnValueNil(gameLevelGeneratorSet_levelIndex >= gameLevelGenerators.count, NO);
	
	return [gameLevelGenerators objectAtIndex:gameLevelGeneratorSet_levelIndex];
}

-(void)gameLevelView_gameLevel_didComplete
{
	SMBGameLevelGeneratorSet* const gameLevelGeneratorSet = self.gameLevelGeneratorSet;
	kRUConditionalReturn(gameLevelGeneratorSet == nil, YES);

	NSArray<SMBGameLevelGenerator*>* const gameLevelGenerators = gameLevelGeneratorSet.gameLevelGenerators;
	kRUConditionalReturn(gameLevelGenerators == nil, YES);

	NSUInteger const gameLevelGeneratorSet_levelIndex = self.gameLevelGeneratorSet_levelIndex;
	NSUInteger const gameLevelGeneratorSet_levelIndex_new = gameLevelGeneratorSet_levelIndex + 1;
	if (gameLevelGeneratorSet_levelIndex_new < gameLevelGenerators.count)
	{
		UIAlertController* const alertController =
		[UIAlertController alertControllerWithTitle:@"Congratulations!"
											message:RUStringWithFormat(@"You beat level %lu! Continue to the next level?",gameLevelGeneratorSet_levelIndex + 1)
									 preferredStyle:UIAlertControllerStyleAlert];
		
		__weak typeof(self) const self_weak = self;
		[alertController addAction:
		 [UIAlertAction actionWithTitle:@"Yes"
								  style:UIAlertActionStyleDefault
								handler:
		  ^(UIAlertAction * _Nonnull action) {
			  [self_weak setGameLevelGeneratorSet_levelIndex:gameLevelGeneratorSet_levelIndex_new];
		  }]];

		[alertController addAction:
		 [UIAlertAction actionWithTitle:@"Quit"
								  style:UIAlertActionStyleDefault
								handler:
		  ^(UIAlertAction * _Nonnull action) {
			  [self_weak.navigationController popViewControllerAnimated:YES];
		  }]];

		[self presentViewController:alertController animated:YES completion:nil];
	}
	else
	{
		UIAlertController* const alertController =
		[UIAlertController alertControllerWithTitle:@"Congratulations!"
											message:@"You have beaten the last level in this set!"
									 preferredStyle:UIAlertControllerStyleAlert];

		__weak typeof(self) const self_weak = self;
		[alertController addAction:
		 [UIAlertAction actionWithTitle:@"Awesome!"
								  style:UIAlertActionStyleDefault
								handler:
		  ^(UIAlertAction * _Nonnull action) {
			  [self_weak.navigationController popViewControllerAnimated:YES];
		  }]];

		[self presentViewController:alertController animated:YES completion:nil];
	}
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

-(void)gameLevelView_update
{
	SMBGameLevelView* const gameLevelView = self.gameLevelView;
	kRUConditionalReturn(gameLevelView == nil, NO);

	[gameLevelView setGameLevel:self.gameLevelView_gameLevel];
}

#pragma mark - gameLevelGeneratorSet
-(void)setGameLevelGeneratorSet:(nullable SMBGameLevelGeneratorSet*)gameLevelGeneratorSet
{
	kRUConditionalReturn(self.gameLevelGeneratorSet == gameLevelGeneratorSet, NO);

	[self setGameLevelView_isBeingSet:YES];

	_gameLevelGeneratorSet = gameLevelGeneratorSet;
	[self setGameLevelGeneratorSet_levelIndex:0];

	[self setGameLevelView_isBeingSet:NO];

	[self gameLevelView_gameLevel_update];
}

#pragma mark - KVO
-(void)observeValueForKeyPath:(nullable NSString*)keyPath ofObject:(nullable id)object change:(nullable NSDictionary*)change context:(nullable void*)context
{
	if (context == kSMBGameLevelGeneratorSetViewController__KVOContext)
	{
		if (object == self.gameLevelView_gameLevel)
		{
			if ([keyPath isEqualToString:[SMBGameLevel_PropertiesForKVO isComplete]])
			{
				SMBGameLevel* const gameLevelView_gameLevel = self.gameLevelView_gameLevel;
				kRUConditionalReturn(gameLevelView_gameLevel == nil, YES);

				kRUConditionalReturn(gameLevelView_gameLevel.isComplete == NO, NO);

				[self gameLevelView_gameLevel_didComplete];
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

#pragma mark - gameLevelGeneratorSet
-(void)setGameLevelGeneratorSet_levelIndex:(NSUInteger)gameLevelGeneratorSet_levelIndex
{
	kRUConditionalReturn(self.gameLevelGeneratorSet_levelIndex == gameLevelGeneratorSet_levelIndex, NO);

	_gameLevelGeneratorSet_levelIndex = gameLevelGeneratorSet_levelIndex;

	[self navigationItem_title_update];
	[self gameLevelView_gameLevel_update];
}

#pragma mark - navigationItem_title
-(void)navigationItem_title_update
{
	[self.navigationItem setTitle:[self navigationItem_title_generate]];
}

-(nullable NSString*)navigationItem_title_generate
{
	return
	RUStringWithFormat(@"%@      %lu/%lu",
					   [[self gameLevelView_gameLevel_generator_appropriate] name],
					   (unsigned long)self.gameLevelGeneratorSet_levelIndex + 1,
					   (unsigned long)self.gameLevelGeneratorSet.gameLevelGenerators.count
					   );
}

@end
