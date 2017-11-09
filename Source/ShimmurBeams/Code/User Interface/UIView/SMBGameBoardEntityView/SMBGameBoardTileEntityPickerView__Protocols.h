//
//  SMBGameBoardTileEntityPickerView__Protocols.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 11/8/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import <Foundation/Foundation.h>





@class SMBGameBoardTileEntityPickerView;
@class SMBGameBoardTileEntitySpawner;





@protocol SMBGameBoardTileEntityPickerView__GameBoardTileEntitySpawner_TapDelegate <NSObject>

-(void)gameBoardTileEntityPickerView:(nonnull SMBGameBoardTileEntityPickerView*)gameBoardTileEntityPickerView
   didTap_gameBoardTileEntitySpawner:(nonnull SMBGameBoardTileEntitySpawner*)gameBoardTileEntitySpawner;

@end
