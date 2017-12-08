//
//  SMBGenericLabelTableViewCell__label_layoutStyles.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 12/7/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#ifndef SMBGenericLabelTableViewCell__label_layoutStyles_h
#define SMBGenericLabelTableViewCell__label_layoutStyles_h

#import <Foundation/Foundation.h>





typedef NS_ENUM(NSInteger, SMBGenericLabelTableViewCell__label_layoutStyle) {
	SMBGenericLabelTableViewCell__label_layoutStyle_entireCell,
	SMBGenericLabelTableViewCell__label_layoutStyle_textSize,

	SMBGenericLabelTableViewCell__label_layoutStyle__first	= SMBGenericLabelTableViewCell__label_layoutStyle_entireCell,
	SMBGenericLabelTableViewCell__label_layoutStyle__last	= SMBGenericLabelTableViewCell__label_layoutStyle_textSize,
};

#endif /* SMBGenericLabelTableViewCell__label_layoutStyles_h */
