//
//  SMBGameBoardTileEntitySpawner+SMBInitMethods.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 11/14/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardTileEntitySpawner.h"





@interface SMBGameBoardTileEntitySpawner (SMBInitMethods)

#pragma mark - init
+(nullable NSArray<SMBGameBoardTileEntitySpawner*>*)smb_gameBoardTileEntitySpawners_with_spawnedGameBoardTileEntities_tracked_maximum:(NSUInteger)spawnedGameBoardTileEntities_tracked_maximum
																													spawnEntityBlocks:(nonnull NSArray<SMBGameBoardTileEntitySpawner_spawnEntityBlock>*)spawnEntityBlocks;

@end
