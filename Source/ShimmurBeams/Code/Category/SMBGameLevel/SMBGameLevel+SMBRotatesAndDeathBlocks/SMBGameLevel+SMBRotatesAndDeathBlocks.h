//
//  SMBGameLevel+SMBRotatesAndDeathBlocks.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/15/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameLevel.h"





@interface SMBGameLevel (SMBRotatesAndDeathBlocks)

#pragma mark - rotates
+(nonnull instancetype)smb_rotates_oneRotate_right;
+(nonnull instancetype)smb_rotates_twoLefts_right;

@end
