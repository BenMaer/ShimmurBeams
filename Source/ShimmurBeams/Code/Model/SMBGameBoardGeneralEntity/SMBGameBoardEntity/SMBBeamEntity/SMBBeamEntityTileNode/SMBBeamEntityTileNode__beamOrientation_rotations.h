//
//  SMBBeamEntityTileNode__beamOrientation_rotations.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/8/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#ifndef SMBBeamEntityTileNode__beamOrientation_rotations_h
#define SMBBeamEntityTileNode__beamOrientation_rotations_h

#import "SMBBeamEntityTileNode__beamOrientations.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/RUEnumIsInRangeSynthesization.h>

#import <Foundation/Foundation.h>





typedef NS_ENUM(NSInteger, SMBBeamEntityTileNode__beamOrientation_rotation) {
	SMBBeamEntityTileNode__beamOrientation_rotation_none,
	SMBBeamEntityTileNode__beamOrientation_rotation_left,
	SMBBeamEntityTileNode__beamOrientation_rotation_right,

	SMBBeamEntityTileNode__beamOrientation_rotation_unknown,

	SMBBeamEntityTileNode__beamOrientation_rotation__first	= SMBBeamEntityTileNode__beamOrientation_rotation_left,
	SMBBeamEntityTileNode__beamOrientation_rotation__last	= SMBBeamEntityTileNode__beamOrientation_rotation_right,
};

static inline RUEnumIsInRangeSynthesization_autoFirstLast(SMBBeamEntityTileNode__beamOrientation_rotation);

static inline SMBBeamEntityTileNode__beamOrientation SMBBeamEntityTileNode__beamOrientation_rotation_beamOrientation_rotated_right(SMBBeamEntityTileNode__beamOrientation beamOrientation){
	switch (beamOrientation)
	{
		case SMBBeamEntityTileNode__beamOrientation_none:
			break;

		case SMBBeamEntityTileNode__beamOrientation_up:
			return SMBBeamEntityTileNode__beamOrientation_right;
			break;

		case SMBBeamEntityTileNode__beamOrientation_right:
			return SMBBeamEntityTileNode__beamOrientation_down;
			break;

		case SMBBeamEntityTileNode__beamOrientation_down:
			return SMBBeamEntityTileNode__beamOrientation_left;
			break;

		case SMBBeamEntityTileNode__beamOrientation_left:
			return SMBBeamEntityTileNode__beamOrientation_up;
			break;
	}

	NSCAssert(false, @"unhandled beamOrientation %li",(long)beamOrientation);
	return SMBBeamEntityTileNode__beamOrientation_none;
}

static inline SMBBeamEntityTileNode__beamOrientation SMBBeamEntityTileNode__beamOrientation_rotation_beamOrientation_rotated_left(SMBBeamEntityTileNode__beamOrientation beamOrientation){
	switch (beamOrientation)
	{
		case SMBBeamEntityTileNode__beamOrientation_none:
			break;
			
		case SMBBeamEntityTileNode__beamOrientation_up:
			return SMBBeamEntityTileNode__beamOrientation_left;
			break;
			
		case SMBBeamEntityTileNode__beamOrientation_right:
			return SMBBeamEntityTileNode__beamOrientation_up;
			break;
			
		case SMBBeamEntityTileNode__beamOrientation_down:
			return SMBBeamEntityTileNode__beamOrientation_right;
			break;
			
		case SMBBeamEntityTileNode__beamOrientation_left:
			return SMBBeamEntityTileNode__beamOrientation_down;
			break;
	}

	NSCAssert(false, @"unhandled beamOrientation %li",(long)beamOrientation);
	return SMBBeamEntityTileNode__beamOrientation_none;
}

static inline SMBBeamEntityTileNode__beamOrientation SMBBeamEntityTileNode__beamOrientation_rotation_beamOrientation_rotated(SMBBeamEntityTileNode__beamOrientation beamOrientation, SMBBeamEntityTileNode__beamOrientation_rotation beamOrientation_rotation){

	switch (beamOrientation_rotation)
	{
		case SMBBeamEntityTileNode__beamOrientation_rotation_none:
			return beamOrientation;
			break;

		case SMBBeamEntityTileNode__beamOrientation_rotation_left:
			return SMBBeamEntityTileNode__beamOrientation_rotation_beamOrientation_rotated_left(beamOrientation);
			break;

		case SMBBeamEntityTileNode__beamOrientation_rotation_right:
			return SMBBeamEntityTileNode__beamOrientation_rotation_beamOrientation_rotated_right(beamOrientation);
			break;

		case SMBBeamEntityTileNode__beamOrientation_rotation_unknown:
			break;
	}

	NSCAssert(false, @"unhandled beamOrientation %li",(long)beamOrientation);
	return SMBBeamEntityTileNode__beamOrientation_none;
}





#endif /* SMBBeamEntityTileNode__beamOrientation_rotations_h */
