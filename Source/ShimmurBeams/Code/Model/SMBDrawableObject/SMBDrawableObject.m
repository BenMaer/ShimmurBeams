//
//  SMBDrawableObject.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/11/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBDrawableObject.h"





@implementation SMBDrawableObject

#pragma mark - NSObject
-(instancetype)init
{
	if (self = [super init])
	{
		[self setNeedsRedraw:YES];
	}
	
	return self;
}

#pragma mark - draw
-(void)draw_in_rect:(CGRect)rect
{
	[self setNeedsRedraw:NO];
}

@end





@implementation SMBDrawableObject_PropertiesForKVO

+(nonnull NSString*)needsRedraw{return NSStringFromSelector(_cmd);}

@end
