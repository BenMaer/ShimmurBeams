//
//  SMBGameLevelGeneratorSetViewController.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/10/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameLevelGeneratorSetViewController.h"
#import "SMBGameLevelGeneratorSet.h"
#import "SMBGameLevelGenerator.h"
#import "SMBGameLevelGeneratorViewController.h"
#import "SMBGameLevel.h"
#import "SMBGameLevelCompletion.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/RUConstants.h>
#import <ResplendentUtilities/NSString+RUMacros.h>





@interface SMBGameLevelGeneratorSetViewController () <SMBGameLevelGeneratorViewController_gameLevelDidCompleteDelegate, UITableViewDataSource, UITableViewDelegate, SMBGameLevelGeneratorViewController_levelSuccessBarButtonItemDelegate>

#pragma mark - gameLevelGeneratorViewController
@property (nonatomic, weak, nullable) SMBGameLevelGeneratorViewController* gameLevelGeneratorViewController;
-(void)gameLevelGeneratorViewController_push_attempt;
-(void)gameLevelGeneratorViewController_gameLevelGenerator_updateExisting;
-(void)gameLevelGeneratorViewController_regenerateLevel;

-(void)gameLevelGeneratorViewController_levelSuccessBarButtonItem_action_didFire;

#pragma mark - gameLevelGenerator
@property (nonatomic, assign) BOOL gameLevelGenerator_appropriate_disable;
-(nullable SMBGameLevelGenerator*)gameLevelGenerator_appropriate;

#pragma mark - gameLevelGeneratorSet
@property (nonatomic, assign) NSUInteger gameLevelGeneratorSet_levelIndex;
-(void)gameLevelGeneratorSet_levelIndex_increment_attempt_with_alertControllers:(BOOL)alertControllers;

#pragma mark - tableView
@property (nonatomic, readonly, strong, nullable) UITableView* tableView;
-(CGRect)tableView_frame;

#pragma mark - gameLevelGenerators
-(nullable SMBGameLevelGenerator*)gameLevelGenerator_at_index:(NSUInteger)gameLevelGenerator_index;
-(NSUInteger)gameLevelGenerator_index_for_indexPathSection:(NSInteger)indexPathSection;

#pragma mark - navigationItem_title
-(void)navigationItem_title_update;
-(nullable NSString*)navigationItem_title_generate;

@end





@implementation SMBGameLevelGeneratorSetViewController

#pragma mark - UIViewController
-(void)viewDidLoad
{
	[super viewDidLoad];

	[self navigationItem_title_update];

	[self.view setBackgroundColor:[UIColor whiteColor]];

	_tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
	[self.tableView setBackgroundColor:[UIColor clearColor]];
	[self.tableView setDataSource:self];
	[self.tableView setDelegate:self];
	[self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
	[self.view addSubview:self.tableView];
}

-(void)viewWillLayoutSubviews
{
	[super viewWillLayoutSubviews];

	[self.tableView setFrame:[self tableView_frame]];
}

#pragma mark - gameLevelGeneratorViewController
-(void)setGameLevelGeneratorViewController:(nullable SMBGameLevelGeneratorViewController*)gameLevelGeneratorViewController
{
	kRUConditionalReturn(self.gameLevelGeneratorViewController == gameLevelGeneratorViewController, NO);

	_gameLevelGeneratorViewController = gameLevelGeneratorViewController;

	if (self.gameLevelGeneratorViewController)
	{
		[self gameLevelGeneratorViewController_gameLevelGenerator_updateExisting];
	}
}

-(void)gameLevelGeneratorViewController_push_attempt
{
	kRUConditionalReturn(self.gameLevelGeneratorViewController != nil, YES);

	SMBGameLevelGeneratorViewController* const gameLevelGeneratorViewController = [SMBGameLevelGeneratorViewController new];
	[gameLevelGeneratorViewController setGameLevelDidCompleteDelegate:self];
	[gameLevelGeneratorViewController setLevelSuccessBarButtonItemDelegate:self];

	[self setGameLevelGeneratorViewController:gameLevelGeneratorViewController];
	kRUConditionalReturn(self.gameLevelGeneratorViewController == nil, YES);

	[self.navigationController pushViewController:gameLevelGeneratorViewController animated:YES];
}

-(void)gameLevelGeneratorViewController_gameLevelGenerator_updateExisting
{
	SMBGameLevelGeneratorViewController* const gameLevelGeneratorViewController = self.gameLevelGeneratorViewController;
	kRUConditionalReturn(gameLevelGeneratorViewController == nil, NO);

	SMBGameLevelGenerator* const gameLevelGenerator_appropriate = [self gameLevelGenerator_appropriate];
	kRUConditionalReturn(gameLevelGenerator_appropriate == nil, NO);

	[gameLevelGeneratorViewController setGameLevelGenerator:gameLevelGenerator_appropriate];
}

-(void)gameLevelGeneratorViewController_regenerateLevel
{
	SMBGameLevelGeneratorViewController* const gameLevelGeneratorViewController = self.gameLevelGeneratorViewController;
	kRUConditionalReturn(gameLevelGeneratorViewController == nil, YES);

	[gameLevelGeneratorViewController gameLevelGenerator_gameLevel_regenerate];
}

-(void)gameLevelGeneratorViewController_levelSuccessBarButtonItem_action_didFire
{
	[self gameLevelGeneratorSet_levelIndex_increment_attempt_with_alertControllers:NO];
}

#pragma mark - gameLevelGenerator
-(nullable SMBGameLevelGenerator*)gameLevelGenerator_appropriate
{
	kRUConditionalReturn_ReturnValueNil(self.gameLevelGenerator_appropriate_disable == YES, NO);

	SMBGameLevelGeneratorSet* const gameLevelGeneratorSet = self.gameLevelGeneratorSet;
	kRUConditionalReturn_ReturnValueNil(gameLevelGeneratorSet == nil, NO);

	NSArray<SMBGameLevelGenerator*>* const gameLevelGenerators = gameLevelGeneratorSet.gameLevelGenerators;
	kRUConditionalReturn_ReturnValueNil(gameLevelGenerators == nil, NO);

	NSUInteger const gameLevelGeneratorSet_levelIndex = self.gameLevelGeneratorSet_levelIndex;
	kRUConditionalReturn_ReturnValueNil(gameLevelGeneratorSet_levelIndex >= gameLevelGenerators.count, NO);

	return [gameLevelGenerators objectAtIndex:gameLevelGeneratorSet_levelIndex];
}

#pragma mark - gameLevelGeneratorSet
-(void)setGameLevelGeneratorSet:(nullable SMBGameLevelGeneratorSet*)gameLevelGeneratorSet
{
	kRUConditionalReturn(self.gameLevelGeneratorSet == gameLevelGeneratorSet, NO);

	[self setGameLevelGenerator_appropriate_disable:YES];

	_gameLevelGeneratorSet = gameLevelGeneratorSet;
	[self setGameLevelGeneratorSet_levelIndex:0];

	[self setGameLevelGenerator_appropriate_disable:NO];

	[self navigationItem_title_update];
	[self gameLevelGeneratorViewController_gameLevelGenerator_updateExisting];
}

#pragma mark - gameLevelGeneratorSet
-(void)setGameLevelGeneratorSet_levelIndex:(NSUInteger)gameLevelGeneratorSet_levelIndex
{
	kRUConditionalReturn(self.gameLevelGeneratorSet_levelIndex == gameLevelGeneratorSet_levelIndex, NO);

	_gameLevelGeneratorSet_levelIndex = gameLevelGeneratorSet_levelIndex;

	[self gameLevelGeneratorViewController_gameLevelGenerator_updateExisting];
}

-(void)gameLevelGeneratorSet_levelIndex_increment_attempt_with_alertControllers:(BOOL)alertControllers
{
	SMBGameLevelGeneratorSet* const gameLevelGeneratorSet = self.gameLevelGeneratorSet;
	kRUConditionalReturn(gameLevelGeneratorSet == nil, YES);

	NSArray<SMBGameLevelGenerator*>* const gameLevelGenerators = gameLevelGeneratorSet.gameLevelGenerators;
	kRUConditionalReturn(gameLevelGenerators == nil, YES);

	NSUInteger const gameLevelGeneratorSet_levelIndex = self.gameLevelGeneratorSet_levelIndex;

	NSUInteger const gameLevelGeneratorSet_levelIndex_new = gameLevelGeneratorSet_levelIndex + 1;

	if (gameLevelGeneratorSet_levelIndex_new < gameLevelGenerators.count)
	{
		__weak typeof(self) const self_weak = self;
		void (^actionBlock)(void) = ^(void){
			[self_weak setGameLevelGeneratorSet_levelIndex:gameLevelGeneratorSet_levelIndex_new];
		};

		if (alertControllers == YES)
		{
			UIAlertController* const alertController =
			[UIAlertController alertControllerWithTitle:@"Congratulations!"
												message:RUStringWithFormat(@"You beat level %lu! Continue to the next level?",(unsigned long)gameLevelGeneratorSet_levelIndex + 1)
										 preferredStyle:UIAlertControllerStyleAlert];
			
			[alertController addAction:
			 [UIAlertAction actionWithTitle:@"Yes"
									  style:UIAlertActionStyleDefault
									handler:
			  ^(UIAlertAction * _Nonnull action) {
				  actionBlock();
			  }]];
			
			[alertController addAction:
			 [UIAlertAction actionWithTitle:@"View"
									  style:UIAlertActionStyleDefault
									handler:nil]];
			
			[alertController addAction:
			 [UIAlertAction actionWithTitle:@"Quit"
									  style:UIAlertActionStyleDefault
									handler:
			  ^(UIAlertAction * _Nonnull action) {
				  [self_weak.navigationController popToViewController:self_weak animated:YES];
			  }]];
			
			[self.navigationController presentViewController:alertController animated:YES completion:nil];
		}
		else
		{
			actionBlock();
		}
	}
	else
	{
		__weak typeof(self) const self_weak = self;
		void (^actionBlock)(void) = ^(void){
			[self_weak.navigationController popToViewController:self_weak animated:YES];
		};

		if (alertControllers == YES)
		{
			UIAlertController* const alertController =
			[UIAlertController alertControllerWithTitle:@"Congratulations!"
												message:@"You have beaten the last level in this set!"
										 preferredStyle:UIAlertControllerStyleAlert];
			
			[alertController addAction:
			 [UIAlertAction actionWithTitle:@"Awesome!"
									  style:UIAlertActionStyleDefault
									handler:
			  ^(UIAlertAction * _Nonnull action) {
				  actionBlock();
			  }]];
			
			[alertController addAction:
			 [UIAlertAction actionWithTitle:@"View"
									  style:UIAlertActionStyleDefault
									handler:nil]];
			
			[self.navigationController presentViewController:alertController animated:YES completion:nil];
		}
		else
		{
			actionBlock();
		}
	}
}

#pragma mark - SMBGameLevelGeneratorViewController_gameLevelDidCompleteDelegate
-(void)gameLevelGeneratorViewController:(nonnull SMBGameLevelGeneratorViewController*)gameLevelGeneratorViewController
				   gameLevelDidComplete:(nonnull SMBGameLevel*)gameLevel
{
	kRUConditionalReturn(gameLevel == nil, YES);

	SMBGameLevelCompletion* const gameLevelCompletion = gameLevel.completion;
	kRUConditionalReturn(gameLevelCompletion == nil, YES);

	NSString* const failureReason = gameLevelCompletion.failureReason;
	if (failureReason != nil)
	{
		UIAlertController* const alertController =
		[UIAlertController alertControllerWithTitle:@"Oops!"
											message:RUStringWithFormat(@"%@\nWould you like to retry?",
																	   failureReason)
									 preferredStyle:UIAlertControllerStyleAlert];
		
		__weak typeof(self) const self_weak = self;
		[alertController addAction:
		 [UIAlertAction actionWithTitle:@"Retry"
								  style:UIAlertActionStyleDefault
								handler:
		  ^(UIAlertAction * _Nonnull action) {
			  [self_weak gameLevelGeneratorViewController_regenerateLevel];
		  }]];

		[alertController addAction:
		 [UIAlertAction actionWithTitle:@"View"
								  style:UIAlertActionStyleDefault
								handler:nil]];

		[alertController addAction:
		 [UIAlertAction actionWithTitle:@"Quit"
								  style:UIAlertActionStyleDefault
								handler:
		  ^(UIAlertAction * _Nonnull action) {
			  [self_weak.navigationController popToViewController:self_weak animated:YES];
		  }]];
		
		[self.navigationController presentViewController:alertController animated:YES completion:nil];
		return;
	}

	[self gameLevelGeneratorSet_levelIndex_increment_attempt_with_alertControllers:YES];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(nonnull UITableView*)tableView
{
	return self.gameLevelGeneratorSet.gameLevelGenerators.count;
}

-(NSInteger)tableView:(nonnull UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
	return 1;
}

-(nonnull UITableViewCell*)tableView:(nonnull UITableView*)tableView cellForRowAtIndexPath:(nonnull NSIndexPath*)indexPath
{
	kRUDefineNSStringConstant(tableViewCell_dequeIdentifier)
	UITableViewCell* const tableViewCell =
	([tableView dequeueReusableCellWithIdentifier:tableViewCell_dequeIdentifier]
	 ?:
	 [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewCell_dequeIdentifier]
	 );

	NSUInteger const gameLevelGenerator_index = [self gameLevelGenerator_index_for_indexPathSection:indexPath.section];
	SMBGameLevelGenerator* const gameLevelGenerator = [self gameLevelGenerator_at_index:gameLevelGenerator_index];
	[tableViewCell.textLabel setText:RUStringWithFormat(@"%lu)\t%@",
														(unsigned long)gameLevelGenerator_index + 1,
														gameLevelGenerator.name)];

	return tableViewCell;
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(nonnull UITableView*)tableView heightForRowAtIndexPath:(nonnull NSIndexPath*)indexPath
{
	return 30.0f;
}

-(void)tableView:(nonnull UITableView*)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath*)indexPath
{
	kRUConditionalReturn(self.gameLevelGeneratorViewController != nil, YES);

	[self setGameLevelGeneratorSet_levelIndex:[self gameLevelGenerator_index_for_indexPathSection:indexPath.section]];

	[self gameLevelGeneratorViewController_push_attempt];
}

#pragma mark - gameLevelGenerators
-(nullable SMBGameLevelGenerator*)gameLevelGenerator_at_index:(NSUInteger)gameLevelGenerator_index
{
	SMBGameLevelGeneratorSet* const gameLevelGeneratorSet = self.gameLevelGeneratorSet;
	kRUConditionalReturn_ReturnValueNil(gameLevelGeneratorSet == nil, YES);

	NSArray<SMBGameLevelGenerator*>* const gameLevelGenerators = gameLevelGeneratorSet.gameLevelGenerators;
	kRUConditionalReturn_ReturnValueNil(gameLevelGenerators == nil, YES);
	kRUConditionalReturn_ReturnValueNil(gameLevelGenerator_index >= gameLevelGenerators.count, YES);

	return [gameLevelGenerators objectAtIndex:gameLevelGenerator_index];
}

-(NSUInteger)gameLevelGenerator_index_for_indexPathSection:(NSInteger)indexPathSection
{
	return indexPathSection;
}

#pragma mark - tableView
-(CGRect)tableView_frame
{
	return self.view.bounds;
}

#pragma mark - navigationItem_title
-(void)navigationItem_title_update
{
	[self.navigationItem setTitle:[self navigationItem_title_generate]];
}

-(nullable NSString*)navigationItem_title_generate
{
	return self.gameLevelGeneratorSet.name;
}

#pragma mark - SMBGameLevelGeneratorViewController_levelSuccessBarButtonItemDelegate
-(nonnull UIBarButtonItem*)gameLevelGeneratorViewController_levelSuccessBarButtonItem:(nonnull SMBGameLevelGeneratorViewController*)gameLevelGeneratorViewController
{
	kRUConditionalReturn_ReturnValueNil(gameLevelGeneratorViewController == nil, YES);

	SMBGameLevelGenerator* const gameLevelGenerator = gameLevelGeneratorViewController.gameLevelGenerator;
	kRUConditionalReturn_ReturnValueNil(gameLevelGenerator == nil, YES);

	BOOL const isDone = (self.gameLevelGeneratorSet.gameLevelGenerators.lastObject == gameLevelGenerator);
	return
	[[UIBarButtonItem alloc] initWithTitle:(isDone ? @"Done" : @"Next")
									 style:UIBarButtonItemStylePlain
									target:self
									action:@selector(gameLevelGeneratorViewController_levelSuccessBarButtonItem_action_didFire)];
}

@end
