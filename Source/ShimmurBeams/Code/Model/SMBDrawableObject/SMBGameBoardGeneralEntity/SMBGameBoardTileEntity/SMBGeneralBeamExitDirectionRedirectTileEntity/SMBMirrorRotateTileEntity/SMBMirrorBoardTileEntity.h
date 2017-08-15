//
//  SMBMirrorBoardTileEntity.h
//  ShimmurBeams
//
//  Created by Jordan Langsam on 8/15/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardTileEntity.h"
#import "SMBGeneralBeamExitDirectionRedirectTileEntity.h"
#import "SMBGameBoardTile__direction_rotations.h"





@interface SMBMirrorBoardTileEntity : SMBGameBoardTileEntity <SMBGeneralBeamExitDirectionRedirectTileEntity>

#pragma mark - init
-(nullable instancetype)init_with_topLeftToBotoomRight:(BOOL)topLeftToBotoomRight NS_DESIGNATED_INITIALIZER;

@end
