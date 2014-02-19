//
//  iHItemiPhoneDetailViewController.m
//  iHarmony
//
//  Created by Alberto De Bortoli on 29/09/2013.
//
//

#import "iHItemiPhoneDetailViewController.h"

@interface iHItemiPhoneDetailViewController ()

@property (nonatomic, assign) NSUInteger index;

@end

@implementation iHItemiPhoneDetailViewController

- (instancetype)initWithIndex:(NSUInteger)index
{
    self = [super init];
    if (self) {
        _index = index;
        _tableViews = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
