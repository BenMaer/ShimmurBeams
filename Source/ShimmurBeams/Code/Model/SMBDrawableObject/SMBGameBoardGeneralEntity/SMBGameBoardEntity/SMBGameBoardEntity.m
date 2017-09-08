//
//  SMBGameBoardEntity.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/5/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardEntity.h"





@implementation SMBGameBoardEntity

#if DEBUG
#pragma mark - NSObject
-(void)dealloc
{
	NSAssert(self.gameBoard == nil, @"Should already be cleared");
	[self setGameBoard:nil];
}
#endif

@end
