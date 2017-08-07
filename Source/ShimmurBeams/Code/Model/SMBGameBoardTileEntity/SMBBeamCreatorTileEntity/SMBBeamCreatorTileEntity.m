//
//  SMBBeamCreatorTileEntity.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/4/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBBeamCreatorTileEntity.h"
#import "SMBBeamEntity.h"

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>





@interface SMBBeamCreatorTileEntity ()

#pragma mark - beamEntity
@property (nonatomic, readonly, strong, nullable) SMBBeamEntity* beamEntity;

@end





@implementation SMBBeamCreatorTileEntity

#pragma mark - draw
-(void)draw_in_rect:(CGRect)rect
{
	CGContextRef const context = UIGraphicsGetCurrentContext();

	CGContextSaveGState(context);

	[super draw_in_rect:rect];

	CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
	CGContextSetLineWidth(context, 1.0f);

	CGFloat const inset = CGRectGetWidth(rect) / 4.0f;

	CGContextMoveToPoint(context, 0.0f, CGRectGetMaxY(rect)); /* Bottom left */
	CGContextAddLineToPoint(context, inset, CGRectGetMaxY(rect)); /* Bottom left of machine */
	CGContextAddLineToPoint(context, inset, CGRectGetMidY(rect)); /* Top left of machine */
	CGContextAddLineToPoint(context, CGRectGetMaxX(rect) - inset, CGRectGetMidY(rect)); /* Top right of machine */
	CGContextAddLineToPoint(context, CGRectGetMaxX(rect) - inset, CGRectGetMaxY(rect)); /* Bottom right of machine */
	CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect)); /* Bottom right */

	CGContextStrokePath(context);

	CGContextRestoreGState(context);
}

#pragma mark - entityAction
-(void)entityAction_setup
{
	_beamEntity =
	[[SMBBeamEntity alloc] init_with_gameBoardTile:self.gameBoardTile];

	NSAssert(self.beamEntity != nil, @"Shouldn't be nil");
}

@end