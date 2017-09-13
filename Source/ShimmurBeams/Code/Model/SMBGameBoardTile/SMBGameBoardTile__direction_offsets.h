//
//  SMBGameBoardTile__direction_offsets.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/10/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#ifndef SMBGameBoardTile__direction_offsets_h
#define SMBGameBoardTile__direction_offsets_h

#import <Foundation/Foundation.h>





#define kSMBGameBoardTile__direction_offset__name(suffix) SMBGameBoardTile__direction_offset##suffix

typedef struct kSMBGameBoardTile__direction_offset__name() {
	NSUInteger horizontal, vertical;
} kSMBGameBoardTile__direction_offset__name();

static kSMBGameBoardTile__direction_offset__name() const kSMBGameBoardTile__direction_offset__name(_zero) = (kSMBGameBoardTile__direction_offset__name()){};





#endif /* SMBGameBoardTile__direction_offsets_h */
