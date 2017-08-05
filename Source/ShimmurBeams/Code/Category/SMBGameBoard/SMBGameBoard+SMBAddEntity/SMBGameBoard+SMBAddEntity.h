//
//  SMBGameBoard+SMBAddEntity.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/5/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoard.h"





@class SMBGameBoardEntity;





@interface SMBGameBoard (SMBAddEntity)

-(void)gameBoardEntity_add:(nonnull SMBGameBoardEntity*)gameBoardEntity
				 to_column:(NSUInteger)column
					   row:(NSUInteger)row;

@end
