//
//  SMBPowerButtonTileEntity.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/18/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBForcedBeamRedirectTileEntity.h"





@class SMBGameBoardTilePosition;





@interface SMBPowerButtonTileEntity : SMBForcedBeamRedirectTileEntity

#pragma mark - gameBoardTilePosition_toPower
@property (nonatomic, readonly, strong, nullable) SMBGameBoardTilePosition* gameBoardTilePosition_toPower;

#pragma mark - SMBForcedBeamRedirectTileEntity: init
-(nullable instancetype)init_with_forcedBeamExitDirection:(SMBGameBoardTile__direction)forcedBeamExitDirection OBJC_DEPRECATED("Must use init");

#pragma mark - init
-(nullable instancetype)init_with_gameBoardTilePosition_toPower:(nonnull SMBGameBoardTilePosition*)gameBoardTilePosition_toPower NS_DESIGNATED_INITIALIZER;

@end
