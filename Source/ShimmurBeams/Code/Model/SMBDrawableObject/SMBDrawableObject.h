//
//  SMBDrawableObject.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/11/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>





@interface SMBDrawableObject : NSObject

#pragma mark - draw
@property (nonatomic, assign) BOOL needsRedraw;
-(void)draw_in_rect:(CGRect)rect;

@end





@interface SMBDrawableObject_PropertiesForKVO : NSObject

+(nonnull NSString*)needsRedraw;

@end
