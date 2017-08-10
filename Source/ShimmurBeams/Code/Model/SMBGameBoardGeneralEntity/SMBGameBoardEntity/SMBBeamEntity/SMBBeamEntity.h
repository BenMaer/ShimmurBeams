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

#pragma mark - beamEntityTileNodes
/**
 A method to determine if this beam entity contains a specific node.

 If you want to KVO on changes to this, use the following KVO values:
 `[SMBBeamEntity_PropertiesForKVO beamEntityTileNode_mappedDataCollection]`

 @param beamEntityTileNode The node to check if exists in this beam.
 @return YES if the node exists in this beam, otherwise NO.
 */
-(BOOL)beamEntityTileNode_contains:(nonnull SMBBeamEntityTileNode*)beamEntityTileNode;

#pragma mark - init
-(nullable instancetype)init_with_gameBoardTile:(nonnull SMBGameBoardTile*)gameBoardTile NS_DESIGNATED_INITIALIZER;

@end





@interface SMBBeamEntity_PropertiesForKVO : NSObject

+(nonnull NSString*)beamEntityTileNode_initial;
+(nonnull NSString*)beamEntityTileNode_mappedDataCollection;

@end
