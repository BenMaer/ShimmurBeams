//
//  SMBWallTileEntity.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/10/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBWallTileEntity.h"





@implementation SMBWallTileEntity

#pragma mark - NSObject
-(instancetype)init
{
	if (self = [super init])
	{
		[self setBeamEnterDirections_blocked:SMBGameBoardTile__directions_all()];
	}

	return self;
}

#pragma mark - SMBGameBoardGeneralEntity: draw
-(void)draw_in_rect:(CGRect)rect
{
	[super draw_in_rect:rect];

	CGContextRef const context = UIGraphicsGetCurrentContext();

	CGContextSaveGState(context);

	CGContextSetFillColorWithColor(context, [UIColor darkGrayColor].CGColor);

	CGFloat const inset_ratio = 0.0f;
	CGContextFillRect(context, CGRectInset(rect, CGRectGetWidth(rect) * inset_ratio, CGRectGetHeight(rect) * inset_ratio));

	CGContextRestoreGState(context);
}

#pragma mark - SMBBeamBlockerTileEntity
@synthesize beamEnterDirections_blocked = _beamEnterDirections_blocked;

@end
