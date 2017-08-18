//
//  SMBGameBoardTile__directions.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/8/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#ifndef SMBGameBoardTile__directions_h
#define SMBGameBoardTile__directions_h

#import <ResplendentUtilities/RUEnumIsInRangeSynthesization.h>

#import <Foundation/Foundation.h>





typedef NS_ENUM(NSInteger, SMBGameBoardTile__direction) {
	SMBGameBoardTile__direction_unknown = 1 << 0,
	SMBGameBoardTile__direction_none	= 1 << 1,

	SMBGameBoardTile__direction_up		= 1 << 2,
	SMBGameBoardTile__direction_right	= 1 << 3,
	SMBGameBoardTile__direction_down	= 1 << 4,
	SMBGameBoardTile__direction_left	= 1 << 5,


	SMBGameBoardTile__direction__first	= SMBGameBoardTile__direction_up,
	SMBGameBoardTile__direction__last	= SMBGameBoardTile__direction_left,
};

static inline RUEnumIsInRangeSynthesization_autoFirstLast(SMBGameBoardTile__direction)
static inline BOOL SMBGameBoardTile__direction__isInRange_or_none(SMBGameBoardTile__direction direction){
	return
	(direction == SMBGameBoardTile__direction_none
	 ||
	 SMBGameBoardTile__direction__isInRange(direction)
	);
}

static inline SMBGameBoardTile__direction SMBGameBoardTile__direction__opposite(SMBGameBoardTile__direction direction){
	switch (direction)
	{
		case SMBGameBoardTile__direction_unknown:
			break;
			
		case SMBGameBoardTile__direction_up:
			return SMBGameBoardTile__direction_down;
			break;
			
		case SMBGameBoardTile__direction_right:
			return SMBGameBoardTile__direction_left;
			break;
			
		case SMBGameBoardTile__direction_down:
			return SMBGameBoardTile__direction_up;
			break;
			
		case SMBGameBoardTile__direction_left:
			return SMBGameBoardTile__direction_right;
			break;
			
		case SMBGameBoardTile__direction_none:
			break;
	}

	NSCAssert(false, @"unhandled direction %li",(long)direction);
	return SMBGameBoardTile__direction_unknown;
}

#endif /* SMBGameBoardTile__directions_h */
