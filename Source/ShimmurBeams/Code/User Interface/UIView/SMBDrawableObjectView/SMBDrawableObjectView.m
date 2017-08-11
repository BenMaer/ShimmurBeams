//
//  SMBDrawableObjectView.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/4/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBDrawableObjectView.h"
#import "SMBDrawableObject.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/NSMutableArray+RUAddObjectIfNotNil.h>
#import <ResplendentUtilities/RUConstants.h>





static void* kSMBDrawableObjectView__KVOContext = &kSMBDrawableObjectView__KVOContext;





@interface SMBDrawableObjectView ()

#pragma mark - drawableObject
@property (nonatomic, assign) BOOL drawableObject_hasRedrawn;
-(void)drawableObject_setKVORegistered:(BOOL)registered;

@end





@implementation SMBDrawableObjectView

#pragma mark - NSObject
-(void)dealloc
{
	[self drawableObject_setKVORegistered:NO];
}

-(instancetype)initWithFrame:(CGRect)frame
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wno-nullability-completeness"
	return [self init_with_drawableObject:nil];
#pragma clang diagnostic pop
}

-(nonnull NSString*)description
{
	NSMutableArray<NSString*>* const description_lines = [NSMutableArray<NSString*> array];
	[description_lines ru_addObjectIfNotNil:[super description]];
	[description_lines ru_addObjectIfNotNil:RUStringWithFormat(@"drawableObject: %@",self.drawableObject)];

	return [description_lines componentsJoinedByString:@"\n"];
}

#pragma mark - NSCoding
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wno-nullability-completeness"
	return [self init_with_drawableObject:nil];
#pragma clang diagnostic pop
}

#pragma mark - init
-(nullable instancetype)init_with_drawableObject:(nonnull SMBDrawableObject*)drawableObject
{
	kRUConditionalReturn_ReturnValueNil(drawableObject == nil, YES);

	if (self = [super initWithFrame:CGRectZero])
	{
		[self setBackgroundColor:[UIColor clearColor]];

		_drawableObject = drawableObject;
		[self drawableObject_setKVORegistered:YES];
	}

	return self;
}

#pragma mark - UIView
-(void)drawRect:(CGRect)rect
{
	[super drawRect:rect];

	SMBDrawableObject* const drawableObject = self.drawableObject;
	kRUConditionalReturn(drawableObject == nil, YES);

	if ((self.drawableObject_hasRedrawn == false)
		||
		drawableObject.needsRedraw)
	{
		[self setDrawableObject_hasRedrawn:YES];

		CGContextRef const context = UIGraphicsGetCurrentContext();

		CGContextSaveGState(context);

		[drawableObject draw_in_rect:rect];

		CGContextRestoreGState(context);
	}
}

#pragma mark - drawableObject
-(void)drawableObject_setKVORegistered:(BOOL)registered
{
	typeof(self.drawableObject) const drawableObject = self.drawableObject;
	kRUConditionalReturn(drawableObject == nil, YES);

	NSMutableArray<NSString*>* const propertiesToObserve = [NSMutableArray<NSString*> array];
	[propertiesToObserve addObject:[SMBDrawableObject_PropertiesForKVO needsRedraw]];

	[propertiesToObserve enumerateObjectsUsingBlock:^(NSString * _Nonnull propertyToObserve, NSUInteger idx, BOOL * _Nonnull stop) {
		if (registered)
		{
			[drawableObject addObserver:self
									 forKeyPath:propertyToObserve
										options:(NSKeyValueObservingOptionInitial)
										context:&kSMBDrawableObjectView__KVOContext];
		}
		else
		{
			[drawableObject removeObserver:self
										forKeyPath:propertyToObserve
										   context:&kSMBDrawableObjectView__KVOContext];
		}
	}];
}

#pragma mark - KVO
-(void)observeValueForKeyPath:(nullable NSString*)keyPath ofObject:(nullable id)object change:(nullable NSDictionary*)change context:(nullable void*)context
{
	if (context == kSMBDrawableObjectView__KVOContext)
	{
		if (object == self.drawableObject)
		{
			if ([keyPath isEqualToString:[SMBDrawableObject_PropertiesForKVO needsRedraw]])
			{
				if (self.drawableObject.needsRedraw)
				{
					[self setDrawableObject_hasRedrawn:NO];
					[self setNeedsDisplay];
				}
			}
			else
			{
				NSAssert(false, @"unhandled keyPath %@",keyPath);
			}
		}
		else
		{
			NSAssert(false, @"unhandled object %@",object);
		}
	}
	else
	{
		[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
	}
}

@end
