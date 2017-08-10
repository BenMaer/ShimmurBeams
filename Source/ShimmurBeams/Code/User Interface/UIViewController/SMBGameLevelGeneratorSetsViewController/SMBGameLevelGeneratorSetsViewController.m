//
//  SMBGameLevelGeneratorSetsViewController.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/10/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameLevelGeneratorSetsViewController.h"
#import "SMBGameLevelGeneratorSet.h"
#import "SMBGameLevelGeneratorSetViewController.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/NSString+RUMacros.h>





@interface SMBGameLevelGeneratorSetsViewController () <UITableViewDataSource, UITableViewDelegate>

#pragma mark - gameLevelGeneratorSets
-(nullable SMBGameLevelGeneratorSet*)gameLevelGeneratorSet_at_index:(NSUInteger)gameLevelGeneratorSet_index;
-(NSUInteger)gameLevelGeneratorSet_index_for_indexPathSection:(NSInteger)indexPathSection;

#pragma mark - tableView
@property (nonatomic, readonly, strong, nullable) UITableView* tableView;
-(CGRect)tableView_frame;

@end





@implementation SMBGameLevelGeneratorSetsViewController

#pragma mark - UIViewController
-(void)viewDidLoad
{
	[super viewDidLoad];

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

#pragma mark - gameLevelGeneratorSets
-(void)setGameLevelGeneratorSets:(nullable NSArray<SMBGameLevelGeneratorSet*>*)gameLevelGeneratorSets
{
	kRUConditionalReturn((self.gameLevelGeneratorSets == gameLevelGeneratorSets)
						 ||
						 [self.gameLevelGeneratorSets isEqual:gameLevelGeneratorSets], NO);

	_gameLevelGeneratorSets = (gameLevelGeneratorSets ? [NSArray<SMBGameLevelGeneratorSet*> arrayWithArray:gameLevelGeneratorSets] : nil);

	[self.tableView reloadData];
}

-(nullable SMBGameLevelGeneratorSet*)gameLevelGeneratorSet_at_index:(NSUInteger)gameLevelGeneratorSet_index
{
	NSArray<SMBGameLevelGeneratorSet*>* const gameLevelGeneratorSets = self.gameLevelGeneratorSets;
	kRUConditionalReturn_ReturnValueNil(gameLevelGeneratorSet_index >= gameLevelGeneratorSets.count, YES);

	return [gameLevelGeneratorSets objectAtIndex:gameLevelGeneratorSet_index];
}

-(NSUInteger)gameLevelGeneratorSet_index_for_indexPathSection:(NSInteger)indexPathSection
{
	return indexPathSection;
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(nonnull UITableView*)tableView
{
	return self.gameLevelGeneratorSets.count;
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

	SMBGameLevelGeneratorSet* const gameLevelGeneratorSet = [self gameLevelGeneratorSet_at_index:[self gameLevelGeneratorSet_index_for_indexPathSection:indexPath.section]];
	[tableViewCell.textLabel setText:gameLevelGeneratorSet.name];

	return tableViewCell;
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(nonnull UITableView*)tableView heightForRowAtIndexPath:(nonnull NSIndexPath*)indexPath
{
	return 30.0f;
}

-(void)tableView:(nonnull UITableView*)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath*)indexPath
{
	SMBGameLevelGeneratorSetViewController* const gameLevelGeneratorSetViewController = [SMBGameLevelGeneratorSetViewController new];
	[gameLevelGeneratorSetViewController setGameLevelGeneratorSet:[self gameLevelGeneratorSet_at_index:[self gameLevelGeneratorSet_index_for_indexPathSection:indexPath.section]]];

	[self.navigationController pushViewController:gameLevelGeneratorSetViewController animated:YES];
}

#pragma mark - tableView
-(CGRect)tableView_frame
{
	return self.view.bounds;
}

@end
