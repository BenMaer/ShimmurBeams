//
//  SMBGameLevel+SMBForcedRedirectsAndWalls.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/14/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameLevel.h"





@interface SMBGameLevel (SMBForcedRedirectsAndWalls)

+(nonnull instancetype)smb_forcedRedirectsAndWalls_oneForce_right;
+(nonnull instancetype)smb_forcedRedirectsAndWalls_twoForces_leftThenDown;
+(nonnull instancetype)smb_forcedRedirectsAndWalls_oneWall_threeForces;
+(nonnull instancetype)smb_forcedRedirectsAndWalls_twoWalls_threeForces;
+(nonnull instancetype)smb_forcedRedirectsAndWalls_wallsAndForces_twoForcesNotMovable_tricky;

#pragma mark - forces not movable
+(nonnull instancetype)smb_forcedRedirects_oneForceNotMovable;
+(nonnull instancetype)smb_forcedRedirects_wallsAndForces_threeForcesNotMovable;

@end
