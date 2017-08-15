//
//  SMBTimer__Protocols.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/15/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import <Foundation/Foundation.h>





@class SMBTimer;





@protocol SMBTimer__timerDidFireDelegate <NSObject>

-(void)timer_didFire:(nonnull SMBTimer*)timer;

@end
