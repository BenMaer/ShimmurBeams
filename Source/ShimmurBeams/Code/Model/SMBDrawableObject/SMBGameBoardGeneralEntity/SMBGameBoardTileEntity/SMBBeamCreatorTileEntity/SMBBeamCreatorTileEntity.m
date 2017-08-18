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
#import "CoreGraphics+SMBRotation.h"
#import "SMBGameBoardTile__directions_to_CoreGraphics_SMBRotation__orientations_utilities.h"

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/UIView+RUUtility.h>





static void* kSMBBeamCreatorTileEntity__KVOContext = &kSMBBeamCreatorTileEntity__KVOContext;





@interface SMBBeamCreatorTileEntity ()

#pragma mark - gameBoardTile
-(BOOL)SMBBeamCreatorTileEntity_gameBoardTile_requiresKVO;
-(void)SMBBeamCreatorTileEntity_gameBoardTile_setKVORegistered:(BOOL)registered;

#pragma mark - beamEntity
@property (nonatomic, strong, nullable) SMBBeamEntity* beamEntity;
-(void)beamEntity_update;
-(nullable SMBBeamEntity*)beamEntity_create;

@end





@implementation SMBBeamCreatorTileEntity

#pragma mark - NSObject
-(void)dealloc
{
	[self SMBBeamCreatorTileEntity_gameBoardTile_setKVORegistered:NO];
}

#pragma mark - draw
-(void)draw_in_rect:(CGRect)rect
{
	[super draw_in_rect:rect];

	CGContextRef const context = UIGraphicsGetCurrentContext();

	CoreGraphics_SMBRotation__rotateCTM(context, rect, CoreGraphics_SMBRotation__orientation_for_direction(self.beamDirection));

	CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
	CGContextSetLineWidth(context, 1.0f);

	CGFloat const box_inset_from_side = CGRectGetWidth(rect) / 4.0f;

	CGFloat const triangle_inset_from_exit = 2;
	CGFloat const triangle_width_from_exit = 3;
	CGFloat const triangle_height_from_exit = 4;

	CGContextMoveToPoint(context, 0.0f, CGRectGetMaxY(rect)); /* Bottom left */
	CGContextAddLineToPoint(context, box_inset_from_side, CGRectGetMaxY(rect)); /* Bottom left of machine */
	CGContextAddLineToPoint(context, box_inset_from_side, CGRectGetMidY(rect)); /* Top left of machine */

	CGContextAddLineToPoint(context, CGRectGetMidX(rect) - triangle_inset_from_exit - triangle_width_from_exit, CGRectGetMidY(rect)); /* Left barrel triangle, bottom left. */
	CGContextAddLineToPoint(context, CGRectGetMidX(rect) - triangle_inset_from_exit, CGRectGetMidY(rect) - triangle_height_from_exit); /* Left barrel triangle, top right. */
	CGContextAddLineToPoint(context, CGRectGetMidX(rect) - triangle_inset_from_exit, CGRectGetMidY(rect)); /* Left barrel triangle, bottom right. */

	CGContextAddLineToPoint(context, CGRectGetMidX(rect) + triangle_inset_from_exit, CGRectGetMidY(rect)); /* Right barrel triangle, bottom left. */
	CGContextAddLineToPoint(context, CGRectGetMidX(rect) + triangle_inset_from_exit, CGRectGetMidY(rect) - triangle_height_from_exit); /* Right barrel triangle, top right. */
	CGContextAddLineToPoint(context, CGRectGetMidX(rect) + triangle_inset_from_exit + triangle_width_from_exit, CGRectGetMidY(rect)); /* Right barrel triangle, bottom right. */

	CGContextAddLineToPoint(context, CGRectGetMaxX(rect) - box_inset_from_side, CGRectGetMidY(rect)); /* Top right of machine */
	CGContextAddLineToPoint(context, CGRectGetMaxX(rect) - box_inset_from_side, CGRectGetMaxY(rect)); /* Bottom right of machine */
	CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect)); /* Bottom right */

	CGContextStrokePath(context);

	/**
	 Power indicator
	 */
	if (self.requiresExternalPowerForBeam)
	{
		CGFloat const powerIndicator_width = ((CGRectGetWidth(rect) / 2.0f) - box_inset_from_side) / 2.0f;

		UIColor* const color =
		(self.beamEntity
		 ?
		 [UIColor greenColor]
		 :
		 [UIColor redColor]
		);
		CGContextSetFillColorWithColor(context, color.CGColor);
		
		CGRect const powerIndicator_frame = (CGRect){
			.origin.x		= CGRectGetMinX(rect) + CGRectGetHorizontallyAlignedXCoordForWidthOnWidth(powerIndicator_width, CGRectGetWidth(rect)),
			.origin.y		= CGRectGetMaxY(rect) - powerIndicator_width,
			.size.width		= powerIndicator_width,
			.size.height	= powerIndicator_width,
		};
		
		CGContextFillRect(context, powerIndicator_frame);
	}
}

#pragma mark - SMBGameBoardTileEntity: gameBoardTile
-(void)setGameBoardTile:(nullable SMBGameBoardTile*)gameBoardTile
{
	SMBGameBoardTile* const gameBoardTile_old = self.gameBoardTile;

	[self SMBBeamCreatorTileEntity_gameBoardTile_setKVORegistered:NO];

	[super setGameBoardTile:gameBoardTile];

	[self SMBBeamCreatorTileEntity_gameBoardTile_setKVORegistered:YES];

	kRUConditionalReturn(gameBoardTile_old == self.gameBoardTile, NO);

	[self beamEntity_update];
}

#pragma mark - gameBoardTile
-(BOOL)SMBBeamCreatorTileEntity_gameBoardTile_requiresKVO
{
	return self.requiresExternalPowerForBeam;
}

-(void)SMBBeamCreatorTileEntity_gameBoardTile_setKVORegistered:(BOOL)registered
{
	kRUConditionalReturn([self SMBBeamCreatorTileEntity_gameBoardTile_requiresKVO] == false, NO);

	typeof(self.gameBoardTile) const gameBoardTile = self.gameBoardTile;
	kRUConditionalReturn(gameBoardTile == nil, NO);
	
	NSMutableArray<NSString*>* const propertiesToObserve = [NSMutableArray<NSString*> array];
	[propertiesToObserve addObject:[SMBGameBoardTile_PropertiesForKVO isPowered]];
	
	[propertiesToObserve enumerateObjectsUsingBlock:^(NSString * _Nonnull propertyToObserve, NSUInteger idx, BOOL * _Nonnull stop) {
		if (registered)
		{
			[gameBoardTile addObserver:self
							forKeyPath:propertyToObserve
							   options:(0)
							   context:&kSMBBeamCreatorTileEntity__KVOContext];
		}
		else
		{
			[gameBoardTile removeObserver:self
							   forKeyPath:propertyToObserve
								  context:&kSMBBeamCreatorTileEntity__KVOContext];
		}
	}];
}

#pragma mark - KVO
-(void)observeValueForKeyPath:(nullable NSString*)keyPath ofObject:(nullable id)object change:(nullable NSDictionary*)change context:(nullable void*)context
{
	if (context == kSMBBeamCreatorTileEntity__KVOContext)
	{
		if (object == self.gameBoardTile)
		{
			if ([keyPath isEqualToString:[SMBGameBoardTile_PropertiesForKVO isPowered]])
			{
				NSAssert([self SMBBeamCreatorTileEntity_gameBoardTile_requiresKVO], @"should require KVO is changing");
				[self beamEntity_update];
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

	[self setNeedsRedraw:YES];
}

-(void)beamEntity_update
{
	[self setBeamEntity:[self beamEntity_create]];
}

-(nullable SMBBeamEntity*)beamEntity_create
{
	SMBGameBoardTile* const gameBoardTile = self.gameBoardTile;
	kRUConditionalReturn_ReturnValueNil(gameBoardTile == nil, NO);

	kRUConditionalReturn_ReturnValueNil((self.requiresExternalPowerForBeam == YES)
										&&
										(gameBoardTile.isPowered == false), NO);

	return [[SMBBeamEntity alloc] init_with_gameBoardTile:gameBoardTile];
}

#pragma mark - beamDirection
-(void)setBeamDirection:(SMBGameBoardTile__direction)beamDirection
{
	kRUConditionalReturn(self.beamDirection == beamDirection, NO);

	_beamDirection = beamDirection;

	[self beamEntity_update];
}

#pragma mark - requiresExternalPowerForBeam
-(void)setRequiresExternalPowerForBeam:(BOOL)requiresExternalPowerForBeam
{
	kRUConditionalReturn(self.requiresExternalPowerForBeam == requiresExternalPowerForBeam, NO);

	[self SMBBeamCreatorTileEntity_gameBoardTile_setKVORegistered:NO];

	_requiresExternalPowerForBeam = requiresExternalPowerForBeam;

	[self SMBBeamCreatorTileEntity_gameBoardTile_setKVORegistered:YES];

	[self beamEntity_update];
}

#pragma mark - SMBBeamBlockerTileEntity
-(BOOL)beamEnterDirection_isBlocked:(SMBGameBoardTile__direction)beamEnterDirection
{
	return YES;
}

@end
