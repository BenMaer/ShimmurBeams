//
//  SMBGameLevel+SMBPowerSwitchesAndDoorGroups.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 9/1/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameLevel.h"





@interface SMBGameLevel (SMBPowerSwitchesAndDoorGroups)

#pragma mark - powerSwitches
+(nonnull instancetype)smb_powerSwitch_introduction;
+(nonnull instancetype)smb_powerSwitch_and_button_and_door;

#pragma mark - doorGroups
+(nonnull instancetype)smb_doorGroup_introduction;
+(nonnull instancetype)smb_powerSwitch_and_doorGroup_combo;
+(nonnull instancetype)smb_doorGroups_introduction;

#pragma mark - powerSwitches_and_doorGroups
+(nonnull instancetype)smb_powerSwitches_and_doorGroups_beamCreatorGroup;
+(nonnull instancetype)smb_powerSwitches_and_doorGroups_backwardsLane;

@end
