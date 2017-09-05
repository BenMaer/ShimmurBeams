//
//  SMBGenericPowerOutputTileEntity.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 9/1/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardTileEntity.h"
#import "SMBGenericPowerOutputTileEntity_OutputPowerReceiver.h"





@interface SMBGenericPowerOutputTileEntity : SMBGameBoardTileEntity

#pragma mark - providesOutputPower
@property (nonatomic, assign) BOOL providesOutputPower;

#pragma mark - outputPowerReceiver
@property (nonatomic, readonly, copy, nullable) NSArray<id<SMBGenericPowerOutputTileEntity_OutputPowerReceiver>>* outputPowerReceivers;

#pragma mark - init
-(nullable instancetype)init_with_outputPowerReceivers:(nonnull NSArray<id<SMBGenericPowerOutputTileEntity_OutputPowerReceiver>>*)outputPowerReceivers NS_DESIGNATED_INITIALIZER;

@end
