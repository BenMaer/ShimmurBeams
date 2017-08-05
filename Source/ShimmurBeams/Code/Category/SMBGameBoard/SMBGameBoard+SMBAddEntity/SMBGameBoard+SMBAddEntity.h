//
//  SMBGameBoard+SMBAddEntity.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/5/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoard.h"





@class SMBGameBoardTileEntity;





@interface SMBGameBoard (SMBAddEntity)

-(void)gameBoardEntity_add:(nonnull SMBGameBoardTileEntity*)gameBoardEntity
				 to_column:(NSUInteger)column
					   row:(NSUInteger)row;

@end
