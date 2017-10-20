//
//  SMBForcedBeamRedirectTileEntity.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/8/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBForcedBeamRedirectTileEntity.h"
#import "CoreGraphics+SMBRotation.h"
#import "SMBGameBoardTile__directions_to_CoreGraphics_SMBRotation__orientations_utilities.h"
#import "CoreGraphics+SMBDrawArrow.h"
#import "SMBGameBoardTileBeamEnterToExitDirectionMapping.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@interface SMBForcedBeamRedirectTileEntity ()

#pragma mark - forcedBeamRedirectArrow_drawing
-(void)forcedBeamRedirectArrow_draw_in_rect:(CGRect)rect;

#pragma mark - beamEnterToExitDirectionMapping
-(void)beamEnterToExitDirectionMapping_update;
-(nullable SMBGameBoardTileBeamEnterToExitDirectionMapping*)beamEnterToExitDirectionMapping_generate;
-(nullable NSDictionary<NSNumber*,NSNumber*>*)beamEnterToExitDirectionMapping_beamEnterToExitDirectionMappingDictionary_generate;

@end





@implementation SMBForcedBeamRedirectTileEntity

#pragma mark - NSObject
-(instancetype)init
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);

	return [self init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_unknown];
}

#pragma mark - init
-(nullable instancetype)init_with_forcedBeamExitDirection:(SMBGameBoardTile__direction)forcedBeamExitDirection
{
	kRUConditionalReturn_ReturnValueNil(SMBGameBoardTile__direction__isInRange_or_none(forcedBeamExitDirection) == false, YES);

	if (self = [super init])
	{
		_forcedBeamExitDirection = forcedBeamExitDirection;
		[self beamEnterToExitDirectionMapping_update];
	}

	return self;
}

#pragma mark - SMBGameBoardGeneralEntity: draw
-(void)draw_in_rect:(CGRect)rect
{
	[super draw_in_rect:rect];

	if (self.forcedBeamRedirectArrow_drawing_disable == false)
	{
		[self forcedBeamRedirectArrow_draw_in_rect:rect];
	}
}

#pragma mark - forcedBeamRedirectArrow_drawing
-(void)setForcedBeamRedirectArrow_drawing_disable:(BOOL)forcedBeamRedirectArrow_drawing_disable
{
	kRUConditionalReturn(self.forcedBeamRedirectArrow_drawing_disable == forcedBeamRedirectArrow_drawing_disable, NO);

	_forcedBeamRedirectArrow_drawing_disable = forcedBeamRedirectArrow_drawing_disable;

	[self setNeedsRedraw];
}

-(void)forcedBeamRedirectArrow_draw_in_rect:(CGRect)rect
{
	CGContextRef const context = UIGraphicsGetCurrentContext();

	CoreGraphics_SMBRotation__rotateCTM(context, rect, CoreGraphics_SMBRotation__orientation_for_direction(self.forcedBeamExitDirection));

	CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
	CGContextSetLineWidth(context, 1.0f);

	CGFloat const arrow_inset_from_side = CGRectGetWidth(rect) / 4.0f;

	CGRect const rect_inset = UIEdgeInsetsInsetRect(rect, RU_UIEdgeInsetsMakeAll(arrow_inset_from_side));

	CoreGraphics_SMBDrawArrow(context, rect_inset);
}

#pragma mark - SMBGeneralBeamExitDirectionRedirectTileEntity
@synthesize beamEnterToExitDirectionMapping = _beamEnterToExitDirectionMapping;

#pragma mark - beamEnterToExitDirectionMapping
-(void)beamEnterToExitDirectionMapping_update
{
	[self setBeamEnterToExitDirectionMapping:[self beamEnterToExitDirectionMapping_generate]];
}

-(nullable SMBGameBoardTileBeamEnterToExitDirectionMapping*)beamEnterToExitDirectionMapping_generate
{
	return
	[[SMBGameBoardTileBeamEnterToExitDirectionMapping alloc] init_with_beamEnterToExitDirectionMappingDictionary:[self beamEnterToExitDirectionMapping_beamEnterToExitDirectionMappingDictionary_generate]];
}

-(nullable NSDictionary<NSNumber*,NSNumber*>*)beamEnterToExitDirectionMapping_beamEnterToExitDirectionMappingDictionary_generate
{
	NSMutableDictionary<NSNumber*,NSNumber*>* const beamEnterToExitDirectionMappingDictionary = [NSMutableDictionary<NSNumber*,NSNumber*> dictionary];
	SMBGameBoardTile__direction const forcedBeamExitDirection = self.forcedBeamExitDirection;

	SMBGameBoardTile__directions_enumerate(^(SMBGameBoardTile__direction direction) {
		[beamEnterToExitDirectionMappingDictionary setObject:@(forcedBeamExitDirection)
											   forKey:@(direction)];
	});

	return [NSDictionary<NSNumber*,NSNumber*> dictionaryWithDictionary:beamEnterToExitDirectionMappingDictionary];
}

@end
