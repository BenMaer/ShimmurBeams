//
//  SMBGameLevel.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/3/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import <Foundation/Foundation.h>





@class SMBGameBoard;
@class SMBGameBoardTileEntity;





@interface SMBGameLevel : NSObject

#pragma mark - gameBoard
@property (nonatomic, readonly, strong, nullable) SMBGameBoard* gameBoard;

#pragma mark - usableGameBoardTileEntities
@property (nonatomic, readonly, copy, nullable) NSArray<SMBGameBoardTileEntity*>* usableGameBoardTileEntities;

#pragma mark - init
-(nullable instancetype)init_with_gameBoard:(nonnull SMBGameBoard*)gameBoard
				usableGameBoardTileEntities:(nullable NSArray<SMBGameBoardTileEntity*>*)usableGameBoardTileEntities NS_DESIGNATED_INITIALIZER;

#pragma mark - isComplete
@property (nonatomic, assign) BOOL isComplete;

@end





@interface SMBGameLevel_PropertiesForKVO : NSObject

+(nonnull NSString*)isComplete;

@end
