//
//  SMBGameBoardEntity.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/5/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardGeneralEntity.h"





@class SMBGameBoard;





@interface SMBGameBoardEntity : SMBGameBoardGeneralEntity

#pragma mark - gameBoard
@property (nonatomic, assign, nullable) SMBGameBoard* gameBoard;

@end
