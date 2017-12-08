//
//  SMBGameBoardTileEntityPickerView__trashButton_types.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 11/8/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#ifndef SMBGameBoardTileEntityPickerView__trashButton_types_h
#define SMBGameBoardTileEntityPickerView__trashButton_types_h

#import <Foundation/Foundation.h>





typedef NS_ENUM(NSInteger, SMBGameBoardTileEntityPickerView__trashButton_type) {
	SMBGameBoardTileEntityPickerView__trashButton_type_none,
	SMBGameBoardTileEntityPickerView__trashButton_type_clearBoard,
	SMBGameBoardTileEntityPickerView__trashButton_type_remove,
	
	SMBGameBoardTileEntityPickerView__trashButton_type__first	= SMBGameBoardTileEntityPickerView__trashButton_type_clearBoard,
	SMBGameBoardTileEntityPickerView__trashButton_type__last	= SMBGameBoardTileEntityPickerView__trashButton_type_remove,
};

#endif /* SMBGameBoardTileEntityPickerView__trashButton_types_h */
