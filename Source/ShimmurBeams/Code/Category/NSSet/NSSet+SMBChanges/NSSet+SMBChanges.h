//
//  NSSet+SMBChanges.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 10/2/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import <Foundation/Foundation.h>





@interface NSSet
<ObjectType>
(SMBChanges)

#pragma mark - changes
+(void)smb_changes_from_objects:(nullable NSSet<ObjectType>*)from_objects
					 to_objects:(nullable NSSet<ObjectType>*)to_objects
				 removedObjects:(NSSet<ObjectType>*_Nullable * _Nonnull)removedObjects
					 newObjects:(NSSet<ObjectType>*_Nullable * _Nonnull)newObjects;

@end
