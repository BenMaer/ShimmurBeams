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
+(nonnull instancetype)smb_mirrorsAndMeltableBlocks_introduction;

#pragma mark - powerButtonsAndDoors
+(nonnull instancetype)smb_powerButtonsAndDoors_introduction;

#pragma mark - powerSwitchesAndDoorGroups
+(nonnull instancetype)smb_powerSwitchesAndDoorGroups_introduction;

@end
