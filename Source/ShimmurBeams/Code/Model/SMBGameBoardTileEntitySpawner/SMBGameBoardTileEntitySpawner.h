//
//  SMBGameBoardTileEntitySpawner.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 11/6/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardTileEntitySpawner__Blocks.h"

#import <Foundation/Foundation.h>





@class SMBGameBoardTile;
@class SMBGameBoardTileEntity;





/**
 Entities are added using `gameBoardTileEntity_spawnNew_tracked_on_gameBoardTile:`.
 Entities are removed by removing them from the game board tile.
 */
@interface SMBGameBoardTileEntitySpawner : NSObject

#pragma mark - gameBoardTileEntities
-(nullable SMBGameBoardTileEntity*)gameBoardTileEntity_spawnNew_tracked_on_gameBoardTile:(nonnull SMBGameBoardTile*)gameBoardTile;
-(nullable SMBGameBoardTileEntity*)gameBoardTileEntity_spawnNew_untracked;

#pragma mark - gameBoardTileEntities_spawned
@property (nonatomic, readonly, assign) NSUInteger gameBoardTileEntities_maximum;
@property (nonatomic, readonly, copy, nullable) NSArray<SMBGameBoardTileEntity*>* gameBoardTileEntities_spawned;
-(BOOL)gameBoardTileEntities_spawned_atCapacity;

#pragma mark - init
-(nullable instancetype)init_with_gameBoardTileEntities_maximum:(NSUInteger)gameBoardTileEntities_maximum
											   spawnEntityBlock:(nonnull SMBGameBoardTileEntitySpawner_spawnEntityBlock)spawnEntityBlock NS_DESIGNATED_INITIALIZER;

@end





@interface SMBGameBoardTileEntitySpawner_PropertiesForKVO : NSObject

+(nonnull NSString*)gameBoardTileEntities_spawned;

@end
