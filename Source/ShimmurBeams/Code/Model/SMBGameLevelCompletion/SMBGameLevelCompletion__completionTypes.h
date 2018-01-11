//
//  SMBGameLevelCompletion__completionTypes.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 1/11/18.
//  Copyright © 2018 Shimmur. All rights reserved.
//

#ifndef SMBGameLevelCompletion__completionTypes_h
#define SMBGameLevelCompletion__completionTypes_h

#import <Foundation/Foundation.h>





typedef NS_ENUM(NSInteger, SMBGameLevelCompletion__completionType) {
	SMBGameLevelCompletion__completionType_success,
	SMBGameLevelCompletion__completionType_defeat,

	SMBGameLevelCompletion__completionType__first	= SMBGameLevelCompletion__completionType_success,
	SMBGameLevelCompletion__completionType__last	= SMBGameLevelCompletion__completionType_defeat,
};

#endif /* SMBGameLevelCompletion__completionTypes_h */
