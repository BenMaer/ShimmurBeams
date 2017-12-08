//
//  SMBGenericButtonTableViewCell__Protocols.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 12/7/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import <Foundation/Foundation.h>





@class SMBGenericButtonTableViewCell;





@protocol SMBGenericButtonTableViewCell_genericButtonDelegate <NSObject>

-(void)genericButtonTableViewCell_didTouchUpInsideButton:(nonnull SMBGenericButtonTableViewCell*)genericButtonTableViewCell;

@end

