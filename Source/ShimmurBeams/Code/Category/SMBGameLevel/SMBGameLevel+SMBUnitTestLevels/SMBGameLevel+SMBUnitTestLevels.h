//
//  SMBGameLevel+SMBUnitTestLevels.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 9/8/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameLevel.h"





@interface SMBGameLevel (SMBUnitTestLevels)

#pragma mark - beamEntityOrder
+(nonnull instancetype)smb_beamEntityOrder;

#pragma mark - buttonPoweredImmediately
+(nonnull instancetype)smb_buttonPoweredImmediately;

#pragma mark - beamCreatorPoweringItself
+(nonnull instancetype)smb_beamCreatorPoweringItself;

@end
