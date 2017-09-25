//
//  SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection_BlacklistToggler.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 9/6/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection_BlacklistToggler.h"
#import "SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@interface SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection_BlacklistToggler ()

#pragma mark - genericPowerOutputTileEntity_OutputPowerReceiverCollection
-(void)genericPowerOutputTileEntity_OutputPowerReceiverCollection_outputPowerReceivers_blacklisted_toggle;

@end





@implementation SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection_BlacklistToggler

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
	return [self init_with_genericPowerOutputTileEntity_OutputPowerReceiverCollection:nil];
#if __has_feature(nullability)
#pragma clang diagnostic pop
#endif
}

#pragma mark - init
-(nullable instancetype)init_with_genericPowerOutputTileEntity_OutputPowerReceiverCollection:(nonnull SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection*)genericPowerOutputTileEntity_OutputPowerReceiverCollection
{
	kRUConditionalReturn_ReturnValueNil(genericPowerOutputTileEntity_OutputPowerReceiverCollection == nil, YES);
	
	if (self = [super init])
	{
		_genericPowerOutputTileEntity_OutputPowerReceiverCollection = genericPowerOutputTileEntity_OutputPowerReceiverCollection;

		[self setOutputPowerReceiver_isPowered:NO];
	}
	
	return self;
}

#pragma mark - outputPowerReceiver_isPowered
@synthesize outputPowerReceiver_isPowered = _outputPowerReceiver_isPowered;
-(void)setOutputPowerReceiver_isPowered:(BOOL)outputPowerReceiver_isPowered
{
	kRUConditionalReturn(self.outputPowerReceiver_isPowered == outputPowerReceiver_isPowered, NO);

	_outputPowerReceiver_isPowered = outputPowerReceiver_isPowered;

	[self genericPowerOutputTileEntity_OutputPowerReceiverCollection_outputPowerReceivers_blacklisted_toggle];
}

#pragma mark - genericPowerOutputTileEntity
@synthesize outputPowerReceiver_genericPowerOutputTileEntity = _outputPowerReceiver_genericPowerOutputTileEntity;

#pragma mark - genericPowerOutputTileEntity_OutputPowerReceiverCollection
-(void)genericPowerOutputTileEntity_OutputPowerReceiverCollection_outputPowerReceivers_blacklisted_toggle
{
	SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection* const genericPowerOutputTileEntity_OutputPowerReceiverCollection = self.genericPowerOutputTileEntity_OutputPowerReceiverCollection;
	kRUConditionalReturn(genericPowerOutputTileEntity_OutputPowerReceiverCollection == nil, YES);

	NSSet<id<SMBGenericPowerOutputTileEntity_OutputPowerReceiver>>* const outputPowerReceivers = genericPowerOutputTileEntity_OutputPowerReceiverCollection.outputPowerReceivers;
	kRUConditionalReturn(outputPowerReceivers == nil, YES);

	NSMutableSet<id<SMBGenericPowerOutputTileEntity_OutputPowerReceiver>>* const outputPowerReceivers_blacklisted_new = [NSMutableSet<id<SMBGenericPowerOutputTileEntity_OutputPowerReceiver>> setWithSet:outputPowerReceivers];

	NSSet<id<SMBGenericPowerOutputTileEntity_OutputPowerReceiver>>* const outputPowerReceivers_blacklisted_old = genericPowerOutputTileEntity_OutputPowerReceiverCollection.outputPowerReceivers_blacklisted;
	if (outputPowerReceivers_blacklisted_old)
	{
		[outputPowerReceivers_blacklisted_new minusSet:outputPowerReceivers_blacklisted_old];
	}

	[genericPowerOutputTileEntity_OutputPowerReceiverCollection setOutputPowerReceivers_blacklisted:outputPowerReceivers_blacklisted_new];
}

@end
