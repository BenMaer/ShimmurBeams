//
//  SMBGameBoardTileEntitySpawnerCollectionViewCell.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 11/6/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import <UIKit/UIKit.h>





@class SMBGameBoardTileEntitySpawner;





@interface SMBGameBoardTileEntitySpawnerPickerCollectionViewCell : UICollectionViewCell

#pragma mark - gameBoardTileEntitySpawner
@property (nonatomic, strong, nullable) SMBGameBoardTileEntitySpawner* gameBoardTileEntitySpawner;
@property (nonatomic, assign) BOOL gameBoardTileEntitySpawner_isSelected;

@end
