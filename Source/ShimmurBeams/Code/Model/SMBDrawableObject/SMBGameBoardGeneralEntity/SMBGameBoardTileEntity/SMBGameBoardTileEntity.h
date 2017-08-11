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
 
 Make sure not to first set `gameBoardTile` on this instance before already adding this instance to the tile.
 Make sure this instance doesn't already have a game board tile when setting to a new tile. If it does, make sure to remove this instance from its current game tile, before adding it to another.
 */
@interface SMBGameBoardTileEntity : SMBGameBoardGeneralEntity

#pragma mark - gameBoardTile
@property (nonatomic, assign, nullable) SMBGameBoardTile* gameBoardTile;

@end





@interface SMBGameBoardTileEntity_PropertiesForKVO : NSObject

+(nonnull NSString*)needsRedraw;

@end
