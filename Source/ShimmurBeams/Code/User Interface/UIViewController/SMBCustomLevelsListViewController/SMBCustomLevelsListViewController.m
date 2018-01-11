//
//  SMBCustomLevelsListViewController.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 1/11/18.
//  Copyright © 2018 Shimmur. All rights reserved.
//

#import "SMBCustomLevelsListViewController.h"
#import "SMBLevelEditorCreationViewController.h"

#import <RTSMTableSectionManager/RTSMTableSectionManager.h>
#import <RTSMTableSectionManager/RTSMTableSectionRangeManager.h>





typedef NS_ENUM(NSInteger, SMBCustomLevelsListViewController__tableSection) {
	SMBCustomLevelsListViewController__tableSection_saved,

	SMBCustomLevelsListViewController__tableSection__first	= SMBCustomLevelsListViewController__tableSection_saved,
	SMBCustomLevelsListViewController__tableSection__last	= SMBCustomLevelsListViewController__tableSection_saved,
};





@interface SMBCustomLevelsListViewController () <UITableViewDataSource, UITableViewDelegate, RTSMTableSectionRangeManager_SectionLengthDelegate, RTSMTableSectionManager_SectionDelegate>

#pragma mark - tableSectionRangeManager
@property (nonatomic, readonly, strong, nonnull) RTSMTableSectionRangeManager* tableSectionRangeManager;

#pragma mark - tableView
@property (nonatomic, readonly, strong, nullable) UITableView* tableView;
-(CGRect)tableView_frame;

#pragma mark - levelEditorCreationViewController
-(void)levelEditorCreationViewController_push_attempt;

#pragma mark - navigationItem_barButtonItem_createNew
-(void)navigationItem_barButtonItem_createNew_action_didFire;

@end





@implementation SMBCustomLevelsListViewController

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
		[[RTSMTableSectionManager alloc] initWithFirstSection:SMBCustomLevelsListViewController__tableSection__first
												  lastSection:SMBCustomLevelsListViewController__tableSection__last];
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
	SMBCustomLevelsListViewController__tableSection const tableSection = [self.tableSectionRangeManager sectionForIndexPathSection:indexPath.section];
	switch (tableSection)
	{
		case SMBCustomLevelsListViewController__tableSection_saved:
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
	SMBCustomLevelsListViewController__tableSection const tableSection = [self.tableSectionRangeManager sectionForIndexPathSection:indexPath.section];
	switch (tableSection)
	{
		case SMBCustomLevelsListViewController__tableSection_saved:
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
		SMBCustomLevelsListViewController__tableSection const tableSection = (SMBCustomLevelsListViewController__tableSection)section;
		switch (tableSection)
		{
			case SMBCustomLevelsListViewController__tableSection_saved:
				return 0;
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

@end
