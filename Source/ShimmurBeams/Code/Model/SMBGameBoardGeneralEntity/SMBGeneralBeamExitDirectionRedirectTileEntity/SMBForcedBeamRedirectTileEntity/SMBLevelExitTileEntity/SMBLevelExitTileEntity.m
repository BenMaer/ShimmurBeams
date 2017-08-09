//
//  SMBLevelExitTileEntity.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/9/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBLevelExitTileEntity.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@implementation SMBLevelExitTileEntity

#pragma mark - NSObject
-(instancetype)init
{
	if (self = [super init_with_forcedBeamExitDirection:SMBGameBoardTile__direction_none])
	{
		[self setForcedBeamRedirectArrow_drawing_disable:YES];
	}

	return self;
}

#pragma mark - SMBForcedBeamRedirectTileEntity: init
-(nullable instancetype)init_with_forcedBeamExitDirection:(SMBGameBoardTile__direction)forcedBeamExitDirection
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);

	return [self init];
}

@end
