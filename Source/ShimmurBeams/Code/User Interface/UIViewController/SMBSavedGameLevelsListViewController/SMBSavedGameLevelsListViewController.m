//
//  SMBSavedGameLevelsListViewController.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 1/11/18.
//  Copyright © 2018 Shimmur. All rights reserved.
//

#import "SMBSavedGameLevelsListViewController.h"
#import "SMBLevelEditorCreationViewController.h"
#import "SMBSavedGameLevel.h"
#import "SMBSavedGameLevelsManager.h"
#import "SMBGenericLabelTableViewCell.h"
#import "SMBGameLevelMetaData.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/NSString+RUMacros.h>

#import <RTSMTableSectionManager/RTSMTableSectionManager.h>
#import <RTSMTableSectionManager/RTSMTableSectionRangeManager.h>

#import <RUTextSize/RUAttributesDictionaryBuilder.h>





typedef NS_ENUM(NSInteger, SMBSavedGameLevelsListViewController__tableSection) {
	SMBSavedGameLevelsListViewController__tableSection_saved,

	SMBSavedGameLevelsListViewController__tableSection__first	= SMBSavedGameLevelsListViewController__tableSection_saved,
	SMBSavedGameLevelsListViewController__tableSection__last	= SMBSavedGameLevelsListViewController__tableSection_saved,
};





@interface SMBSavedGameLevelsListViewController () <UITableViewDataSource, UITableViewDelegate, RTSMTableSectionRangeManager_SectionLengthDelegate, RTSMTableSectionManager_SectionDelegate>

#pragma mark - tableSectionRangeManager
@property (nonatomic, readonly, strong, nonnull) RTSMTableSectionRangeManager* tableSectionRangeManager;

#pragma mark - tableView
@property (nonatomic, readonly, strong, nullable) UITableView* tableView;
-(CGRect)tableView_frame;

#pragma mark - levelEditorCreationViewController
-(void)levelEditorCreationViewController_push_attempt;

#pragma mark - navigationItem_barButtonItem_createNew
-(void)navigationItem_barButtonItem_createNew_action_didFire;

#pragma mark - savedGameLevels
@property (nonatomic, copy, nullable) NSArray<SMBSavedGameLevel*>* savedGameLevels;
-(void)savedGameLevels_update;
-(nullable NSArray<SMBSavedGameLevel*>*)savedGameLevels_generate;
-(nullable SMBSavedGameLevel*)savedGameLevel_at_index:(NSUInteger)savedGameLevel_index;
-(NSUInteger)savedGameLevel_index_at_indexPathSection:(NSInteger)indexPathSection;

#pragma mark - tableViewCell_GenericLabel
-(nonnull SMBGenericLabelTableViewCell*)tableViewCell_GenericLabel_with_attributedText:(nonnull NSAttributedString*)attributedText
																			textInsets:(UIEdgeInsets)textInsets;

@end





@implementation SMBSavedGameLevelsListViewController

#pragma mark - UIViewController
-(void)viewDidLoad
{
	[super viewDidLoad];
	
	[self.view setBackgroundColor:[UIColor whiteColor]];
	
	[self.navigationItem setTitle:@"Custom Levels"];
	[self.navigationItem setRightBarButtonItem:
	 [[UIBarButtonItem alloc] initWithTitle:@"New"
									  style:UIBarButtonItemStylePlain
									 target:self
									 action:@selector(navigationItem_barButtonItem_createNew_action_didFire)]];

	_tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
	[self.tableView setBackgroundColor:[UIColor clearColor]];
	[self.tableView setDataSource:self];
	[self.tableView setDelegate:self];
	[self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
	[self.view addSubview:self.tableView];
}

-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];

	[self savedGameLevels_update];
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
		[[RTSMTableSectionManager alloc] initWithFirstSection:SMBSavedGameLevelsListViewController__tableSection__first
												  lastSection:SMBSavedGameLevelsListViewController__tableSection__last];
		[tableSectionManager setSectionDelegate:self];
		
		_tableSectionRangeManager = [RTSMTableSectionRangeManager new];
		[_tableSectionRangeManager setTableSectionManager:tableSectionManager];
		[_tableSectionRangeManager setSectionLengthDelegate:self];
	}
	
	return _tableSectionRangeManager;
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
	SMBSavedGameLevelsListViewController__tableSection const tableSection = [self.tableSectionRangeManager sectionForIndexPathSection:indexPath.section];
	switch (tableSection)
	{
		case SMBSavedGameLevelsListViewController__tableSection_saved:
		{
			NSUInteger const savedGameLevel_index = [self savedGameLevel_index_at_indexPathSection:indexPath.section];
			SMBSavedGameLevel* const savedGameLevel = [self savedGameLevel_at_index:savedGameLevel_index];

			RUAttributesDictionaryBuilder* const attributesDictionaryBuilder = [RUAttributesDictionaryBuilder new];
			
			[attributesDictionaryBuilder setFont:[UIFont systemFontOfSize:12.0f]];
			[attributesDictionaryBuilder setTextColor:[UIColor lightGrayColor]];

			CGFloat const padding_horizontal = 12.0f;

			return [self tableViewCell_GenericLabel_with_attributedText:
					[[NSAttributedString alloc] initWithString:savedGameLevel.gameLevelMetaData.name
													attributes:[attributesDictionaryBuilder attributesDictionary_generate]]
															 textInsets:(UIEdgeInsets){
																 .left	= padding_horizontal,
																 .right	= padding_horizontal,
															 }];
		}
			break;
	}
	
	NSAssert(false, @"unhandled tableSection %li",(long)tableSection);
	return [UITableViewCell new];
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(nonnull UITableView*)tableView heightForRowAtIndexPath:(nonnull NSIndexPath*)indexPath
{
	return 30.0f;
}

-(void)tableView:(nonnull UITableView*)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath*)indexPath
{
	SMBSavedGameLevelsListViewController__tableSection const tableSection = [self.tableSectionRangeManager sectionForIndexPathSection:indexPath.section];
	switch (tableSection)
	{
		case SMBSavedGameLevelsListViewController__tableSection_saved:
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
		SMBSavedGameLevelsListViewController__tableSection const tableSection = (SMBSavedGameLevelsListViewController__tableSection)section;
		switch (tableSection)
		{
			case SMBSavedGameLevelsListViewController__tableSection_saved:
				return self.savedGameLevels.count;
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

#pragma mark - levelEditorCreationViewController
-(void)levelEditorCreationViewController_push_attempt
{
	SMBLevelEditorCreationViewController* const levelEditorCreationViewController = [SMBLevelEditorCreationViewController new];

	[self.navigationController pushViewController:levelEditorCreationViewController animated:YES];
}

#pragma mark - navigationItem_barButtonItem_createNew
-(void)navigationItem_barButtonItem_createNew_action_didFire
{
	[self levelEditorCreationViewController_push_attempt];
}

#pragma mark - savedGameLevels
-(void)setSavedGameLevels:(nullable NSArray<SMBSavedGameLevel*>*)savedGameLevels
{
	kRUConditionalReturn((self.savedGameLevels == savedGameLevels)
						 ||
						 [self.savedGameLevels isEqual:savedGameLevels], NO);

	_savedGameLevels = (savedGameLevels ? [NSArray<SMBSavedGameLevel*> arrayWithArray:savedGameLevels] : nil);

	[self.tableView reloadData];
}

-(void)savedGameLevels_update
{
	[self setSavedGameLevels:[self savedGameLevels_generate]];
}

-(nullable NSArray<SMBSavedGameLevel*>*)savedGameLevels_generate
{
	return [[SMBSavedGameLevelsManager sharedInstance] savedGameLevels_fetch];
}

-(nullable SMBSavedGameLevel*)savedGameLevel_at_index:(NSUInteger)savedGameLevel_index
{
	NSArray<SMBSavedGameLevel*>* const savedGameLevels = self.savedGameLevels;
	kRUConditionalReturn_ReturnValueNil(savedGameLevel_index >= savedGameLevels.count, YES);

	return [savedGameLevels objectAtIndex:savedGameLevel_index];
}

-(NSUInteger)savedGameLevel_index_at_indexPathSection:(NSInteger)indexPathSection
{
	NSInteger const tableSection_saved_indexPathSection = [self.tableSectionRangeManager indexPathSectionForSection:SMBSavedGameLevelsListViewController__tableSection_saved];
	kRUConditionalReturn_ReturnValue(tableSection_saved_indexPathSection > indexPathSection, YES, NSNotFound);

	return indexPathSection - tableSection_saved_indexPathSection;
}

#pragma mark - tableViewCell_GenericLabel
-(nonnull SMBGenericLabelTableViewCell*)tableViewCell_GenericLabel_with_attributedText:(nonnull NSAttributedString*)attributedText
																			textInsets:(UIEdgeInsets)textInsets
{
	kRUDefineNSStringConstant(cellDequeIdentifier__SMBGenericLabelTableViewCell);
	SMBGenericLabelTableViewCell* const tableViewCell_GenericLabel =
	(
	 [self.tableView dequeueReusableCellWithIdentifier:cellDequeIdentifier__SMBGenericLabelTableViewCell]
	 ?:
	 [[SMBGenericLabelTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
										 reuseIdentifier:cellDequeIdentifier__SMBGenericLabelTableViewCell]
	 );
	
	[tableViewCell_GenericLabel setSelectionStyle:UITableViewCellSelectionStyleNone];
	[tableViewCell_GenericLabel setBackgroundColor:[UIColor clearColor]];
	[tableViewCell_GenericLabel.contentView setBackgroundColor:[UIColor clearColor]];
	
	[tableViewCell_GenericLabel.genericLabel setAttributedText:attributedText];
	[tableViewCell_GenericLabel.genericLabel setBackgroundColor:[UIColor clearColor]];
	[tableViewCell_GenericLabel setGenericLabel_frame_insets:textInsets];
	
	return tableViewCell_GenericLabel;
}

@end
