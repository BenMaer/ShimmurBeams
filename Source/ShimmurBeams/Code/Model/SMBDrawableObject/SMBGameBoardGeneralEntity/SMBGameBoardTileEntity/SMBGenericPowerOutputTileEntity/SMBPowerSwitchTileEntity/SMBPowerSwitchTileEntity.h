//
//  SMBPowerSwitchTileEntity.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 9/1/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGenericPowerOutputTileEntity.h"
#import "SMBPowerSwitchTileEntity__switchStates.h"





@interface SMBPowerSwitchTileEntity : SMBGenericPowerOutputTileEntity

#pragma mark - switchState
@property (nonatomic, assign) SMBPowerSwitchTileEntity__switchState switchState;

@end
