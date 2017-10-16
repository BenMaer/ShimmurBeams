//
//  SMBMeltableWallTileEntity.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/15/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBForcedBeamRedirectTileEntity.h"
#import "SMBBeamBlockerTileEntity.h"





@interface SMBMeltableWallTileEntity : SMBForcedBeamRedirectTileEntity <SMBBeamBlockerTileEntity>

#pragma mark - meltableBeamEnterDirections
@property (nonatomic, readonly, assign) SMBGameBoardTile__direction meltableBeamEnterDirections;

#pragma mark - SMBForcedBeamRedirectTileEntity: init
-(nullable instancetype)init_with_forcedBeamExitDirection:(SMBGameBoardTile__direction)forcedBeamExitDirection OBJC_DEPRECATED("Must use init");

#pragma mark - init
-(nullable instancetype)init_with_meltableBeamEnterDirections:(SMBGameBoardTile__direction)meltableBeamEnterDirections NS_DESIGNATED_INITIALIZER;

@end
