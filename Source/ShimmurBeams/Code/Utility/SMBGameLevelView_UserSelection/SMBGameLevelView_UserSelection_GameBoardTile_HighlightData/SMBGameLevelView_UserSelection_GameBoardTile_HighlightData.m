//
//  SMBGameLevelView_UserSelection_GameBoardTile_HighlightData.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 11/8/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameLevelView_UserSelection_GameBoardTile_HighlightData.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/NSMutableArray+RUAddObjectIfNotNil.h>
#import <ResplendentUtilities/RUConstants.h>





@implementation SMBGameLevelView_UserSelection_GameBoardTile_HighlightData

#pragma mark - NSObject
-(instancetype)init
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);
	
#if __has_feature(nullability)
#pragma clang diagnostic push
#pragma GCC diagnostic ignored "-Wnullability-completeness"
#endif
	return [self init_with_gameBoardTile:nil
						  highlightColor:nil];
#if __has_feature(nullability)
#pragma clang diagnostic pop
#endif
}

-(nonnull NSString*)description
{
	NSMutableArray<NSString*>* const description_lines = [NSMutableArray<NSString*> array];
	[description_lines ru_addObjectIfNotNil:[super description]];
	[description_lines ru_addObjectIfNotNil:RUStringWithFormat(@"gameBoardTile: %@",self.gameBoardTile)];
	[description_lines ru_addObjectIfNotNil:RUStringWithFormat(@"highlightColor: %@",self.highlightColor)];

	return [description_lines componentsJoinedByString:@"\n"];
}

#pragma mark - init
-(nullable instancetype)init_with_gameBoardTile:(nonnull SMBGameBoardTile*)gameBoardTile
								 highlightColor:(nonnull UIColor*)highlightColor
{
	kRUConditionalReturn_ReturnValueNil(gameBoardTile == nil, YES);
	kRUConditionalReturn_ReturnValueNil(highlightColor == nil, YES);

	if (self = [super init])
	{
		_gameBoardTile = gameBoardTile;
		_highlightColor = highlightColor;
	}
	
	return self;
}

@end
