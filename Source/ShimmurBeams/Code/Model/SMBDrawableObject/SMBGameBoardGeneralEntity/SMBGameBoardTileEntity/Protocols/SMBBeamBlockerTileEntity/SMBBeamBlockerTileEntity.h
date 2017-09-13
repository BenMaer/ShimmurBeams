//
//  SMBBeamBlockerTileEntity.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/10/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardTile__directions.h"

#import <Foundation/Foundation.h>





/**
 Right now, beam blocking is only considered when set as the `gameBoardTileEntity_for_beamInteractions` property on `SMBGameBoardTile`.
 */
@protocol SMBBeamBlockerTileEntity <NSObject>

@property (nonatomic, assign) SMBGameBoardTile__direction beamEnterDirections_blocked;

@end
