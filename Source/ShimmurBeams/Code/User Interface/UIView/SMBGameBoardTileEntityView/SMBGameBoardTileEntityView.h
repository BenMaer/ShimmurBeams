//
//  SMBGameBoardTileEntityView.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/4/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBMappedDataCollection_MappableObject.h"

#import <UIKit/UIKit.h>





@class SMBGameBoardTileEntity;





@interface SMBGameBoardTileEntityView : UIView <SMBMappedDataCollection_MappableObject>

#pragma mark - gameBoardEntity
@property (nonatomic, readonly, strong, nullable) SMBGameBoardTileEntity* gameBoardEntity;

#pragma mark - init
-(nullable instancetype)init_with_gameBoardEntity:(nonnull SMBGameBoardTileEntity*)gameBoardEntity NS_DESIGNATED_INITIALIZER;

@end
