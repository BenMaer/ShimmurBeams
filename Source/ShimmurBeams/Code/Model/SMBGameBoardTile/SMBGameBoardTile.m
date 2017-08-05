//
//  SMBGameBoardTile.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/3/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardTile.h"

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

	if (self = [super init])
	{
		_gameBoardTilePosition = gameBoardTilePosition;
		_gameBoard = gameBoard;
	}

	return self;
}

@end





@implementation SMBGameBoardTile_PropertiesForKVO

+(nonnull NSString*)gameBoardEntity{return NSStringFromSelector(_cmd);}

@end
