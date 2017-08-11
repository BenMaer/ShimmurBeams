//
//  SMBGameLevelGeneratorSet.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/10/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import <Foundation/Foundation.h>





@class SMBGameLevelGenerator;





@interface SMBGameLevelGeneratorSet : NSObject

#pragma mark - gameLevelGenerators
@property (nonatomic, readonly, copy, nullable) NSArray<SMBGameLevelGenerator*>* gameLevelGenerators;

#pragma mark - name
@property (nonatomic, readonly, copy, nullable) NSString* name;

#pragma mark - init
-(nullable instancetype)init_with_gameLevelGenerators:(nonnull NSArray<SMBGameLevelGenerator*>*)gameLevelGenerators
												 name:(nonnull NSString*)name NS_DESIGNATED_INITIALIZER;

@end
