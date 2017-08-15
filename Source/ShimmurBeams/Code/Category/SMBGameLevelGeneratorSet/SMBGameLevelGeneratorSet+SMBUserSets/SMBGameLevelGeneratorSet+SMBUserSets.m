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
#import "SMBGameLevel+SMBGameLevelMirros.h"

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
		return [SMBGameLevel smb_rotates_two_left];
	}
																						  name:@"Two rotates left"]];

	[gameLevelGenerators addObject:[[SMBGameLevelGenerator alloc] init_with_generateLevelBlock:^SMBGameLevel * _Nonnull{
		return [SMBGameLevel smb_rotates_oneLeft_forced_oneLeft];
	}
																						  name:@"Rotate and forced left"]];
	[gameLevelGenerators addObject:[[SMBGameLevelGenerator alloc] init_with_generateLevelBlock:^SMBGameLevel * _Nonnull{
		return [SMBGameLevel smb_rotates_oneLeft_twoRight_wall_oneCenter];
	}
																						  name:@"Rotate around wall"]];

	[gameLevelGenerators addObject:[[SMBGameLevelGenerator alloc] init_with_generateLevelBlock:^SMBGameLevel * _Nonnull{
		return [SMBGameLevel smb_rotates_twoRight_deathBlock_one];
	}
																						  name:@"Thorn"]];

	[gameLevelGenerators addObject:[[SMBGameLevelGenerator alloc] init_with_generateLevelBlock:^SMBGameLevel * _Nonnull{
		return [SMBGameLevel smb_rotates_twoRight_twoLeft_deathBlocks_surrounded_and_someBlocking];
	}
																						  name:@"Surrounded"]];

	[gameLevelGenerators addObject:[[SMBGameLevelGenerator alloc]init_with_generateLevelBlock:^SMBGameLevel * _Nonnull{
		return [SMBGameLevel smb_rotates_deathBlocks_blackAnglesMatter];
	}
																						 name:@"Black Angles Matter"]];

	[gameLevelGenerators addObject:[[SMBGameLevelGenerator alloc] init_with_generateLevelBlock:^SMBGameLevel * _Nonnull{
		return [SMBGameLevel smb_rotates_deathBlocks_scattered];
	}
																						  name:@"Scattered"]];
	
	return
	[[self alloc] init_with_gameLevelGenerators:[NSArray<SMBGameLevelGenerator*> arrayWithArray:gameLevelGenerators]
										   name:@"Rotates and Death Blocks"];
}

#pragma mark - mirrorsIntroduction
+(nonnull instancetype)smb_mirrors_introduction
{
	NSMutableArray<SMBGameLevelGenerator*>* const gameLevelGenerators = [NSMutableArray<SMBGameLevelGenerator*> array];
	
	[gameLevelGenerators addObject:[[SMBGameLevelGenerator alloc] init_with_generateLevelBlock:^SMBGameLevel * _Nonnull{
		return [SMBGameLevel smb_mirrors_introduction];
	}
																						  name:@"Introduction To Mirrors"]];
	
	return
	[[self alloc] init_with_gameLevelGenerators:[NSArray<SMBGameLevelGenerator*> arrayWithArray:gameLevelGenerators]
										   name:@"Mirrors"];
}

@end
