//
//  SMBGameBoardEntity__orientations.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/4/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#ifndef SMBGameBoardEntity__orientations_h
#define SMBGameBoardEntity__orientations_h

#import <Foundation/Foundation.h>





typedef NS_ENUM(NSInteger, SMBGameBoardEntity__orientation) {
	SMBGameBoardEntity__orientation_up,
	SMBGameBoardEntity__orientation_right,
	SMBGameBoardEntity__orientation_down,
	SMBGameBoardEntity__orientation_left,
	
	SMBGameBoardEntity__orientation__first	= SMBGameBoardEntity__orientation_up,
	SMBGameBoardEntity__orientation__last	= SMBGameBoardEntity__orientation_left,
};





#endif /* SMBGameBoardEntity__orientations_h */
