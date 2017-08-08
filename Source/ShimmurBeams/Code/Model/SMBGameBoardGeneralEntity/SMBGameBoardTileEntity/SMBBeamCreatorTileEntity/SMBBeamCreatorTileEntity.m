//
//  SMBBeamCreatorTileEntity.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/4/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBBeamCreatorTileEntity.h"
#import "SMBBeamEntity.h"
#import "SMBGameBoardTile.h"
#import "SMBGameBoard.h"

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

#import <ResplendentUtilities/RUConditionalReturn.h>




@interface SMBBeamCreatorTileEntity ()

#pragma mark - beamEntity
@property (nonatomic, strong, nullable) SMBBeamEntity* beamEntity;
-(void)beamEntity_update;

@end





@implementation SMBBeamCreatorTileEntity

#pragma mark - draw
-(void)draw_in_gameBoardView:(nonnull SMBGameBoardView*)gameBoardView
						rect:(CGRect)rect
{
	[super draw_in_gameBoardView:gameBoardView
							rect:rect];

	CGContextRef const context = UIGraphicsGetCurrentContext();

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
}

#pragma mark - entityAction
-(void)entityAction_setup
{
	[self beamEntity_update];

	NSAssert(self.beamEntity != nil, @"Shouldn't be nil");
}

#pragma mark - beamEntity
-(void)setBeamEntity:(nullable SMBBeamEntity*)beamEntity
{
	kRUConditionalReturn(self.beamEntity == beamEntity, NO);

	if (self.beamEntity)
	{
		[self.gameBoardTile.gameBoard gameBoardEntity_remove:self.beamEntity];
	}

	_beamEntity = beamEntity;

	if (self.beamEntity)
	{
		[self.gameBoardTile.gameBoard gameBoardEntity_add:self.beamEntity];
	}
}

-(void)beamEntity_update
{
	[self setBeamEntity:[[SMBBeamEntity alloc] init_with_gameBoardTile:self.gameBoardTile]];
}

@end
