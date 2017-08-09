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

#pragma mark - gameBoardTileEntity
-(void)gameBoardTileEntity_add:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
					 to_column:(NSUInteger)column
						   row:(NSUInteger)row;

#pragma mark - gameBoardTileEntity_for_beamInteractions
-(void)gameBoardTileEntity_for_beamInteractions_set:(nonnull SMBGameBoardTileEntity*)moveableGameBoardTileEntity
										  to_column:(NSUInteger)column
												row:(NSUInteger)row;

@end
