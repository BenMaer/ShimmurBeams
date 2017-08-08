//
//  SMBBeamEntityTileNode__beamOrientations.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/7/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#ifndef SMBBeamEntityTileNode__beamOrientations_h
#define SMBBeamEntityTileNode__beamOrientations_h

#import <ResplendentUtilities/RUEnumIsInRangeSynthesization.h>

#import <Foundation/Foundation.h>





typedef NS_ENUM(NSInteger, SMBBeamEntityTileNode__beamOrientation) {
	SMBBeamEntityTileNode__beamOrientation_none,

	SMBBeamEntityTileNode__beamOrientation_up,
	SMBBeamEntityTileNode__beamOrientation_right,
	SMBBeamEntityTileNode__beamOrientation_down,
	SMBBeamEntityTileNode__beamOrientation_left,

	SMBBeamEntityTileNode__beamOrientation__first	= SMBBeamEntityTileNode__beamOrientation_up,
	SMBBeamEntityTileNode__beamOrientation__last	= SMBBeamEntityTileNode__beamOrientation_left,
};

static inline RUEnumIsInRangeSynthesization_autoFirstLast(SMBBeamEntityTileNode__beamOrientation)

#endif /* SMBBeamEntityTileNode__beamOrientations_h */
