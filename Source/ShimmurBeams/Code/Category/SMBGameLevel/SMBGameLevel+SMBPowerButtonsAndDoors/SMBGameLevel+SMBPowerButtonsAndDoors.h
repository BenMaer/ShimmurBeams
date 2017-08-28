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
+(nonnull instancetype)smb_button_introduction;
+(nonnull instancetype)smb_buttons_3choices;
+(nonnull instancetype)smb_buttons_usableGameBoardTileEntities_choices;
+(nonnull instancetype)smb_buttons_windows_3x3;

@end
