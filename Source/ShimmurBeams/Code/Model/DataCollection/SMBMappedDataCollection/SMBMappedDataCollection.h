//
//  SMBMappedDataCollection.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/7/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBMappedDataCollection_MappableObject.h"

#import <Foundation/Foundation.h>





@class RUOrderedDictionary<KeyType, ObjectType>;
@class SMBMutableMappedDataCollection<ObjectType>;





@interface SMBMappedDataCollection
<ObjectType>
: NSObject

#pragma mark - uniqueKey_to_mappableObject_mapping
@property (nonatomic, readonly, copy, nullable) RUOrderedDictionary<NSString*,ObjectType<SMBMappedDataCollection_MappableObject>>* uniqueKey_to_mappableObject_mapping;

#pragma mark - mappableObjects
-(nullable NSArray<ObjectType /**<SMBMappedDataCollection_MappableObject>*/ >*)mappableObjects;
-(nullable ObjectType /**<SMBMappedDataCollection_MappableObject>*/)mappableObject_for_uniqueKey:(nonnull NSString*)uniqueKey;
-(BOOL)mappableObject_exists:(nonnull ObjectType<SMBMappedDataCollection_MappableObject>)mappableObject;
-(nullable NSString*)mappableObject_uniqueKey:(nonnull ObjectType<SMBMappedDataCollection_MappableObject>)mappableObject;

#pragma mark - init
-(nonnull instancetype)init_with_uniqueKey_to_mappableObject_mapping:(nullable RUOrderedDictionary<NSString*,ObjectType<SMBMappedDataCollection_MappableObject>>*)uniqueKey_to_mappableObject_mapping;
-(nonnull instancetype)init_with_mappedDataCollection:(nullable SMBMappedDataCollection<ObjectType>*)mappedDataCollection;

#pragma mark - copy
-(nonnull SMBMappedDataCollection<ObjectType>*)copy;
-(nonnull SMBMutableMappedDataCollection<ObjectType<SMBMappedDataCollection_MappableObject>>*)mutableCopy;

#pragma mark - isEqual
-(BOOL)isEqual_to_mappedDataCollection:(nullable SMBMappedDataCollection<ObjectType>*)mappedDataCollection;

#pragma mark - changes
+(void)changes_from_mappedDataCollection:(nullable SMBMappedDataCollection<ObjectType>*)from_mappedDataCollection
				 to_mappedDataCollection:(nullable SMBMappedDataCollection<ObjectType>*)to_mappedDataCollection
						  removedObjects:(NSArray<ObjectType<SMBMappedDataCollection_MappableObject>>*_Nullable * _Nonnull)removedObjects
							  newObjects:(NSArray<ObjectType<SMBMappedDataCollection_MappableObject>>*_Nullable * _Nonnull)newObjects;

@end
