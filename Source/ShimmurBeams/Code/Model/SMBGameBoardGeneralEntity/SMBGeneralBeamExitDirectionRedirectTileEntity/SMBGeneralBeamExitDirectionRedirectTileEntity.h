//
//  SMBGeneralBeamExitDirectionRedirectTileEntity.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/8/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardTileEntity.h"
#import "SMBGameBoardTile__directions.h"





@interface SMBGeneralBeamExitDirectionRedirectTileEntity : SMBGameBoardTileEntity

#pragma mark - beamExitDirection
-(SMBGameBoardTile__direction)beamExitDirection_for_beamEnterDirection:(SMBGameBoardTile__direction)beamEnterDirection;

@end
