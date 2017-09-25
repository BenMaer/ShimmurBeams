//
//  SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 9/5/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@interface SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection ()

#pragma mark - outputPowerReceiver
-(void)outputPowerReceivers_outputPowerReceiver_isPowered_update;
-(void)genericPowerOutputTileEntity_outputPowerReceiver_genericPowerOutputTileEntity_update;

@end





@implementation SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection

#pragma mark - NSObject
-(void)dealloc
{
	NSAssert(self.outputPowerReceiver_genericPowerOutputTileEntity == nil, @"should have been set to nil externally by now.");
	[self setOutputPowerReceiver_genericPowerOutputTileEntity:nil];
}

-(instancetype)init
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);

#if __has_feature(nullability)
#pragma clang diagnostic push
#pragma GCC diagnostic ignored "-Wnullability-completeness"
#endif
	return [self init_with_outputPowerReceivers:nil];
#if __has_feature(nullability)
#pragma clang diagnostic pop
#endif
}

#pragma mark - init
-(nullable instancetype)init_with_outputPowerReceivers:(nonnull NSSet<id<SMBGenericPowerOutputTileEntity_OutputPowerReceiver>>*)outputPowerReceivers
{
	kRUConditionalReturn_ReturnValueNil(outputPowerReceivers == nil, YES);
	kRUConditionalReturn_ReturnValueNil(outputPowerReceivers.count == 0, YES);

	if (self = [super init])
	{
		_outputPowerReceivers = [NSSet<id<SMBGenericPowerOutputTileEntity_OutputPowerReceiver>> setWithSet:outputPowerReceivers];

		[self setOutputPowerReceiver_isPowered:NO];
		[self setOutputPowerReceivers_powerIsOppositeOfReceiver:NO];

		[self outputPowerReceivers_outputPowerReceiver_isPowered_update];
	}

	return self;
}

#pragma mark - outputPowerReceiver_isPowered
@synthesize outputPowerReceiver_isPowered = _outputPowerReceiver_isPowered;
-(void)setOutputPowerReceiver_isPowered:(BOOL)outputPowerReceiver_isPowered
{
	kRUConditionalReturn(self.outputPowerReceiver_isPowered == outputPowerReceiver_isPowered, NO);

	_outputPowerReceiver_isPowered = outputPowerReceiver_isPowered;

	[self outputPowerReceivers_outputPowerReceiver_isPowered_update];
}

#pragma mark - outputPowerReceivers_powerIsOppositeOfReceiver
-(void)setOutputPowerReceivers_powerIsOppositeOfReceiver:(BOOL)outputPowerReceivers_powerIsOppositeOfReceiver
{
	kRUConditionalReturn(self.outputPowerReceivers_powerIsOppositeOfReceiver == outputPowerReceivers_powerIsOppositeOfReceiver, NO);

	_outputPowerReceivers_powerIsOppositeOfReceiver = outputPowerReceivers_powerIsOppositeOfReceiver;

	[self outputPowerReceivers_outputPowerReceiver_isPowered_update];
}

#pragma mark - genericPowerOutputTileEntity
@synthesize outputPowerReceiver_genericPowerOutputTileEntity = _outputPowerReceiver_genericPowerOutputTileEntity;
-(void)setOutputPowerReceiver_genericPowerOutputTileEntity:(nullable SMBGenericPowerOutputTileEntity*)outputPowerReceiver_genericPowerOutputTileEntity
{
	kRUConditionalReturn(self.outputPowerReceiver_genericPowerOutputTileEntity == outputPowerReceiver_genericPowerOutputTileEntity, NO);

	_outputPowerReceiver_genericPowerOutputTileEntity = outputPowerReceiver_genericPowerOutputTileEntity;

	[self genericPowerOutputTileEntity_outputPowerReceiver_genericPowerOutputTileEntity_update];
}

#pragma mark - outputPowerReceiver
-(void)setOutputPowerReceivers_blacklisted:(nullable NSSet<id<SMBGenericPowerOutputTileEntity_OutputPowerReceiver>>*)outputPowerReceivers_blacklisted
{
	kRUConditionalReturn((self.outputPowerReceivers_blacklisted == outputPowerReceivers_blacklisted)
						 ||
						 [self.outputPowerReceivers_blacklisted isEqual:outputPowerReceivers_blacklisted], NO);

	_outputPowerReceivers_blacklisted =
	(outputPowerReceivers_blacklisted
	 ?
	 [NSSet<id<SMBGenericPowerOutputTileEntity_OutputPowerReceiver>> setWithSet:outputPowerReceivers_blacklisted]
	 :
	 nil);

	[self outputPowerReceivers_outputPowerReceiver_isPowered_update];
}

-(void)outputPowerReceivers_outputPowerReceiver_isPowered_update
{
	BOOL const providesOutputPower = self.outputPowerReceiver_isPowered;
	BOOL const outputPowerReceivers_powerIsOppositeOfReceiver = self.outputPowerReceivers_powerIsOppositeOfReceiver;
	NSSet<id<SMBGenericPowerOutputTileEntity_OutputPowerReceiver>>* const outputPowerReceivers_blacklisted = self.outputPowerReceivers_blacklisted;

	BOOL const providesOutputPower_toReceivers = (outputPowerReceivers_powerIsOppositeOfReceiver ? !providesOutputPower : providesOutputPower);

	[self.outputPowerReceivers enumerateObjectsUsingBlock:^(id<SMBGenericPowerOutputTileEntity_OutputPowerReceiver>  _Nonnull outputPowerReceiver, BOOL * _Nonnull stop) {
		BOOL const outputPowerReceiver_isPowered =
		((providesOutputPower_toReceivers == true)
		 &&
		 ((outputPowerReceivers_blacklisted == nil)
		  ||
		  ([outputPowerReceivers_blacklisted containsObject:outputPowerReceiver] == false))
		 );

		[outputPowerReceiver setOutputPowerReceiver_isPowered:outputPowerReceiver_isPowered];
	}];
}

-(void)genericPowerOutputTileEntity_outputPowerReceiver_genericPowerOutputTileEntity_update
{
	SMBGenericPowerOutputTileEntity* const outputPowerReceiver_genericPowerOutputTileEntity = self.outputPowerReceiver_genericPowerOutputTileEntity;

	[self.outputPowerReceivers enumerateObjectsUsingBlock:^(id<SMBGenericPowerOutputTileEntity_OutputPowerReceiver>  _Nonnull outputPowerReceiver, BOOL * _Nonnull stop) {
		kRUConditionalReturn(outputPowerReceiver.outputPowerReceiver_genericPowerOutputTileEntity == outputPowerReceiver_genericPowerOutputTileEntity, YES);

		[outputPowerReceiver setOutputPowerReceiver_genericPowerOutputTileEntity:outputPowerReceiver_genericPowerOutputTileEntity];
	}];
}

@end
