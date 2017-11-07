//
//  SMBGameBoardTileEntityPickerView.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/9/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import <UIKit/UIKit.h>





@class SMBGameBoardTileEntitySpawner;





@interface SMBGameBoardTileEntityPickerView : UIView

#pragma mark - gameBoardTileEntitySpawners
@property (nonatomic, copy, nullable) NSArray<SMBGameBoardTileEntitySpawner*>* gameBoardTileEntitySpawners;

#pragma mark - selectedGameBoardTileEntitySpawner
@property (nonatomic, strong, nullable) SMBGameBoardTileEntitySpawner* selectedGameBoardTileEntitySpawner;

//#pragma mark - selectedGameBoardTileEntity
//@property (nonatomic, strong, nullable) SMBGameBoardTileEntitySpawner* selectedGameBoardTileEntity;

@end





@interface SMBGameBoardTileEntityPickerView_PropertiesForKVO : NSObject

+(nonnull NSString*)selectedGameBoardTileEntitySpawner;

@end
