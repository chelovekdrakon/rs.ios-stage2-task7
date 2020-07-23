//
//  RSVideoProvider.h
//  rs.ios-stage2-task7
//
//  Created by Фёдор Морев on 7/24/20.
//  Copyright © 2020 Фёдор Морев. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSTedVideoContent.h"

NS_ASSUME_NONNULL_BEGIN

@interface RSVideoProvider : UIActivityItemProvider

- (instancetype)initWithPlaceholderItem:(id)placeholderItem video:(RSTedVideoContent *)video;

@end

NS_ASSUME_NONNULL_END
