//
//  SMBGameBoardTileEntity+SMBBeamBlocker.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/10/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardTileEntity+SMBBeamBlocker.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@implementation SMBGameBoardTileEntity (SMBBeamBlocker)

#pragma mark - beamBlocker
-(BOOL)smb_beamBlocker
{
	return ([self smb_beamBlocker_selfOrNull] != nil);
}

-(nullable SMBGameBoardTileEntity<SMBBeamBlockerTileEntity>*)smb_beamBlocker_selfOrNull
{
	kRUConditionalReturn_ReturnValueNil([self conformsToProtocol:@protocol(SMBBeamBlockerTileEntity)] == false, NO);

	return (SMBGameBoardTileEntity<SMBBeamBlockerTileEntity>*)self;
}

@end
