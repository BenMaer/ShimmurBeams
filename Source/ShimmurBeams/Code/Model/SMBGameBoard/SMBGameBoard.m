//
//  SMBGameBoard.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/3/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoard.h"
#import "SMBGameBoardTile.h"
#import "SMBGameBoardTilePosition.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@interface SMBGameBoard ()

#pragma mark - gameBoardTiles
/**
 The first array will contain columns, and then the second array will contain each tile in the column. That way first index is x, similar to the standard x,y system.
 */
@property (nonatomic, copy, nullable) NSArray<NSArray<SMBGameBoardTile*>*>* gameBoardTiles;
-(nullable NSArray<NSArray<SMBGameBoardTile*>*>*)gameBoardTiles_generate_with_numberOfRows:(NSUInteger)numberOfRows
																		   numberOfColumns:(NSUInteger)numberOfColumns;

-(nullable NSArray<SMBGameBoardTile*>*)gameBoardTiles_column_at_column:(NSUInteger)column;

@end





@implementation SMBGameBoard

#pragma mark - NSObject
-(instancetype)init
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);

	return [self init_with_numberOfColumns:0
							  numberOfRows:0];
}

#pragma mark - init
-(nullable instancetype)init_with_numberOfColumns:(NSUInteger)numberOfColumns
									 numberOfRows:(NSUInteger)numberOfRows
{
	kRUConditionalReturn_ReturnValueNil(numberOfColumns <= 0, YES);
	kRUConditionalReturn_ReturnValueNil(numberOfRows <= 0, YES);

	if (self = [super init])
	{
		[self setGameBoardTiles:[self gameBoardTiles_generate_with_numberOfRows:numberOfRows
																numberOfColumns:numberOfColumns]];
	}

	return self;
}

#pragma mark - gameBoardTiles
-(nullable NSArray<NSArray<SMBGameBoardTile*>*>*)gameBoardTiles_generate_with_numberOfRows:(NSUInteger)numberOfRows
																		   numberOfColumns:(NSUInteger)numberOfColumns
{
	kRUConditionalReturn_ReturnValueNil(numberOfRows == 0, YES);
	kRUConditionalReturn_ReturnValueNil(numberOfColumns == 0, YES);

	NSMutableArray<NSArray<SMBGameBoardTile*>*>* const gameBoardTiles = [NSMutableArray<NSArray<SMBGameBoardTile*>*> array];

	for (NSUInteger column = 0;
		 column < numberOfColumns;
		 column++)
	{
		NSMutableArray<SMBGameBoardTile*>* const gameBoardTiles_column = [NSMutableArray<SMBGameBoardTile*> array];

		for (NSUInteger row = 0;
			 row < numberOfRows;
			 row++)
		{
			SMBGameBoardTile* const gameBoardTile =
			[[SMBGameBoardTile alloc] init_with_gameBoardTilePosition:
			 [[SMBGameBoardTilePosition alloc] init_with_column:column row:row]
			 ];

			[gameBoardTiles_column addObject:gameBoardTile];
		}

		[gameBoardTiles addObject:[NSArray<SMBGameBoardTile*> arrayWithArray:gameBoardTiles_column]];
	}

	return [NSArray<NSArray<SMBGameBoardTile*>*> arrayWithArray:gameBoardTiles];
}

-(nullable NSArray<SMBGameBoardTile*>*)gameBoardTiles_column_at_column:(NSUInteger)column
{
	NSArray<NSArray<SMBGameBoardTile*>*>* const gameBoardTiles = self.gameBoardTiles;
	kRUConditionalReturn_ReturnValueNil(gameBoardTiles == nil, YES);
	kRUConditionalReturn_ReturnValueNil(column >= gameBoardTiles.count, YES);

	return [gameBoardTiles objectAtIndex:column];
}

-(nullable SMBGameBoardTile*)gameBoardTile_at_position:(nonnull SMBGameBoardTilePosition*)position
{
	kRUConditionalReturn_ReturnValueNil(position == nil, YES);

	NSArray<SMBGameBoardTile*>* const gameBoardTiles_column = [self gameBoardTiles_column_at_column:position.column];
	kRUConditionalReturn_ReturnValueNil(gameBoardTiles_column == nil, YES);

	NSUInteger const row = position.row;
	kRUConditionalReturn_ReturnValueNil(row >= gameBoardTiles_column.count, YES);

	SMBGameBoardTile* const gameBoardTile = [gameBoardTiles_column objectAtIndex:row];
	kRUConditionalReturn_ReturnValueNil([gameBoardTile.gameBoardTilePosition isEqual_to_gameBoardTilePosition:position] == false, YES);

	return gameBoardTile;
}

@end
