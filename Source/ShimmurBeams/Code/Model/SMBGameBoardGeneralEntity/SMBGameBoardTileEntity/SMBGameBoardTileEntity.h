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





@interface SMBGameBoardTileEntity : SMBGameBoardGeneralEntity

#pragma mark - gameBoardTile
@property (nonatomic, assign, nullable) SMBGameBoardTile* gameBoardTile;

@end





@interface SMBGameBoardTileEntity_PropertiesForKVO : NSObject

+(nonnull NSString*)needsRedraw;

@end
