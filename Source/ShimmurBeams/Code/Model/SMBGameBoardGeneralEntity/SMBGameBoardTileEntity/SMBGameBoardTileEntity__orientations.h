//
//  SMBGameBoardTileEntity__orientations.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/4/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#ifndef SMBGameBoardTileEntity__orientations_h
#define SMBGameBoardTileEntity__orientations_h

#import <Foundation/Foundation.h>





typedef NS_ENUM(NSInteger, SMBGameBoardTileEntity__orientation) {
	SMBGameBoardTileEntity__orientation_up,
	SMBGameBoardTileEntity__orientation_right,
	SMBGameBoardTileEntity__orientation_down,
	SMBGameBoardTileEntity__orientation_left,

	SMBGameBoardTileEntity__orientation_unknown,

	SMBGameBoardTileEntity__orientation__first	= SMBGameBoardTileEntity__orientation_up,
	SMBGameBoardTileEntity__orientation__last	= SMBGameBoardTileEntity__orientation_left,
};





#endif /* SMBGameBoardTileEntity__orientations_h */
