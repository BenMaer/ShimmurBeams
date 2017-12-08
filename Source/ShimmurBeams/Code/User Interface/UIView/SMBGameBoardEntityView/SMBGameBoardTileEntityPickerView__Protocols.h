//
//  SMBGameBoardTileEntityPickerView__Protocols.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 11/8/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardTileEntityPickerView__trashButton_types.h"

#import <Foundation/Foundation.h>





@class SMBGameBoardTileEntityPickerView;
@class SMBGameBoardTileEntitySpawner;





@protocol SMBGameBoardTileEntityPickerView__GameBoardTileEntitySpawner_TapDelegate <NSObject>

-(void)gameBoardTileEntityPickerView:(nonnull SMBGameBoardTileEntityPickerView*)gameBoardTileEntityPickerView
   didTap_gameBoardTileEntitySpawner:(nonnull SMBGameBoardTileEntitySpawner*)gameBoardTileEntitySpawner;

@end





@protocol SMBGameBoardTileEntityPickerView__TrashButton_TapDelegate <NSObject>

-(void)gameBoardTileEntityPickerView:(nonnull SMBGameBoardTileEntityPickerView*)gameBoardTileEntityPickerView
		didTap_trashButton_with_type:(SMBGameBoardTileEntityPickerView__trashButton_type)trashButton_type;

@end
