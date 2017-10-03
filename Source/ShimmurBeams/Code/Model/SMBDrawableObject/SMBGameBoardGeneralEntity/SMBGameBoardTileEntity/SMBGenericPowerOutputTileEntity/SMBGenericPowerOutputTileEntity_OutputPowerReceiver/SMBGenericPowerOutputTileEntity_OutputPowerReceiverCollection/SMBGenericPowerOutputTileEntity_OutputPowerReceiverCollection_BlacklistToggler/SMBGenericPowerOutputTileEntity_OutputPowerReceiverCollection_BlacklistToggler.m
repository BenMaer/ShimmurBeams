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

		[self setIsPowered:NO];
	}

	return self;
}

#pragma mark - SMBGenericPowerOutputTileEntity_OutputPowerReceiver: outputPowerReceiver_isPowered
-(void)setIsPowered:(BOOL)isPowered
{
	BOOL const isPowered_old = self.isPowered;
	[super setIsPowered:isPowered];

	kRUConditionalReturn(isPowered_old == isPowered, NO);

	[self genericPowerOutputTileEntity_OutputPowerReceiverCollection_outputPowerReceivers_blacklisted_toggle];
}

#pragma mark - genericPowerOutputTileEntity_OutputPowerReceiverCollection
-(void)genericPowerOutputTileEntity_OutputPowerReceiverCollection_outputPowerReceivers_blacklisted_toggle
{
	SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection* const genericPowerOutputTileEntity_OutputPowerReceiverCollection = self.genericPowerOutputTileEntity_OutputPowerReceiverCollection;
	kRUConditionalReturn(genericPowerOutputTileEntity_OutputPowerReceiverCollection == nil, YES);

	NSSet<SMBGenericPowerOutputTileEntity_OutputPowerReceiver*>* const outputPowerReceivers = genericPowerOutputTileEntity_OutputPowerReceiverCollection.outputPowerReceivers;
	kRUConditionalReturn(outputPowerReceivers == nil, YES);

	NSMutableSet<SMBGenericPowerOutputTileEntity_OutputPowerReceiver*>* const outputPowerReceivers_blacklisted_new = [NSMutableSet<SMBGenericPowerOutputTileEntity_OutputPowerReceiver*> setWithSet:outputPowerReceivers];

	NSSet<SMBGenericPowerOutputTileEntity_OutputPowerReceiver*>* const outputPowerReceivers_blacklisted_old = genericPowerOutputTileEntity_OutputPowerReceiverCollection.outputPowerReceivers_blacklisted;
	if (outputPowerReceivers_blacklisted_old)
	{
		[outputPowerReceivers_blacklisted_new minusSet:outputPowerReceivers_blacklisted_old];
	}

	[genericPowerOutputTileEntity_OutputPowerReceiverCollection setOutputPowerReceivers_blacklisted:outputPowerReceivers_blacklisted_new];
}

@end
