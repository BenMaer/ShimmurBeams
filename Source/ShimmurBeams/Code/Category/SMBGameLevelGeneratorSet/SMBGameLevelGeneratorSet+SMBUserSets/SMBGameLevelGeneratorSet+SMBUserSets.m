//
//  SMBGameLevelGeneratorSet+SMBUserSets.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/10/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameLevelGeneratorSet+SMBUserSets.h"
#import "SMBGameLevelGenerator.h"
#import "SMBGameLevel+SMBTestLevel.h"

#import <ResplendentUtilities/NSMutableArray+RUAddObjectIfNotNil.h>





@implementation SMBGameLevelGeneratorSet (SMBUserSets)

#pragma mark - userSet_1
+(nonnull instancetype)smb_userSet_1
{
	NSMutableArray<SMBGameLevelGenerator*>* const gameLevelGenerators = [NSMutableArray<SMBGameLevelGenerator*> array];
	[gameLevelGenerators addObject:[[SMBGameLevelGenerator alloc] init_with_generateLevelBlock:^SMBGameLevel * _Nonnull{
		return [SMBGameLevel smb_testLevel_oneTurnRight];
	}]];
	[gameLevelGenerators addObject:[[SMBGameLevelGenerator alloc] init_with_generateLevelBlock:^SMBGameLevel * _Nonnull{
		return [SMBGameLevel smb_testLevel_clover];
	}]];

	return
	[[self alloc] init_with_gameLevelGenerators:[NSArray<SMBGameLevelGenerator*> arrayWithArray:gameLevelGenerators]
										   name:@"User sets 1"];
}

@end
