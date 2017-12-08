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

#pragma mark - uniqueId_last
@property (nonatomic, copy, nullable) NSString* uniqueId_last;
-(nonnull NSString*)uniqueId_generate_initial;
-(nullable NSString*)uniqueId_generate_next:(nonnull NSString*)currentId;

@end




@implementation SMBUniqueStringGenerator

-(nullable NSString*)uniqueId_next
{
	NSString* const uniqueId_last = self.uniqueId_last;

#warning Let's have this method return nonnull by nonnulling the next method, by putting initial inside it's fail cases.
	NSString* const uniqueId_new =
	(uniqueId_last
	 ?
	 [self uniqueId_generate_next:uniqueId_last]
	 :
	 [self uniqueId_generate_initial]
	 );

	kRUConditionalReturn_ReturnValueNil(uniqueId_new == nil, YES);

	[self setUniqueId_last:uniqueId_new];

	return uniqueId_new;
}

-(nonnull NSString*)uniqueId_generate_initial
{
	unichar const character = 32;
	return [NSString stringWithCharacters:&character length:1];
}

-(nullable NSString*)uniqueId_generate_next:(nonnull NSString*)currentId
{
	kRUConditionalReturn_ReturnValueNil(currentId == nil, YES);
	kRUConditionalReturn_ReturnValueNil(currentId.length <= 0, YES);

	unichar const character_last = [currentId characterAtIndex:currentId.length - 1];
	unichar const character_next = character_last + 1;

	NSString* const string_suffix =
	(character_next == 0
	 ?
	 [self uniqueId_generate_initial]
	 :
	 [NSString stringWithCharacters:&character_next length:1]
	 );

	NSMutableString* const entityId_next = [NSMutableString stringWithString:currentId];

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
