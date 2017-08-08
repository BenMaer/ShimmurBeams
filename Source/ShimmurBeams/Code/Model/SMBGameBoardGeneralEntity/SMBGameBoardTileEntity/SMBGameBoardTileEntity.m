//
//  SMBGameBoardTileEntity.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/4/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardTileEntity.h"
#import "SMBGameBoardTile.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@interface SMBGameBoardTileEntity ()

#pragma mark - draw
-(CGFloat)draw_angle_radians;
-(CGFloat)draw_angle_degrees;

@end





@implementation SMBGameBoardTileEntity

#pragma mark - gameBoardTile
-(void)setGameBoardTile:(nullable SMBGameBoardTile*)gameBoardTile
{
	kRUConditionalReturn(self.gameBoardTile == gameBoardTile, NO);

	_gameBoardTile = gameBoardTile;

	if ((self.gameBoardTile != nil)
		&&
		(self.gameBoardTile.gameBoardTileEntity != self))
	{
		[self.gameBoardTile setGameBoardTileEntity:self];
	}
}

#pragma mark - SMBGameBoardGeneralEntity: draw
-(void)draw_in_gameBoardView:(nonnull SMBGameBoardView*)gameBoardView
						rect:(CGRect)rect
{
	[super draw_in_gameBoardView:gameBoardView
							rect:rect];

	CGContextRef const context = UIGraphicsGetCurrentContext();

	CGContextTranslateCTM(context, CGRectGetMidX(rect), CGRectGetMidY(rect));
	CGContextRotateCTM(context, [self draw_angle_radians]);
	CGContextTranslateCTM(context, -CGRectGetWidth(rect) / 2.0f, -CGRectGetHeight(rect) / 2.0f);
}

-(CGFloat)draw_angle_radians
{
	return ([self draw_angle_degrees] / 180.0f) * M_PI;
}

-(CGFloat)draw_angle_degrees
{
	SMBGameBoardTileEntity__orientation const orientation = self.orientation;
	switch (orientation)
	{
		case SMBGameBoardTileEntity__orientation_up:
			return 0.0f;
			break;
		
		case SMBGameBoardTileEntity__orientation_right:
			return 90.0f;
			break;

		case SMBGameBoardTileEntity__orientation_down:
			return 180.0f;
			break;

		case SMBGameBoardTileEntity__orientation_left:
			return -90.0f;
			break;

		case SMBGameBoardTileEntity__orientation_unknown:
			break;
	}

	NSAssert(false, @"unhandled orientation %li",(long)orientation);
	return 0.0f;
}

#pragma mark - entityAction
-(void)entityAction_setup{}

@end





@implementation SMBGameBoardTileEntity_PropertiesForKVO

+(nonnull NSString*)gameBoardEntity{return NSStringFromSelector(_cmd);}
+(nonnull NSString*)needsRedraw{return NSStringFromSelector(_cmd);}

@end
