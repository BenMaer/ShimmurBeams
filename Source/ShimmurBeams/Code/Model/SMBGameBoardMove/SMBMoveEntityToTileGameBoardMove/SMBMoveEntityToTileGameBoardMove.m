//
//  SMBMoveEntityToTileGameBoardMove.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 12/20/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBMoveEntityToTileGameBoardMove.h"
#import "SMBGameBoard+SMBAddEntity.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@interface SMBMoveEntityToTileGameBoardMove ()

#pragma mark - gameBoardTile
@property (nonatomic, readonly, strong, nullable) SMBGameBoardTilePosition* gameBoardTilePosition;

#pragma mark - gameBoardTileEntity
@property (nonatomic, readonly, strong, nullable) SMBGameBoardTileEntity* gameBoardTileEntity;

@end





@implementation SMBMoveEntityToTileGameBoardMove

#pragma mark - NSObject
-(nonnull instancetype)init
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);
	
#if __has_feature(nullability)
#pragma clang diagnostic push
#pragma GCC diagnostic ignored "-Wnullability-completeness"
#endif
	return [self init_with_gameBoardTilePosition:nil
							 gameBoardTileEntity:nil];
#if __has_feature(nullability)
#pragma clang diagnostic pop
#endif
}

#pragma mark - init
-(nullable instancetype)init_with_gameBoardTilePosition:(nonnull SMBGameBoardTilePosition*)gameBoardTilePosition
									gameBoardTileEntity:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
{
	kRUConditionalReturn_ReturnValueNil(gameBoardTilePosition == nil, YES);
	kRUConditionalReturn_ReturnValueNil(gameBoardTileEntity == nil, YES);

	if (self = [super init])
	{
		_gameBoardTilePosition = gameBoardTilePosition;
		_gameBoardTileEntity = gameBoardTileEntity;
	}

	return self;
}

#pragma mark - SMBGameBoardMove
-(BOOL)move_perform_on_gameBoard:(nonnull SMBGameBoard*)gameBoard
{
	kRUConditionalReturn_ReturnValueFalse(gameBoard == nil, YES);

	SMBGameBoardTilePosition* const gameBoardTilePosition = self.gameBoardTilePosition;
	kRUConditionalReturn_ReturnValueFalse(gameBoardTilePosition == nil, YES);

	SMBGameBoardTileEntity* const gameBoardTileEntity = self.gameBoardTileEntity;
	kRUConditionalReturn_ReturnValueFalse(gameBoardTileEntity == nil, YES);

	return
	[gameBoard gameBoardTileEntity_for_beamInteractions_set:gameBoardTileEntity
								   to_gameBoardTilePosition:gameBoardTilePosition];
}

@end
