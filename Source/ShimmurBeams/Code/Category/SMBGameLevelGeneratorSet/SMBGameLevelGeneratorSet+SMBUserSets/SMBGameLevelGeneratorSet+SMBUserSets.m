//
//  SMBGameLevelGeneratorSet+SMBUserSets.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/10/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameLevelGeneratorSet+SMBUserSets.h"
#import "SMBGameLevelGenerator.h"
#import "SMBGameLevel+SMBForcedRedirectsAndWalls.h"
#import "SMBGameLevel+SMBRotatesAndDeathBlocks.h"

#import <ResplendentUtilities/NSMutableArray+RUAddObjectIfNotNil.h>





@implementation SMBGameLevelGeneratorSet (SMBUserSets)

#pragma mark - userSet_1
+(nonnull instancetype)smb_forcedRedirectsAndWalls
{
	NSMutableArray<SMBGameLevelGenerator*>* const gameLevelGenerators = [NSMutableArray<SMBGameLevelGenerator*> array];

	[gameLevelGenerators addObject:[[SMBGameLevelGenerator alloc] init_with_generateLevelBlock:^SMBGameLevel * _Nonnull{
		return [SMBGameLevel smb_forcedRedirects_oneForce_right];
	}
																						  name:@"One force right"]];

	[gameLevelGenerators addObject:[[SMBGameLevelGenerator alloc] init_with_generateLevelBlock:^SMBGameLevel * _Nonnull{
		return [SMBGameLevel smb_forcedRedirects_twoForces_leftThenDown];
	}
																						  name:@"Two forces"]];

	[gameLevelGenerators addObject:[[SMBGameLevelGenerator alloc] init_with_generateLevelBlock:^SMBGameLevel * _Nonnull{
		return [SMBGameLevel smb_forcedRedirectsAndWalls_oneWall_threeForces];
	}
																						  name:@"Wall in the way"]];

	[gameLevelGenerators addObject:[[SMBGameLevelGenerator alloc] init_with_generateLevelBlock:^SMBGameLevel * _Nonnull{
		return [SMBGameLevel smb_forcedRedirectsAndWalls_twoWalls_threeForces];
	}
																						  name:@"Two walls in the way"]];

	[gameLevelGenerators addObject:[[SMBGameLevelGenerator alloc] init_with_generateLevelBlock:^SMBGameLevel * _Nonnull{
		return [SMBGameLevel smb_forcedRedirects_oneForceNotMovable];
	}
																						  name:@"Already placed"]];

	[gameLevelGenerators addObject:[[SMBGameLevelGenerator alloc] init_with_generateLevelBlock:^SMBGameLevel * _Nonnull{
		return [SMBGameLevel smb_forcedRedirects_wallsAndForces_threeForcesNotMovable];
	}
																						  name:@"Already placed tricky"]];

	[gameLevelGenerators addObject:[[SMBGameLevelGenerator alloc] init_with_generateLevelBlock:^SMBGameLevel * _Nonnull{
		return [SMBGameLevel smb_forcedRedirectsAndWalls_wallsAndForces_twoForcesNotMovable_tricky];
	}
																						  name:@"Tricky"]];
	

	return
	[[self alloc] init_with_gameLevelGenerators:[NSArray<SMBGameLevelGenerator*> arrayWithArray:gameLevelGenerators]
										   name:@"Forced Redirects and Walls"];
}

#pragma mark - rotatesAndDeathBlocks
+(nonnull instancetype)smb_rotatesAndDeathBlocks
{
	NSMutableArray<SMBGameLevelGenerator*>* const gameLevelGenerators = [NSMutableArray<SMBGameLevelGenerator*> array];
	
	[gameLevelGenerators addObject:[[SMBGameLevelGenerator alloc] init_with_generateLevelBlock:^SMBGameLevel * _Nonnull{
		return [SMBGameLevel smb_rotates_oneRotate_right];
	}
																						  name:@"One rotate right"]];

	[gameLevelGenerators addObject:[[SMBGameLevelGenerator alloc] init_with_generateLevelBlock:^SMBGameLevel * _Nonnull{
		return [SMBGameLevel smb_rotates_twoLefts_right];
	}
																						  name:@"Two rotates left"]];

	return
	[[self alloc] init_with_gameLevelGenerators:[NSArray<SMBGameLevelGenerator*> arrayWithArray:gameLevelGenerators]
										   name:@"Rotates and Death Blocks"];
}

@end
