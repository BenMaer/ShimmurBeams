//
//  SMBGameBoardTileEntityPickerViewCollectionViewCell.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/9/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import <UIKit/UIKit.h>





@class SMBGameBoardTileEntity;





@interface SMBGameBoardTileEntityPickerViewCollectionViewCell : UICollectionViewCell

#pragma mark - gameBoardTileEntity
@property (nonatomic, strong, nullable) SMBGameBoardTileEntity* gameBoardTileEntity;
@property (nonatomic, assign) BOOL gameBoardTileEntity_isSelected;

@end
