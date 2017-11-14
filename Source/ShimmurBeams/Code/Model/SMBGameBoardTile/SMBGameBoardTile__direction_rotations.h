//
//  SMBGameBoardTile__direction_rotations.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/8/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#ifndef SMBGameBoardTile__direction_rotations_h
#define SMBGameBoardTile__direction_rotations_h

#import "SMBGameBoardTile__directions.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/RUEnumIsInRangeSynthesization.h>

#import <Foundation/Foundation.h>





typedef NS_ENUM(NSInteger, SMBGameBoardTile__direction_rotation) {
	SMBGameBoardTile__direction_rotation_none,
	SMBGameBoardTile__direction_rotation_left,
	SMBGameBoardTile__direction_rotation_right,

	SMBGameBoardTile__direction_rotation_unknown,

	SMBGameBoardTile__direction_rotation__first	= SMBGameBoardTile__direction_rotation_left,
	SMBGameBoardTile__direction_rotation__last	= SMBGameBoardTile__direction_rotation_right,
};

static inline RUEnumIsInRangeSynthesization_autoFirstLast(SMBGameBoardTile__direction_rotation);

static inline void SMBGameBoardTile__direction_rotations_enumerate(void (^ _Nonnull enumerationBlock)(SMBGameBoardTile__direction_rotation direction_rotation)){
	kRUConditionalReturn(enumerationBlock == nil, YES);
	
	for (SMBGameBoardTile__direction_rotation direction_rotation = SMBGameBoardTile__direction_rotation__first;
		 direction_rotation <= SMBGameBoardTile__direction_rotation__last;
		 direction_rotation = direction_rotation << 1)
	{
		enumerationBlock(direction_rotation);
	}
}

static inline SMBGameBoardTile__direction SMBGameBoardTile__direction_rotation_direction_rotated_right(SMBGameBoardTile__direction direction){
	switch (direction)
	{
		case SMBGameBoardTile__direction_unknown:
		case SMBGameBoardTile__direction_none:
			break;
			
		case SMBGameBoardTile__direction_up:
			return SMBGameBoardTile__direction_right;
			break;
			
		case SMBGameBoardTile__direction_right:
			return SMBGameBoardTile__direction_down;
			break;
			
		case SMBGameBoardTile__direction_down:
			return SMBGameBoardTile__direction_left;
			break;
			
		case SMBGameBoardTile__direction_left:
			return SMBGameBoardTile__direction_up;
			break;
	}
	
	NSCAssert(false, @"unhandled direction %li",(long)direction);
	return SMBGameBoardTile__direction_unknown;
}

static inline SMBGameBoardTile__direction SMBGameBoardTile__direction_rotation_direction_rotated_left(SMBGameBoardTile__direction direction){
	switch (direction)
	{
		case SMBGameBoardTile__direction_unknown:
		case SMBGameBoardTile__direction_none:
			break;
			
		case SMBGameBoardTile__direction_up:
			return SMBGameBoardTile__direction_left;
			break;
			
		case SMBGameBoardTile__direction_right:
			return SMBGameBoardTile__direction_up;
			break;
			
		case SMBGameBoardTile__direction_down:
			return SMBGameBoardTile__direction_right;
			break;
			
		case SMBGameBoardTile__direction_left:
			return SMBGameBoardTile__direction_down;
			break;
	}
	
	NSCAssert(false, @"unhandled direction %li",(long)direction);
	return SMBGameBoardTile__direction_unknown;
}

static inline SMBGameBoardTile__direction SMBGameBoardTile__direction_rotation_direction_rotated(SMBGameBoardTile__direction direction, SMBGameBoardTile__direction_rotation direction_rotation){
	
	switch (direction_rotation)
	{
		case SMBGameBoardTile__direction_rotation_none:
			return direction;
			break;
			
		case SMBGameBoardTile__direction_rotation_left:
			return SMBGameBoardTile__direction_rotation_direction_rotated_left(direction);
			break;
			
		case SMBGameBoardTile__direction_rotation_right:
			return SMBGameBoardTile__direction_rotation_direction_rotated_right(direction);
			break;
			
		case SMBGameBoardTile__direction_rotation_unknown:
			break;
	}
	
	NSCAssert(false, @"unhandled direction %li",(long)direction);
	return SMBGameBoardTile__direction_unknown;
}

#endif /* SMBGameBoardTile__direction_rotations_h */
