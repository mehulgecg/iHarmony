//
//  iHMenuTableViewCell.m
//  iHarmony
//
//  Created by Alberto De Bortoli on 10/11/13.
//  Copyright (c) 2013 iHarmony, Inc. All rights reserved.
//

#import "iHMenuTableViewCell.h"
#import "Constants.h"

@implementation iHMenuTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.textLabel.font = kIHDetailCellTitleFont;
        self.textLabel.textColor = kIHCellTitleColor;
//        self.textLabel.font = kIHBrowsingCellTitleFont;
        
        self.detailTextLabel.font = kIHBrowsingCellSubtitleFont;
        self.detailTextLabel.textColor = kIHCellSubtitleColor;
        
        self.backgroundColor = kIHMenuCellBackgroundColor;
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
        backgroundView.backgroundColor = kIHMenuCellSelectedBackgroundColor;
        self.selectedBackgroundView = backgroundView;
        
        self.textLabel.font = kIHMenuCellTitleFont;
        self.textLabel.textColor = kIHMenuCellTitleFontColor;
        
        self.textLabel.backgroundColor = self.detailTextLabel.backgroundColor = [UIColor clearColor];
        
        self.textLabel.minimumScaleFactor = 9.0/16.0f;
        self.textLabel.adjustsFontSizeToFitWidth = YES;
        
        self.detailTextLabel.minimumScaleFactor = 9.0/14.0f;
        self.detailTextLabel.adjustsFontSizeToFitWidth = YES;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
