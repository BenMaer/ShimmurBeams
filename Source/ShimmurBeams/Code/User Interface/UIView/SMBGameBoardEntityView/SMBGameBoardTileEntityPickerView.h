//
//  SMBGameBoardTileEntityPickerView.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/9/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardTileEntityPickerView__Protocols.h"

#import <UIKit/UIKit.h>





@class SMBGameBoardTileEntity;





@interface SMBGameBoardTileEntityPickerView : UIView

#pragma mark - gameBoardTileEntities
@property (nonatomic, copy, nullable) NSArray<SMBGameBoardTileEntity*>* gameBoardTileEntities;

#pragma mark - selectedGameBoardTileEntity
@property (nonatomic, readonly, strong, nullable) SMBGameBoardTileEntity* selectedGameBoardTileEntity;

#pragma mark - selectedGameBoardTileEntityDelegate
@property (nonatomic, assign, nullable) id<SMBGameBoardTileEntityPickerView__selectedGameBoardTileEntityDelegate> selectedGameBoardTileEntityDelegate;

@end
