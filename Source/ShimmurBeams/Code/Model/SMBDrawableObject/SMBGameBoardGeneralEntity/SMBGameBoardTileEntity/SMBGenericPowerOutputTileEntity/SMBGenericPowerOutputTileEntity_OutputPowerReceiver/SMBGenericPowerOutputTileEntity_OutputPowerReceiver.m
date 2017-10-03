//
//  SMBGenericPowerOutputTileEntity_OutputPowerReceiver.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 10/2/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGenericPowerOutputTileEntity_OutputPowerReceiver.h"
#import "SMBGameBoard.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/NSMutableArray+RUAddObjectIfNotNil.h>
#import <ResplendentUtilities/RUConstants.h>





@interface SMBGenericPowerOutputTileEntity_OutputPowerReceiver ()

#pragma mark - gameBoard
-(void)gameBoard_removeFrom:(nonnull SMBGameBoard*)gameBoard;
-(void)gameBoard_addTo;

@end





@implementation SMBGenericPowerOutputTileEntity_OutputPowerReceiver

#pragma mark - NSObject
-(void)dealloc
{
	NSAssert(self.gameBoard == nil, @"should have been set to nil externally by SMBGameBoard by now.");
	[self setGameBoard:nil];
}

-(nonnull NSString*)description
{
	NSMutableArray<NSString*>* const description_lines = [NSMutableArray<NSString*> array];
	[description_lines ru_addObjectIfNotNil:[super description]];
	[description_lines ru_addObjectIfNotNil:RUStringWithFormat(@"isPowered: %i",self.isPowered)];
	[description_lines ru_addObjectIfNotNil:RUStringWithFormat(@"gameBoard: %@",self.gameBoard)];
	
	return [description_lines componentsJoinedByString:@"\n"];
}

#pragma mark - gameBoard
-(void)setGameBoard:(nullable SMBGameBoard*)gameBoard
{
	kRUConditionalReturn(self.gameBoard == gameBoard, NO);

	SMBGameBoard* const gameBoard_old = self.gameBoard;
	_gameBoard = gameBoard;

	if (gameBoard_old)
	{
		[self gameBoard_removeFrom:gameBoard_old];
	}

	if (gameBoard)
	{
		[self gameBoard_addTo];
	}
}

-(void)gameBoard_removeFrom:(nonnull SMBGameBoard*)gameBoard
{
	kRUConditionalReturn(gameBoard == nil, YES);

	[gameBoard outputPowerReceiver_remove:self];
}

-(void)gameBoard_addTo
{
	SMBGameBoard* const gameBoard = self.gameBoard;
	kRUConditionalReturn(gameBoard == nil, YES);

	[gameBoard outputPowerReceiver_add:self];
}

@end
