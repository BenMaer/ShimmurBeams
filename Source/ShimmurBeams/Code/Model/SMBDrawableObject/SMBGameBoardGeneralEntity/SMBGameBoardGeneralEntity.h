//
//  SMBGameBoardGeneralEntity.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/7/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBDrawableObject.h"
#import "SMBMappedDataCollection_MappableObject.h"

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>





@class SMBGameBoardView;





@interface SMBGameBoardGeneralEntity : SMBDrawableObject <SMBMappedDataCollection_MappableObject, NSCoding>

#pragma mark - uniqueId
@property (nonatomic, readonly, copy, nonnull) NSString* uniqueId;

@end
