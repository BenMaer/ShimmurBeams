//
//  SMBGameLevel.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/3/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameLevel.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@implementation SMBGameLevel

#pragma mark - NSObject
-(instancetype)init
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wno-nullability-completeness"

	return [self init_with_gameBoard:nil];

#pragma clang diagnostic pop
}

#pragma mark - init
-(nullable instancetype)init_with_gameBoard:(nonnull SMBGameBoard*)gameBoard
{
	kRUConditionalReturn_ReturnValueNil(gameBoard == nil, YES);

	if (self = [super init])
	{
		_gameBoard = gameBoard;
	}

	return self;
}

@end
