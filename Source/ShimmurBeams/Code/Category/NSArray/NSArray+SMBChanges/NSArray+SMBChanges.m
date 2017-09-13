//
//  NSArray+SMBChanges.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/8/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "NSArray+SMBChanges.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@implementation NSArray (SMBChanges)

#pragma mark - changes
+(void)smb_changes_from_objects:(nullable NSArray<id>*)from_objects
					 to_objects:(nullable NSArray<id>*)to_objects
				 removedObjects:(NSArray<id>*_Nullable * _Nonnull)removedObjects
					 newObjects:(NSArray<id>*_Nullable * _Nonnull)newObjects
{
	kRUConditionalReturn(removedObjects == nil, YES);
	kRUConditionalReturn(newObjects == nil, YES);
	
	NSMutableArray<id>* const removedObjects_mutable = [NSMutableArray<id> array];
	[from_objects enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		if ([to_objects containsObject:obj] == false)
		{
			[removedObjects_mutable addObject:obj];
		}
	}];
	
	*removedObjects = [NSArray<id> arrayWithArray:removedObjects_mutable];
	
	NSMutableArray<id>* const newObjects_mutable = [NSMutableArray<id> array];
	[to_objects enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		if ([from_objects containsObject:obj] == false)
		{
			[newObjects_mutable addObject:obj];
		}
	}];
	
	*newObjects = [NSArray<id> arrayWithArray:newObjects_mutable];
}

@end
