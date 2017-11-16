//
//  SMBDiagonalMirrorTileEntity__MirrorTypes.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 11/16/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#ifndef SMBDiagonalMirrorTileEntity__MirrorTypes_h
#define SMBDiagonalMirrorTileEntity__MirrorTypes_h

#import <Foundation/Foundation.h>

#import <ResplendentUtilities/RUConditionalReturn.h>





typedef NS_ENUM(NSInteger, SMBDiagonalMirrorTileEntity__mirrorType) {
	SMBDiagonalMirrorTileEntity__mirrorType_topLeft_to_bottomRight,
	SMBDiagonalMirrorTileEntity__mirrorType_bottomLeft_to_topRight,

	SMBDiagonalMirrorTileEntity__mirrorType__first	= SMBDiagonalMirrorTileEntity__mirrorType_topLeft_to_bottomRight,
	SMBDiagonalMirrorTileEntity__mirrorType__last	= SMBDiagonalMirrorTileEntity__mirrorType_bottomLeft_to_topRight,
};

static inline void SMBDiagonalMirrorTileEntity__mirrorTypes_enumerate(void (^ _Nonnull enumerationBlock)(SMBDiagonalMirrorTileEntity__mirrorType mirrorType)){
	kRUConditionalReturn(enumerationBlock == nil, YES);

	for (SMBDiagonalMirrorTileEntity__mirrorType mirrorType = SMBDiagonalMirrorTileEntity__mirrorType__first;
		 mirrorType <= SMBDiagonalMirrorTileEntity__mirrorType__last;
		 mirrorType++)
	{
		enumerationBlock(mirrorType);
	}
}

#endif /* SMBDiagonalMirrorTileEntity__MirrorTypes_h */
