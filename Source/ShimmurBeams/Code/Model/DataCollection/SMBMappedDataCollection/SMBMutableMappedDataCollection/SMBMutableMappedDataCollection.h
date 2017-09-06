//
//  SMBMutableMappedDataCollection.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/7/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBMappedDataCollection.h"





@interface SMBMutableMappedDataCollection<ObjectType> : SMBMappedDataCollection

#pragma mark - mappableObjects
-(void)mappableObject_add:(nonnull ObjectType<SMBMappedDataCollection_MappableObject>)mappableObject;
-(void)mappableObject_remove:(nonnull ObjectType<SMBMappedDataCollection_MappableObject>)mappableObject;

@end
