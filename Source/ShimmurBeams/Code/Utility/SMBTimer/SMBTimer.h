//
//  SMBTimer.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/15/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBTimer__Protocols.h"

#import <Foundation/Foundation.h>





@interface SMBTimer : NSObject

#pragma mark - timerDuration
/**
 The duration of time in between each call of the timer.
 Must be >= 0.
 If set while running to a new value, it will cancel the current timer. 
 */
@property (nonatomic, assign) NSTimeInterval timerDuration;

#pragma mark - timerDidFireDelegate
@property (nonatomic, assign, nullable) id<SMBTimer__timerDidFireDelegate> timerDidFireDelegate;

#pragma mark - running
@property (nonatomic, assign) BOOL running;

@end
