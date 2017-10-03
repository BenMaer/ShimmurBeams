//
//  SMBGenericPowerOutputTileEntity_OutputPowerReceiver_GameBoardTilePowerProvider.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 9/5/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGenericPowerOutputTileEntity_OutputPowerReceiver_GameBoardTilePowerProvider.h"
#import "SMBPowerOutputTileEntity.h"
#import "SMBGameBoardTile.h"
#import "SMBGameBoard.h"
#import "SMBGenericPowerOutputTileEntity.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/NSMutableArray+RUAddObjectIfNotNil.h>
#import <ResplendentUtilities/RUConstants.h>





@interface SMBGenericPowerOutputTileEntity_OutputPowerReceiver_GameBoardTilePowerProvider ()

#pragma mark - powerOutputTileEntity
@property (nonatomic, readonly, strong, nullable) SMBPowerOutputTileEntity* powerOutputTileEntity;
-(void)powerOutputTileEntity_gameBoardTile_update;
-(nullable SMBGameBoardTile*)powerOutputTileEntity_gameBoardTile_appropriate;
-(void)powerOutputTileEntity_providesPower_update;
-(BOOL)powerOutputTileEntity_providesPower_appropriate;

@end





@implementation SMBGenericPowerOutputTileEntity_OutputPowerReceiver_GameBoardTilePowerProvider

#pragma mark - NSObject
-(instancetype)init
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);

#if __has_feature(nullability)
#pragma clang diagnostic push
#pragma GCC diagnostic ignored "-Wnullability-completeness"
#endif
	return [self init_with_gameBoardTilePosition_toPower:nil];
#if __has_feature(nullability)
#pragma clang diagnostic pop
#endif
}

#pragma mark - init
-(nullable instancetype)init_with_gameBoardTilePosition_toPower:(nonnull SMBGameBoardTilePosition*)gameBoardTilePosition_toPower
{
	kRUConditionalReturn_ReturnValueNil(gameBoardTilePosition_toPower == nil, YES);

	if (self = [super init])
	{
		_gameBoardTilePosition_toPower = gameBoardTilePosition_toPower;
		[self setIsPowered:NO];

		_powerOutputTileEntity = [SMBPowerOutputTileEntity new];
		[self powerOutputTileEntity_gameBoardTile_update];
		[self powerOutputTileEntity_providesPower_update];
	}

	return self;
}

-(nonnull NSString*)description
{
	NSMutableArray<NSString*>* const description_lines = [NSMutableArray<NSString*> array];
	[description_lines ru_addObjectIfNotNil:[super description]];
	[description_lines ru_addObjectIfNotNil:RUStringWithFormat(@"gameBoardTilePosition_toPower %@",self.gameBoardTilePosition_toPower)];

	return [description_lines componentsJoinedByString:@"\n"];
}

#pragma mark - powerOutputTileEntity
-(void)powerOutputTileEntity_gameBoardTile_update
{
	SMBPowerOutputTileEntity* const powerOutputTileEntity = self.powerOutputTileEntity;
	kRUConditionalReturn(powerOutputTileEntity == nil, YES);

	SMBGameBoardTile__entityType const entityType = SMBGameBoardTile__entityType_many;
	SMBGameBoardTile* const powerOutputTileEntity_gameBoardTile_appropriate = [self powerOutputTileEntity_gameBoardTile_appropriate];
	if (powerOutputTileEntity_gameBoardTile_appropriate)
	{
		NSAssert(powerOutputTileEntity.gameBoardTile == nil, @"should not be set yet.");
		[powerOutputTileEntity_gameBoardTile_appropriate gameBoardTileEntities_add:powerOutputTileEntity
																		entityType:entityType];
	}
	else
	{
		SMBGameBoardTile* const powerOutputTileEntity_gameBoardTile = powerOutputTileEntity.gameBoardTile;
		kRUConditionalReturn(powerOutputTileEntity_gameBoardTile == nil,
							 self.gameBoard != nil);

		[powerOutputTileEntity_gameBoardTile gameBoardTileEntities_remove:powerOutputTileEntity
															   entityType:entityType];
	}
}

-(nullable SMBGameBoardTile*)powerOutputTileEntity_gameBoardTile_appropriate
{
	SMBGameBoardTilePosition* const gameBoardTilePosition_toPower = self.gameBoardTilePosition_toPower;
	kRUConditionalReturn_ReturnValueNil(gameBoardTilePosition_toPower == nil, YES);

	SMBGameBoard* const gameBoard = self.gameBoard;
	kRUConditionalReturn_ReturnValueNil(gameBoard == nil, NO);

	SMBGameBoardTile* const gameBoardTile_at_position = [gameBoard gameBoardTile_at_position:gameBoardTilePosition_toPower];
	kRUConditionalReturn_ReturnValueNil(gameBoardTile_at_position == nil, YES);

	return gameBoardTile_at_position;
}

-(void)powerOutputTileEntity_providesPower_update
{
	[self.powerOutputTileEntity setProvidesPower:[self powerOutputTileEntity_providesPower_appropriate]];
}

-(BOOL)powerOutputTileEntity_providesPower_appropriate
{
	return self.isPowered;
}

#pragma mark - SMBGenericPowerOutputTileEntity_OutputPowerReceiver: outputPowerReceiver_isPowered
-(void)setIsPowered:(BOOL)isPowered
{
	BOOL const isPowered_old = self.isPowered;
	[super setIsPowered:isPowered];

	kRUConditionalReturn(isPowered_old == isPowered, NO);

	[self powerOutputTileEntity_providesPower_update];
}

#pragma mark - SMBGenericPowerOutputTileEntity_OutputPowerReceiver: gameBoard
-(void)setGameBoard:(nullable SMBGameBoard*)gameBoard
{
	SMBGameBoard* const gameBoard_old = self.gameBoard;
	[super setGameBoard:gameBoard];

	kRUConditionalReturn(gameBoard_old == gameBoard, NO);

	[self powerOutputTileEntity_gameBoardTile_update];
}

@end
