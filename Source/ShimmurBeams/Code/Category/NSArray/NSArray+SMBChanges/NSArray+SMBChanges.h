//
//  NSArray+SMBChanges.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/8/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import <Foundation/Foundation.h>





@interface NSArray
<ObjectType>
(SMBChanges)

#pragma mark - changes
+(void)smb_changes_from_objects:(nullable NSArray<ObjectType>*)from_objects
					 to_objects:(nullable NSArray<ObjectType>*)to_objects
				 removedObjects:(NSArray<ObjectType>*_Nullable * _Nonnull)removedObjects
					 newObjects:(NSArray<ObjectType>*_Nullable * _Nonnull)newObjects;

@end
