//
//  SMBGameLevel.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/3/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import <Foundation/Foundation.h>





@class SMBGameBoard;





@interface SMBGameLevel : NSObject

#pragma mark - gameBoard
@property (nonatomic, readonly, strong, nullable) SMBGameBoard* gameBoard;

#pragma mark - init
-(nullable instancetype)init_with_gameBoard:(nonnull SMBGameBoard*)gameBoard NS_DESIGNATED_INITIALIZER;

@end
