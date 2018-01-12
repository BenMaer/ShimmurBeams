//
//  SMBSavedGameLevelsManager.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 1/11/18.
//  Copyright © 2018 Shimmur. All rights reserved.
//

#import "SMBSavedGameLevelsManager.h"
#import "SMBSaveGameLevelToDiskOperation.h"
#import "NSURL+SMBSavedLevelsPath.h"
#import "SMBSavedGameLevel.h"

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

#pragma mark - savedGameLevels
-(nullable NSArray<SMBSavedGameLevel*>*)savedGameLevels_fetch
{
	NSFileManager* const fileManager = [NSFileManager defaultManager];
	kRUConditionalReturn_ReturnValueNil(fileManager == nil, YES);

	NSMutableArray<SMBSavedGameLevel*>* const savedGameLevels = [NSMutableArray<SMBSavedGameLevel*> array];

	NSURL* const savedLevelsPath = [NSURL smb_savedLevelsPath];

	NSError* savedLevelsPath_getContentsOfDirectory_error = nil;
	NSArray<NSURL*>* const savedLevels_directoryContents =
	[fileManager contentsOfDirectoryAtURL:savedLevelsPath
			   includingPropertiesForKeys:nil
								  options:0
									error:&savedLevelsPath_getContentsOfDirectory_error];
	kRUConditionalReturn_ReturnValueNil(savedLevelsPath_getContentsOfDirectory_error != nil, YES);

	[savedLevels_directoryContents enumerateObjectsUsingBlock:^(NSURL * _Nonnull savedLevelPath_URL, NSUInteger idx, BOOL * _Nonnull stop) {
		BOOL isDirectory = NO;
		[fileManager fileExistsAtPath:[savedLevelPath_URL path]
						  isDirectory:&isDirectory];
		kRUConditionalReturn(isDirectory == false, NO);

		SMBSavedGameLevel* const savedGameLevel =
		[[SMBSavedGameLevel alloc] init_with_URL:savedLevelPath_URL];

		kRUConditionalReturn(savedGameLevel == nil, YES);
		[savedGameLevels addObject:savedGameLevel];
	}];

	return [NSArray<SMBSavedGameLevel*> arrayWithArray:savedGameLevels];
}

@end
