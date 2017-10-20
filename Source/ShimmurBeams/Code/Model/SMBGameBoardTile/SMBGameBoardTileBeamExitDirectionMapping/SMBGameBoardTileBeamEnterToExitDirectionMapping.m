//
//  SMBGameBoardTileBeamEnterToExitDirectionMapping.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 10/19/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardTileBeamEnterToExitDirectionMapping.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/RUClassOrNilUtil.h>





@interface SMBGameBoardTileBeamEnterToExitDirectionMapping ()

#pragma mark - beamEnterToExitDirectionMappingDictionary
@property (nonatomic, strong, nullable) NSDictionary<NSNumber*,NSNumber*>* beamEnterToExitDirectionMappingDictionary;
-(nonnull NSDictionary<NSNumber*,NSNumber*>*)beamEnterToExitDirectionMappingDictionary_generate_from_source:(nullable NSDictionary<NSNumber*,NSNumber*>*)beamEnterToExitDirectionMappingDictionary;

@end





@implementation SMBGameBoardTileBeamEnterToExitDirectionMapping

#pragma mark - NSObject
-(instancetype)init
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);
	
#if __has_feature(nullability)
#pragma clang diagnostic push
#pragma GCC diagnostic ignored "-Wnullability-completeness"
#endif
	return [self init_with_beamEnterToExitDirectionMappingDictionary:nil];
#if __has_feature(nullability)
#pragma clang diagnostic pop
#endif
}

#pragma mark - init
-(nullable instancetype)init_with_beamEnterToExitDirectionMappingDictionary:(nullable NSDictionary<NSNumber*,NSNumber*>*)beamEnterToExitDirectionMappingDictionary
{
	if (self = [super init])
	{
		_beamEnterToExitDirectionMappingDictionary = [self beamEnterToExitDirectionMappingDictionary_generate_from_source:beamEnterToExitDirectionMappingDictionary];
	}
	
	return self;
}

#pragma mark - beamExitDirection
-(SMBGameBoardTile__direction)beamExitDirection_for_beamEnterDirection:(SMBGameBoardTile__direction)beamEnterDirection
{
	kRUConditionalReturn_ReturnValue(SMBGameBoardTile__direction__isInRange(beamEnterDirection) == false, YES, SMBGameBoardTile__direction_unknown);

	NSDictionary<NSNumber*,NSNumber*>* const beamEnterToExitDirectionMappingDictionary = self.beamEnterToExitDirectionMappingDictionary;
	NSNumber* const beamExitDirection_number = [beamEnterToExitDirectionMappingDictionary objectForKey:@(beamEnterDirection)];
	kRUConditionalReturn_ReturnValue(beamExitDirection_number == nil, YES, SMBGameBoardTile__direction_unknown);

	SMBGameBoardTile__direction const beamExitDirection = beamExitDirection_number.integerValue;
	kRUConditionalReturn_ReturnValue(SMBGameBoardTile__direction__isInRange_or_none(beamExitDirection) == false, YES, SMBGameBoardTile__direction_unknown);

	return beamExitDirection;
}

#pragma mark - isEqual
-(BOOL)isEqual_to_beamEnterToExitDirectionMapping:(nullable SMBGameBoardTileBeamEnterToExitDirectionMapping*)beamEnterToExitDirectionMapping
{
	kRUConditionalReturn_ReturnValueFalse(beamEnterToExitDirectionMapping == nil, YES);
	kRUConditionalReturn_ReturnValueTrue(self == beamEnterToExitDirectionMapping, NO);
	
	kRUConditionalReturn_ReturnValueFalse(__RUClassOrNilUtilFunction(beamEnterToExitDirectionMapping, [self class]) == nil, YES);
	
	kRUConditionalReturn_ReturnValueFalse((self.beamEnterToExitDirectionMappingDictionary != beamEnterToExitDirectionMapping.beamEnterToExitDirectionMappingDictionary)
										  &&
										  ([self.beamEnterToExitDirectionMappingDictionary isEqual:beamEnterToExitDirectionMapping.beamEnterToExitDirectionMappingDictionary] == false), NO);
	
	return YES;
}

#pragma mark - beamEnterToExitDirectionMappingDictionary
-(nonnull NSDictionary<NSNumber*,NSNumber*>*)beamEnterToExitDirectionMappingDictionary_generate_from_source:(nullable NSDictionary<NSNumber*,NSNumber*>*)beamEnterToExitDirectionMappingDictionary
{
	NSMutableDictionary<NSNumber*,NSNumber*>* const beamEnterToExitDirectionMappingDictionary_final = [NSMutableDictionary<NSNumber*,NSNumber*> dictionary];

	for (SMBGameBoardTile__direction direction = SMBGameBoardTile__direction__first;
		 direction <= SMBGameBoardTile__direction__last;
		 direction = direction << 1)
	{
		NSNumber* const direction_number = @(direction);
		NSNumber* const exitDirection_number = [beamEnterToExitDirectionMappingDictionary objectForKey:direction_number];
		[beamEnterToExitDirectionMappingDictionary_final setObject:
		 (exitDirection_number
		  ?:
		  @(SMBGameBoardTile__direction__opposite(direction))
		  )
													 forKey:direction_number];
	}

	return [NSDictionary<NSNumber*,NSNumber*> dictionaryWithDictionary:beamEnterToExitDirectionMappingDictionary_final];
}

@end
