//
//  SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection_BlacklistToggler.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 9/6/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGenericPowerOutputTileEntity_OutputPowerReceiver.h"

#import <Foundation/Foundation.h>





@class SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection;





@interface SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection_BlacklistToggler : SMBGenericPowerOutputTileEntity_OutputPowerReceiver

#pragma mark - genericPowerOutputTileEntity_OutputPowerReceiverCollection
@property (nonatomic, readonly, strong, nullable) SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection* genericPowerOutputTileEntity_OutputPowerReceiverCollection;

#pragma mark - init
-(nullable instancetype)init_with_genericPowerOutputTileEntity_OutputPowerReceiverCollection:(nonnull SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection*)genericPowerOutputTileEntity_OutputPowerReceiverCollection NS_DESIGNATED_INITIALIZER;


@end
