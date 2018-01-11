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

#pragma mark - NSObject
+(nonnull instancetype)new NS_UNAVAILABLE;
-(nonnull instancetype)init NS_UNAVAILABLE;

#pragma mark - init
-(nullable instancetype)init_with_spawnedGameBoardTileEntities_tracked_maximum:(NSUInteger)spawnedGameBoardTileEntities_tracked_maximum
															  spawnEntityBlock:(nonnull SMBGameBoardTileEntitySpawner_spawnEntityBlock)spawnEntityBlock NS_DESIGNATED_INITIALIZER;

#pragma mark - gameBoardTileEntities
-(nullable SMBGameBoardTileEntity*)gameBoardTileEntity_spawnNew_tracked_on_gameBoardTile:(nonnull SMBGameBoardTile*)gameBoardTile;
-(nullable SMBGameBoardTileEntity*)gameBoardTileEntity_spawnNew_untracked;

#pragma mark - spawnedGameBoardTileEntities_tracked
@property (nonatomic, readonly, assign) NSUInteger spawnedGameBoardTileEntities_tracked_maximum;
@property (nonatomic, readonly, copy, nullable) NSArray<SMBGameBoardTileEntity*>* spawnedGameBoardTileEntities_tracked;
-(BOOL)spawnedGameBoardTileEntities_tracked_atCapacity;

@end





@interface SMBGameBoardTileEntitySpawner_PropertiesForKVO : NSObject

+(nonnull NSString*)spawnedGameBoardTileEntities_tracked;

@end
