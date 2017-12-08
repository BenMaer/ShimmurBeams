//
//  SMBDiagonalMirrorTileEntity.h
//  ShimmurBeams
//
//  Created by Jordan Langsam on 8/15/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardTileEntity.h"
#import "SMBGeneralBeamEnterToExitDirectionRedirectTileEntity.h"
#import "SMBDiagonalMirrorTileEntity__MirrorTypes.h"





@interface SMBDiagonalMirrorTileEntity : SMBGameBoardTileEntity <SMBGeneralBeamEnterToExitDirectionRedirectTileEntity>

#pragma mark - init
-(nullable instancetype)init_with_mirrorType:(SMBDiagonalMirrorTileEntity__mirrorType)mirrorType NS_DESIGNATED_INITIALIZER;

#pragma mark - mirrorType
@property (nonatomic, readonly, assign) SMBDiagonalMirrorTileEntity__mirrorType mirrorType;

@end
