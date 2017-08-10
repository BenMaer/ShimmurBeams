//
//  SMBGameBoardTileEntity+SMBProvidesPower.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/10/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardTileEntity+SMBProvidesPower.h"
#import "SMBGameBoardTileEntity_PowerProvider.h"

#import <ResplendentUtilities/RUProtocolOrNil.h>





@implementation SMBGameBoardTileEntity (SMBProvidesPower)

#pragma mark - providesPower
-(BOOL)smb_providesPower
{
	return (kRUProtocolOrNil(self, SMBGameBoardTileEntity_PowerProvider) != nil);
}

@end
