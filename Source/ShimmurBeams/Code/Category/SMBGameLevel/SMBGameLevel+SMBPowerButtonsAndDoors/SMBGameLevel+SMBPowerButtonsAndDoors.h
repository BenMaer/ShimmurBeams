//
//  SMBGameLevel+SMBPowerButtonsAndDoors.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/18/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameLevel.h"





@interface SMBGameLevel (SMBPowerButtonsAndDoors)

#pragma mark - button
+(nonnull instancetype)smb_powerButton_introduction;
+(nonnull instancetype)smb_powerButtons_3choices;
+(nonnull instancetype)smb_powerButtons_usableGameBoardTileEntities_choices;
+(nonnull instancetype)smb_powerButtons_windows_3x3;

#pragma mark - buttons and doors
+(nonnull instancetype)smb_powerButtons_and_door_introduction;
+(nonnull instancetype)smb_powerButtons_and_door_selfPoweredBeamCreator;
+(nonnull instancetype)smb_powerButtons_and_doors_choices;

@end
