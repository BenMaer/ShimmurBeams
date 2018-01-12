//
//  SMBLevelEditorViewController.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 1/11/18.
//  Copyright © 2018 Shimmur. All rights reserved.
//

#import "SMBLevelEditorViewController.h"
#import "SMBLevelEditorCreationData.h"
#import "SMBSavedGameLevelsManager.h"
#import "SMBSaveGameLevelToDiskOperation.h"
#import "SMBGameLevelMetaData.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/UIView+RUUtility.h>
#import <ResplendentUtilities/NSMutableArray+RUAddObjectIfNotNil.h>





@interface SMBLevelEditorViewController ()

#pragma mark - saveBarButtonItem
@property (nonatomic, strong, nullable) UIBarButtonItem* saveBarButtonItem;
-(void)saveBarButtonItem_action_didFire;

#pragma mark - saveCustomLevel
-(void)saveCustomLevel_attempt;
-(nullable NSString*)saveCustomLevel_errorMessage_for_name:(nullable NSString*)name;
-(void)saveCustomLevel_didFail_with_errorMessage:(nullable NSString*)errorMessage;

#pragma mark - textField
@property (nonatomic, readonly, strong, nullable) UITextField* textField;
-(CGRect)textField_frame;

#pragma mark - gameLevelGenerator
-(void)gameLevelGenerator_update;
-(nullable SMBGameLevelGenerator*)gameLevelGenerator_generate;

@end





@implementation SMBLevelEditorViewController

#pragma mark - UIViewController
-(void)viewDidLoad
{
	[super viewDidLoad];

	_saveBarButtonItem =
	[[UIBarButtonItem alloc] initWithTitle:@"Save"
									 style:UIBarButtonItemStylePlain
									target:self
									action:@selector(saveBarButtonItem_action_didFire)];
	[self navigationItem_rightBarButtonItems_update];

	_textField = [UITextField new];
	[self.textField setBackgroundColor:[UIColor clearColor]];
	[self.textField setFont:[UIFont systemFontOfSize:14.0f]];
	[self.textField setTextColor:[UIColor darkTextColor]];
	[self.textField setTextAlignment:NSTextAlignmentCenter];
	[self.textField setPlaceholder:@"Untitled"];

	[self.navigationItem setTitleView:self.textField];
}

-(void)viewWillLayoutSubviews
{
	[super viewWillLayoutSubviews];

	[self.textField setFrame:[self textField_frame]];
}

#pragma mark - saveBarButtonItem
-(void)saveBarButtonItem_action_didFire
{
	[self saveCustomLevel_attempt];
}

#pragma mark - saveCustomLevel
-(void)saveCustomLevel_attempt
{
	NSString* const name = self.textField.text;

	NSString* const name_errorMessage = [self saveCustomLevel_errorMessage_for_name:name];
	if (name_errorMessage != nil)
	{
		[self saveCustomLevel_didFail_with_errorMessage:name_errorMessage];
		return;
	}

	SMBGameLevelMetaData* const gameLevelMetaData =
	[[SMBGameLevelMetaData alloc] init_with_name:name
											hint:nil];

	SMBSaveGameLevelToDiskOperation* const saveGameLevelToDiskOperation =
	[[SMBSaveGameLevelToDiskOperation alloc] init_with_gameLevelMetaData:gameLevelMetaData
												gameLevel:self.gameLevelGenerator_gameLevel];

	[[SMBSavedGameLevelsManager sharedInstance] saveGameLevel_toDisk_with_operation:saveGameLevelToDiskOperation];
}

-(nullable NSString*)saveCustomLevel_errorMessage_for_name:(nullable NSString*)name
{
	kRUConditionalReturn_ReturnValue((name == nil)
									 ||
									 (name.length <= 0), NO, @"You must enter a name.");

	return nil;
}

-(void)saveCustomLevel_didFail_with_errorMessage:(nullable NSString*)errorMessage
{
	NSString* const errorMessage_final = (errorMessage ?: @"There was an issue trying to save the level");

	UIAlertController* const alertController =
	[UIAlertController alertControllerWithTitle:@"Oops!"
										message:errorMessage_final
								 preferredStyle:UIAlertControllerStyleAlert];
	
	[alertController addAction:
	 [UIAlertAction actionWithTitle:@"Okay"
							  style:UIAlertActionStyleDefault
							handler:nil]];

	[self.navigationController presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - textField
-(CGRect)textField_frame
{
	return self.navigationController.navigationBar.frame;
}

#pragma mark - levelEditorCreationData
-(void)setLevelEditorCreationData:(nullable SMBLevelEditorCreationData*)levelEditorCreationData
{
	kRUConditionalReturn(self.levelEditorCreationData == levelEditorCreationData, NO);

	_levelEditorCreationData = levelEditorCreationData;

	[self gameLevelGenerator_update];
}

#pragma mark - gameLevelGenerator
-(void)gameLevelGenerator_update
{
	[self setGameLevelGenerator:[self gameLevelGenerator_generate]];
}

-(nullable SMBGameLevelGenerator*)gameLevelGenerator_generate
{
	SMBLevelEditorCreationData* const levelEditorCreationData = self.levelEditorCreationData;
	kRUConditionalReturn_ReturnValueNil(levelEditorCreationData == nil, NO);

	return [levelEditorCreationData gameLevelGenerator_generate];
}

#pragma mark - navigationItem_rightBarButtonItems
-(nullable NSArray<UIBarButtonItem*>*)navigationItem_rightBarButtonItems_generate
{
	NSMutableArray<UIBarButtonItem*>* const navigationItem_rightBarButtonItems = [NSMutableArray<UIBarButtonItem*> array];

	NSArray<UIBarButtonItem*>* const navigationItem_rightBarButtonItems_generate_super = [super navigationItem_rightBarButtonItems_generate];
	if (navigationItem_rightBarButtonItems_generate_super)
	{
		[navigationItem_rightBarButtonItems addObjectsFromArray:navigationItem_rightBarButtonItems_generate_super];
	}

	[navigationItem_rightBarButtonItems ru_addObjectIfNotNil:self.saveBarButtonItem];

	return [NSArray<UIBarButtonItem*> arrayWithArray:navigationItem_rightBarButtonItems];
}

@end
