//
//  SMBGenericPowerOutputTileEntity.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 9/1/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGenericPowerOutputTileEntity.h"
#import "SMBGenericPowerOutputTileEntity_OutputPowerReceiver.h"
#import "SMBGameBoardTile.h"
#import "SMBGameBoard.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@interface SMBGenericPowerOutputTileEntity ()

#pragma mark - outputPowerReceiver
-(void)outputPowerReceiver_outputPowerReceiver_isPowered_update;
-(void)outputPowerReceiver_outputPowerReceiver_gameBoard_update:(BOOL)forceClear;

@end





@implementation SMBGenericPowerOutputTileEntity

#pragma mark - NSObject
-(void)dealloc
{
	[self outputPowerReceiver_outputPowerReceiver_gameBoard_update:YES];
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
-(nullable instancetype)init_with_outputPowerReceiver:(nonnull SMBGenericPowerOutputTileEntity_OutputPowerReceiver*)outputPowerReceiver
{
	kRUConditionalReturn_ReturnValueNil(outputPowerReceiver == nil, YES);

	if (self = [super init])
	{
		_outputPowerReceiver = outputPowerReceiver;
		[self outputPowerReceiver_outputPowerReceiver_gameBoard_update:NO];

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
	SMBGenericPowerOutputTileEntity_OutputPowerReceiver* const outputPowerReceiver = self.outputPowerReceiver;
	kRUConditionalReturn(outputPowerReceiver == nil, YES);

	[outputPowerReceiver setIsPowered:self.providesOutputPower];
}

-(void)outputPowerReceiver_outputPowerReceiver_gameBoard_update:(BOOL)forceClear
{
	SMBGenericPowerOutputTileEntity_OutputPowerReceiver* const outputPowerReceiver = self.outputPowerReceiver;
	kRUConditionalReturn(outputPowerReceiver == nil, YES);

	SMBGameBoardTile* const gameBoardTile = self.gameBoardTile;
	kRUConditionalReturn(gameBoardTile == nil, NO);
	NSAssert(gameBoardTile.gameBoard != nil, @"Should be.");

	[outputPowerReceiver setGameBoard:(forceClear ? nil : self.gameBoardTile.gameBoard)];
}

#pragma mark - SMBGameBoardTileEntity: gameBoardTile
-(void)setGameBoardTile:(nullable SMBGameBoardTile*)gameBoardTile
{
	SMBGameBoardTile* const gameBoardTile_old = self.gameBoardTile;
	[super setGameBoardTile:gameBoardTile];

	kRUConditionalReturn(self.gameBoardTile == gameBoardTile_old, NO);

	[self outputPowerReceiver_outputPowerReceiver_gameBoard_update:NO];
}

@end
