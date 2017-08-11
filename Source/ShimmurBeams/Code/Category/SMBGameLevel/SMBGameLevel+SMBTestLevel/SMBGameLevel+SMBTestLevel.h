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
+(nonnull instancetype)smb_testLevel_oneForce_right;
+(nonnull instancetype)smb_testLevel_twoForces_leftThenDown;
+(nonnull instancetype)smb_testLevel_clover;

@end
