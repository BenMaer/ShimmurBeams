//
//  SMBLevelEditorViewController.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 1/11/18.
//  Copyright © 2018 Shimmur. All rights reserved.
//

#import "SMBLevelEditorViewController.h"
#import "SMBLevelEditorCreationData.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@interface SMBLevelEditorViewController ()

#pragma mark - gameLevelGenerator
-(void)gameLevelGenerator_update;
-(nullable SMBGameLevelGenerator*)gameLevelGenerator_generate;

@end





@implementation SMBLevelEditorViewController

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

@end
