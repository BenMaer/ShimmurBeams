//
//  SMBDrawableObject.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/11/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBDrawableObject.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@interface SMBDrawableObject ()

#pragma mark - draw
@property (nonatomic, assign) BOOL needsRedraw;

#pragma mark - subDrawableObjects
@property (nonatomic, copy, nullable) NSArray<__kindof SMBDrawableObject*>* subDrawableObjects;
-(void)subDrawableObjects_update;
@property (nonatomic, readonly, strong, nonnull) NSMutableArray<__kindof SMBDrawableObject*>* subDrawableObjects_mutable;

@end





@implementation SMBDrawableObject

#pragma mark - NSObject
-(instancetype)init
{
	if (self = [super init])
	{
		[self subDrawableObjects_update];

		[self setNeedsRedraw];
	}

	return self;
}

#pragma mark - draw
-(void)setNeedsRedraw
{
	kRUConditionalReturn(self.needsRedraw == YES, NO);

	[self setNeedsRedraw:YES];
}

-(void)draw_in_rect:(CGRect)rect
{
	[self setNeedsRedraw:NO];

	CGContextRef const context = UIGraphicsGetCurrentContext();

	[self.subDrawableObjects enumerateObjectsUsingBlock:^(__kindof SMBDrawableObject * _Nonnull subDrawableObject, NSUInteger idx, BOOL * _Nonnull stop) {
		CGContextSaveGState(context);

		[self subDrawableObject:subDrawableObject
				   draw_in_rect:rect];

		CGContextRestoreGState(context);
	}];
}

#pragma mark - subDrawableObjects
-(void)setSubDrawableObjects:(nullable NSArray<__kindof SMBDrawableObject*>*)subDrawableObjects
{
	kRUConditionalReturn((self.subDrawableObjects == subDrawableObjects)
						 ||
						 [self.subDrawableObjects isEqual:subDrawableObjects], NO);

	_subDrawableObjects = (subDrawableObjects ? [NSArray<__kindof SMBDrawableObject*> arrayWithArray:subDrawableObjects] : nil);

	[self setNeedsRedraw];
}

-(void)subDrawableObjects_update
{
	[self setSubDrawableObjects:[NSArray<__kindof SMBDrawableObject*> arrayWithArray:self.subDrawableObjects_mutable]];
}

@synthesize subDrawableObjects_mutable = _subDrawableObjects_mutable;
-(nonnull NSMutableArray<__kindof SMBDrawableObject*>*)subDrawableObjects_mutable
{
	if (_subDrawableObjects_mutable == nil)
	{
		_subDrawableObjects_mutable = [NSMutableArray<__kindof SMBDrawableObject*> new];
	}

	return _subDrawableObjects_mutable;
}

-(void)subDrawableObjects_add:(nonnull __kindof SMBDrawableObject*)subDrawableObject
{
	kRUConditionalReturn(subDrawableObject == nil, YES);

	NSMutableArray<__kindof SMBDrawableObject*>* const subDrawableObjects_mutable = self.subDrawableObjects_mutable;
	kRUConditionalReturn(subDrawableObjects_mutable == nil, YES);
	kRUConditionalReturn([subDrawableObjects_mutable containsObject:subDrawableObject], YES);

	[subDrawableObjects_mutable addObject:subDrawableObject];

	[self subDrawableObjects_update];
}

-(void)subDrawableObjects_remove:(nonnull __kindof SMBDrawableObject*)subDrawableObject
{
	kRUConditionalReturn(subDrawableObject == nil, YES);

	NSMutableArray<__kindof SMBDrawableObject*>* const subDrawableObjects_mutable = self.subDrawableObjects_mutable;
	kRUConditionalReturn(subDrawableObjects_mutable == nil, YES);

	NSUInteger const subDrawableObject_index = [subDrawableObjects_mutable indexOfObject:subDrawableObject];
	kRUConditionalReturn(subDrawableObject_index == NSNotFound, YES);

	[subDrawableObjects_mutable removeObjectAtIndex:subDrawableObject_index];

	[self subDrawableObjects_update];
}

-(void)subDrawableObject:(nonnull __kindof SMBDrawableObject*)subDrawableObject
			draw_in_rect:(CGRect)rect
{
	kRUConditionalReturn(subDrawableObject == nil, YES);
	kRUConditionalReturn([self.subDrawableObjects containsObject:subDrawableObject] == false, YES);

	[subDrawableObject draw_in_rect:rect];
}

@end





@implementation SMBDrawableObject_PropertiesForKVO

+(nonnull NSString*)needsRedraw{return NSStringFromSelector(_cmd);}

@end
