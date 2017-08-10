//
//  SMBGameLevelGeneratorSetsNavigationController.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/10/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameLevelGeneratorSetsNavigationController.h"
#import "SMBGameLevelGeneratorSetsViewController.h"
#import "SMBGameLevelGeneratorSet+SMBUserSets.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/NSMutableArray+RUAddObjectIfNotNil.h>





@interface SMBGameLevelGeneratorSetsNavigationController ()

#pragma mark - gameLevelGeneratorSets
-(nonnull NSArray<SMBGameLevelGeneratorSet*>*)gameLevelGeneratorSets;

@end





@implementation SMBGameLevelGeneratorSetsNavigationController

#pragma mark - UIViewController
-(void)viewDidLoad
{
	[super viewDidLoad];
	
	[self.view setBackgroundColor:[UIColor redColor]];

	SMBGameLevelGeneratorSetsViewController* const gameLevelGeneratorSetsViewController = [SMBGameLevelGeneratorSetsViewController new];
	[gameLevelGeneratorSetsViewController setGameLevelGeneratorSets:[self gameLevelGeneratorSets]];
	kRUConditionalReturn(gameLevelGeneratorSetsViewController == nil, YES);

	[self setViewControllers:[NSArray<__kindof UIViewController *> arrayWithObject:gameLevelGeneratorSetsViewController]];
}

#pragma mark - gameLevelGeneratorSets
-(nonnull NSArray<SMBGameLevelGeneratorSet*>*)gameLevelGeneratorSets
{
	NSMutableArray<SMBGameLevelGeneratorSet*>* const gameLevelGeneratorSets = [NSMutableArray<SMBGameLevelGeneratorSet*> array];
	[gameLevelGeneratorSets addObject:[SMBGameLevelGeneratorSet smb_userSet_1]];

	return [NSArray<SMBGameLevelGeneratorSet*> arrayWithArray:gameLevelGeneratorSets];
}

@end
