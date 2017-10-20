//
//  SMBDiagonalMirrorTileEntity.h
//  ShimmurBeams
//
//  Created by Jordan Langsam on 8/15/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardTileEntity.h"
#import "SMBGeneralBeamEnterToExitDirectionRedirectTileEntity.h"
#import "SMBGameBoardTile__direction_rotations.h"





typedef NS_ENUM(NSInteger, SMBDiagonalMirrorTileEntity_startingPosition) {
	SMBDiagonalMirrorTileEntity_startingPosition_topLeft,
	SMBDiagonalMirrorTileEntity_startingPosition_bottomLeft,
};

@interface SMBDiagonalMirrorTileEntity : SMBGameBoardTileEntity <SMBGeneralBeamEnterToExitDirectionRedirectTileEntity>

#pragma mark - init
-(nullable instancetype)init_with_startingPosition:(SMBDiagonalMirrorTileEntity_startingPosition)startingPosition NS_DESIGNATED_INITIALIZER;

#pragma mark - startingPosition
@property (nonatomic, readonly, assign) SMBDiagonalMirrorTileEntity_startingPosition startingPosition;

@end
