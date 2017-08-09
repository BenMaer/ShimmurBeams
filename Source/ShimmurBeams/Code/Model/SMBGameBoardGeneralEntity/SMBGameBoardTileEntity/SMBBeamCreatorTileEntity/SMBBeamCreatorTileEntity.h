//
//  SMBBeamCreatorTileEntity.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/4/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardTileEntity.h"
#import "SMBGameBoardTile__directions.h"





@interface SMBBeamCreatorTileEntity : SMBGameBoardTileEntity

#pragma mark - beamDirection
@property (nonatomic, assign) SMBGameBoardTile__direction beamDirection;

@end
