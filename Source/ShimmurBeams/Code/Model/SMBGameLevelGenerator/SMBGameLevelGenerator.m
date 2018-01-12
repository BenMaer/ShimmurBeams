//
//  SMBGameLevelGenerator.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/10/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameLevelGenerator.h"
#import "SMBGameLevelMetaData.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@interface SMBGameLevelGenerator ()

#pragma mark - generateLevelBlock
@property (nonatomic, readonly, strong, nullable) SMBGameLevelGenerator__generateLevelBlock generateLevelBlock;

@end





@implementation SMBGameLevelGenerator

#pragma mark - NSObject
-(instancetype)init
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);

#if __has_feature(nullability)
#pragma clang diagnostic push
#pragma GCC diagnostic ignored "-Wnullability-completeness"
#endif
	return [self init_with_generateLevelBlock:nil
										 name:nil
										 hint:nil];
#if __has_feature(nullability)
#pragma clang diagnostic pop
#endif
}

#pragma mark - init
-(nullable instancetype)init_with_generateLevelBlock:(nonnull SMBGameLevelGenerator__generateLevelBlock)generateLevelBlock
												name:(nonnull NSString*)name
												hint:(nullable NSString*)hint
{
	kRUConditionalReturn_ReturnValueNil(generateLevelBlock == nil, YES);

	if (self = [super init])
	{
		_generateLevelBlock = generateLevelBlock;

		_gameLevelMetaData =
		[[SMBGameLevelMetaData alloc] init_with_name:name
												hint:hint];
		kRUConditionalReturn_ReturnValueNil(self.gameLevelMetaData == nil, YES);
	}

	return self;
}

-(nullable instancetype)init_with_generateLevelBlock:(nonnull SMBGameLevelGenerator__generateLevelBlock)generateLevelBlock
												name:(nonnull NSString*)name
{
	return
	[self init_with_generateLevelBlock:generateLevelBlock
								  name:name
								  hint:nil];
}

#pragma mark - gameLevel
-(nullable SMBGameLevel*)gameLevel_generate
{
	SMBGameLevelGenerator__generateLevelBlock const generateLevelBlock = self.generateLevelBlock;
	kRUConditionalReturn_ReturnValueNil(generateLevelBlock == nil, YES);

	SMBGameLevel* const gameLevel = generateLevelBlock();
	kRUConditionalReturn_ReturnValueNil(gameLevel == nil, YES);

	return gameLevel;
}

@end
