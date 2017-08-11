//
//  SMBGameLevel+SMBTestLevel.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/4/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameLevel.h"





@interface SMBGameLevel (SMBTestLevel)

#pragma mark - testLevel
+(nonnull instancetype)smb_testLevel_oneTurnRight;
+(nonnull instancetype)smb_testLevel_clover;

@end
