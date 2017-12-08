//
//  SMBUniqueStringGenerator.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/5/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBUniqueStringGenerator.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@interface SMBUniqueStringGenerator ()

#pragma mark - uniqueId
@property (nonatomic, copy, nullable) NSString* uniqueId_last;
-(nonnull NSString*)uniqueId_generate_initial;
-(nonnull NSString*)uniqueId_generate_next;

@end




@implementation SMBUniqueStringGenerator

#pragma mark - uniqueId
-(nonnull NSString*)uniqueId_next
{
	NSString* _Nonnull const uniqueId_new = [self uniqueId_generate_next];

	[self setUniqueId_last:uniqueId_new];

	if (uniqueId_new == nil)
	{
		@throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Unable to generate a new unique id" userInfo:nil];
	}

	return uniqueId_new;
}

-(nonnull NSString*)uniqueId_generate_initial
{
	unichar const character = 32;
	return [NSString stringWithCharacters:&character length:1];
}

-(nonnull NSString*)uniqueId_generate_next
{
	NSString* const uniqueId_last = self.uniqueId_last;

	kRUConditionalReturn_ReturnValue(uniqueId_last == nil, NO, [self uniqueId_generate_initial]);
	kRUConditionalReturn_ReturnValue(uniqueId_last.length <= 0, YES, [self uniqueId_generate_initial]);

	unichar const character_last = [uniqueId_last characterAtIndex:uniqueId_last.length - 1];
	unichar const character_next = character_last + 1;

	NSString* const string_suffix =
	(character_next == 0
	 ?
	 [self uniqueId_generate_initial]
	 :
	 [NSString stringWithCharacters:&character_next length:1]
	 );

	NSMutableString* const entityId_next = [NSMutableString stringWithString:uniqueId_last];

	if (character_next == 0)
	{
		[entityId_next appendString:string_suffix];
	}
	else
	{
		[entityId_next replaceCharactersInRange:(NSRange){
			.location	= entityId_next.length - 1,
			.length		= 1,
		}
									 withString:string_suffix];
	}

	return [NSString stringWithString:entityId_next];
}

@end
