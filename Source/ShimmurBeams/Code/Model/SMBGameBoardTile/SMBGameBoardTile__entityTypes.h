//
//  SMBGameBoardTile__entityTypes.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/15/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#ifndef SMBGameBoardTile__entityTypes_h
#define SMBGameBoardTile__entityTypes_h

#import <ResplendentUtilities/RUEnumIsInRangeSynthesization.h>

#import <Foundation/Foundation.h>





typedef NS_ENUM(NSInteger, SMBGameBoardTile__entityType) {
	SMBGameBoardTile__entityType_none,

	SMBGameBoardTile__entityType_many,
	SMBGameBoardTile__entityType_beamInteractions,
	
	SMBGameBoardTile__entityType__first		= SMBGameBoardTile__entityType_many,
	SMBGameBoardTile__entityType__last		= SMBGameBoardTile__entityType_beamInteractions,
};

static inline RUEnumIsInRangeSynthesization_autoFirstLast(SMBGameBoardTile__entityType);

#endif /* SMBGameBoardTile__entityTypes_h */
