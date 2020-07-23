//
//  RSNetworkService.h
//  rs.ios-stage2-task7
//
//  Created by Фёдор Морев on 7/22/20.
//  Copyright © 2020 Фёдор Морев. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSTedVideoContent.h"

NS_ASSUME_NONNULL_BEGIN

@interface RSVideosService : NSObject

@property (nonatomic, strong) NSURLSession *session;

+ (RSVideosService *)sharedService;
- (void)loadVideos:(void (^)(NSMutableArray <RSTedVideoContent *> *videos, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
