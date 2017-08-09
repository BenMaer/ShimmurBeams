//
//  SMBGameBoardTileEntityPickerView__Protocols.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/9/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import <Foundation/Foundation.h>





@class SMBGameBoardTileEntityPickerView;
@class SMBGameBoardTileEntity;





@protocol SMBGameBoardTileEntityPickerView__selectedGameBoardTileEntityDelegate <NSObject>

-(void)gameBoardTileEntityPickerView:(nonnull SMBGameBoardTileEntityPickerView*)gameBoardTileEntityPickerView
	  did_select_gameBoardTileEntity:(nonnull SMBGameBoardTileEntity*)selectedGameBoardTileEntity;

@end
