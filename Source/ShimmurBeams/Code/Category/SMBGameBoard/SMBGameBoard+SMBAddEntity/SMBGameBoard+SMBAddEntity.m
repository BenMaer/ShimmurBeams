//
//  SMBGameBoard+SMBAddEntity.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/5/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoard+SMBAddEntity.h"
#import "SMBGameBoardTile.h"
#import "SMBGameBoardTilePosition.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@implementation SMBGameBoard (SMBAddEntity)

-(void)gameBoardEntity_add:(nonnull SMBGameBoardTileEntity*)gameBoardEntity
				 to_column:(NSUInteger)column
					   row:(NSUInteger)row
{
	kRUConditionalReturn(gameBoardEntity == nil, YES);

	SMBGameBoardTile* const gameBoardTile =
	[self gameBoardTile_at_position:[[SMBGameBoardTilePosition alloc] init_with_column:column row:row]];

	[gameBoardTile setGameBoardTileEntity:gameBoardEntity];
}

@end
