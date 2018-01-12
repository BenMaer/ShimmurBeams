//
//  SMBSaveGameLevelToDiskOperation.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 1/11/18.
//  Copyright © 2018 Shimmur. All rights reserved.
//

#import "SMBSaveGameLevelToDiskOperation.h"
#import "NSURL+SMBUserPath.h"
#import "SMBGameLevelMetaData.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@interface SMBSaveGameLevelToDiskOperation ()

#pragma mark - gameLevel
@property (nonatomic, readonly, strong, nullable) SMBGameLevel* gameLevel;

//#pragma mark - gameLevelData
//@property (nonatomic, copy, nullable) NSData* gameLevelData;
//-(void)gameLevelData_generate_attempt;
//-(nullable NSData*)gameLevelData_generate;

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

	NSURL* const userPath = [NSURL smb_userPath];
	kRUConditionalReturn(userPath == nil, YES);

	NSURL* const filePath_URL_base =
	[NSURL fileURLWithPath:@"saved levels" isDirectory:YES relativeToURL:userPath];
	kRUConditionalReturn(filePath_URL_base == nil, YES);

	NSURL* const filePath_URL =
	[NSURL fileURLWithPath:name
			   isDirectory:YES
			 relativeToURL:filePath_URL_base];
	kRUConditionalReturn(filePath_URL == nil, YES);

	NSURL* const gameLevelMetaData_filePath_URL =
	[NSURL fileURLWithPath:@"metaData"
			   isDirectory:YES
			 relativeToURL:filePath_URL_base];
	kRUConditionalReturn(gameLevelMetaData_filePath_URL == nil, YES);

	NSURL* const gameLevel_filePath_URL =
	[NSURL fileURLWithPath:@"levelData"
			   isDirectory:YES
			 relativeToURL:filePath_URL_base];
	kRUConditionalReturn(gameLevel_filePath_URL == nil, YES);

	
	NSMutableDictionary<NSURL*,id<NSCoding>>* const filePath_to_objectToSave_mapping = [NSMutableDictionary<NSURL*,id<NSCoding>> dictionary];
	[filePath_to_objectToSave_mapping setObject:gameLevelMetaData
										 forKey:gameLevelMetaData_filePath_URL];

	[filePath_to_objectToSave_mapping setObject:gameLevel
										 forKey:gameLevel_filePath_URL];

	[filePath_to_objectToSave_mapping enumerateKeysAndObjectsUsingBlock:^(NSURL * _Nonnull filePath_URL, id<NSCoding>  _Nonnull obj, BOOL * _Nonnull stop) {
		BOOL const success =
		[NSKeyedArchiver archiveRootObject:obj toFile:filePath_URL.absoluteString];

		if (success == false)
		{
			NSAssert(false, @"error saving object %@ to path %@",obj,filePath_URL);
			*stop = YES;
		}
	}];
}

@end
