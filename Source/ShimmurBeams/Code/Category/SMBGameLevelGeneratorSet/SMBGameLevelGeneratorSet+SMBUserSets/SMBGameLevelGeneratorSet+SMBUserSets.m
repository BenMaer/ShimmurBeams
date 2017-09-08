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
#import "SMBGameLevel+SMBMirrorsAndMeltableBlocks.h"
#import "SMBGameLevel+SMBPowerButtonsAndDoors.h"
#import "SMBGameLevel+SMBPowerSwitchesAndDoorGroups.h"
#import "SMBGameLevel+SMBUnitTestLevels.h"

#import <ResplendentUtilities/NSMutableArray+RUAddObjectIfNotNil.h>





@implementation SMBGameLevelGeneratorSet (SMBUserSets)

#pragma mark - userSet_1
+(nonnull instancetype)smb_forcedRedirectsAndWalls
{
	NSMutableArray<SMBGameLevelGenerator*>* const gameLevelGenerators = [NSMutableArray<SMBGameLevelGenerator*> array];

	[gameLevelGenerators addObject:[[SMBGameLevelGenerator alloc] init_with_generateLevelBlock:^SMBGameLevel * _Nonnull{
		return [SMBGameLevel smb_forcedRedirects_oneForce_right];
	}
																						  name:@"One force right"
																						  hint:@"Select an entity from the bottom, and then tap an empty tile on the board to place it.\nGet the beam to the exit."]];

	[gameLevelGenerators addObject:[[SMBGameLevelGenerator alloc] init_with_generateLevelBlock:^SMBGameLevel * _Nonnull{
		return [SMBGameLevel smb_forcedRedirects_twoForces_leftThenDown];
	}
																						  name:@"Two forces"
																						  hint:@"Any piece that you placed on the board, can be selected again by tapping it on the board."]];

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
																						  name:@"Already placed"
																						  hint:@"When an entity starts on the board, you cannot move it."]];

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
																						  name:@"One rotate right"
																						  hint:@"Rotate blocks change the direction of the beam based on the direction the beam enters."]];

	[gameLevelGenerators addObject:[[SMBGameLevelGenerator alloc] init_with_generateLevelBlock:^SMBGameLevel * _Nonnull{
		return [SMBGameLevel smb_rotates_two_left];
	}
																						  name:@"Two rotates left"]];

	[gameLevelGenerators addObject:[[SMBGameLevelGenerator alloc] init_with_generateLevelBlock:^SMBGameLevel * _Nonnull{
		return [SMBGameLevel smb_rotates_oneRight_forced_oneRight];
	}
																						  name:@"Rotate and forced right"]];
	[gameLevelGenerators addObject:[[SMBGameLevelGenerator alloc] init_with_generateLevelBlock:^SMBGameLevel * _Nonnull{
		return [SMBGameLevel smb_rotates_oneLeft_twoRight_wall_oneCenter];
	}
																						  name:@"Rotate around wall"]];

	[gameLevelGenerators addObject:[[SMBGameLevelGenerator alloc] init_with_generateLevelBlock:^SMBGameLevel * _Nonnull{
		return [SMBGameLevel smb_rotates_twoRight_deathBlock_one];
	}
																						  name:@"Thorn"
																						  hint:@"Avoid letting your beam hit a death block."]];

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
+(nonnull instancetype)smb_mirrorsAndMeltableBlocks
{
	NSMutableArray<SMBGameLevelGenerator*>* const gameLevelGenerators = [NSMutableArray<SMBGameLevelGenerator*> array];

	[gameLevelGenerators addObject:[[SMBGameLevelGenerator alloc] init_with_generateLevelBlock:^SMBGameLevel * _Nonnull{
		return [SMBGameLevel smb_mirrors_introduction];
	}
																						  name:@"Mirror Introduction"]];

	[gameLevelGenerators addObject:[[SMBGameLevelGenerator alloc] init_with_generateLevelBlock:^SMBGameLevel * _Nonnull{
		return [SMBGameLevel smb_mirror_man_in_the_mirror];
	}
																						  name:@"That Man In The Mirror"]];

	[gameLevelGenerators addObject:[[SMBGameLevelGenerator alloc] init_with_generateLevelBlock:^SMBGameLevel * _Nonnull{
		return [SMBGameLevel smb_meltableWall_introduction];
	}
																						  name:@"Meltable Wall Introduction"
																						  hint:@"Focus your beam on the meltable wall for a couple seconds to destroy it."]];

	return
	[[self alloc] init_with_gameLevelGenerators:[NSArray<SMBGameLevelGenerator*> arrayWithArray:gameLevelGenerators]
										   name:@"Mirrors and Meltable Walls"];
}

#pragma mark - powerButtonsAndDoors
+(nonnull instancetype)smb_powerButtonsAndDoors
{
	NSMutableArray<SMBGameLevelGenerator*>* const gameLevelGenerators = [NSMutableArray<SMBGameLevelGenerator*> array];

	[gameLevelGenerators addObject:[[SMBGameLevelGenerator alloc] init_with_generateLevelBlock:^SMBGameLevel * _Nonnull{
		return [SMBGameLevel smb_powerButton_introduction];
	}
																						  name:@"Button Introduction"
																						  hint:@"Power up a button to turn it on. A powered button will power another tile on the board."]];

	[gameLevelGenerators addObject:[[SMBGameLevelGenerator alloc] init_with_generateLevelBlock:^SMBGameLevel * _Nonnull{
		return [SMBGameLevel smb_powerButtons_3choices];
	}
																						  name:@"Button Choices"
																						  hint:@"Determine which button powers which tile."]];

	[gameLevelGenerators addObject:[[SMBGameLevelGenerator alloc] init_with_generateLevelBlock:^SMBGameLevel * _Nonnull{
		return [SMBGameLevel smb_powerButtons_usableGameBoardTileEntities_choices];
	}
																						  name:@"Too Easy"]];

	[gameLevelGenerators addObject:[[SMBGameLevelGenerator alloc] init_with_generateLevelBlock:^SMBGameLevel * _Nonnull{
		return [SMBGameLevel smb_powerButtons_windows_3x3];
	}
																						  name:@"Windows"]];

	[gameLevelGenerators addObject:[[SMBGameLevelGenerator alloc] init_with_generateLevelBlock:^SMBGameLevel * _Nonnull{
		return [SMBGameLevel smb_powerButtons_and_door_introduction];
	}
																						  name:@"Door Introduction"]];

	[gameLevelGenerators addObject:[[SMBGameLevelGenerator alloc] init_with_generateLevelBlock:^SMBGameLevel * _Nonnull{
		return [SMBGameLevel smb_powerButtons_and_doors_choices];
	}
																						  name:@"Buttons and Doors"]];

	return
	[[self alloc] init_with_gameLevelGenerators:[NSArray<SMBGameLevelGenerator*> arrayWithArray:gameLevelGenerators]
										   name:@"Power buttons and doors"];
}

#pragma mark - powerSwitchesAndDoorGroups
+(nonnull instancetype)smb_powerSwitchesAndDoorGroups
{
	NSMutableArray<SMBGameLevelGenerator*>* const gameLevelGenerators = [NSMutableArray<SMBGameLevelGenerator*> array];

	[gameLevelGenerators addObject:[[SMBGameLevelGenerator alloc] init_with_generateLevelBlock:^SMBGameLevel * _Nonnull{
		return [SMBGameLevel smb_powerSwitch_introduction];
	}
																						  name:@"Switch Introduction"
																						  hint:@"Power up a switch to toggle its power. A powered switch will power another tile on the board."]];

	[gameLevelGenerators addObject:[[SMBGameLevelGenerator alloc] init_with_generateLevelBlock:^SMBGameLevel * _Nonnull{
		return [SMBGameLevel smb_powerSwitch_and_button_and_door];
	}
																						  name:@"Switch and Button Choice"]];

	[gameLevelGenerators addObject:[[SMBGameLevelGenerator alloc] init_with_generateLevelBlock:^SMBGameLevel * _Nonnull{
		return [SMBGameLevel smb_doorGroup_introduction];
	}
																						  name:@"Door Group Introduction"]];

	[gameLevelGenerators addObject:[[SMBGameLevelGenerator alloc] init_with_generateLevelBlock:^SMBGameLevel * _Nonnull{
		return [SMBGameLevel smb_powerSwitch_and_doorGroup_combo];
	}
																						  name:@"Combo"]];

	[gameLevelGenerators addObject:[[SMBGameLevelGenerator alloc] init_with_generateLevelBlock:^SMBGameLevel * _Nonnull{
		return [SMBGameLevel smb_doorGroups_introduction];
	}
																						  name:@"Up and Down"]];

	[gameLevelGenerators addObject:[[SMBGameLevelGenerator alloc] init_with_generateLevelBlock:^SMBGameLevel * _Nonnull{
		return [SMBGameLevel smb_powerSwitches_and_doorGroups_beamCreatorGroup];
	}
																						  name:@"Beam Creator Group Toggle"]];

	[gameLevelGenerators addObject:[[SMBGameLevelGenerator alloc] init_with_generateLevelBlock:^SMBGameLevel * _Nonnull{
		return [SMBGameLevel smb_powerSwitches_and_doorGroups_backwardsLane];
	}
																						  name:@"Death lane"]];

	return
	[[self alloc] init_with_gameLevelGenerators:[NSArray<SMBGameLevelGenerator*> arrayWithArray:gameLevelGenerators]
										   name:@"Power switches and door groups"];
}

#pragma mark - unitTests
+(nonnull instancetype)smb_unitTests
{
	NSMutableArray<SMBGameLevelGenerator*>* const gameLevelGenerators = [NSMutableArray<SMBGameLevelGenerator*> array];

	[gameLevelGenerators addObject:[[SMBGameLevelGenerator alloc] init_with_generateLevelBlock:^SMBGameLevel * _Nonnull{
		return [SMBGameLevel smb_beamEntityOrder];
	}
																						  name:@"Beam entity order"
																						  hint:@"Place entity at 0x3. Should not cause death."]];

	[gameLevelGenerators addObject:[[SMBGameLevelGenerator alloc] init_with_generateLevelBlock:^SMBGameLevel * _Nonnull{
		return [SMBGameLevel smb_buttonPoweredImmediately];
	}
																						  name:@"Initial power"
																						  hint:@"The button should be powered off the bat."]];

	return
	[[self alloc] init_with_gameLevelGenerators:[NSArray<SMBGameLevelGenerator*> arrayWithArray:gameLevelGenerators]
										   name:@"UNIT TESTS"];
}

@end
