//
//  SMBGenericTextFieldTableViewCell.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 12/7/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBFullBoundsCustomViewTableViewCell.h"
#import "SMBGenericTextFieldTableViewCell__Protocols.h"

#import <UIKit/UIKit.h>





@interface SMBGenericTextFieldTableViewCell : SMBFullBoundsCustomViewTableViewCell <UITextFieldDelegate>

#pragma mark - textField
@property (nonatomic, readonly, nullable) UITextField* textField;
@property (nonatomic, assign) UIEdgeInsets textFieldFrameInsets;
-(CGRect)textField_frame_raw;
-(CGRect)textField_frame;
/**
 Called when `textField` fires an action for `UIControlEventEditingChanged`. Meant to be subclassed. Overloadeding methods should call super.
 */
-(void)textField_textDidChange;

#pragma mark - textChangeDelegate
@property (nonatomic, assign, nullable) id<SMBGenericTextFieldTableViewCell_textChangeDelegate> textChangeDelegate;

#pragma mark - textShouldChangeDelegate
@property (nonatomic, assign, nullable) id<SMBGenericTextFieldTableViewCell_textShouldChangeDelegate> textShouldChangeDelegate;

#pragma mark - keyboardDelegate
@property (nonatomic, assign, nullable) id<SMBGenericTextFieldTableViewCell_keyboardDelegate> keyboardDelegate;

#pragma mark - nextToolbarDelegate
@property (nonatomic, assign, nullable) id<SMBGenericTextFieldTableViewCell_nextToolbarDelegate> nextToolbarDelegate;

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(nonnull UITextField*)textField;
-(BOOL)textField:(nonnull UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(nonnull NSString*)string;

#pragma mark - nextToolBar
@property (nonatomic, assign) BOOL nextToolBar_visibility;

@end
