//
//  SMBGameBoardGeneralEntityView.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/4/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBMappedDataCollection_MappableObject.h"

#import <UIKit/UIKit.h>





@class SMBGameBoardView;
@class SMBGameBoardGeneralEntity;





@interface SMBGameBoardGeneralEntityView : UIView <SMBMappedDataCollection_MappableObject>

#pragma mark - gameBoardGeneralEntity
@property (nonatomic, readonly, strong, nullable) SMBGameBoardGeneralEntity* gameBoardGeneralEntity;

#pragma mark - init
-(nullable instancetype)init_with_gameBoardGeneralEntity:(nonnull SMBGameBoardGeneralEntity*)gameBoardGeneralEntity NS_DESIGNATED_INITIALIZER;

@end
