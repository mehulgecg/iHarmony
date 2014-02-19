//
//  iHSectionHeaderView.m
//  iHarmony
//
//  Created by Alberto De Bortoli on 03/12/11.
//  Copyright (c) 2013 iHarmony. All rights reserved.
//

#import "iHSectionHeaderView.h"
#import "Constants.h"

@interface iHSectionHeaderView ()

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation iHSectionHeaderView

- (id)initWithText:(NSString *)title
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _title = title;
        self.backgroundColor = kIHSectionBackgroundColor;
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [titleLabel setFont:kiHSectionCellTitleFont];
        [titleLabel setText:self.title];
        [titleLabel setBackgroundColor:kIHSectionBackgroundColor];
        [titleLabel setTextColor:[UIColor whiteColor]];
        [titleLabel setShadowColor:[UIColor grayColor]];
        [titleLabel setShadowOffset:CGSizeMake(0.0, 1.0)];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.frame = CGRectInset(self.bounds, 10, 0);
}

@end
