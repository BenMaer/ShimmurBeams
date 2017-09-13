//
//  SMBPowerSwitchTileEntity__switchStates.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 9/1/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#ifndef SMBPowerSwitchTileEntity__switchStates_h
#define SMBPowerSwitchTileEntity__switchStates_h

#import <Foundation/Foundation.h>

#import <ResplendentUtilities/RUEnumIsInRangeSynthesization.h>





typedef NS_ENUM(NSInteger, SMBPowerSwitchTileEntity__switchState) {
	SMBPowerSwitchTileEntity__switchState_unknown,

	SMBPowerSwitchTileEntity__switchState_off,
	SMBPowerSwitchTileEntity__switchState_on,
	
	SMBPowerSwitchTileEntity__switchState__first	= SMBPowerSwitchTileEntity__switchState_off,
	SMBPowerSwitchTileEntity__switchState__last		= SMBPowerSwitchTileEntity__switchState_on,
};

static inline RUEnumIsInRangeSynthesization_autoFirstLast(SMBPowerSwitchTileEntity__switchState);

#endif /* SMBPowerSwitchTileEntity__switchStates_h */
