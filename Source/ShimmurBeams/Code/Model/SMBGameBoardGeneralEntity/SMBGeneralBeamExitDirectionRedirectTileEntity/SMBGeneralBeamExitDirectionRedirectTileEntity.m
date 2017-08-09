//
//  SMBGeneralBeamExitDirectionRedirectTileEntity.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/8/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGeneralBeamExitDirectionRedirectTileEntity.h"





@implementation SMBGeneralBeamExitDirectionRedirectTileEntity

#pragma mark - beamExitDirection
-(SMBGameBoardTile__direction)beamExitDirection_for_beamEnterDirection:(SMBGameBoardTile__direction)beamEnterDirection
{
	NSAssert(false, @"Must overload this method!");

	return beamEnterDirection;
}

@end
