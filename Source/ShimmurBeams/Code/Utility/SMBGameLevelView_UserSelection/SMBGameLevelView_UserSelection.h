//
//  SMBGameLevelView_UserSelection.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 11/8/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import <Foundation/Foundation.h>





@class SMBGameBoardTileEntitySpawnerManager;
@class SMBGameBoardTileEntity;
@class SMBGameBoardTileEntitySpawner;
@class SMBGameBoardTile;





@interface SMBGameLevelView_UserSelection : NSObject

#pragma mark - init
-(nullable instancetype)init_with_gameBoardTileEntitySpawnerManager:(nonnull SMBGameBoardTileEntitySpawnerManager*)gameBoardTileEntitySpawnerManager
										selectedGameBoardTileEntity:(nonnull SMBGameBoardTileEntity*)selectedGameBoardTileEntity NS_DESIGNATED_INITIALIZER;

-(nullable instancetype)init_with_gameBoardTileEntitySpawnerManager:(nonnull SMBGameBoardTileEntitySpawnerManager*)gameBoardTileEntitySpawnerManager
								 selectedGameBoardTileEntitySpawner:(nonnull SMBGameBoardTileEntitySpawner*)selectedGameBoardTileEntitySpawner NS_DESIGNATED_INITIALIZER;

#pragma mark - selectedGameBoardTileEntity
@property (nonatomic, readonly, strong, nullable) SMBGameBoardTileEntity* selectedGameBoardTileEntity;

#pragma mark - selectedGameBoardTileEntitySpawner
@property (nonatomic, readonly, strong, nullable) SMBGameBoardTileEntitySpawner* selectedGameBoardTileEntitySpawner;

#pragma mark - selectedGameBoardTiles
@property (nonatomic, readonly, copy, nullable) NSSet<SMBGameBoardTile*>* selectedGameBoardTiles;

@end





@interface SMBGameLevelView_UserSelection_PropertiesForKVO : NSObject

+(nonnull NSString*)selectedGameBoardTiles;

@end
