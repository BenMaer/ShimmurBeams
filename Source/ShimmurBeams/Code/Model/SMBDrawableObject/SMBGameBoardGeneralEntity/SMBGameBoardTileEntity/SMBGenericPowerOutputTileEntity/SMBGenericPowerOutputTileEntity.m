//
//  SMBGenericPowerOutputTileEntity.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 9/1/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGenericPowerOutputTileEntity.h"
#import "SMBGenericPowerOutputTileEntity_OutputPowerReceiver.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@interface SMBGenericPowerOutputTileEntity ()

#pragma mark - outputPowerReceiver
-(void)outputPowerReceiver_outputPowerReceiver_isPowered_update;
-(void)outputPowerReceiver_outputPowerReceiver_genericPowerOutputTileEntity_update:(BOOL)registerToSelf;

@end





@implementation SMBGenericPowerOutputTileEntity

#pragma mark - NSObject
-(void)dealloc
{
	[self outputPowerReceiver_outputPowerReceiver_genericPowerOutputTileEntity_update:NO];
}

-(instancetype)init
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);

#if __has_feature(nullability)
#pragma clang diagnostic push
#pragma GCC diagnostic ignored "-Wnullability-completeness"
#endif
	return [self init_with_outputPowerReceiver:nil];
#if __has_feature(nullability)
#pragma clang diagnostic pop
#endif
}

#pragma mark - init
-(nullable instancetype)init_with_outputPowerReceiver:(nonnull id<SMBGenericPowerOutputTileEntity_OutputPowerReceiver>)outputPowerReceiver
{
	kRUConditionalReturn_ReturnValueNil(outputPowerReceiver == nil, YES);

	if (self = [super init])
	{
		_outputPowerReceiver = outputPowerReceiver;
		[self outputPowerReceiver_outputPowerReceiver_genericPowerOutputTileEntity_update:YES];

		[self setProvidesOutputPower:NO];
		[self outputPowerReceiver_outputPowerReceiver_isPowered_update];
	}

	return self;
}

#pragma mark - providesOutputPower
-(void)setProvidesOutputPower:(BOOL)providesOutputPower
{
	kRUConditionalReturn(self.providesOutputPower == providesOutputPower, NO);

	_providesOutputPower = providesOutputPower;

	[self outputPowerReceiver_outputPowerReceiver_isPowered_update];
}

#pragma mark - outputPowerReceiver
-(void)outputPowerReceiver_outputPowerReceiver_isPowered_update
{
	id<SMBGenericPowerOutputTileEntity_OutputPowerReceiver> const outputPowerReceiver = self.outputPowerReceiver;
	kRUConditionalReturn(outputPowerReceiver == nil, YES);

	[outputPowerReceiver setOutputPowerReceiver_isPowered:self.providesOutputPower];
}

-(void)outputPowerReceiver_outputPowerReceiver_genericPowerOutputTileEntity_update:(BOOL)registerToSelf
{
	id<SMBGenericPowerOutputTileEntity_OutputPowerReceiver> const outputPowerReceiver = self.outputPowerReceiver;
	kRUConditionalReturn(outputPowerReceiver == nil, YES);

	SMBGenericPowerOutputTileEntity* const outputPowerReceiver_genericPowerOutputTileEntity = (registerToSelf ? self : nil);
	kRUConditionalReturn(outputPowerReceiver.outputPowerReceiver_genericPowerOutputTileEntity == outputPowerReceiver_genericPowerOutputTileEntity, YES);

	[outputPowerReceiver setOutputPowerReceiver_genericPowerOutputTileEntity:outputPowerReceiver_genericPowerOutputTileEntity];
}

@end
