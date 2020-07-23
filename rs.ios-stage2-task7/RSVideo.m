//
//  RSVideo.m
//  rs.ios-stage2-task7
//
//  Created by Фёдор Морев on 7/23/20.
//  Copyright © 2020 Фёдор Морев. All rights reserved.
//

#import "RSTedVideoContent.h"

@implementation RSTedVideoContent

//- (instancetype)initWithTitle:(NSString *)title
//                       author:(NSString *)author
//                     duration:(NSString *)duration
//                      details:(NSString *)details
//                     imageUrl:(NSURL *)imageUrl
//                     videoUrl:(NSURL *)videoUrl
//                     favorite:(BOOL)favorite {
//    self = [super init];
//    if (self) {
//        _title = title;
//        _author = author;
//        _duration = duration;
//        _details = details;
//        _imageUrl = imageUrl;
//        _videoUrl = videoUrl;
//        _favorite = favorite;
//    }
//    return self;
//}
//
//- (instancetype)initWithTitle:(NSString *)title
//                       author:(NSString *)author
//                     duration:(NSString *)duration
//                      details:(NSString *)details
//                     imageUrl:(NSURL *)imageUrl
//                     videoUrl:(NSURL *)videoUrl {
//    return [self initWithTitle:title author:author duration:duration details:(NSString *)details imageUrl:imageUrl videoUrl:videoUrl favorite:NO];
////    self = [super init];
////    if (self) {
////        _title = title;
////        _author = author;
////        _duration = duration;
////        _imageUrl = imageUrl;
////        _favorite = NO;
////    }
////    return self;
//}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _title = dictionary[@"title"];
        _authors = dictionary[@"authors"];
        _details = dictionary[@"details"];
        _favorite = NO;
        _duration = dictionary[@"duration"];
        _imageUrl = dictionary[@"imageUrl"];
        _videoUrl = dictionary[@"videoUrl"];
        _imageThumbnailUrl = dictionary[@"imageThumbnailUrl"];
    }
    return self;
}



@end
