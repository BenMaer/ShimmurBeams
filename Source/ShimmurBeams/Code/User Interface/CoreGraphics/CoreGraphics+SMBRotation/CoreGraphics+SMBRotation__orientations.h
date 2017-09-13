//
//  CoreGraphics+SMBRotation__orientations.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/8/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#ifndef CoreGraphics_SMBRotation__orientations_h
#define CoreGraphics_SMBRotation__orientations_h

#import <Foundation/Foundation.h>





typedef NS_ENUM(NSInteger, CoreGraphics_SMBRotation__orientation) {
	CoreGraphics_SMBRotation__orientation_up,
	CoreGraphics_SMBRotation__orientation_right,
	CoreGraphics_SMBRotation__orientation_down,
	CoreGraphics_SMBRotation__orientation_left,
	
	CoreGraphics_SMBRotation__orientation_unknown,
	
	CoreGraphics_SMBRotation__orientation__first	= CoreGraphics_SMBRotation__orientation_up,
	CoreGraphics_SMBRotation__orientation__last		= CoreGraphics_SMBRotation__orientation_left,
};

#endif /* CoreGraphics_SMBRotation__orientations_h */
