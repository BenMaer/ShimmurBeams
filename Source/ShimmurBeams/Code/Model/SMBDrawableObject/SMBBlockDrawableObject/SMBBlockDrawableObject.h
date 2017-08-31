//
//  SMBBlockDrawableObject.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/30/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBDrawableObject.h"
#import "SMBBlockDrawableObject__blocks.h"





@interface SMBBlockDrawableObject : SMBDrawableObject

#pragma mark - drawBlock
@property (nonatomic, copy, nullable) SMBBlockDrawableObject__drawBlock drawBlock;

#pragma mark - convenience constructor
+(nullable instancetype)SMBBlockDrawableObject_with_drawBlock:(nonnull SMBBlockDrawableObject__drawBlock)drawBlock;

@end
