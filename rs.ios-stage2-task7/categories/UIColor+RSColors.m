//
//  UIColor+RSColors.m
//  rs.ios-stage2-task7
//
//  Created by Фёдор Морев on 7/22/20.
//  Copyright © 2020 Фёдор Морев. All rights reserved.
//

#import "UIColor+RSColors.h"

@implementation UIColor (RSColors)

+ (UIColor *)grayColor {
    return [UIColor colorWithRed:112.0f/255.0f
                           green:112.0f/255.0f
                            blue:112.0f/255.0f
                           alpha:1.0f];
}

+ (UIColor *)yellowColor {
    return [UIColor colorWithRed:249.0f/255.0f
                           green:204.0f/255.0f
                            blue:120.0f/255.0f
                           alpha:1.0f];
}

+ (UIColor *)darkGrayColor {
    return [UIColor colorWithRed:40.0f/255.0f
                           green:40.0f/255.0f
                            blue:40.0f/255.0f
                           alpha:1.0f];
}

+ (UIColor *)lightGrayColor {
    return [UIColor colorWithRed:151.0f/255.0f
                           green:151.0f/255.0f
                            blue:151.0f/255.0f
                           alpha:1.0f];
}

+ (UIColor *)yellowHighlightedColor {
    return [UIColor colorWithRed:253.0f/255.0f
                           green:244.0f/255.0f
                            blue:227.0f/255.0f
                           alpha:1.0f];
}

@end
