//
//  SMBGameLevelGenerator.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/10/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameLevelGenerator.h"

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

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wno-nullability-completeness"
	return [self init_with_generateLevelBlock:nil];
#pragma clang diagnostic pop
}

#pragma mark - init
-(nullable instancetype)init_with_generateLevelBlock:(nonnull SMBGameLevelGenerator__generateLevelBlock)generateLevelBlock
{
	kRUConditionalReturn_ReturnValueNil(generateLevelBlock == nil, YES);

	if (self = [super init])
	{
		_generateLevelBlock = generateLevelBlock;
	}

	return self;
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
