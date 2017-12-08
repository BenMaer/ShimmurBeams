//
//  SMBGameBoardTileEntitySpawner+SMBInitMethods.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 11/14/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardTileEntitySpawner+SMBInitMethods.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@implementation SMBGameBoardTileEntitySpawner (SMBInitMethods)

#pragma mark - init
+(nullable NSArray<SMBGameBoardTileEntitySpawner*>*)smb_gameBoardTileEntitySpawners_with_spawnedGameBoardTileEntities_tracked_maximum:(NSUInteger)spawnedGameBoardTileEntities_tracked_maximum
																													spawnEntityBlocks:(nonnull NSArray<SMBGameBoardTileEntitySpawner_spawnEntityBlock>*)spawnEntityBlocks
{
	kRUConditionalReturn_ReturnValueNil(spawnEntityBlocks == nil, YES);

	NSMutableArray<SMBGameBoardTileEntitySpawner*>* const gameBoardTileEntitySpawners = [NSMutableArray<SMBGameBoardTileEntitySpawner*> array];
	[spawnEntityBlocks enumerateObjectsUsingBlock:^(SMBGameBoardTileEntitySpawner_spawnEntityBlock  _Nonnull gameBoardTileEntitySpawner_spawnEntityBlock, NSUInteger idx, BOOL * _Nonnull stop) {
		SMBGameBoardTileEntitySpawner* const gameBoardTileEntitySpawner =
		[[SMBGameBoardTileEntitySpawner alloc] init_with_spawnedGameBoardTileEntities_tracked_maximum:spawnedGameBoardTileEntities_tracked_maximum
																					 spawnEntityBlock:gameBoardTileEntitySpawner_spawnEntityBlock];
		kRUConditionalReturn(gameBoardTileEntitySpawner == nil, YES);

		[gameBoardTileEntitySpawners addObject:gameBoardTileEntitySpawner];
	}];

	return [NSArray<SMBGameBoardTileEntitySpawner*> arrayWithArray:gameBoardTileEntitySpawners];;
}

@end
