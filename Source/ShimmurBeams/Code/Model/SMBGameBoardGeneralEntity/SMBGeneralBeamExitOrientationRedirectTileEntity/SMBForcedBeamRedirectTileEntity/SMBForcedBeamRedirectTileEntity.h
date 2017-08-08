//
//  SMBForcedBeamRedirectTileEntity.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/8/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGeneralBeamExitOrientationRedirectTileEntity.h"





@interface SMBForcedBeamRedirectTileEntity : SMBGeneralBeamExitOrientationRedirectTileEntity

#pragma mark - forcedBeamExitOrientation
@property (nonatomic, readonly, assign) SMBBeamEntityTileNode__beamOrientation forcedBeamExitOrientation;

#pragma mark - init
-(nullable instancetype)init_with_forcedBeamExitOrientation:(SMBBeamEntityTileNode__beamOrientation)forcedBeamExitOrientation NS_DESIGNATED_INITIALIZER;

@end
