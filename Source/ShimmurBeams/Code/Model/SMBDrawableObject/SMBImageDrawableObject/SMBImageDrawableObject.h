//
//  SMBImageDrawableObject.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/30/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBDrawableObject.h"





@interface SMBImageDrawableObject : SMBDrawableObject

#pragma mark - image
-(nullable UIImage*)image_toDraw_in_rect:(CGRect)rect;

@end
