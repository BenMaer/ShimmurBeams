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
@class SMBGameLevelView_UserSelection_GameBoardTile_HighlightData;





@interface SMBGameLevelView_UserSelection : NSObject

#pragma mark - init
-(nullable instancetype)init_with_gameBoardTileEntitySpawnerManager:(nonnull SMBGameBoardTileEntitySpawnerManager*)gameBoardTileEntitySpawnerManager
										selectedGameBoardTileEntity:(nonnull SMBGameBoardTileEntity*)selectedGameBoardTileEntity NS_DESIGNATED_INITIALIZER;

-(nullable instancetype)init_with_gameBoardTileEntitySpawnerManager:(nonnull SMBGameBoardTileEntitySpawnerManager*)gameBoardTileEntitySpawnerManager
								 selectedGameBoardTileEntitySpawner:(nonnull SMBGameBoardTileEntitySpawner*)selectedGameBoardTileEntitySpawner NS_DESIGNATED_INITIALIZER;

#pragma mark - selectedGameBoardTileEntity
-(nullable SMBGameBoardTileEntity*)selectedGameBoardTileEntity;

#pragma mark - selectedGameBoardTileEntitySpawner
-(nullable SMBGameBoardTileEntitySpawner*)selectedGameBoardTileEntitySpawner;

#pragma mark - selectedGameBoardTiles_HighlightData
-(nullable NSSet<SMBGameLevelView_UserSelection_GameBoardTile_HighlightData*>*)selectedGameBoardTiles_HighlightData;

@end





@interface SMBGameLevelView_UserSelection_PropertiesForKVO : NSObject

+(nonnull NSString*)selectedGameBoardTiles_HighlightData;

@end
