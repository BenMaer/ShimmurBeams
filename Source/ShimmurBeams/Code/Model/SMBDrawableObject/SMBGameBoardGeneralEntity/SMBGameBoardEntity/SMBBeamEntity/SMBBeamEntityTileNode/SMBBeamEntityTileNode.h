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
 Usage steps:
 1) init
 2) prepare:
  - KVO on `node_next_gameTile`
  - set game tile
 3) make ready (prepare steps must be done by this point):
 - call `setState_ready`.
 4) while ready:
 - when `node_next_gameTile` changes, call `node_next_update_if_needed`.

 Finish steps:
 - un KVO on `node_next_gameTile`.
 - call `setState_finished`.
 - Ensure it's been removed from the previous node, if it had one.
 */
@interface SMBBeamEntityTileNode : SMBGameBoardTileEntity <SMBGameBoardTileEntity_PowerProvider>

#pragma mark - beamEntity
@property (nonatomic, readonly, assign, nullable) SMBBeamEntity* beamEntity;

#pragma mark - node_next
@property (nonatomic, readonly, strong, nullable) SMBBeamEntityTileNode* node_next;
-(void)node_next_update_if_needed;

#pragma mark - beamExitDirection
@property (nonatomic, readonly, assign) SMBGameBoardTile__direction beamExitDirection;

#pragma mark - beamEnterDirection
@property (nonatomic, readonly, assign) SMBGameBoardTile__direction beamEnterDirection;
+(SMBGameBoardTile__direction)beamEnterDirection_for_node_previous_exitDirection:(SMBGameBoardTile__direction)node_previous_exitDirection;

#pragma mark - state
-(void)setState_ready;
-(void)setState_finished;

#pragma mark - init
-(nullable instancetype)init_with_beamEntity:(nonnull SMBBeamEntity*)beamEntity
						  beamEnterDirection:(SMBGameBoardTile__direction)beamEnterDirection NS_DESIGNATED_INITIALIZER;

@end





@interface SMBBeamEntityTileNode_PropertiesForKVO : NSObject

+(nonnull NSString*)node_next;
+(nonnull NSString*)node_next_gameTilePosition;

@end
