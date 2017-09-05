//
//  SMBGenericPowerOutputTileEntity_OutputPowerReceiver.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 9/5/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import <Foundation/Foundation.h>





@class SMBGenericPowerOutputTileEntity;





/**
 In classes that use this, it's nice to include the following to enforce proper behavior:
 ```
 -(void)dealloc
 {
 	NSAssert(self.outputPowerReceiver_genericPowerOutputTileEntity == nil, @"should have been set to nil externally by now.");
 	[self setOutputPowerReceiver_genericPowerOutputTileEntity:nil];
 }
 ```
 */
@protocol SMBGenericPowerOutputTileEntity_OutputPowerReceiver <NSObject>

#pragma mark - outputPowerReceiver_isPowered
@property (nonatomic, assign) BOOL outputPowerReceiver_isPowered;

#pragma mark - genericPowerOutputTileEntity
/**
 Should only be set by the instance of `SMBGenericPowerOutputTileEntity`.
 */
@property (nonatomic, assign, nullable) SMBGenericPowerOutputTileEntity* outputPowerReceiver_genericPowerOutputTileEntity;

@end
