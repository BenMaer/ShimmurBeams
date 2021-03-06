//
//  SMBGameLevel+SMBMirrorsAndMeltableBlocks.h
//  ShimmurBeams
//
//  Created by Jordan Langsam on 8/15/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameLevel.h"





@interface SMBGameLevel (SMBMirrorsAndMeltableBlocks)

+(nonnull instancetype)smb_mirrors_introduction;
+(nonnull instancetype)smb_mirror_man_in_the_mirror;
+(nonnull instancetype)smb_mirrors_hallOfMirrors;

#pragma mark - meltableWall
+(nonnull instancetype)smb_meltableWall_introduction;
+(nonnull instancetype)smb_meltableWall_oneDirection;
+(nonnull instancetype)smb_meltableWall_inTheWay;

@end
