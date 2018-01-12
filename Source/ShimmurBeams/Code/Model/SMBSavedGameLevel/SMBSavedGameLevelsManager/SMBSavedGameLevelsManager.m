//
//  SMBSavedGameLevelsManager.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 1/11/18.
//  Copyright © 2018 Shimmur. All rights reserved.
//

#import "SMBSavedGameLevelsManager.h"
#import "SMBSaveGameLevelToDiskOperation.h"

#import <ResplendentUtilities/RUSingleton.h>
#import <ResplendentUtilities/RUConditionalReturn.h>





@implementation SMBSavedGameLevelsManager

#pragma mark - Singleton
RUSingletonUtil_Synthesize_Singleton_Implementation_SharedInstance;

#pragma mark - saveGameLevel
-(void)saveGameLevel_toDisk_with_operation:(nonnull SMBSaveGameLevelToDiskOperation*)saveGameLevelToDiskOperation
{
	kRUConditionalReturn(saveGameLevelToDiskOperation == nil, YES);

	[saveGameLevelToDiskOperation saveGameLevelToDisk];
}

@end
