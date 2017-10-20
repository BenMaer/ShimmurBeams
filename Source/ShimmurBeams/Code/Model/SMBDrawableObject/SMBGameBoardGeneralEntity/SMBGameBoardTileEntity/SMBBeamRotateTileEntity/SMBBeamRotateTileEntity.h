//
//  SMBBeamRotateTileEntity.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/14/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardTileEntity.h"
#import "SMBGeneralBeamEnterToExitDirectionRedirectTileEntity.h"
#import "SMBGameBoardTile__direction_rotations.h"





@interface SMBBeamRotateTileEntity : SMBGameBoardTileEntity <SMBGeneralBeamEnterToExitDirectionRedirectTileEntity>

#pragma mark - direction_rotation
@property (nonatomic, readonly, assign) SMBGameBoardTile__direction_rotation direction_rotation;

#pragma mark - init
-(nullable instancetype)init_with_direction_rotation:(SMBGameBoardTile__direction_rotation)direction_rotation NS_DESIGNATED_INITIALIZER;

@end
