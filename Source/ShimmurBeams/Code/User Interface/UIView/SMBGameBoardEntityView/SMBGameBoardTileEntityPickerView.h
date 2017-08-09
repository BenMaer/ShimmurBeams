//
//  SMBGameBoardTileEntityPickerView.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/9/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import <UIKit/UIKit.h>





@class SMBGameBoardTileEntity;





@interface SMBGameBoardTileEntityPickerView : UIView

#pragma mark - gameBoardTileEntities
@property (nonatomic, copy, nullable) NSArray<SMBGameBoardTileEntity*>* gameBoardTileEntities;

#pragma mark - selectedGameBoardTileEntity
@property (nonatomic, strong, nullable) SMBGameBoardTileEntity* selectedGameBoardTileEntity;

@end





@interface SMBGameBoardTileEntityPickerView_PropertiesForKVO : NSObject

+(nonnull NSString*)selectedGameBoardTileEntity;

@end
