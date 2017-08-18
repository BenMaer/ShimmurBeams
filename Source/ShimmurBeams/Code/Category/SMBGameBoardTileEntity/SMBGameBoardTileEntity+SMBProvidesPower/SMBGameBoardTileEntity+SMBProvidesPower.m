//
//  SMBGameBoardTileEntity+SMBProvidesPower.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/10/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardTileEntity+SMBProvidesPower.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@implementation SMBGameBoardTileEntity (SMBProvidesPower)

#pragma mark - providesPower
-(BOOL)smb_providesPower
{
	SMBGameBoardTileEntity<SMBGameBoardTileEntity_PowerProvider>* const smb_providesPower_selfOrNull = self.smb_providesPower_selfOrNull;
	kRUConditionalReturn_ReturnValueFalse(smb_providesPower_selfOrNull == nil, NO);

	return smb_providesPower_selfOrNull.providesPower;
}

-(nullable SMBGameBoardTileEntity<SMBGameBoardTileEntity_PowerProvider>*)smb_providesPower_selfOrNull
{
	kRUConditionalReturn_ReturnValueNil([self conformsToProtocol:@protocol(SMBGameBoardTileEntity_PowerProvider)] == false, NO);

	return (SMBGameBoardTileEntity<SMBGameBoardTileEntity_PowerProvider>*)self;
}

@end
