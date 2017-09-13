//
//  SMBBlockDrawableObject.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/30/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBBlockDrawableObject.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@implementation SMBBlockDrawableObject

#pragma mark - SMBDrawableObject: draw
-(void)draw_in_rect:(CGRect)rect
{
	[super draw_in_rect:rect];

	SMBBlockDrawableObject__drawBlock const drawBlock = self.drawBlock;

	if (drawBlock)
	{
		CGContextRef const context = UIGraphicsGetCurrentContext();

		CGContextSaveGState(context);

		drawBlock(rect);

		CGContextRestoreGState(context);
	}
}

#pragma mark - drawBlock
-(void)setDrawBlock:(nullable SMBBlockDrawableObject__drawBlock)drawBlock
{
	kRUConditionalReturn(self.drawBlock == drawBlock, NO);

	_drawBlock = drawBlock;

	[self setNeedsRedraw];
}

#pragma mark - convenience constructor
+(nullable instancetype)SMBBlockDrawableObject_with_drawBlock:(nonnull SMBBlockDrawableObject__drawBlock)drawBlock
{
	kRUConditionalReturn_ReturnValueNil(drawBlock == nil, YES);

	SMBBlockDrawableObject* const SVGDrawableObject = [SMBBlockDrawableObject new];
	[SVGDrawableObject setDrawBlock:drawBlock];

	return SVGDrawableObject;
}

@end
