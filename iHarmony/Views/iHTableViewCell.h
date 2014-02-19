//
//  iHTableViewCell.h
//  iHarmony
//
//  Created by Alberto De Bortoli on 03/12/11.
//  Copyright (c) 2013 iHarmony. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    iHTableViewCellTypeiPhone       = 0,
    iHTableViewCellTypeiPhoneDetail = 1,
    iHTableViewCellTypeiPadMaster   = 2,
    iHTableViewCellTypeiPadDetail   = 3
} iHTableViewCellType;

@interface iHTableViewCell : UITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellType:(iHTableViewCellType)cellType;
- (void)setupCell;

@end
