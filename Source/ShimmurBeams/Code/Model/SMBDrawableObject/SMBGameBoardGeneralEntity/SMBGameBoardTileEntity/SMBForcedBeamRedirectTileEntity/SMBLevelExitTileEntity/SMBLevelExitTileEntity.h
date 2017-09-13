//
//  SMBLevelExitTileEntity.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/9/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBForcedBeamRedirectTileEntity.h"





@interface SMBLevelExitTileEntity : SMBForcedBeamRedirectTileEntity

#pragma mark - SMBForcedBeamRedirectTileEntity: init
-(nullable instancetype)init_with_forcedBeamExitDirection:(SMBGameBoardTile__direction)forcedBeamExitDirection OBJC_DEPRECATED("Must use init");

#pragma mark - init
-(nullable instancetype)init NS_DESIGNATED_INITIALIZER;

@end
