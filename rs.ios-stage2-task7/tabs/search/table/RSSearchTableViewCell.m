//
//  RSSearchTableViewCell.m
//  rs.ios-stage2-task7
//
//  Created by Фёдор Морев on 7/22/20.
//  Copyright © 2020 Фёдор Морев. All rights reserved.
//

#import "UIColor+RSColors.h"
#import "RSSearchTableViewCell.h"

static NSString * const kCellId = @"RSSearchTableViewCell";

@implementation RSSearchTableViewCell

+ (NSString *)cellId {
    return kCellId;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.textLabel.textColor = [UIColor lightGrayColor];
        self.textLabel.font = [UIFont systemFontOfSize:12.0f weight:UIFontWeightRegular];
        self.detailTextLabel.textColor = [UIColor whiteColor];
        self.detailTextLabel.font = [UIFont systemFontOfSize:15.0f weight:UIFontWeightMedium];
        self.detailTextLabel.numberOfLines = 0;
    }
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.imageView.image = nil;
    self.textLabel.text = @"";
    self.detailTextLabel.text = @"";
}

- (UIEdgeInsets)separatorInset {
    return UIEdgeInsetsMake(10.0f, 0, 10.0f, 0);
}


@end
