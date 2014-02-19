//
//  iHTableViewCell.m
//  iHarmony
//
//  Created by Alberto De Bortoli on 03/12/11.
//  Copyright (c) 2011 iHarmony, Inc. All rights reserved.
//

#import "iHTableViewCell.h"
#import "Constants.h"

@interface iHTableViewCell ()

@property (nonatomic, assign) iHTableViewCellType cellType;

@end

@implementation iHTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellType:(iHTableViewCellType)cellType
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _cellType = cellType;
    }
    return self;
}

- (void)setupCell
{
    self.textLabel.font = kIHDetailCellTitleFont;
    self.textLabel.textColor = kIHCellTitleColor;
    //        self.textLabel.font = kIHBrowsingCellTitle;
    
    self.detailTextLabel.font = kIHBrowsingCellSubtitleFont;
    self.detailTextLabel.textColor = kIHCellSubtitleColor;
    
    self.textLabel.minimumScaleFactor = 9.0/16.0f;
    self.textLabel.adjustsFontSizeToFitWidth = YES;
    
    self.detailTextLabel.minimumScaleFactor = 9.0/14.0f;
    self.detailTextLabel.adjustsFontSizeToFitWidth = YES;
}

@end
