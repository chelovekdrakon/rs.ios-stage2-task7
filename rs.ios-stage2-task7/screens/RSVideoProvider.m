//
//  RSVideoProvider.m
//  rs.ios-stage2-task7
//
//  Created by Фёдор Морев on 7/24/20.
//  Copyright © 2020 Фёдор Морев. All rights reserved.
//

#import "RSVideoProvider.h"
#import "RSVideosService.h"


@interface RSVideoProvider()
@property (nonatomic, strong) RSTedVideoContent *video;
@end


@implementation RSVideoProvider

- (instancetype)initWithPlaceholderItem:(id)placeholderItem video:(RSTedVideoContent *)video {
    self = [super initWithPlaceholderItem:placeholderItem];
    if (self) {
        _video = video;
    }
    return self;
}

- (id)item {
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    
    __block NSURL *result;
    
    [[RSVideosService sharedService] downloadVideoFromUrl:self.video.videoUrl completion:^(NSURL * _Nonnull path, NSError * _Nonnull error) {
        result = path;
        dispatch_semaphore_signal(sem);
    }];
    
    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    
    return result;
}

@end
