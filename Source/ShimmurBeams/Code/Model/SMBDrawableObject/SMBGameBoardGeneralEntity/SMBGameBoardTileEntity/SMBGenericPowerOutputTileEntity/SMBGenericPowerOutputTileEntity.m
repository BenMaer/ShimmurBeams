//
//  SMBGenericPowerOutputTileEntity.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 9/1/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGenericPowerOutputTileEntity.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@interface SMBGenericPowerOutputTileEntity ()

#pragma mark - outputPowerReceiver
-(void)outputPowerReceivers_outputPowerReceiver_isPowered_update;
-(void)genericPowerOutputTileEntity_outputPowerReceiver_genericPowerOutputTileEntity_update:(BOOL)registerToSelf;

@end





@implementation SMBGenericPowerOutputTileEntity

#pragma mark - NSObject
-(void)dealloc
{
	[self genericPowerOutputTileEntity_outputPowerReceiver_genericPowerOutputTileEntity_update:NO];
}

-(instancetype)init
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wno-nullability-completeness"
	return [self init_with_outputPowerReceivers:nil];
#pragma clang diagnostic pop
}

#pragma mark - init
-(nullable instancetype)init_with_outputPowerReceivers:(nonnull NSArray<id<SMBGenericPowerOutputTileEntity_OutputPowerReceiver>>*)outputPowerReceivers
{
	kRUConditionalReturn_ReturnValueNil(outputPowerReceivers == nil, YES);
	kRUConditionalReturn_ReturnValueNil(outputPowerReceivers.count == 0, YES);

	if (self = [super init])
	{
		_outputPowerReceivers = [NSArray<id<SMBGenericPowerOutputTileEntity_OutputPowerReceiver>> arrayWithArray:outputPowerReceivers];
		[self genericPowerOutputTileEntity_outputPowerReceiver_genericPowerOutputTileEntity_update:YES];

		[self setProvidesOutputPower:NO];
		[self outputPowerReceivers_outputPowerReceiver_isPowered_update];
	}

	return self;
}

#pragma mark - providesOutputPower
-(void)setProvidesOutputPower:(BOOL)providesOutputPower
{
	kRUConditionalReturn(self.providesOutputPower == providesOutputPower, NO);

	_providesOutputPower = providesOutputPower;

	[self outputPowerReceivers_outputPowerReceiver_isPowered_update];
}

#pragma mark - outputPowerReceiver
-(void)outputPowerReceivers_outputPowerReceiver_isPowered_update
{
	BOOL const providesOutputPower = self.providesOutputPower;
	[self.outputPowerReceivers enumerateObjectsUsingBlock:^(id<SMBGenericPowerOutputTileEntity_OutputPowerReceiver>  _Nonnull outputPowerReceiver, NSUInteger idx, BOOL * _Nonnull stop) {
		[outputPowerReceiver setOutputPowerReceiver_isPowered:providesOutputPower];
	}];
}

-(void)genericPowerOutputTileEntity_outputPowerReceiver_genericPowerOutputTileEntity_update:(BOOL)registerToSelf
{
	SMBGenericPowerOutputTileEntity* const outputPowerReceiver_genericPowerOutputTileEntity = (registerToSelf ? self : nil);
	[self.outputPowerReceivers enumerateObjectsUsingBlock:^(id<SMBGenericPowerOutputTileEntity_OutputPowerReceiver>  _Nonnull outputPowerReceiver, NSUInteger idx, BOOL * _Nonnull stop) {
		kRUConditionalReturn(outputPowerReceiver.outputPowerReceiver_genericPowerOutputTileEntity == outputPowerReceiver_genericPowerOutputTileEntity, YES);

		[outputPowerReceiver setOutputPowerReceiver_genericPowerOutputTileEntity:outputPowerReceiver_genericPowerOutputTileEntity];
	}];
}

@end
