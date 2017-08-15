//
//  SMBTimer.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/15/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBTimer.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@interface SMBTimer ()

#pragma mark - timer
@property (nonatomic, strong, nullable) NSObject* timer_pointer;
-(void)timer_update;
-(void)timer_cancel;
-(void)timer_didFire_with_timer_pointer:(nonnull NSObject*)timer_pointer;

@end





@implementation SMBTimer

#pragma mark - running
-(void)setRunning:(BOOL)running
{
	kRUConditionalReturn(self.running == running, NO);

	_running = running;

	[self timer_update];
}

#pragma mark - timerDuration
-(void)setTimerDuration:(NSTimeInterval)timerDuration
{
	kRUConditionalReturn(self.timerDuration == timerDuration, NO);

	_timerDuration = timerDuration;

	[self timer_update];
}

#pragma mark - timer
-(void)timer_update
{
	[self timer_cancel];

	kRUConditionalReturn(self.running == NO, NO);

	NSTimeInterval const timerDuration = self.timerDuration;
	kRUConditionalReturn(timerDuration <= 0, YES);

	NSObject* const timer_pointer = [NSObject new];
	[self setTimer_pointer:timer_pointer];

	kRUConditionalReturn((self.timer_pointer == nil)
						 ||
						 (self.timer_pointer != timer_pointer), YES);

	__weak typeof(self) const self_weak = self;
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timerDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		[self_weak timer_didFire_with_timer_pointer:timer_pointer];
	});
}

-(void)timer_cancel
{
	[self setTimer_pointer:nil];
}

-(void)timer_didFire_with_timer_pointer:(nonnull NSObject*)timer_pointer
{
	kRUConditionalReturn(self.timer_pointer == timer_pointer, NO);

	id<SMBTimer__timerDidFireDelegate> const timerDidFireDelegate = self.timerDidFireDelegate;
	kRUConditionalReturn(self.timerDidFireDelegate == nil, YES);

	[timerDidFireDelegate timer_didFire:self];
}

@end
