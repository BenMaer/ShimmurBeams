//
//  SMBSVGDrawableObject.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/30/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBSVGDrawableObject.h"

#import <ResplendentUtilities/RUConditionalReturn.h>

#import <UIImage+SVG/UIImage+SVG.h>





@implementation SMBSVGDrawableObject

#pragma mark - name
-(void)setName:(nullable NSString*)name
{
	kRUConditionalReturn((self.name == name)
						 ||
						 [self.name isEqual:name], NO);

	_name =
	(name
	 ?
	 [NSString stringWithString:name]
	 :
	 nil
	);

	[self setNeedsRedraw];
}

#pragma mark - convenience constructor
+(nullable instancetype)SMBSVGDrawableObject_with_name:(nonnull NSString*)name
{
	kRUConditionalReturn_ReturnValueNil(name == nil, YES);

	SMBSVGDrawableObject* const SVGDrawableObject = [SMBSVGDrawableObject new];
	[SVGDrawableObject setName:name];

	return SVGDrawableObject;
}

#pragma mark - image
-(nullable UIImage*)image_toDraw_in_rect:(CGRect)rect
{
	NSString* const name = self.name;
	kRUConditionalReturn_ReturnValueNil(name == nil, YES);

	UIImage* const image =
	[UIImage imageWithSVGNamed:name
					targetSize:rect.size
					 fillColor:[UIColor blackColor]
						 cache:YES];
	kRUConditionalReturn_ReturnValueNil(image == nil, YES);

	return image;
}

@end
