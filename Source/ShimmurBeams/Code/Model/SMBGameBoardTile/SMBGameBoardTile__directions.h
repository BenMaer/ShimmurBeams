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
	SMBGameBoardTile__direction_unknown,

	SMBGameBoardTile__direction_up,
	SMBGameBoardTile__direction_right,
	SMBGameBoardTile__direction_down,
	SMBGameBoardTile__direction_left,
	
	SMBGameBoardTile__direction__first	= SMBGameBoardTile__direction_up,
	SMBGameBoardTile__direction__last	= SMBGameBoardTile__direction_left,
};

static inline RUEnumIsInRangeSynthesization_autoFirstLast(SMBGameBoardTile__direction)

#endif /* SMBGameBoardTile__directions_h */
