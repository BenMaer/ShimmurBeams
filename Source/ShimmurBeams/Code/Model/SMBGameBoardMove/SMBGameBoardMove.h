//
//  SMBGameBoardMove.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 12/20/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import <Foundation/Foundation.h>





@class SMBGameBoard;





@protocol SMBGameBoardMove <NSObject>

/**
 This method will attempt to perform this move on the gameboard.
 
 @param gameBoard The game board to perform the move on.
 @return If the move was successfully performed, this method returns YES. Otherwise, it returns NO.
 */
-(BOOL)move_perform_on_gameBoard:(nonnull SMBGameBoard*)gameBoard;

@end
