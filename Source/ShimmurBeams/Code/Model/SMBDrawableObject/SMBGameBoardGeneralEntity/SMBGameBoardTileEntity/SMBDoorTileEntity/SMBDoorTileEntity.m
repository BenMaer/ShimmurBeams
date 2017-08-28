//
//  SMBDoorTileEntity.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/28/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBDoorTileEntity.h"





@implementation SMBDoorTileEntity

#pragma mark - NSObject
-(instancetype)init
{
	if (self = [super init])
	{
		[self setDoorIsOpen:YES];
	}

	return self;
}

#pragma mark - SMBGameBoardGeneralEntity: draw
-(void)draw_in_rect:(CGRect)rect
{
	[super draw_in_rect:rect];

	CGFloat const padding_fromEdge_horizontal = CGRectGetWidth(rect) / 5.0f;
	CGFloat const padding_fromTop = CGRectGetWidth(rect) / 4.0f;

	CGContextRef const context = UIGraphicsGetCurrentContext();

	CGContextSaveGState(context);

	CGContextSetFillColorWithColor(context, [UIColor darkGrayColor].CGColor);
	CGContextFillRect(context,
					  UIEdgeInsetsInsetRect(rect,
											(UIEdgeInsets){
												.left	= padding_fromEdge_horizontal,
												.right	= padding_fromEdge_horizontal,
												.top	= padding_fromTop,
											}));

	CGContextRestoreGState(context);
}

#pragma mark - SMBBeamBlockerTileEntity
-(BOOL)beamEnterDirection_isBlocked:(SMBGameBoardTile__direction)beamEnterDirection
{
	return (self.doorIsOpen == false);
}

@end
