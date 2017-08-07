//
//  SMBGameBoardEntity.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/5/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>





@interface SMBGameBoardEntity : NSObject

#pragma mark - uniqueTileId
@property (nonatomic, readonly, strong, nullable) NSString* uniqueTileId;

#pragma mark - draw
@property (nonatomic, assign) BOOL needsRedraw;
-(void)draw_in_rect:(CGRect)rect;

@end
