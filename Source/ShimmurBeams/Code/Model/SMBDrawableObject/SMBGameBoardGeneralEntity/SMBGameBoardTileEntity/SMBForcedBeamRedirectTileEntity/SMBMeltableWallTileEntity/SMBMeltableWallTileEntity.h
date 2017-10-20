//
//  SMBMeltableWallTileEntity.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/15/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardTileEntity.h"
#import "SMBBeamBlockerTileEntity.h"
#import "SMBGeneralBeamEnterToExitDirectionRedirectTileEntity.h"





@interface SMBMeltableWallTileEntity : SMBGameBoardTileEntity <SMBBeamBlockerTileEntity, SMBGeneralBeamEnterToExitDirectionRedirectTileEntity>

#pragma mark - meltableBeamEnterDirections
@property (nonatomic, readonly, assign) SMBGameBoardTile__direction meltableBeamEnterDirections;

#pragma mark - init
-(nullable instancetype)init_with_meltableBeamEnterDirections:(SMBGameBoardTile__direction)meltableBeamEnterDirections NS_DESIGNATED_INITIALIZER;

@end
