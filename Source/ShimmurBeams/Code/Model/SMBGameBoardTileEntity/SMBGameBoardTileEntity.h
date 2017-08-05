//
//  SMBGameBoardTileEntity.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/4/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardTileEntity__orientations.h"

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>





@class SMBGameBoardTile;





@interface SMBGameBoardTileEntity : NSObject

#pragma mark - uniqueEntityId
@property (nonatomic, readonly, strong, nullable) NSString* uniqueEntityId;

#pragma mark - orientation
@property (nonatomic, assign) SMBGameBoardTileEntity__orientation orientation;

#pragma mark - gameBoardTile
@property (nonatomic, assign, nullable) SMBGameBoardTile* gameBoardTile;

#pragma mark - draw
@property (nonatomic, assign) BOOL needsRedraw;
-(void)draw_in_rect:(CGRect)rect;

#pragma mark - entityAction
-(void)entityAction_setup;

@end





@interface SMBGameBoardTileEntity_PropertiesForKVO : NSObject

+(nonnull NSString*)gameBoardEntity;
+(nonnull NSString*)needsRedraw;

@end
