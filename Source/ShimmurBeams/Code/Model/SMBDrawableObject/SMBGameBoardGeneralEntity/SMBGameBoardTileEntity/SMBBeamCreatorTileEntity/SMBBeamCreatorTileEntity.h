//
//  SMBBeamCreatorTileEntity.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/4/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardTileEntity.h"
#import "SMBGameBoardTile__directions.h"
#import "SMBBeamBlockerTileEntity.h"





@class SMBBeamEntity;





@interface SMBBeamCreatorTileEntity : SMBGameBoardTileEntity <SMBBeamBlockerTileEntity>

#pragma mark - beamEntity
@property (nonatomic, readonly, strong, nullable) SMBBeamEntity* beamEntity;

#pragma mark - beamDirection
@property (nonatomic, assign) SMBGameBoardTile__direction beamDirection;

#pragma mark - requiresExternalPowerForBeam
@property (nonatomic, assign) BOOL requiresExternalPowerForBeam;

@end
