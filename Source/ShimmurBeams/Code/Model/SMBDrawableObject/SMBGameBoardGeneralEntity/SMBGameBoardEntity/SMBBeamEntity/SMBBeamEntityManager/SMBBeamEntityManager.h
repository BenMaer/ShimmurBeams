//
//  SMBBeamEntityManager.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 9/6/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import <Foundation/Foundation.h>





@class SMBBeamEntity;





@interface SMBBeamEntityManager : NSObject

#pragma mark - beamEntity_forMarkingNodesReady
@property (nonatomic, readonly, strong, nullable) SMBBeamEntity* beamEntity_forMarkingNodesReady;
-(void)beamEntity_forMarkingNodesReady_add:(nonnull SMBBeamEntity*)beamEntity;
-(void)beamEntity_forMarkingNodesReady_remove:(nonnull SMBBeamEntity*)beamEntity;

#pragma mark - singleton
+(nonnull instancetype)sharedInstance;

@end





@interface SMBBeamEntityManager_PropertiesForKVO : NSObject

+(nonnull NSString*)beamEntity_forMarkingNodesReady;

@end
