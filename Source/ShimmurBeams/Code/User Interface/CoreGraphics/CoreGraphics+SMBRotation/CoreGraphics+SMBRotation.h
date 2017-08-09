//
//  CoreGraphics+SMBRotation.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/8/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#ifndef CoreGraphics_SMBRotation_h
#define CoreGraphics_SMBRotation_h

#import "CoreGraphics+SMBRotation__orientations.h"

#import <CoreGraphics/CoreGraphics.h>





static inline CGFloat _CoreGraphics_SMBRotation_radians(CGFloat degrees)
{
	return (degrees / 180.0f) * M_PI;
}

static inline CGFloat _CoreGraphics_SMBRotation_degrees(CoreGraphics_SMBRotation__orientation orientation)
{
	switch (orientation)
	{
		case CoreGraphics_SMBRotation__orientation_up:
			return 0.0f;
			break;

		case CoreGraphics_SMBRotation__orientation_right:
			return 90.0f;
			break;

		case CoreGraphics_SMBRotation__orientation_down:
			return 180.0f;
			break;

		case CoreGraphics_SMBRotation__orientation_left:
			return -90.0f;
			break;

		case CoreGraphics_SMBRotation__orientation_unknown:
			break;
	}

	NSCAssert(false, @"unhandled orientation %li",(long)orientation);
	return 0.0f;
}

static inline void CoreGraphics_SMBRotation__rotateCTM(CGContextRef context, CGRect rect, CoreGraphics_SMBRotation__orientation orientation){
	
	CGContextTranslateCTM(context, CGRectGetMidX(rect), CGRectGetMidY(rect));
	CGContextRotateCTM(context, _CoreGraphics_SMBRotation_radians(_CoreGraphics_SMBRotation_degrees(orientation)));
	CGContextTranslateCTM(context, -CGRectGetWidth(rect) / 2.0f, -CGRectGetHeight(rect) / 2.0f);
}

#endif /* CoreGraphics_SMBRotation_h */
