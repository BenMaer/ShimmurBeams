//
//  SMBGameBoardGeneralEntity.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/7/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBMappedDataCollection_MappableObject.h"

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>





@interface SMBGameBoardGeneralEntity : NSObject <SMBMappedDataCollection_MappableObject>

#pragma mark - uniqueId
@property (nonatomic, readonly, strong, nullable) NSString* uniqueId;

#pragma mark - draw
@property (nonatomic, assign) BOOL needsRedraw;
-(void)draw_in_rect:(CGRect)rect;

@end
