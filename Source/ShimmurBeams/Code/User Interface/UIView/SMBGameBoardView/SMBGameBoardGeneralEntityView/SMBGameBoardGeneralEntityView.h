//
//  SMBGameBoardGeneralEntityView.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/11/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBDrawableObjectView.h"
#import "SMBMappedDataCollection_MappableObject.h"





@class SMBGameBoardGeneralEntity;





@interface SMBGameBoardGeneralEntityView : SMBDrawableObjectView <SMBMappedDataCollection_MappableObject>

#pragma mark - gameBoardGeneralEntity
-(nullable SMBGameBoardGeneralEntity*)gameBoardGeneralEntity;

#pragma mark - SMBDrawableObjectView: init
-(nullable instancetype)init_with_drawableObject:(nonnull SMBDrawableObject*)drawableObject OBJC_DEPRECATED("Must use init");

#pragma mark - init
-(nullable instancetype)init_with_gameBoardGeneralEntity:(nonnull SMBGameBoardGeneralEntity*)gameBoardGeneralEntity NS_DESIGNATED_INITIALIZER;

@end
