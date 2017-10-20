//
//  SMBGameBoardTile__directions.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/8/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#ifndef SMBGameBoardTile__directions_h
#define SMBGameBoardTile__directions_h

#import <Foundation/Foundation.h>

#import <ResplendentUtilities/RUConditionalReturn.h>





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

static inline void SMBGameBoardTile__directions_enumerate(void (^ _Nonnull enumerationBlock)(SMBGameBoardTile__direction direction)){
	kRUConditionalReturn(enumerationBlock == nil, YES);

	for (SMBGameBoardTile__direction direction = SMBGameBoardTile__direction__first;
		 direction <= SMBGameBoardTile__direction__last;
		 direction = direction << 1)
	{
		enumerationBlock(direction);
	}
}

static inline SMBGameBoardTile__direction SMBGameBoardTile__directions_all(){
	static SMBGameBoardTile__direction directions_all = 0;

	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		SMBGameBoardTile__directions_enumerate(^(SMBGameBoardTile__direction direction) {
			directions_all = (directions_all | direction);
		});
	});
	
	return directions_all;
}

static inline BOOL SMBGameBoardTile__direction__isInRange(SMBGameBoardTile__direction direction){
	return
	((direction >= SMBGameBoardTile__direction__first)
	 &&
	 (direction <= SMBGameBoardTile__directions_all())
	);
}

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

static inline SMBGameBoardTile__direction SMBGameBoardTile__directions__opposite(SMBGameBoardTile__direction directions){
	__block SMBGameBoardTile__direction directions_opposite = 0;

	/**
	 Since all directions on `directions_opposite` have been set to false, we only need to check if we need to set any to true.
	 */
	SMBGameBoardTile__directions_enumerate(^(SMBGameBoardTile__direction direction) {
		if ((directions & direction) == false)
		{
			directions_opposite = (directions_opposite | direction);
		}
	});

	return directions_opposite;
}

#endif /* SMBGameBoardTile__directions_h */
