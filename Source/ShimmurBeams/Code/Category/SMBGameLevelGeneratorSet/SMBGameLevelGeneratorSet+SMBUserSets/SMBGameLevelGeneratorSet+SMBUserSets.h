//
//  SMBGameLevelGeneratorSet+SMBUserSets.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/10/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameLevelGeneratorSet.h"





@interface SMBGameLevelGeneratorSet (SMBUserSets)

#pragma mark - forcedRedirectsAndWalls
+(nonnull instancetype)smb_forcedRedirectsAndWalls;

#pragma mark - rotatesAndDeathBlocks
+(nonnull instancetype)smb_rotatesAndDeathBlocks;

#pragma mark - mirrorsAndMeltableBlocks
+(nonnull instancetype)smb_mirrorsAndMeltableBlocks;
//
//#pragma mark - powerButtonsAndDoors
//+(nonnull instancetype)smb_powerButtonsAndDoors;
//
//#pragma mark - powerSwitchesAndDoorGroups
//+(nonnull instancetype)smb_powerSwitchesAndDoorGroups;
//
#if kSMBEnvironment__SMBGameLevel_SMBUnitTestLevels_unitTestLevels_enabled
#pragma mark - unitTests
+(nonnull instancetype)smb_unitTests;
#endif

@end
