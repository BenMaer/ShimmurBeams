//
//  SMBGameBoardTilePosition.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/3/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardTilePosition.h"
#import "NSString+SMBColumnNames.h"
#import "NSString+SMBRowNames.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/RUClassOrNilUtil.h>
#import <ResplendentUtilities/RUConstants.h>
#import <ResplendentUtilities/NSMutableArray+RUAddObjectIfNotNil.h>





@implementation SMBGameBoardTilePosition

#pragma mark - NSObject
-(instancetype)init
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);

	return [self init_with_column:0
							  row:0];
}

-(nonnull NSString*)description
{
	NSMutableArray<NSString*>* const description_lines = [NSMutableArray<NSString*> array];
	[description_lines ru_addObjectIfNotNil:[super description]];
	[description_lines ru_addObjectIfNotNil:RUStringWithFormat(@"column %@",[NSString smb_columnName_for_columnIndex:self.column])];
	[description_lines ru_addObjectIfNotNil:RUStringWithFormat(@"row %@",[NSString smb_rowName_for_rowIndex:self.row])];
	
	return [description_lines componentsJoinedByString:@"\n"];
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
	kRUConditionalReturn_ReturnValueTrue(self == gameBoardTilePosition, NO);

	kRUConditionalReturn_ReturnValueFalse(__RUClassOrNilUtilFunction(gameBoardTilePosition, [self class]) == nil, YES);

	kRUConditionalReturn_ReturnValueFalse(self.column != gameBoardTilePosition.column, NO);
	kRUConditionalReturn_ReturnValueFalse(self.row != gameBoardTilePosition.row, NO);

	return YES;
}

#pragma mark - SMBMappedDataCollection_MappableObject
-(nonnull NSString*)smb_uniqueKey
{
	NSMutableArray<NSString*>* const strings = [NSMutableArray<NSString*> array];
	[strings addObject:RUStringWithFormat(@"%lu",(unsigned long)self.column)];
	[strings addObject:RUStringWithFormat(@"%lu",(unsigned long)self.row)];

	return [strings componentsJoinedByString:@"x"];
}

@end
