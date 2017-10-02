//
//  SMBGenericPowerOutputTileEntity.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 9/1/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardTileEntity.h"





@protocol SMBGenericPowerOutputTileEntity_OutputPowerReceiver;





@interface SMBGenericPowerOutputTileEntity : SMBGameBoardTileEntity

#pragma mark - providesOutputPower
@property (nonatomic, assign) BOOL providesOutputPower;

#pragma mark - outputPowerReceiver
@property (nonatomic, readonly, strong, nullable) id<SMBGenericPowerOutputTileEntity_OutputPowerReceiver> outputPowerReceiver;

#pragma mark - init
-(nullable instancetype)init_with_outputPowerReceiver:(nonnull id<SMBGenericPowerOutputTileEntity_OutputPowerReceiver>)outputPowerReceiver NS_DESIGNATED_INITIALIZER;

@end
