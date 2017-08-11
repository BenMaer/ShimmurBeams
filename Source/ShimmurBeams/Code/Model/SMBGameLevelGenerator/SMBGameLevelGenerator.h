//
//  SMBGameLevelGenerator.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/10/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameLevelGenerator__blocks.h"

#import <Foundation/Foundation.h>





@interface SMBGameLevelGenerator : NSObject

#pragma mark - name
@property (nonatomic, readonly, copy, nullable) NSString* name;

#pragma mark - init
-(nullable instancetype)init_with_generateLevelBlock:(nonnull SMBGameLevelGenerator__generateLevelBlock)generateLevelBlock
												name:(nonnull NSString*)name NS_DESIGNATED_INITIALIZER;

#pragma mark - gameLevel
-(nullable SMBGameLevel*)gameLevel_generate;

@end
