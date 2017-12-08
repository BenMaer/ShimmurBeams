//
//  SMBGameBoardTileEntitySpawnerManager.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 11/6/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import <Foundation/Foundation.h>





@class SMBGameBoardTileEntitySpawner;
@class SMBGameBoardTileEntity;





@interface SMBGameBoardTileEntitySpawnerManager : NSObject

#pragma mark - init
-(nullable instancetype)init_with_gameBoardTileEntitySpawners:(nullable NSArray<SMBGameBoardTileEntitySpawner*>*)gameBoardTileEntitySpawners NS_DESIGNATED_INITIALIZER;

#pragma mark - gameBoardTileEntitySpawners
@property (nonatomic, readonly, copy, nullable) NSArray<SMBGameBoardTileEntitySpawner*>* gameBoardTileEntitySpawners;

#pragma mark - gameBoardTileEntitySpawners
-(nullable SMBGameBoardTileEntitySpawner*)gameBoardTileEntitySpawner_for_entity:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity;

@end
