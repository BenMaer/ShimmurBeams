//
//  SMBGameBoardTile__directions_to_CoreGraphics_SMBRotation__orientations_utilities.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/9/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#ifndef SMBGameBoardTile__directions_to_CoreGraphics_SMBRotation__orientations_utilities_h
#define SMBGameBoardTile__directions_to_CoreGraphics_SMBRotation__orientations_utilities_h

#import "SMBGameBoardTile__directions.h"
#import "CoreGraphics+SMBRotation__orientations.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/NSDictionary+RUReverse.h>





static inline NSDictionary<NSNumber*,NSNumber*>* SMBGameBoardTile__direction_to_CoreGraphics_SMBRotation__orientations_mapping(){
	NSMutableDictionary<NSNumber*,NSNumber*>* const gameBoardTileEntity__orientation_to_direction_mapping = [NSMutableDictionary<NSNumber*,NSNumber*> dictionary];

	[gameBoardTileEntity__orientation_to_direction_mapping setObject:@(CoreGraphics_SMBRotation__orientation_up)	forKey:@(SMBGameBoardTile__direction_up)];
	[gameBoardTileEntity__orientation_to_direction_mapping setObject:@(CoreGraphics_SMBRotation__orientation_right)	forKey:@(SMBGameBoardTile__direction_right)];
	[gameBoardTileEntity__orientation_to_direction_mapping setObject:@(CoreGraphics_SMBRotation__orientation_down)	forKey:@(SMBGameBoardTile__direction_down)];
	[gameBoardTileEntity__orientation_to_direction_mapping setObject:@(CoreGraphics_SMBRotation__orientation_left)	forKey:@(SMBGameBoardTile__direction_left)];

	return [NSDictionary<NSNumber*,NSNumber*> dictionaryWithDictionary:gameBoardTileEntity__orientation_to_direction_mapping];
}

static inline CoreGraphics_SMBRotation__orientation CoreGraphics_SMBRotation__orientation_for_direction(SMBGameBoardTile__direction direction){
	NSDictionary<NSNumber*,NSNumber*>* const direction_to_gameBoardTileEntity__orientation_mapping = SMBGameBoardTile__direction_to_CoreGraphics_SMBRotation__orientations_mapping();
	kRUConditionalReturn_ReturnValue(direction_to_gameBoardTileEntity__orientation_mapping == nil, YES, CoreGraphics_SMBRotation__orientation_unknown);

	NSNumber* const gameBoardTileEntity__orientation_number = [direction_to_gameBoardTileEntity__orientation_mapping objectForKey:@(direction)];
	kRUConditionalReturn_ReturnValue(gameBoardTileEntity__orientation_number == nil, YES, CoreGraphics_SMBRotation__orientation_unknown);

	return gameBoardTileEntity__orientation_number.integerValue;
}

static inline SMBGameBoardTile__direction SMBGameBoardTile__direction_for_gameBoardTileEntity__orientation(CoreGraphics_SMBRotation__orientation gameBoardTileEntity__orientation){
	NSDictionary<NSNumber*,NSNumber*>* const direction_to_gameBoardTileEntity__orientation_mapping = SMBGameBoardTile__direction_to_CoreGraphics_SMBRotation__orientations_mapping();
	kRUConditionalReturn_ReturnValue(direction_to_gameBoardTileEntity__orientation_mapping == nil, YES, SMBGameBoardTile__direction_unknown);

	NSDictionary<NSNumber*,NSNumber*>* const gameBoardTileEntity__orientation_to_direction_mapping = [direction_to_gameBoardTileEntity__orientation_mapping ru_reverseDictionary];
	kRUConditionalReturn_ReturnValue(gameBoardTileEntity__orientation_to_direction_mapping == nil, YES, SMBGameBoardTile__direction_unknown);

	NSNumber* const direction_number = [gameBoardTileEntity__orientation_to_direction_mapping objectForKey:@(gameBoardTileEntity__orientation)];
	kRUConditionalReturn_ReturnValue(direction_number == nil, YES, SMBGameBoardTile__direction_unknown);

	SMBGameBoardTile__direction const direction = direction_number.integerValue;
	kRUConditionalReturn_ReturnValue(SMBGameBoardTile__direction__isInRange(direction) == false, YES, SMBGameBoardTile__direction_unknown);

	return direction;
}

#endif /* SMBGameBoardTile__directions_to_CoreGraphics_SMBRotation__orientations_utilities_h */
