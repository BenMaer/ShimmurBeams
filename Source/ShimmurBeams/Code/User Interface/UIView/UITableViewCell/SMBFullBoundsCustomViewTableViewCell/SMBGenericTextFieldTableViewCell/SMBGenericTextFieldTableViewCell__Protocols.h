//
//  SMBGenericTextFieldTableViewCell__Protocols.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 12/7/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import <Foundation/Foundation.h>





@class SMBGenericTextFieldTableViewCell;





@protocol DRGenericTextFieldTableViewCell_textChangeDelegate <NSObject>

-(void)genericTextFieldTableViewCell:(nonnull SMBGenericTextFieldTableViewCell*)genericTextFieldTableViewCell
					   textDidChange:(nonnull NSString*)text;

@end





@protocol DRGenericTextFieldTableViewCell_keyboardDelegate <NSObject>

@optional
-(BOOL)genericTextFieldTableViewCell_shouldReturn:(nonnull SMBGenericTextFieldTableViewCell*)genericTextFieldTableViewCell;
-(BOOL)genericTextFieldTableViewCell_shouldBeginEditing:(nonnull SMBGenericTextFieldTableViewCell*)genericTextFieldTableViewCell;
-(void)genericTextFieldTableViewCell_didBeginEditing:(nonnull SMBGenericTextFieldTableViewCell*)genericTextFieldTableViewCell;
-(void)genericTextFieldTableViewCell_didEndEditing:(nonnull SMBGenericTextFieldTableViewCell*)genericTextFieldTableViewCell;

@end





@protocol DRGenericTextFieldTableViewCell_textShouldChangeDelegate <NSObject>

-(BOOL)genericTextFieldTableViewCell:(nonnull SMBGenericTextFieldTableViewCell*)genericTextFieldTableViewCell
						   textField:(nonnull UITextField*)textField
	   shouldChangeCharactersInRange:(NSRange)range
				   replacementString:(nonnull NSString*)string;

@end





@protocol DRGenericTextFieldTableViewCell_nextToolbarDelegate <NSObject>

-(void)genericTextFieldTableViewCell_nextButtonWasPressed:(nonnull SMBGenericTextFieldTableViewCell*)genericTextFieldTableViewCell;

@end

