//
//  SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 9/5/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGenericPowerOutputTileEntity_OutputPowerReceiver.h"

#import <Foundation/Foundation.h>





@interface SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection : NSObject <SMBGenericPowerOutputTileEntity_OutputPowerReceiver>

#pragma mark - outputPowerReceivers_powerIsOppositeOfReceiver
@property (nonatomic, assign) BOOL outputPowerReceivers_powerIsOppositeOfReceiver;

#pragma mark - outputPowerReceiver
@property (nonatomic, readonly, copy, nullable) NSArray<id<SMBGenericPowerOutputTileEntity_OutputPowerReceiver>>* outputPowerReceivers;

#pragma mark - init
-(nullable instancetype)init_with_outputPowerReceivers:(nonnull NSArray<id<SMBGenericPowerOutputTileEntity_OutputPowerReceiver>>*)outputPowerReceivers NS_DESIGNATED_INITIALIZER;

@end
