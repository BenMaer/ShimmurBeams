//
//  SMBGameBoardEntity.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/4/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardEntity__orientations.h"

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>





@class SMBGameBoardTile;





@interface SMBGameBoardEntity : NSObject

#pragma mark - uniqueEntityId
@property (nonatomic, readonly, strong, nullable) NSString* uniqueEntityId;

#pragma mark - orientation
@property (nonatomic, assign) SMBGameBoardEntity__orientation orientation;

#pragma mark - gameBoardTile
@property (nonatomic, assign, nullable) SMBGameBoardTile* gameBoardTile;

#pragma mark - draw
-(void)drawRect:(CGRect)rect;

@end





@interface SMBGameBoardEntity_PropertiesForKVO : NSObject

+(nonnull NSString*)gameBoardEntity;

@end
