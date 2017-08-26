//
//  SMBGameBoardTileEntity+SMBProvidesPower.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/10/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardTileEntity.h"
#import "SMBGameBoardTileEntity_PowerProvider.h"





@interface SMBGameBoardTileEntity (SMBProvidesPower)

#pragma mark - providesPower
-(BOOL)smb_powerProvider_providesPower;
-(nullable SMBGameBoardTileEntity<SMBGameBoardTileEntity_PowerProvider>*)smb_powerProvider_selfOrNull;

@end
