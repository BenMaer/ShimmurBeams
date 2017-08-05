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





/**
 Instances of `SMBGameBoardEntity` should be added to a game board tile.
 */
@interface SMBGameBoardEntity : NSObject

#pragma mark - orientation
@property (nonatomic, assign) SMBGameBoardEntity__orientation orientation;

#pragma mark - draw
-(void)drawRect:(CGRect)rect;

@end
