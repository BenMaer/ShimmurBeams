//
//  SMBGameLevel+SMBPowerButtonsAndSwitches.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/18/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameLevel.h"





@interface SMBGameLevel (SMBPowerButtonsAndSwitches)

#pragma mark - button
+(nonnull instancetype)smb_button_introduction;
+(nonnull instancetype)smb_buttons_3choices;
+(nonnull instancetype)smb_buttons_usableGameBoardTileEntities_choices;

@end
