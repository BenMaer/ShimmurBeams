//
//  SMBSavedGameLevel.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 1/11/18.
//  Copyright © 2018 Shimmur. All rights reserved.
//

#import "SMBSavedGameLevel.h"
#import "NSURL+SMBSavedLevelsPath.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/NSMutableArray+RUAddObjectIfNotNil.h>
#import <ResplendentUtilities/RUConstants.h>





@interface SMBSavedGameLevel ()

#pragma mark - URL
@property (nonatomic, copy, nullable) NSURL* URL;

#pragma mark - gameLevelMetaData
-(nullable SMBGameLevelMetaData*)gameLevelMetaData_generate;

@end





@implementation SMBSavedGameLevel

#pragma mark - NSObject
-(nonnull instancetype)init
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);
	
#if __has_feature(nullability)
#pragma clang diagnostic push
#pragma GCC diagnostic ignored "-Wnullability-completeness"
#endif
	return [self init_with_URL:nil];
#if __has_feature(nullability)
#pragma clang diagnostic pop
#endif
}

-(nonnull NSString*)description
{
	NSMutableArray<NSString*>* const description_lines = [NSMutableArray<NSString*> array];
	[description_lines ru_addObjectIfNotNil:[super description]];
	[description_lines ru_addObjectIfNotNil:RUStringWithFormat(@"gameLevelMetaData: %@",self.gameLevelMetaData)];
	
	return [description_lines componentsJoinedByString:@"\n"];
}

#pragma mark - init
-(nullable instancetype)init_with_URL:(nonnull NSURL*)URL
{
	kRUConditionalReturn_ReturnValueNil(URL == nil, YES);

	if (self = [super init])
	{
		[self setURL:URL];

		_gameLevelMetaData = [self gameLevelMetaData_generate];
		kRUConditionalReturn_ReturnValueNil(self.gameLevelMetaData == nil, YES);
	}

	return self;
}

#pragma mark - gameLevelMetaData
-(nullable SMBGameLevelMetaData*)gameLevelMetaData_generate
{
	NSURL* const URL = self.URL;
	kRUConditionalReturn_ReturnValueNil(URL == nil, YES);

	NSURL* const savedLevelPath_metaData = [URL smb_savedLevelPath_metaData];
	kRUConditionalReturn_ReturnValueNil(savedLevelPath_metaData == nil, YES);

	return [NSKeyedUnarchiver unarchiveObjectWithFile:[savedLevelPath_metaData path]];
}

@end
