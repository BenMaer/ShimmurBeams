//
//  SMBBlockDrawableObject+SMBDefaultBlockDrawings.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/30/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBBlockDrawableObject.h"





@interface SMBBlockDrawableObject (SMBDefaultBlockDrawings)

#pragma mark - beamCreatorTileEntity
+(nullable instancetype)smb_defaultBlockDrawing_beamCreatorTileEntity_drawableObject_with_powerIndicatorColorRefBlock:(CGColorRef _Nullable (^ _Nonnull)(void))powerIndicatorColorRefBlock;

extern void SMBBlockDrawableObject_SMBDefaultBlockDrawings__beamCreatorTileEntity_draw(CGContextRef _Nonnull context, CGRect rect, CGColorRef _Nullable powerIndicatorColorRef);

@end
