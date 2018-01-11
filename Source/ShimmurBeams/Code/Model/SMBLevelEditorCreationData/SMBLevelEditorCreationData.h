//
//  SMBLevelEditorCreationData.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 1/11/18.
//  Copyright © 2018 Shimmur. All rights reserved.
//

#import <Foundation/Foundation.h>





@class SMBGameLevelGenerator;





@interface SMBLevelEditorCreationData : NSObject

#pragma mark - columns
@property (nonatomic, assign) NSUInteger columns;

#pragma mark - rows
@property (nonatomic, assign) NSUInteger rows;

#pragma mark - gameLevelGenerator
-(nullable SMBGameLevelGenerator*)gameLevelGenerator_generate;

@end
