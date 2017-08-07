//
//  SMBBeamEntityTileNode.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/5/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBBeamEntityTileNode__beamOrientations.h"
#import "SMBMappedDataCollection_MappableObject.h"

#import <Foundation/Foundation.h>





@class SMBGameBoardTile;
@class SMBBeamEntity;





@interface SMBBeamEntityTileNode : NSObject <SMBMappedDataCollection_MappableObject>

#pragma mark - gameBoardTile
@property (nonatomic, readonly, strong, nullable) SMBGameBoardTile* gameBoardTile;

#pragma mark - beamEntity
@property (nonatomic, readonly, assign, nullable) SMBBeamEntity* beamEntity;

#pragma mark - node_previous
@property (nonatomic, readonly, assign, nullable) SMBBeamEntityTileNode* node_previous;

#pragma mark - node_next
@property (nonatomic, readonly, strong, nullable) SMBBeamEntityTileNode* node_next;

#pragma mark - beamExitOrientation
@property (nonatomic, readonly, assign) SMBBeamEntityTileNode__beamOrientation beamExitOrientation;

#pragma mark - init
-(nullable instancetype)init_with_gameBoardTile:(nonnull SMBGameBoardTile*)gameBoardTile
									 beamEntity:(nonnull SMBBeamEntity*)beamEntity
								  node_previous:(nullable SMBBeamEntityTileNode*)node_previous NS_DESIGNATED_INITIALIZER;

@end





@interface SMBBeamEntityTileNode_PropertiesForKVO : NSObject

+(nonnull NSString*)node_next;

@end
