//
//  SMBBeamBlockerTileEntity.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/10/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardTile__directions.h"

#import <Foundation/Foundation.h>





@protocol SMBBeamBlockerTileEntity <NSObject>

-(BOOL)beamEnterDirection_isBlocked:(SMBGameBoardTile__direction)beamEnterDirection;

@end
