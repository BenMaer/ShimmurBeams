//
//  SMBGenericPowerOutputTileEntity.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 9/1/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGenericPowerOutputTileEntity.h"
#import "SMBPowerOutputTileEntity.h"
#import "SMBGameBoardTile.h"
#import "SMBGameBoard.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@interface SMBGenericPowerOutputTileEntity ()

#pragma mark - powerOutputTileEntity
@property (nonatomic, readonly, strong, nullable) SMBPowerOutputTileEntity* powerOutputTileEntity;
-(void)powerOutputTileEntity_gameBoardTile_update;
-(nullable SMBGameBoardTile*)powerOutputTileEntity_gameBoardTile_appropriate;
-(void)powerOutputTileEntity_providesPower_update;
-(BOOL)powerOutputTileEntity_providesPower_appropriate;

@end





@implementation SMBGenericPowerOutputTileEntity

#pragma mark - NSObject
-(instancetype)init
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wno-nullability-completeness"
	return [self init_with_gameBoardTilePosition_toPower:nil];
#pragma clang diagnostic pop
}

#pragma mark - init
-(nullable instancetype)init_with_gameBoardTilePosition_toPower:(nonnull SMBGameBoardTilePosition*)gameBoardTilePosition_toPower
{
	kRUConditionalReturn_ReturnValueNil(gameBoardTilePosition_toPower == nil, YES);

	if (self = [super init])
	{
		_gameBoardTilePosition_toPower = gameBoardTilePosition_toPower;
		[self setProvidesOutputPower:NO];

		_powerOutputTileEntity = [SMBPowerOutputTileEntity new];
		[self powerOutputTileEntity_gameBoardTile_update];
		[self powerOutputTileEntity_providesPower_update];
	}
	
	return self;
}

#pragma mark - SMBGameBoardTileEntity: gameBoardTile
-(void)setGameBoardTile:(nullable SMBGameBoardTile*)gameBoardTile
{
	SMBGameBoardTile* const gameBoardTile_old = self.gameBoardTile;
	[super setGameBoardTile:gameBoardTile];

	kRUConditionalReturn(self.gameBoardTile == gameBoardTile_old, NO);

	[self powerOutputTileEntity_gameBoardTile_update];
}

#pragma mark - providesOutputPower
-(void)setProvidesOutputPower:(BOOL)providesOutputPower
{
	kRUConditionalReturn(self.providesOutputPower == providesOutputPower, NO);

	_providesOutputPower = providesOutputPower;

	[self powerOutputTileEntity_providesPower_update];
}

#pragma mark - powerOutputTileEntity
-(void)powerOutputTileEntity_gameBoardTile_update
{
	SMBPowerOutputTileEntity* const powerOutputTileEntity = self.powerOutputTileEntity;
	kRUConditionalReturn(powerOutputTileEntity == nil, YES);
	
	SMBGameBoardTile__entityType const entityType = SMBGameBoardTile__entityType_many;
	SMBGameBoardTile* const powerOutputTileEntity_gameBoardTile_appropriate = self.powerOutputTileEntity_gameBoardTile_appropriate;
	if (powerOutputTileEntity_gameBoardTile_appropriate)
	{
		[powerOutputTileEntity_gameBoardTile_appropriate gameBoardTileEntities_add:powerOutputTileEntity
																		entityType:entityType];
	}
	else
	{
		SMBGameBoardTile* const powerOutputTileEntity_gameBoardTile = powerOutputTileEntity.gameBoardTile;;
		kRUConditionalReturn(powerOutputTileEntity_gameBoardTile == nil,
							 self.gameBoardTile != nil);
		
		[powerOutputTileEntity_gameBoardTile gameBoardTileEntities_remove:powerOutputTileEntity
															   entityType:entityType];
	}
}

-(nullable SMBGameBoardTile*)powerOutputTileEntity_gameBoardTile_appropriate
{
	SMBGameBoardTile* const gameBoardTile = self.gameBoardTile;
	kRUConditionalReturn_ReturnValueNil(gameBoardTile == nil, NO);
	
	SMBPowerOutputTileEntity* const powerOutputTileEntity = self.powerOutputTileEntity;
	kRUConditionalReturn_ReturnValueNil(powerOutputTileEntity == nil, YES);
	
	SMBGameBoardTilePosition* const gameBoardTilePosition_toPower = self.gameBoardTilePosition_toPower;
	kRUConditionalReturn_ReturnValueNil(gameBoardTilePosition_toPower == nil, NO);
	
	SMBGameBoard* const gameBoard = gameBoardTile.gameBoard;
	kRUConditionalReturn_ReturnValueNil(gameBoard == nil, YES);
	
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
	return self.providesOutputPower;
}

@end
