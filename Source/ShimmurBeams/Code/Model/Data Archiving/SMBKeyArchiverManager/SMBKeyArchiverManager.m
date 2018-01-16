//
//  SMBKeyArchiverManager.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 1/12/18.
//  Copyright © 2018 Shimmur. All rights reserved.
//

#import "SMBKeyArchiverManager.h"
#import "SMBKeyUnarchiverStore.h"

#import <ResplendentUtilities/RUSingleton.h>
#import <ResplendentUtilities/RUConditionalReturn.h>





@interface SMBKeyArchiverManager ()

#pragma mark - keyUnarchiverStore
@property (nonatomic, strong, nullable) SMBKeyUnarchiverStore* keyUnarchiverStore;

@end





@implementation SMBKeyArchiverManager

#pragma mark - Singleton
RUSingletonUtil_Synthesize_Singleton_Implementation_SharedInstance;

#pragma mark - unarchive
-(nullable id)unarchiveObject_withFile_atPath:(nonnull NSString*)filePath
{
	kRUConditionalReturn_ReturnValueNil(filePath == nil, YES);
	kRUConditionalReturn_ReturnValueNil(self.keyUnarchiverStore != nil, YES);

	SMBKeyUnarchiverStore* const keyUnarchiverStore = [SMBKeyUnarchiverStore new];
	kRUConditionalReturn_ReturnValueNil(keyUnarchiverStore == nil, YES);

	[self setKeyUnarchiverStore:keyUnarchiverStore];

	id const unarchivedObject = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];

	[self setKeyUnarchiverStore:nil];

	return unarchivedObject;
}

@end
