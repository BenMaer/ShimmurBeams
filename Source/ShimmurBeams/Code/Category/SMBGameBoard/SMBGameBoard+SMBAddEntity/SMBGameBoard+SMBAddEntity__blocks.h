//
//  SMBGameBoard+SMBAddEntity__blocks.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/15/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#ifndef SMBGameBoard_SMBAddEntity__blocks_h
#define SMBGameBoard_SMBAddEntity__blocks_h

#import <Foundation/Foundation.h>





@class SMBGameBoardTileEntity;
@class SMBGameBoardTilePosition;





typedef SMBGameBoardTileEntity* _Nullable(^SMBGameBoard_addEntity_createTileEntityAtPosition_block)(SMBGameBoardTilePosition* _Nonnull position);

#endif /* SMBGameBoard_SMBAddEntity__blocks_h */
