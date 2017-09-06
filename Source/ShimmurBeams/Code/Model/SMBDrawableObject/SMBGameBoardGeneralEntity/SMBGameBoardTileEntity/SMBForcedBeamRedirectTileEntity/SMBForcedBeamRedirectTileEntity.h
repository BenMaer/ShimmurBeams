//
//  SMBForcedBeamRedirectTileEntity.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/8/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardTileEntity.h"
#import "SMBGeneralBeamExitDirectionRedirectTileEntity.h"





@interface SMBForcedBeamRedirectTileEntity : SMBGameBoardTileEntity <SMBGeneralBeamExitDirectionRedirectTileEntity>

#pragma mark - forcedBeamExitDirection
@property (nonatomic, readonly, assign) SMBGameBoardTile__direction forcedBeamExitDirection;

#pragma mark - forcedBeamRedirectArrow_drawing
@property (nonatomic, assign) BOOL forcedBeamRedirectArrow_drawing_disable;

#pragma mark - init
-(nullable instancetype)init_with_forcedBeamExitDirection:(SMBGameBoardTile__direction)forcedBeamExitDirection NS_DESIGNATED_INITIALIZER;

@end
