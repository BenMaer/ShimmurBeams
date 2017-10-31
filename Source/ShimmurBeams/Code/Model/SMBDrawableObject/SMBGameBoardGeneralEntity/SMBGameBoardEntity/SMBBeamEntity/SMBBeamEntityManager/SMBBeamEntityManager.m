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
#import "NSArray+SMBChanges.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@interface SMBBeamEntityManager ()

#pragma mark - beamEntity_forMarkingNodesReady
@property (nonatomic, strong, nullable) SMBBeamEntity* beamEntity_forMarkingNodesReady;
-(void)beamEntity_forMarkingNodesReady_update;
-(nullable SMBBeamEntity*)beamEntity_forMarkingNodesReady_appropriate;

#pragma mark - beamEntity_forMarkingNodesReady_mappedDataCollection
@property (nonatomic, readonly, strong, nonnull) SMBMutableMappedDataCollection<SMBBeamEntity*>* beamEntity_forMarkingNodesReady_mappedDataCollection;

#pragma mark - beamEntities_forMarkingNodesReady
@property (nonatomic, copy, nullable) NSArray<SMBBeamEntity*>* beamEntities_forMarkingNodesReady;
-(void)beamEntities_forMarkingNodesReady_update;

@end





@implementation SMBBeamEntityManager

#pragma mark - NSObject
-(void)dealloc
{
	[self setBeamEntities_forMarkingNodesReady:nil];

#if kSMBBeamEntityManager__beamEntity_forMarkingNodesReady_validation_general_enabled
	[self beamEntity_forMarkingNodesReady_isNil_validate];
#endif
}

#pragma mark - beamEntity_forMarkingNodesReady_mappedDataCollection
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
	[self setBeamEntity_forMarkingNodesReady:[self beamEntity_forMarkingNodesReady_appropriate]];
}

-(nullable SMBBeamEntity*)beamEntity_forMarkingNodesReady_appropriate
{
	kRUConditionalReturn_ReturnValueNil(self.isPaused, NO);

	return self.beamEntities_forMarkingNodesReady.firstObject;
}

-(void)beamEntity_forMarkingNodesReady_add:(nonnull SMBBeamEntity*)beamEntity
{
	kRUConditionalReturn(beamEntity == nil, YES);
	kRUConditionalReturn([self beamEntity_forMarkingNodesReady_exists:beamEntity], NO);

	[self.beamEntity_forMarkingNodesReady_mappedDataCollection mappableObject_add:beamEntity];

	[self beamEntities_forMarkingNodesReady_update];
}

-(void)beamEntity_forMarkingNodesReady_remove:(nonnull SMBBeamEntity*)beamEntity
{
	kRUConditionalReturn(beamEntity == nil, YES);
	kRUConditionalReturn([self beamEntity_forMarkingNodesReady_exists:beamEntity] == false, NO);

	[self.beamEntity_forMarkingNodesReady_mappedDataCollection mappableObject_remove:beamEntity];

	[self beamEntities_forMarkingNodesReady_update];
}

-(BOOL)beamEntity_forMarkingNodesReady_exists:(nonnull SMBBeamEntity*)beamEntity
{
	return [self.beamEntity_forMarkingNodesReady_mappedDataCollection mappableObject_exists:beamEntity];
}

#pragma mark - beamEntities_forMarkingNodesReady
-(void)setBeamEntities_forMarkingNodesReady:(nullable NSArray<SMBBeamEntity*>*)beamEntities_forMarkingNodesReady
{
	kRUConditionalReturn((self.beamEntities_forMarkingNodesReady == beamEntities_forMarkingNodesReady)
						 ||
						 [self.beamEntities_forMarkingNodesReady isEqual:beamEntities_forMarkingNodesReady], NO);

	NSArray<SMBBeamEntity*>* const beamEntities_forMarkingNodesReady_old = self.beamEntities_forMarkingNodesReady;
	_beamEntities_forMarkingNodesReady = (beamEntities_forMarkingNodesReady ? [NSArray<SMBBeamEntity*> arrayWithArray:beamEntities_forMarkingNodesReady] : nil);

	NSArray<SMBBeamEntity*>* beamEntities_forMarkingNodesReady_removed = nil;
	NSArray<SMBBeamEntity*>* beamEntities_forMarkingNodesReady_added = nil;
	[NSArray<SMBBeamEntity*> smb_changes_from_objects:beamEntities_forMarkingNodesReady_old
										   to_objects:beamEntities_forMarkingNodesReady
									   removedObjects:&beamEntities_forMarkingNodesReady_removed
										   newObjects:&beamEntities_forMarkingNodesReady_added];

	[beamEntities_forMarkingNodesReady_removed enumerateObjectsUsingBlock:^(SMBBeamEntity * _Nonnull beamEntity_forMarkingNodesReady_removed, NSUInteger idx, BOOL * _Nonnull stop) {
		[beamEntity_forMarkingNodesReady_removed setBeamEntityManager:nil];
	}];

	[beamEntities_forMarkingNodesReady_added enumerateObjectsUsingBlock:^(SMBBeamEntity * _Nonnull beamEntity_forMarkingNodesReady_added, NSUInteger idx, BOOL * _Nonnull stop) {
		[beamEntity_forMarkingNodesReady_added setBeamEntityManager:self];
	}];

	[self beamEntity_forMarkingNodesReady_update];
}

-(void)beamEntities_forMarkingNodesReady_update
{
	[self setBeamEntities_forMarkingNodesReady:[self.beamEntity_forMarkingNodesReady_mappedDataCollection mappableObjects]];
}

#if kSMBBeamEntityManager__beamEntity_forMarkingNodesReady_validation_general_enabled
#pragma mark - beamEntity_forMarkingNodesReady_isNil_validate
-(void)beamEntity_forMarkingNodesReady_isNil_validate;
{
	NSAssert(self.beamEntity_forMarkingNodesReady == nil, @"when a level is finished, beam entity manager should be done with beam entities.");
}
#endif

#pragma mark - isPaused
-(void)setIsPaused:(BOOL)isPaused
{
	kRUConditionalReturn(self.isPaused == isPaused, NO);

	_isPaused = isPaused;

	[self beamEntity_forMarkingNodesReady_update];
}

@end





@implementation SMBBeamEntityManager_PropertiesForKVO

+(nonnull NSString*)beamEntity_forMarkingNodesReady{return NSStringFromSelector(_cmd);}

@end
