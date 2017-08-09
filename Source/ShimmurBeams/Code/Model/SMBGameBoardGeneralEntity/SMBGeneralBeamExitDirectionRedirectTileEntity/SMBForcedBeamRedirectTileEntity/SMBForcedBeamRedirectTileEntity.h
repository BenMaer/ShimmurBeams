//
//  SMBForcedBeamRedirectTileEntity.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/8/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGeneralBeamExitDirectionRedirectTileEntity.h"





@interface SMBForcedBeamRedirectTileEntity : SMBGeneralBeamExitDirectionRedirectTileEntity

#pragma mark - forcedBeamExitDirection
@property (nonatomic, readonly, assign) SMBGameBoardTile__direction forcedBeamExitDirection;

#pragma mark - init
-(nullable instancetype)init_with_forcedBeamExitDirection:(SMBGameBoardTile__direction)forcedBeamExitDirection NS_DESIGNATED_INITIALIZER;

@end
