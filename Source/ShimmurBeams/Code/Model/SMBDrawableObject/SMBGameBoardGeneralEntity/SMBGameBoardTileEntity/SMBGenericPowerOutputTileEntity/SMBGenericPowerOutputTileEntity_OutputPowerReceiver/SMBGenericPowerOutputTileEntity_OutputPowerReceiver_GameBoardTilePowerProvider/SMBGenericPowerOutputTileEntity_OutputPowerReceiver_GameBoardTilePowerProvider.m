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





static void* kSMBGenericPowerOutputTileEntity_OutputPowerReceiver_GameBoardTilePowerProvider__KVOContext = &kSMBGenericPowerOutputTileEntity_OutputPowerReceiver_GameBoardTilePowerProvider__KVOContext;





@interface SMBGenericPowerOutputTileEntity_OutputPowerReceiver_GameBoardTilePowerProvider ()

#pragma mark - genericPowerOutputTileEntity
-(void)outputPowerReceiver_genericPowerOutputTileEntity_setKVORegistered:(BOOL)registered;

#pragma mark - powerOutputTileEntity
@property (nonatomic, readonly, strong, nullable) SMBPowerOutputTileEntity* powerOutputTileEntity;
-(void)powerOutputTileEntity_gameBoardTile_update;
-(nullable SMBGameBoardTile*)powerOutputTileEntity_gameBoardTile_appropriate;
-(void)powerOutputTileEntity_providesPower_update;
-(BOOL)powerOutputTileEntity_providesPower_appropriate;

@end





@implementation SMBGenericPowerOutputTileEntity_OutputPowerReceiver_GameBoardTilePowerProvider

#pragma mark - NSObject
-(void)dealloc
{
	NSAssert(self.outputPowerReceiver_genericPowerOutputTileEntity == nil, @"should have been set to nil externally by now.");
	[self setOutputPowerReceiver_genericPowerOutputTileEntity:nil];
}

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
		[self setOutputPowerReceiver_isPowered:NO];

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
	[description_lines ru_addObjectIfNotNil:RUStringWithFormat(@"outputPowerReceiver_isPowered %i",self.outputPowerReceiver_isPowered)];
	
	return [description_lines componentsJoinedByString:@"\n"];
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
		NSAssert(powerOutputTileEntity.gameBoardTile == nil, @"should not be set yet.");
		[powerOutputTileEntity_gameBoardTile_appropriate gameBoardTileEntities_add:powerOutputTileEntity
																		entityType:entityType];
	}
	else
	{
		SMBGameBoardTile* const powerOutputTileEntity_gameBoardTile = powerOutputTileEntity.gameBoardTile;
		kRUConditionalReturn(powerOutputTileEntity_gameBoardTile == nil,
							 self.outputPowerReceiver_genericPowerOutputTileEntity.gameBoardTile != nil);
		
		[powerOutputTileEntity_gameBoardTile gameBoardTileEntities_remove:powerOutputTileEntity
															   entityType:entityType];
	}
}

-(nullable SMBGameBoardTile*)powerOutputTileEntity_gameBoardTile_appropriate
{
	SMBGenericPowerOutputTileEntity* const genericPowerOutputTileEntity = self.outputPowerReceiver_genericPowerOutputTileEntity;
	kRUConditionalReturn_ReturnValueNil(genericPowerOutputTileEntity == nil, NO);

	SMBGameBoardTile* const gameBoardTile = genericPowerOutputTileEntity.gameBoardTile;
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
	return self.outputPowerReceiver_isPowered;
}

#pragma mark - outputPowerReceiver_isPowered
@synthesize outputPowerReceiver_isPowered = _outputPowerReceiver_isPowered;
-(void)setOutputPowerReceiver_isPowered:(BOOL)outputPowerReceiver_isPowered
{
	kRUConditionalReturn(self.outputPowerReceiver_isPowered == outputPowerReceiver_isPowered, NO);

	_outputPowerReceiver_isPowered = outputPowerReceiver_isPowered;

	[self powerOutputTileEntity_providesPower_update];
}

#pragma mark - genericPowerOutputTileEntity
@synthesize outputPowerReceiver_genericPowerOutputTileEntity = _outputPowerReceiver_genericPowerOutputTileEntity;
-(void)setOutputPowerReceiver_genericPowerOutputTileEntity:(nullable SMBGenericPowerOutputTileEntity*)outputPowerReceiver_genericPowerOutputTileEntity
{
	kRUConditionalReturn(self.outputPowerReceiver_genericPowerOutputTileEntity == outputPowerReceiver_genericPowerOutputTileEntity, NO);

	[self outputPowerReceiver_genericPowerOutputTileEntity_setKVORegistered:NO];

	_outputPowerReceiver_genericPowerOutputTileEntity = outputPowerReceiver_genericPowerOutputTileEntity;

	[self outputPowerReceiver_genericPowerOutputTileEntity_setKVORegistered:YES];

	[self powerOutputTileEntity_gameBoardTile_update];
}

-(void)outputPowerReceiver_genericPowerOutputTileEntity_setKVORegistered:(BOOL)registered
{
	typeof(self.outputPowerReceiver_genericPowerOutputTileEntity) const outputPowerReceiver_genericPowerOutputTileEntity = self.outputPowerReceiver_genericPowerOutputTileEntity;
	kRUConditionalReturn(outputPowerReceiver_genericPowerOutputTileEntity == nil, NO);
	
	NSMutableArray<NSString*>* const propertiesToObserve = [NSMutableArray<NSString*> array];
	[propertiesToObserve addObject:[SMBGameBoardTileEntity_PropertiesForKVO gameBoardTile]];
	
	[propertiesToObserve enumerateObjectsUsingBlock:^(NSString * _Nonnull propertyToObserve, NSUInteger idx, BOOL * _Nonnull stop) {
		if (registered)
		{
			[outputPowerReceiver_genericPowerOutputTileEntity addObserver:self
															   forKeyPath:propertyToObserve
																  options:(NSKeyValueObservingOptionInitial)
																  context:&kSMBGenericPowerOutputTileEntity_OutputPowerReceiver_GameBoardTilePowerProvider__KVOContext];
		}
		else
		{
			[outputPowerReceiver_genericPowerOutputTileEntity removeObserver:self
																  forKeyPath:propertyToObserve
																	 context:&kSMBGenericPowerOutputTileEntity_OutputPowerReceiver_GameBoardTilePowerProvider__KVOContext];
		}
	}];
}

#pragma mark - KVO
-(void)observeValueForKeyPath:(nullable NSString*)keyPath ofObject:(nullable id)object change:(nullable NSDictionary*)change context:(nullable void*)context
{
	if (context == kSMBGenericPowerOutputTileEntity_OutputPowerReceiver_GameBoardTilePowerProvider__KVOContext)
	{
		if (self.outputPowerReceiver_genericPowerOutputTileEntity == object)
		{
			if ([keyPath isEqualToString:[SMBGameBoardTileEntity_PropertiesForKVO gameBoardTile]])
			{
				[self powerOutputTileEntity_gameBoardTile_update];
			}
			else
			{
				NSAssert(false, @"unhandled keyPath %@",keyPath);
			}
		}
		else
		{
			NSAssert(false, @"unhandled object %@",object);
		}
	}
	else
	{
		[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
	}
}

@end
