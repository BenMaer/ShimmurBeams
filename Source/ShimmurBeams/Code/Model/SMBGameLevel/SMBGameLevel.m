//
//  SMBGameLevel.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/3/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameLevel.h"
#import "SMBGameBoard.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@interface SMBGameLevel ()

#pragma mark - usableGameBoardTileEntities
@property (nonatomic, copy, nullable) NSArray<SMBGameBoardTileEntity*>* usableGameBoardTileEntities;

@end





@implementation SMBGameLevel

#pragma mark - NSObject
-(instancetype)init
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wno-nullability-completeness"

	return [self init_with_gameBoard:nil
		 usableGameBoardTileEntities:nil];

#pragma clang diagnostic pop
}

#pragma mark - init
-(nullable instancetype)init_with_gameBoard:(nonnull SMBGameBoard*)gameBoard
				usableGameBoardTileEntities:(nullable NSArray<SMBGameBoardTileEntity*>*)usableGameBoardTileEntities
{
	kRUConditionalReturn_ReturnValueNil(gameBoard == nil, YES);

	if (self = [super init])
	{
		_gameBoard = gameBoard;
		[self.gameBoard setGameLevel:self];

		[self setUsableGameBoardTileEntities:usableGameBoardTileEntities];
	}

	return self;
}

@end





@implementation SMBGameLevel_PropertiesForKVO

+(nonnull NSString*)isComplete{return NSStringFromSelector(_cmd);}

@end
