//
//  SMBBeamEntityManager.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 9/6/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBBeamEntityManager.h"
#import "SMBMutableMappedDataCollection.h"
#import "SMBBeamEntity.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/RUSingleton.h>





@interface SMBBeamEntityManager ()

#pragma mark - beamEntity_forMarkingNodesReady
@property (nonatomic, strong, nullable) SMBBeamEntity* beamEntity_forMarkingNodesReady;
-(void)beamEntity_forMarkingNodesReady_update;
@property (nonatomic, readonly, strong, nonnull) SMBMutableMappedDataCollection<SMBBeamEntity*>* beamEntity_forMarkingNodesReady_mappedDataCollection;

@end





@implementation SMBBeamEntityManager

#pragma mark - beamEntity_forMarkingNodesReady
@synthesize beamEntity_forMarkingNodesReady_mappedDataCollection = _beamEntity_forMarkingNodesReady_mappedDataCollection;
-(nonnull SMBMutableMappedDataCollection<SMBBeamEntity*>*)beamEntity_forMarkingNodesReady_mappedDataCollection
{
	if (_beamEntity_forMarkingNodesReady_mappedDataCollection == nil)
	{
		_beamEntity_forMarkingNodesReady_mappedDataCollection = [SMBMutableMappedDataCollection<SMBBeamEntity*> new];
	}
	
	return _beamEntity_forMarkingNodesReady_mappedDataCollection;
}

-(void)beamEntity_forMarkingNodesReady_update
{
	[self setBeamEntity_forMarkingNodesReady:[self.beamEntity_forMarkingNodesReady_mappedDataCollection mappableObjects].firstObject];
}

-(void)beamEntity_forMarkingNodesReady_add:(nonnull SMBBeamEntity*)beamEntity
{
	kRUConditionalReturn(beamEntity == nil, YES);
	kRUConditionalReturn([self.beamEntity_forMarkingNodesReady_mappedDataCollection mappableObject_exists:beamEntity], NO);

	[self.beamEntity_forMarkingNodesReady_mappedDataCollection mappableObject_add:beamEntity];

	[self beamEntity_forMarkingNodesReady_update];
}

-(void)beamEntity_forMarkingNodesReady_remove:(nonnull SMBBeamEntity*)beamEntity
{
	kRUConditionalReturn(beamEntity == nil, YES);
	kRUConditionalReturn([self.beamEntity_forMarkingNodesReady_mappedDataCollection mappableObject_exists:beamEntity] == false, NO);

	[self.beamEntity_forMarkingNodesReady_mappedDataCollection mappableObject_remove:beamEntity];

	[self beamEntity_forMarkingNodesReady_update];
}

#pragma mark - singleton
RUSingletonUtil_Synthesize_Singleton_Implementation_SharedInstance;

@end





@implementation SMBBeamEntityManager_PropertiesForKVO

+(nonnull NSString*)beamEntity_forMarkingNodesReady{return NSStringFromSelector(_cmd);}

@end
