//
//  SMBGenericPowerOutputTileEntity_OutputPowerReceiver.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 9/5/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import <Foundation/Foundation.h>





@class SMBGenericPowerOutputTileEntity;





@protocol SMBGenericPowerOutputTileEntity_OutputPowerReceiver <NSObject>

#pragma mark - outputPowerReceiver_isPowered
@property (nonatomic, assign) BOOL outputPowerReceiver_isPowered;

#pragma mark - genericPowerOutputTileEntity
/**
 Should only be set by the instance of `SMBGenericPowerOutputTileEntity`.
 */
@property (nonatomic, assign, nullable) SMBGenericPowerOutputTileEntity* outputPowerReceiver_genericPowerOutputTileEntity;

@end
