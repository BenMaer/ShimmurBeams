//
//  SMBGameBoardTileEntity.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/4/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardTileEntity.h"
#import "SMBGameBoardTile.h"
#import "SMBUniqueStringGenerator.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@interface SMBGameBoardTileEntity ()

#pragma mark - uniqueTileEntityId
@property (nonatomic, strong, nullable) NSString* uniqueTileEntityId;
-(void)uniqueTileEntityId_generate;

#pragma mark - draw
-(CGFloat)draw_angle_radians;
-(CGFloat)draw_angle_degrees;

@end





@implementation SMBGameBoardTileEntity

#pragma mark - NSObject
-(instancetype)init
{
	if (self = [super init])
	{
		[self uniqueTileEntityId_generate];
		kRUConditionalReturn_ReturnValueNil(self.uniqueTileEntityId == nil, YES);
		kRUConditionalReturn_ReturnValueNil(self.uniqueTileEntityId.length == 0, YES);

		[self setNeedsRedraw:YES];
	}

	return self;
}

#pragma mark - uniqueTileEntityId
-(void)uniqueTileEntityId_generate
{
	static SMBUniqueStringGenerator* uniqueStringGenerator = nil;
	if (uniqueStringGenerator == nil)
	{
		uniqueStringGenerator = [SMBUniqueStringGenerator new];
	}

	[self setUniqueTileEntityId:[uniqueStringGenerator uniqueId_next]];
}

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

#pragma mark - draw
-(void)draw_in_rect:(CGRect)rect
{
	kRUConditionalReturn(self.needsRedraw == NO, YES);

	[self setNeedsRedraw:NO];

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

#pragma mark - SMBMappedDataCollection_MappableObject
-(nonnull NSString*)smb_uniqueKey
{
	return self.uniqueTileEntityId;
}

@end





@implementation SMBGameBoardTileEntity_PropertiesForKVO

+(nonnull NSString*)gameBoardEntity{return NSStringFromSelector(_cmd);}
+(nonnull NSString*)needsRedraw{return NSStringFromSelector(_cmd);}

@end
