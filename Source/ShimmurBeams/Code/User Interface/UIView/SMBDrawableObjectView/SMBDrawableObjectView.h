//
//  SMBDrawableObjectView.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/4/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBMappedDataCollection_MappableObject.h"

#import <UIKit/UIKit.h>





@class SMBDrawableObject;





@interface SMBDrawableObjectView : UIView

#pragma mark - drawableObject
@property (nonatomic, readonly, strong, nullable) SMBDrawableObject* drawableObject;

#pragma mark - init
-(nullable instancetype)init_with_drawableObject:(nonnull SMBDrawableObject*)drawableObject NS_DESIGNATED_INITIALIZER;

@end
