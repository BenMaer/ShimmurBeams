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
#import "SMBGameLevelGeneratorViewController.h"
#import "SMBGameLevelGenerator.h"
#import "SMBGameLevel+SMBLevelEditor.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/NSString+RUMacros.h>
#import <ResplendentUtilities/RUConstants.h>

#import <RTSMTableSectionManager/RTSMTableSectionManager.h>
#import <RTSMTableSectionManager/RTSMTableSectionRangeManager.h>





typedef NS_ENUM(NSInteger, SMBGameLevelGeneratorSetsViewController__tableSection) {
	SMBGameLevelGeneratorSetsViewController__tableSection_levelSets,
	SMBGameLevelGeneratorSetsViewController__tableSection_levelEditor,
	
	SMBGameLevelGeneratorSetsViewController__tableSection__first	= SMBGameLevelGeneratorSetsViewController__tableSection_levelSets,
	SMBGameLevelGeneratorSetsViewController__tableSection__last		= SMBGameLevelGeneratorSetsViewController__tableSection_levelEditor,
};





@interface SMBGameLevelGeneratorSetsViewController () <UITableViewDataSource, UITableViewDelegate, RTSMTableSectionRangeManager_SectionLengthDelegate, RTSMTableSectionManager_SectionDelegate>

#pragma mark - tableSectionRangeManager
@property (nonatomic, readonly, strong, nonnull) RTSMTableSectionRangeManager* tableSectionRangeManager;

#pragma mark - gameLevelGeneratorSets
-(nullable SMBGameLevelGeneratorSet*)gameLevelGeneratorSet_at_index:(NSUInteger)gameLevelGeneratorSet_index;
-(NSUInteger)gameLevelGeneratorSet_index_for_indexPathSection:(NSInteger)indexPathSection;

#pragma mark - tableView
@property (nonatomic, readonly, strong, nullable) UITableView* tableView;
-(CGRect)tableView_frame;

#pragma mark - tableView_cells
-(nonnull UITableViewCell*)gameLevelGenerateSet_cell_with_tableView:(nonnull UITableView*)tableView
										gameLevelGeneratorSet_index:(NSUInteger)gameLevelGeneratorSet_index;
-(nonnull UITableViewCell*)levelEditor_cell_with_tableView:(nonnull UITableView*)tableView;

@end





@implementation SMBGameLevelGeneratorSetsViewController

#pragma mark - UIViewController
-(void)viewDidLoad
{
	[super viewDidLoad];

	[self.view setBackgroundColor:[UIColor whiteColor]];

	[self.navigationItem setTitle:@"Level Sets"];

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

#pragma mark - tableSectionRangeManager
@synthesize tableSectionRangeManager = _tableSectionRangeManager;
-(nonnull RTSMTableSectionRangeManager*)tableSectionRangeManager
{
	if (_tableSectionRangeManager == nil)
	{
		RTSMTableSectionManager* const tableSectionManager =
		[[RTSMTableSectionManager alloc] initWithFirstSection:SMBGameLevelGeneratorSetsViewController__tableSection_levelSets
												  lastSection:SMBGameLevelGeneratorSetsViewController__tableSection_levelEditor];
		[tableSectionManager setSectionDelegate:self];

		_tableSectionRangeManager = [RTSMTableSectionRangeManager new];
		[_tableSectionRangeManager setTableSectionManager:tableSectionManager];
		[_tableSectionRangeManager setSectionLengthDelegate:self];
	}

	return _tableSectionRangeManager;
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
	NSInteger const indexPathSection_base_levelSets = [self.tableSectionRangeManager indexPathSectionForSection:SMBGameLevelGeneratorSetsViewController__tableSection_levelSets];
	kRUConditionalReturn_ReturnValue(indexPathSection_base_levelSets > indexPathSection, YES, NSNotFound);

	return indexPathSection - indexPathSection_base_levelSets;
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(nonnull UITableView*)tableView
{
	return [self.tableSectionRangeManager indexPathSectionCount];
}

-(NSInteger)tableView:(nonnull UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
	return 1;
}

-(nonnull UITableViewCell*)tableView:(nonnull UITableView*)tableView cellForRowAtIndexPath:(nonnull NSIndexPath*)indexPath
{
	SMBGameLevelGeneratorSetsViewController__tableSection const tableSection = [self.tableSectionRangeManager sectionForIndexPathSection:indexPath.section];
	switch (tableSection)
	{
		case SMBGameLevelGeneratorSetsViewController__tableSection_levelSets:
			return [self gameLevelGenerateSet_cell_with_tableView:tableView gameLevelGeneratorSet_index:[self gameLevelGeneratorSet_index_for_indexPathSection:indexPath.section]];
			break;

		case SMBGameLevelGeneratorSetsViewController__tableSection_levelEditor:
			return [self levelEditor_cell_with_tableView:tableView];
			break;
	}

	NSAssert(false, @"unhandled tableSection %li",(long)tableSection);
	return [UITableViewCell new];
}

#pragma mark - tableView_cells
-(nonnull UITableViewCell*)gameLevelGenerateSet_cell_with_tableView:(nonnull UITableView*)tableView
										gameLevelGeneratorSet_index:(NSUInteger)gameLevelGeneratorSet_index
{
	NSAssert(tableView != nil, @"Shouldn't be nil");

	SMBGameLevelGeneratorSet* const gameLevelGeneratorSet = [self gameLevelGeneratorSet_at_index:gameLevelGeneratorSet_index];
	NSAssert(gameLevelGeneratorSet != nil, @"Shouldn't be nil");

	kRUDefineNSStringConstant(tableViewCell_dequeIdentifier_gameLevelGenerateSet)
	UITableViewCell* const gameLevelGenerateSet_tableViewCell =
	([tableView dequeueReusableCellWithIdentifier:tableViewCell_dequeIdentifier_gameLevelGenerateSet]
	 ?:
	 [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewCell_dequeIdentifier_gameLevelGenerateSet]
	 );

	[gameLevelGenerateSet_tableViewCell.textLabel setText:
	 RUStringWithFormat(@"%lu)\t%@",
						(unsigned long)gameLevelGeneratorSet_index + 1,
						gameLevelGeneratorSet.name)];

	return gameLevelGenerateSet_tableViewCell;
}

-(nonnull UITableViewCell*)levelEditor_cell_with_tableView:(nonnull UITableView*)tableView
{
	NSAssert(tableView != nil, @"Shouldn't be nil");
	
	kRUDefineNSStringConstant(tableViewCell_dequeIdentifier_levelEditor)
	UITableViewCell* const levelEditor_tableViewCell =
	([tableView dequeueReusableCellWithIdentifier:tableViewCell_dequeIdentifier_levelEditor]
	 ?:
	 [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewCell_dequeIdentifier_levelEditor]
	 );

	[levelEditor_tableViewCell.textLabel setText:@"*\t Level Editor"];

	return levelEditor_tableViewCell;
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(nonnull UITableView*)tableView heightForRowAtIndexPath:(nonnull NSIndexPath*)indexPath
{
	return 30.0f;
}

-(void)tableView:(nonnull UITableView*)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath*)indexPath
{
	SMBGameLevelGeneratorSetsViewController__tableSection const tableSection = [self.tableSectionRangeManager sectionForIndexPathSection:indexPath.section];
	switch (tableSection)
	{
		case SMBGameLevelGeneratorSetsViewController__tableSection_levelSets:
		{
			SMBGameLevelGeneratorSetViewController* const gameLevelGeneratorSetViewController = [SMBGameLevelGeneratorSetViewController new];
			[gameLevelGeneratorSetViewController setGameLevelGeneratorSet:[self gameLevelGeneratorSet_at_index:[self gameLevelGeneratorSet_index_for_indexPathSection:indexPath.section]]];
			
			[self.navigationController pushViewController:gameLevelGeneratorSetViewController animated:YES];
		}
			break;
			
		case SMBGameLevelGeneratorSetsViewController__tableSection_levelEditor:
		{
			SMBGameLevelGeneratorViewController* const gameLevelGeneratorViewController = [SMBGameLevelGeneratorViewController new];
			[gameLevelGeneratorViewController setGameLevelGenerator:
			 [[SMBGameLevelGenerator alloc] init_with_generateLevelBlock:^SMBGameLevel * _Nonnull{
				return [SMBGameLevel smb_levelEditor];
			}
																	name:@"Level Editor"]];

			[self.navigationController pushViewController:gameLevelGeneratorViewController animated:YES];
		}
			break;
	}
}

#pragma mark - tableView
-(CGRect)tableView_frame
{
	return self.view.bounds;
}

#pragma mark - RTSMTableSectionRangeManager_SectionLengthDelegate
-(NSUInteger)tableSectionRangeManager:(nonnull RTSMTableSectionRangeManager*)tableSectionRangeManager
					  lengthOfSection:(NSInteger)section
{
	if (tableSectionRangeManager == self.tableSectionRangeManager)
	{
		SMBGameLevelGeneratorSetsViewController__tableSection const tableSection = (SMBGameLevelGeneratorSetsViewController__tableSection)section;
		switch (tableSection)
		{
			case SMBGameLevelGeneratorSetsViewController__tableSection_levelSets:
				return self.gameLevelGeneratorSets.count;
				break;

			case SMBGameLevelGeneratorSetsViewController__tableSection_levelEditor:
				return 1;
				break;
		}
	}

	NSAssert(false, @"unhandled tableSectionRangeManager %@",tableSectionRangeManager);
	return 0;
}

#pragma mark - RTSMTableSectionManager_SectionDelegate
-(BOOL)tableSectionManager:(nonnull RTSMTableSectionManager*)tableSectionManager sectionIsAvailable:(NSInteger)section
{
	if (tableSectionManager == self.tableSectionRangeManager.tableSectionManager)
	{
		return YES;
	}

	NSAssert(false, @"unhandled tableSectionManager %@",tableSectionManager);
	return NO;
}

@end
