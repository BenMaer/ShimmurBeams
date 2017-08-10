//
//  SMBBeamEntityTileNode.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/5/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardTileEntity.h"
#import "SMBGameBoardTile__directions.h"
#import "SMBMappedDataCollection_MappableObject.h"
#import "SMBGameBoardTileEntity_PowerProvider.h"

#import <Foundation/Foundation.h>





@class SMBGameBoardTile;
@class SMBBeamEntity;





/**
 Setup sets:
 1) init
 2) set game tile
 3) call `setState_ready`.

 Finish steps:
 1) remove from game tile.
 
 Whoever 
 */
@interface SMBBeamEntityTileNode : SMBGameBoardTileEntity <SMBGameBoardTileEntity_PowerProvider>

#pragma mark - beamEntity
@property (nonatomic, readonly, assign, nullable) SMBBeamEntity* beamEntity;

#pragma mark - node_previous
@property (nonatomic, readonly, assign, nullable) SMBBeamEntityTileNode* node_previous;

#pragma mark - node_next
@property (nonatomic, readonly, strong, nullable) SMBBeamEntityTileNode* node_next;

#pragma mark - beamExitDirection
@property (nonatomic, readonly, assign) SMBGameBoardTile__direction beamExitDirection;

#pragma mark - beamEnterDirection
-(SMBGameBoardTile__direction)beamEnterDirection;

#pragma mark - state
-(void)setState_ready;

#pragma mark - init
-(nullable instancetype)init_with_beamEntity:(nonnull SMBBeamEntity*)beamEntity
							   node_previous:(nullable SMBBeamEntityTileNode*)node_previous NS_DESIGNATED_INITIALIZER;

//-(nullable instancetype)init_with_gameBoardTile:(nonnull SMBGameBoardTile*)gameBoardTile
//									 beamEntity:(nonnull SMBBeamEntity*)beamEntity
//								  node_previous:(nullable SMBBeamEntityTileNode*)node_previous NS_DESIGNATED_INITIALIZER;

@end





@interface SMBBeamEntityTileNode_PropertiesForKVO : NSObject

+(nonnull NSString*)node_next;

@end
