//
//  RSPaddingsLabel.m
//  rs.ios-stage2-task7
//
//  Created by Фёдор Морев on 7/23/20.
//  Copyright © 2020 Фёдор Морев. All rights reserved.
//

#import "RSPaddingsLabel.h"

@interface RSPaddingsLabel()
@property(nonatomic, assign) UIEdgeInsets insets;
@end

@implementation RSPaddingsLabel

- (instancetype)init {
    self = [super init];
    if (self) {
        _insets = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return self;
}

- (instancetype)initWithInsets:(UIEdgeInsets)insets {
    self = [super init];
    if (self) {
        _insets = insets;
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.insets)];
}

- (CGSize)intrinsicContentSize {
    CGSize size = [super intrinsicContentSize] ;
    size.height += self.insets.top + self.insets.bottom ;
    size.width += self.insets.left + self.insets.right ;
    return size ;
}

@end
