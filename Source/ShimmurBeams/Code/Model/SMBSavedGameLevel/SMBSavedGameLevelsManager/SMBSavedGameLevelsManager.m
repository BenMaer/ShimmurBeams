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

	NSURL* const savedLevelsPath = [NSURL smb_savedLevelsPath];

	BOOL isDirectory = NO;
	kRUConditionalReturn_ReturnValueNil([fileManager fileExistsAtPath:[savedLevelsPath path] isDirectory:&isDirectory] == false, NO);

	if (isDirectory == false)
	{
		NSAssert(false, @"How did this become a file? It should be a folder.");
		NSError* removeFile_error = nil;
		BOOL removeFile_success =
		[fileManager removeItemAtURL:savedLevelsPath error:&removeFile_error];
		kRUConditionalReturn_ReturnValueNil((removeFile_error != nil)
											||
											(removeFile_success == false), YES);
	}

	NSError* savedLevelsPath_getContentsOfDirectory_error = nil;
	NSArray<NSURL*>* const savedLevels_directoryContents =
	[fileManager contentsOfDirectoryAtURL:savedLevelsPath
			   includingPropertiesForKeys:nil
								  options:0
									error:&savedLevelsPath_getContentsOfDirectory_error];
	kRUConditionalReturn_ReturnValueNil(savedLevelsPath_getContentsOfDirectory_error != nil, YES);

	NSMutableArray<SMBSavedGameLevel*>* const savedGameLevels = [NSMutableArray<SMBSavedGameLevel*> array];

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
