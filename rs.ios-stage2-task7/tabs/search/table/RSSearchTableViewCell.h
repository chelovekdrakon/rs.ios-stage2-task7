//
//  RSSearchTableViewCell.h
//  rs.ios-stage2-task7
//
//  Created by Фёдор Морев on 7/22/20.
//  Copyright © 2020 Фёдор Морев. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSSearchTableViewCell : UITableViewCell

+ (NSString *)cellId;
@property (nonatomic, strong) NSString *imageCaption;

@end

NS_ASSUME_NONNULL_END
