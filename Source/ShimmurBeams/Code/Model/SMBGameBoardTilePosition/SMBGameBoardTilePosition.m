//
//  SMBGameBoardTilePosition.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/3/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardTilePosition.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/RUClassOrNilUtil.h>





@implementation SMBGameBoardTilePosition

#pragma mark - NSObject
-(instancetype)init
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);

	return [self init_with_column:0
							  row:0];
}

#pragma mark - init
-(instancetype)init_with_column:(NSUInteger)column
							row:(NSUInteger)row
{
	if (self = [super init])
	{
		_column = column;
		_row = row;
	}

	return self;
}

#pragma mark - gameBoardTilePosition
-(BOOL)isEqual_to_gameBoardTilePosition:(nullable SMBGameBoardTilePosition*)gameBoardTilePosition
{
	kRUConditionalReturn_ReturnValueFalse(gameBoardTilePosition == nil, YES);
	kRUConditionalReturn_ReturnValueTrue(self == gameBoardTilePosition == false, NO);

	kRUConditionalReturn_ReturnValueFalse(__RUClassOrNilUtilFunction(gameBoardTilePosition, [self class]) == nil, YES);

	kRUConditionalReturn_ReturnValueFalse(self.column != gameBoardTilePosition.column, NO);
	kRUConditionalReturn_ReturnValueFalse(self.row != gameBoardTilePosition.row, NO);

	return YES;
}

@end
