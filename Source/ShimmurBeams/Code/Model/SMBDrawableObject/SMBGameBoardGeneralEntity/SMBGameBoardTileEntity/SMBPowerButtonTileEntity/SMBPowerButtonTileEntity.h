//
//  SMBPowerButtonTileEntity.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/18/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardTileEntity.h"





@class SMBGameBoardTilePosition;





@interface SMBPowerButtonTileEntity : SMBGameBoardTileEntity

#pragma mark - gameBoardTilePosition_toPower
@property (nonatomic, readonly, strong, nullable) SMBGameBoardTilePosition* gameBoardTilePosition_toPower;

#pragma mark - init
-(nullable instancetype)init_with_gameBoardTilePosition_toPower:(nonnull SMBGameBoardTilePosition*)gameBoardTilePosition_toPower NS_DESIGNATED_INITIALIZER;

@end
