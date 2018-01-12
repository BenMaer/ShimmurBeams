//
//  SMBGameLevelMetaData.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 1/11/18.
//  Copyright © 2018 Shimmur. All rights reserved.
//

#import "SMBGameLevelMetaData.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@interface SMBGameLevelMetaData ()

#pragma mark - name
@property (nonatomic, copy, nullable) NSString* name;

#pragma mark - hint
@property (nonatomic, copy, nullable) NSString* hint;

@end

@interface SMBGameLevelMetaData_Attributes_For_NSCoding : NSObject
+(nonnull NSString*)name;
+(nonnull NSString*)hint;
@end





@implementation SMBGameLevelMetaData

#pragma mark - NSObject
-(instancetype)init
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);
	
#if __has_feature(nullability)
#pragma clang diagnostic push
#pragma GCC diagnostic ignored "-Wnullability-completeness"
#endif
	return [self init_with_name:nil
						   hint:nil];
#if __has_feature(nullability)
#pragma clang diagnostic pop
#endif
}

#pragma mark - init
-(nullable instancetype)init_with_name:(nonnull NSString*)name
								  hint:(nullable NSString*)hint
{
	kRUConditionalReturn_ReturnValueNil(name == nil, YES);
	
	if (self = [super init])
	{
		[self setName:name];
		[self setHint:hint];
	}
	
	return self;
}

#pragma mark - NSCoding
-(nullable instancetype)initWithCoder:(nonnull NSCoder*)aDecoder
{
	if (self = [self init_with_name:[aDecoder decodeObjectForKey:[SMBGameLevelMetaData_Attributes_For_NSCoding name]]
							   hint:[aDecoder decodeObjectForKey:[SMBGameLevelMetaData_Attributes_For_NSCoding hint]]])
	{
	}

	return self;
}

-(void)encodeWithCoder:(nonnull NSCoder*)aCoder
{
	[aCoder encodeObject:self.name forKey:[SMBGameLevelMetaData_Attributes_For_NSCoding name]];
	[aCoder encodeObject:self.hint forKey:[SMBGameLevelMetaData_Attributes_For_NSCoding hint]];
}

@end





@implementation SMBGameLevelMetaData_Attributes_For_NSCoding
+(nonnull NSString*)name{return NSStringFromSelector(_cmd);}
+(nonnull NSString*)hint{return NSStringFromSelector(_cmd);}
@end
