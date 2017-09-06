//
//  SMBGenericPowerOutputTileEntity.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 9/1/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardTileEntity.h"





@class SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection;





@interface SMBGenericPowerOutputTileEntity : SMBGameBoardTileEntity

#pragma mark - providesOutputPower
@property (nonatomic, assign) BOOL providesOutputPower;

#pragma mark - outputPowerReceiverCollection
@property (nonatomic, readonly, strong, nullable) SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection* outputPowerReceiverCollection;

#pragma mark - init
-(nullable instancetype)init_with_outputPowerReceiverCollection:(nonnull SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection*)outputPowerReceiverCollection NS_DESIGNATED_INITIALIZER;

@end
