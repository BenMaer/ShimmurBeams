//
//  SMBGameLevel+SMBForcedRedirectsAndWalls.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/14/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameLevel.h"





@interface SMBGameLevel (SMBForcedRedirectsAndWalls)

#pragma mark - forced redirects
+(nonnull instancetype)smb_forcedRedirects_oneForce_right;
//+(nonnull instancetype)smb_forcedRedirects_twoForces_leftThenDown;
//+(nonnull instancetype)smb_forcedRedirects_oneForceNotMovable;
//+(nonnull instancetype)smb_forcedRedirects_wallsAndForces_threeForcesNotMovable;

#pragma mark - forced redirects and walls
//+(nonnull instancetype)smb_forcedRedirectsAndWalls_oneWall_threeForces;
//+(nonnull instancetype)smb_forcedRedirectsAndWalls_twoWalls_threeForces;
//+(nonnull instancetype)smb_forcedRedirectsAndWalls_wallsAndForces_twoForcesNotMovable_tricky;

@end
