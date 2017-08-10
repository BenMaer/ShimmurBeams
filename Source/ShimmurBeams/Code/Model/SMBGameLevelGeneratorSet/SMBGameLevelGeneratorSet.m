//
//  SMBGameLevelGeneratorSet.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/10/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameLevelGeneratorSet.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@interface SMBGameLevelGeneratorSet ()

#pragma mark - gameLevelGenerators
@property (nonatomic, copy, nullable) NSArray<SMBGameLevelGenerator*>* gameLevelGenerators;

#pragma mark - name
@property (nonatomic, copy, null_unspecified) NSString* name;

@end





@implementation SMBGameLevelGeneratorSet

#pragma mark - NSObject
-(instancetype)init
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);
	
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wno-nullability-completeness"
	return [self init_with_gameLevelGenerators:nil
										  name:nil];
#pragma clang diagnostic pop
}

#pragma mark - init
-(nullable instancetype)init_with_gameLevelGenerators:(nonnull NSArray<SMBGameLevelGenerator*>*)gameLevelGenerators
												 name:(nonnull NSString*)name
{
	if (self = [super init])
	{
		[self setGameLevelGenerators:gameLevelGenerators];
		[self setName:name];
	}

	return self;
}

@end
