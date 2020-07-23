//
//  RSSearchTableViewCell.m
//  rs.ios-stage2-task7
//
//  Created by Фёдор Морев on 7/22/20.
//  Copyright © 2020 Фёдор Морев. All rights reserved.
//

#import "RSPaddingsLabel.h"
#import "UIColor+RSColors.h"
#import "RSSearchTableViewCell.h"

static NSString * const kCellId = @"RSSearchTableViewCell";

@interface RSSearchTableViewCell()
@property(nonatomic, strong) RSPaddingsLabel *imageViewCaptionLabel;
@end

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
        
        self.imageViewCaptionLabel = [[RSPaddingsLabel alloc] initWithInsets:UIEdgeInsetsMake(5.0f, 5.0f, 5.0f, 5.0f)];
        self.imageViewCaptionLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8f];
        self.imageViewCaptionLabel.font = [UIFont systemFontOfSize:12.0f weight:UIFontWeightLight];
        self.imageViewCaptionLabel.textColor = [UIColor whiteColor];
        self.imageViewCaptionLabel.layer.cornerRadius = 7.0f;
        self.imageViewCaptionLabel.layer.masksToBounds = YES;
        self.imageViewCaptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self.imageView addSubview:self.imageViewCaptionLabel];
        
        [NSLayoutConstraint activateConstraints:@[
            [self.imageViewCaptionLabel.trailingAnchor constraintEqualToAnchor:self.imageView.trailingAnchor constant:-10.0f],
            [self.imageViewCaptionLabel.bottomAnchor constraintEqualToAnchor:self.imageView.bottomAnchor constant:-10.0f],
        ]];
    }
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.imageView.image = nil;
    self.textLabel.text = @"";
    self.imageCaption = @"";
    self.detailTextLabel.text = @"";
}

#pragma mark - KVC

- (NSString *)imageCaption {
    return self.imageViewCaptionLabel.text;
}

- (void)setImageCaption:(NSString *)imageCaption {
    [self willChangeValueForKey:@"imageCaption"];
    self.imageViewCaptionLabel.text = imageCaption;
    [self.imageViewCaptionLabel sizeToFit];
    [self didChangeValueForKey:@"imageCaption"];
}


@end
