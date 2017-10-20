//
//  SMBGameBoardTileBeamEnterToExitDirectionMapping.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 10/19/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardTile__directions.h"

#import <Foundation/Foundation.h>





@interface SMBGameBoardTileBeamEnterToExitDirectionMapping : NSObject

#pragma mark - init
-(nullable instancetype)init_with_beamEnterToExitDirectionMappingDictionary:(nullable NSDictionary<NSNumber*,NSNumber*>*)beamEnterToExitDirectionMappingDictionary NS_DESIGNATED_INITIALIZER;

#pragma mark - beamExitDirection
-(SMBGameBoardTile__direction)beamExitDirection_for_beamEnterDirection:(SMBGameBoardTile__direction)beamEnterDirection;

#pragma mark - isEqual
-(BOOL)isEqual_to_beamEnterToExitDirectionMapping:(nullable SMBGameBoardTileBeamEnterToExitDirectionMapping*)beamEnterToExitDirectionMapping;

@end
