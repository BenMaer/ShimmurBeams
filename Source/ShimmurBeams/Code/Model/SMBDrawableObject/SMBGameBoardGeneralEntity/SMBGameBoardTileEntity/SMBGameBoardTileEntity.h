//
//  SMBGameBoardTileEntity.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/4/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardGeneralEntity.h"

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>





@class SMBGameBoardTile;





/**
 When adding a `SMBGameBoardTileEntity` instance to a tile:
 1) Add entity to the tile using on the the tile's properties:
 `gameBoardTileEntity_for_beamInteractions`
 `gameBoardTileEntities`
 
 The `SMBGameBoardTile` instance will set the `gameBoardTile` property on this `SMBGameBoardTileEntity` instance automatically. Don't set this ` 
 */
@interface SMBGameBoardTileEntity : SMBGameBoardGeneralEntity

#pragma mark - gameBoardTile
/**
 When this is set to a non nil value, it should already be added to the game board tile.
 When this is set to a nil value, it should already be removed from the game board tile.
 */
@property (nonatomic, assign, nullable) SMBGameBoardTile* gameBoardTile;

@end





@interface SMBGameBoardTileEntity_PropertiesForKVO : NSObject

+(nonnull NSString*)needsRedraw;
+(nonnull NSString*)gameBoardTile;

@end
