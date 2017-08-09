//
//  SMBBeamCreatorTileEntity.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/4/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardTileEntity.h"
#import "SMBGameBoardTile__directions.h"





@class SMBBeamEntity;





@interface SMBBeamCreatorTileEntity : SMBGameBoardTileEntity

#pragma mark - beamEntity
@property (nonatomic, readonly, strong, nullable) SMBBeamEntity* beamEntity;

#pragma mark - beamDirection
@property (nonatomic, assign) SMBGameBoardTile__direction beamDirection;

@end
