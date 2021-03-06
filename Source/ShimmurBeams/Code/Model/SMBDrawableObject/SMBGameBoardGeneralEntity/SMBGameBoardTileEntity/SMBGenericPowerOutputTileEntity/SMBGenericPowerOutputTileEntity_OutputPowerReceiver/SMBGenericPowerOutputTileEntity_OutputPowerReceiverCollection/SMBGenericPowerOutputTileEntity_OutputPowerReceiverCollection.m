//
//  SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 9/5/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/NSMutableArray+RUAddObjectIfNotNil.h>
#import <ResplendentUtilities/RUConstants.h>





@interface SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection ()

#pragma mark - outputPowerReceivers
-(void)outputPowerReceivers_outputPowerReceiver_isPowered_update;
-(void)genericPowerOutputTileEntity_outputPowerReceiver_genericPowerOutputTileEntity_update;

@end





@implementation SMBGenericPowerOutputTileEntity_OutputPowerReceiverCollection

#pragma mark - NSObject
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

-(nonnull NSString*)description
{
	NSMutableArray<NSString*>* const description_lines = [NSMutableArray<NSString*> array];
	[description_lines ru_addObjectIfNotNil:[super description]];
	[description_lines ru_addObjectIfNotNil:RUStringWithFormat(@"outputPowerReceivers_powerIsOppositeOfReceiver: %i",self.outputPowerReceivers_powerIsOppositeOfReceiver)];

	return [description_lines componentsJoinedByString:@"\n"];
}

#pragma mark - init
-(nullable instancetype)init_with_outputPowerReceivers:(nonnull NSSet<SMBGenericPowerOutputTileEntity_OutputPowerReceiver*>*)outputPowerReceivers
{
	kRUConditionalReturn_ReturnValueNil(outputPowerReceivers == nil, YES);
	kRUConditionalReturn_ReturnValueNil(outputPowerReceivers.count == 0, YES);

	if (self = [super init])
	{
		_outputPowerReceivers = [NSSet<SMBGenericPowerOutputTileEntity_OutputPowerReceiver*> setWithSet:outputPowerReceivers];

		[self setOutputPowerReceivers_powerIsOppositeOfReceiver:NO];

		[self outputPowerReceivers_outputPowerReceiver_isPowered_update];
	}

	return self;
}

#pragma mark - SMBGenericPowerOutputTileEntity_OutputPowerReceiver: outputPowerReceiver_isPowered
-(void)setIsPowered:(BOOL)isPowered
{
	BOOL const isPowered_old = self.isPowered;
	[super setIsPowered:isPowered];

	kRUConditionalReturn(isPowered_old == isPowered, NO);

	[self outputPowerReceivers_outputPowerReceiver_isPowered_update];
}

#pragma mark - SMBGenericPowerOutputTileEntity_OutputPowerReceiver: gameBoard
-(void)setGameBoard:(nullable SMBGameBoard*)gameBoard
{
	SMBGameBoard* const gameBoard_old = self.gameBoard;
	[super setGameBoard:gameBoard];

	kRUConditionalReturn(gameBoard_old == gameBoard, NO);

	[self genericPowerOutputTileEntity_outputPowerReceiver_genericPowerOutputTileEntity_update];
}

#pragma mark - outputPowerReceivers_powerIsOppositeOfReceiver
-(void)setOutputPowerReceivers_powerIsOppositeOfReceiver:(BOOL)outputPowerReceivers_powerIsOppositeOfReceiver
{
	kRUConditionalReturn(self.outputPowerReceivers_powerIsOppositeOfReceiver == outputPowerReceivers_powerIsOppositeOfReceiver, NO);

	_outputPowerReceivers_powerIsOppositeOfReceiver = outputPowerReceivers_powerIsOppositeOfReceiver;

	[self outputPowerReceivers_outputPowerReceiver_isPowered_update];
}

#pragma mark - outputPowerReceivers
-(void)setOutputPowerReceivers_blacklisted:(nullable NSSet<SMBGenericPowerOutputTileEntity_OutputPowerReceiver*>*)outputPowerReceivers_blacklisted
{
	kRUConditionalReturn((self.outputPowerReceivers_blacklisted == outputPowerReceivers_blacklisted)
						 ||
						 [self.outputPowerReceivers_blacklisted isEqual:outputPowerReceivers_blacklisted], NO);

	_outputPowerReceivers_blacklisted =
	(outputPowerReceivers_blacklisted
	 ?
	 [NSSet<SMBGenericPowerOutputTileEntity_OutputPowerReceiver*> setWithSet:outputPowerReceivers_blacklisted]
	 :
	 nil);

	[self outputPowerReceivers_outputPowerReceiver_isPowered_update];
}

-(void)outputPowerReceivers_outputPowerReceiver_isPowered_update
{
	BOOL const providesOutputPower = self.isPowered;
	BOOL const outputPowerReceivers_powerIsOppositeOfReceiver = self.outputPowerReceivers_powerIsOppositeOfReceiver;
	NSSet<SMBGenericPowerOutputTileEntity_OutputPowerReceiver*>* const outputPowerReceivers_blacklisted = self.outputPowerReceivers_blacklisted;

	BOOL const providesOutputPower_toReceivers = (outputPowerReceivers_powerIsOppositeOfReceiver ? !providesOutputPower : providesOutputPower);

	[self.outputPowerReceivers enumerateObjectsUsingBlock:^(SMBGenericPowerOutputTileEntity_OutputPowerReceiver*  _Nonnull outputPowerReceiver, BOOL * _Nonnull stop) {
		BOOL const outputPowerReceiver_isPowered =
		((providesOutputPower_toReceivers == true)
		 &&
		 ((outputPowerReceivers_blacklisted == nil)
		  ||
		  ([outputPowerReceivers_blacklisted containsObject:outputPowerReceiver] == false))
		 );

		[outputPowerReceiver setIsPowered:outputPowerReceiver_isPowered];
	}];
}

-(void)genericPowerOutputTileEntity_outputPowerReceiver_genericPowerOutputTileEntity_update
{
	SMBGameBoard* const outputPowerReceiver_gameBoard = self.gameBoard;

	[self.outputPowerReceivers enumerateObjectsUsingBlock:^(SMBGenericPowerOutputTileEntity_OutputPowerReceiver*  _Nonnull outputPowerReceiver, BOOL * _Nonnull stop) {
		[outputPowerReceiver setGameBoard:outputPowerReceiver_gameBoard];
	}];
}

@end
