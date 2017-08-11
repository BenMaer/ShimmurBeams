//
//  SMBGameBoardTileEntity+SMBBeamBlocker.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/10/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardTileEntity.h"
#import "SMBBeamBlockerTileEntity.h"





@interface SMBGameBoardTileEntity (SMBBeamBlocker)

#pragma mark - beamBlocker
-(BOOL)smb_beamBlocker;
-(nullable SMBGameBoardTileEntity<SMBBeamBlockerTileEntity>*)smb_beamBlocker_selfOrNull;

@end
