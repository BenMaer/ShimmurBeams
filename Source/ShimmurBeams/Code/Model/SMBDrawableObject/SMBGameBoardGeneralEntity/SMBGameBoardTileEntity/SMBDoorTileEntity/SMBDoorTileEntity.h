//
//  SMBDoorTileEntity.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/28/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardTileEntity.h"
#import "SMBBeamBlockerTileEntity.h"





@interface SMBDoorTileEntity : SMBGameBoardTileEntity <SMBBeamBlockerTileEntity>

#pragma mark - doorIsOpen
@property (nonatomic, assign) BOOL doorIsOpen;

@end
