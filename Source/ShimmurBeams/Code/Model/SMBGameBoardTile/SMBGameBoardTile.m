//
//  SMBGameBoardTile.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/3/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardTile.h"
#import "SMBGameBoardTileEntity.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@implementation SMBGameBoardTile

#pragma mark - NSObject
-(instancetype)init
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wno-nullability-completeness"
	return [self init_with_gameBoardTilePosition:nil
									   gameBoard:nil];
#pragma clang diagnostic pop
}

#pragma mark - init
-(nullable instancetype)init_with_gameBoardTilePosition:(nonnull SMBGameBoardTilePosition*)gameBoardTilePosition
											  gameBoard:(nonnull SMBGameBoard*)gameBoard
{
	kRUConditionalReturn_ReturnValueNil(gameBoardTilePosition == nil, YES);
	kRUConditionalReturn_ReturnValueNil(gameBoard == nil, YES);

	if (self = [super init])
	{
		_gameBoardTilePosition = gameBoardTilePosition;
		_gameBoard = gameBoard;
	}

	return self;
}

#pragma mark - gameBoardTileEntity
-(void)setGameBoardTileEntity:(nullable SMBGameBoardTileEntity*)gameBoardTileEntity
{
	kRUConditionalReturn(self.gameBoardTileEntity == gameBoardTileEntity, NO);

	_gameBoardTileEntity = gameBoardTileEntity;

	if (self.gameBoardTileEntity)
	{
		if (self.gameBoardTileEntity.gameBoardTile != self)
		{
			[self.gameBoardTileEntity setGameBoardTile:self];
		}
	}
}

@end





@implementation SMBGameBoardTile_PropertiesForKVO

+(nonnull NSString*)gameBoardTileEntity{return NSStringFromSelector(_cmd);}

@end
