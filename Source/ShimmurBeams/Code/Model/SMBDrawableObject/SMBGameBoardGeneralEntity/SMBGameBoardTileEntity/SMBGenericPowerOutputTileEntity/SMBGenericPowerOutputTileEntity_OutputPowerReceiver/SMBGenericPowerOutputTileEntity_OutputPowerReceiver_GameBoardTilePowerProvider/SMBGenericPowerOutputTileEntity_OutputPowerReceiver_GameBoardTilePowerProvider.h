//
//  SMBGenericPowerOutputTileEntity_OutputPowerReceiver_GameBoardTilePowerProvider.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 9/5/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGenericPowerOutputTileEntity_OutputPowerReceiver.h"

#import <Foundation/Foundation.h>





@class SMBGameBoardTilePosition;





@interface SMBGenericPowerOutputTileEntity_OutputPowerReceiver_GameBoardTilePowerProvider : SMBGenericPowerOutputTileEntity_OutputPowerReceiver

#pragma mark - gameBoardTilePosition_toPower
@property (nonatomic, readonly, strong, nullable) SMBGameBoardTilePosition* gameBoardTilePosition_toPower;

#pragma mark - init
-(nullable instancetype)init_with_gameBoardTilePosition_toPower:(nonnull SMBGameBoardTilePosition*)gameBoardTilePosition_toPower NS_DESIGNATED_INITIALIZER;

@end
