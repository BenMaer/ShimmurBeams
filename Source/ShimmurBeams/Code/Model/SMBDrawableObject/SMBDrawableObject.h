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
@property (nonatomic, readonly, assign) BOOL needsRedraw;
-(void)setNeedsRedraw;
-(void)draw_in_rect:(CGRect)rect;

#pragma mark - subDrawableObjects
@property (nonatomic, readonly, copy, nullable) NSArray<__kindof SMBDrawableObject*>* subDrawableObjects;
-(void)subDrawableObjects_add:(nonnull __kindof SMBDrawableObject*)subDrawableObject;
-(void)subDrawableObjects_remove:(nonnull __kindof SMBDrawableObject*)subDrawableObject;

-(void)subDrawableObject:(nonnull __kindof SMBDrawableObject*)subDrawableObject
			draw_in_rect:(CGRect)rect;

@end





@interface SMBDrawableObject_PropertiesForKVO : NSObject

+(nonnull NSString*)needsRedraw;

@end
