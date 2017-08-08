//
//  SMBGeneralBeamExitOrientationRedirectTileEntity.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/8/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardTileEntity.h"
#import "SMBBeamEntityTileNode__beamOrientations.h"





@interface SMBGeneralBeamExitOrientationRedirectTileEntity : SMBGameBoardTileEntity

#pragma mark - beamExitOrientation
-(SMBBeamEntityTileNode__beamOrientation)beamExitOrientation_for_beamEnterOrientation:(SMBBeamEntityTileNode__beamOrientation)beamEnterOrientation;

@end
