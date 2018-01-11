//
//  SMBRemoveEntityFromTileGameBoardMove.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 1/11/18.
//  Copyright © 2018 Shimmur. All rights reserved.
//

#import "SMBRemoveEntityFromTileGameBoardMove.h"
#import "SMBGameBoardTileEntity.h"
#import "SMBGameBoardTile.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@interface SMBRemoveEntityFromTileGameBoardMove ()

#pragma mark - gameBoardTileEntity
@property (nonatomic, readonly, strong, nullable) SMBGameBoardTileEntity* gameBoardTileEntity;

@end





@implementation SMBRemoveEntityFromTileGameBoardMove

#pragma mark - NSObject
-(nonnull instancetype)init
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);

#if __has_feature(nullability)
#pragma clang diagnostic push
#pragma GCC diagnostic ignored "-Wnullability-completeness"
#endif
	return [self init_with_gameBoardTileEntity:nil];
#if __has_feature(nullability)
#pragma clang diagnostic pop
#endif
}

#pragma mark - init
-(nullable instancetype)init_with_gameBoardTileEntity:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
{
	kRUConditionalReturn_ReturnValueNil(gameBoardTileEntity == nil, YES);

	if (self = [super init])
	{
		_gameBoardTileEntity = gameBoardTileEntity;
	}

	return self;
}

#pragma mark - SMBGameBoardMove
-(BOOL)move_perform_on_gameBoard:(nonnull SMBGameBoard*)gameBoard
{
	kRUConditionalReturn_ReturnValueFalse(gameBoard == nil, YES);

	SMBGameBoardTileEntity* const gameBoardTileEntity = self.gameBoardTileEntity;
	kRUConditionalReturn_ReturnValueFalse(gameBoardTileEntity == nil, YES);

	SMBGameBoardTile* const gameBoardTile = gameBoardTileEntity.gameBoardTile;
	kRUConditionalReturn_ReturnValueFalse(gameBoardTile == nil, YES);

	return
	[gameBoardTile gameBoardTileEntities_remove:gameBoardTileEntity entityType:SMBGameBoardTile__entityType_beamInteractions];
}

@end
