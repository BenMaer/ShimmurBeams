//
//  SMBGenericPowerOutputTileEntity.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 9/1/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGenericPowerOutputTileEntity.h"
#import "SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@interface SMBGenericPowerOutputTileEntity ()

#pragma mark - outputPowerReceiverCollection
-(void)outputPowerReceiverCollection_outputPowerReceiver_isPowered_update;
-(void)outputPowerReceiverCollection_outputPowerReceiver_genericPowerOutputTileEntity_update:(BOOL)registerToSelf;

@end





@implementation SMBGenericPowerOutputTileEntity

#pragma mark - NSObject
-(void)dealloc
{
	[self outputPowerReceiverCollection_outputPowerReceiver_genericPowerOutputTileEntity_update:NO];
}

-(instancetype)init
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);

#if __has_feature(nullability)
#pragma clang diagnostic push
#pragma GCC diagnostic ignored "-Wnullability-completeness"
#endif
	return [self init_with_outputPowerReceiverCollection:nil];
#if __has_feature(nullability)
#pragma clang diagnostic pop
#endif
}

#pragma mark - init
-(nullable instancetype)init_with_outputPowerReceiverCollection:(nonnull SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection*)outputPowerReceiverCollection
{
	kRUConditionalReturn_ReturnValueNil(outputPowerReceiverCollection == nil, YES);

	if (self = [super init])
	{
		_outputPowerReceiverCollection = outputPowerReceiverCollection;
		[self outputPowerReceiverCollection_outputPowerReceiver_genericPowerOutputTileEntity_update:YES];

		[self setProvidesOutputPower:NO];
		[self outputPowerReceiverCollection_outputPowerReceiver_isPowered_update];
	}

	return self;
}

#pragma mark - providesOutputPower
-(void)setProvidesOutputPower:(BOOL)providesOutputPower
{
	kRUConditionalReturn(self.providesOutputPower == providesOutputPower, NO);

	_providesOutputPower = providesOutputPower;

	[self outputPowerReceiverCollection_outputPowerReceiver_isPowered_update];
}

#pragma mark - outputPowerReceiverCollection
-(void)outputPowerReceiverCollection_outputPowerReceiver_isPowered_update
{
	SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection* const outputPowerReceiverCollection = self.outputPowerReceiverCollection;
	kRUConditionalReturn(outputPowerReceiverCollection == nil, YES);

	[outputPowerReceiverCollection setOutputPowerReceiver_isPowered:self.providesOutputPower];
}

-(void)outputPowerReceiverCollection_outputPowerReceiver_genericPowerOutputTileEntity_update:(BOOL)registerToSelf
{
	SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection* const outputPowerReceiverCollection = self.outputPowerReceiverCollection;
	kRUConditionalReturn(outputPowerReceiverCollection == nil, YES);

	SMBGenericPowerOutputTileEntity* const outputPowerReceiver_genericPowerOutputTileEntity = (registerToSelf ? self : nil);
	kRUConditionalReturn(outputPowerReceiverCollection.outputPowerReceiver_genericPowerOutputTileEntity == outputPowerReceiver_genericPowerOutputTileEntity, YES);

	[outputPowerReceiverCollection setOutputPowerReceiver_genericPowerOutputTileEntity:outputPowerReceiver_genericPowerOutputTileEntity];
}

@end
