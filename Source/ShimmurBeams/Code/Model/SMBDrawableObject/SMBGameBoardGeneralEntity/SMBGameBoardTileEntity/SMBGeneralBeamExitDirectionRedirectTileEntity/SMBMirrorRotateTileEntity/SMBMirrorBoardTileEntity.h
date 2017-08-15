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





typedef NS_ENUM(NSInteger, SMBMirrorBoardTileEntity_startingPosition) {
	SMBMirrorBoardTileEntity_startingPosition_topLeft,
	SMBMirrorBoardTileEntity_startingPosition_bottomLeft,
};

@interface SMBMirrorBoardTileEntity : SMBGameBoardTileEntity <SMBGeneralBeamExitDirectionRedirectTileEntity>

#pragma mark - init
-(nullable instancetype)init_with_startingPosition:(SMBMirrorBoardTileEntity_startingPosition)startingPosition NS_DESIGNATED_INITIALIZER;

#pragma mark - startingPosition
@property (nonatomic, readonly, assign) SMBMirrorBoardTileEntity_startingPosition startingPosition;

@end
