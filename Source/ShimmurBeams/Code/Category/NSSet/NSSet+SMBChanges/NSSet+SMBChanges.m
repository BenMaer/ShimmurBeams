//
//  NSSet+SMBChanges.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 10/2/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "NSSet+SMBChanges.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@implementation NSSet (SMBChanges)

#pragma mark - changes
+(void)smb_changes_from_objects:(nullable NSSet<id>*)from_objects
					 to_objects:(nullable NSSet<id>*)to_objects
				 removedObjects:(NSSet<id>*_Nullable * _Nonnull)removedObjects
					 newObjects:(NSSet<id>*_Nullable * _Nonnull)newObjects
{
	kRUConditionalReturn(removedObjects == nil, YES);
	kRUConditionalReturn(newObjects == nil, YES);

	NSMutableSet<id>* const removedObjects_mutable = [NSMutableSet<id> set];
	[from_objects enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
		if ([to_objects containsObject:obj] == false)
		{
			[removedObjects_mutable addObject:obj];
		}
	}];

	*removedObjects = [NSSet<id> setWithSet:removedObjects_mutable];

	NSMutableSet<id>* const newObjects_mutable = [NSMutableSet<id> set];
	[to_objects enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
		if ([from_objects containsObject:obj] == false)
		{
			[newObjects_mutable addObject:obj];
		}
	}];

	*newObjects = [NSSet<id> setWithSet:newObjects_mutable];
}

@end
