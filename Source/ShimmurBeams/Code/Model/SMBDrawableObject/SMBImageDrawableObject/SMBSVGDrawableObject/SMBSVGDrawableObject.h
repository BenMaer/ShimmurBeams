//
//  SMBSVGDrawableObject.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/30/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBImageDrawableObject.h"





@interface SMBSVGDrawableObject : SMBImageDrawableObject

#pragma mark - name
@property (nonatomic, copy, nullable) NSString* name;

#pragma mark - convenience constructor
+(nullable instancetype)SMBSVGDrawableObject_with_name:(nonnull NSString*)name;

@end
