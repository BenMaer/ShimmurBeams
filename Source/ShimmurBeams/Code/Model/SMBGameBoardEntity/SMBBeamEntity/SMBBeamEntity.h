//
//  SMBBeamEntity.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/5/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardEntity.h"





@class SMBBeamEntityTileNode;
@class SMBGameBoardTile;





@interface SMBBeamEntity : SMBGameBoardEntity

#pragma mark - beamEntityTileNode_initial
@property (nonatomic, readonly, strong, nullable) SMBBeamEntityTileNode* beamEntityTileNode_initial;

#pragma mark - init
-(nullable instancetype)init_with_gameBoardTile:(nonnull SMBGameBoardTile*)gameBoardTile NS_DESIGNATED_INITIALIZER;

@end
