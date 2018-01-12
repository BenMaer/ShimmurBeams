//
//  SMBSaveGameLevelToDiskOperation.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 1/11/18.
//  Copyright © 2018 Shimmur. All rights reserved.
//

#import "SMBSaveGameLevelToDiskOperation.h"
#import "NSURL+SMBSavedLevelsPath.h"
#import "SMBGameLevelMetaData.h"
#import "SMBGameLevel.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@interface SMBSaveGameLevelToDiskOperation ()

#pragma mark - gameLevel
@property (nonatomic, readonly, strong, nullable) SMBGameLevel* gameLevel;

@end





@implementation SMBSaveGameLevelToDiskOperation

#pragma mark - NSObject
-(nonnull instancetype)init
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);

#if __has_feature(nullability)
#pragma clang diagnostic push
#pragma GCC diagnostic ignored "-Wnullability-completeness"
#endif
	return [self init_with_gameLevelMetaData:nil
								   gameLevel:nil];
#if __has_feature(nullability)
#pragma clang diagnostic pop
#endif
}

#pragma mark - init
-(nullable instancetype)init_with_gameLevelMetaData:(nonnull SMBGameLevelMetaData*)gameLevelMetaData
										  gameLevel:(nonnull SMBGameLevel*)gameLevel
{
	kRUConditionalReturn_ReturnValueNil(gameLevelMetaData == nil, YES);
	kRUConditionalReturn_ReturnValueNil(gameLevel == nil, YES);

	if (self = [super init])
	{
		_gameLevelMetaData = gameLevelMetaData;
		_gameLevel = gameLevel;
	}

	return self;
}

#pragma mark - saveGameLevelToDisk
-(void)saveGameLevelToDisk
{
	SMBGameLevelMetaData* const gameLevelMetaData = self.gameLevelMetaData;
	kRUConditionalReturn(gameLevelMetaData == nil, YES);

	SMBGameLevel* const gameLevel = self.gameLevel;
	kRUConditionalReturn(gameLevel == nil, YES);

	NSString* const name = gameLevelMetaData.name;
	kRUConditionalReturn((name == nil)
						 ||
						 (name.length == 0),
						 YES);

	NSURL* const filePath_URL = [NSURL smb_savedLevelPath_with_levelName:name];
	kRUConditionalReturn(filePath_URL == nil, YES);

	NSError* filePath_URL_createDirectory_error = nil;
	BOOL const filePath_URL_createDirectory_success =
	[[NSFileManager defaultManager] createDirectoryAtURL:filePath_URL
							 withIntermediateDirectories:YES
											  attributes:nil
												   error:&filePath_URL_createDirectory_error];
	kRUConditionalReturn((filePath_URL_createDirectory_success == false)
						 ||
						 (filePath_URL_createDirectory_error != nil), YES);

	NSMutableDictionary<NSURL*,id<NSCoding>>* const filePath_component_to_objectToSave_mapping = [NSMutableDictionary<NSURL*,id<NSCoding>> dictionary];
	[filePath_component_to_objectToSave_mapping setObject:gameLevelMetaData
												   forKey:[filePath_URL smb_savedLevelPath_metaData]];

	[filePath_component_to_objectToSave_mapping setObject:gameLevel
												   forKey:[filePath_URL smb_savedLevelPath_levelData]];

	[filePath_component_to_objectToSave_mapping enumerateKeysAndObjectsUsingBlock:^(NSURL * _Nonnull object_filePath_URL, id<NSCoding>  _Nonnull object, BOOL * _Nonnull stop) {
//		NSURL* const object_filePath_URL =
//		[NSURL fileURLWithPath:filePath_component
//				   isDirectory:NO
//				 relativeToURL:filePath_URL];
//		kRUConditionalReturn(object_filePath_URL == nil, YES);

		BOOL const success =
		[NSKeyedArchiver archiveRootObject:object
									toFile:[object_filePath_URL path]];

		if (success == false)
		{
			NSAssert(false, @"error saving object %@ to path %@", object, object_filePath_URL);
			*stop = YES;
		}
	}];
}

@end
