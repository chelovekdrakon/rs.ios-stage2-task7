//
//  RSVideo.h
//  rs.ios-stage2-task7
//
//  Created by Фёдор Морев on 7/23/20.
//  Copyright © 2020 Фёдор Морев. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSTedVideoContent : NSObject

@property (nonatomic, assign) BOOL favorite;
@property (nonatomic, strong) NSURL *imageUrl;
@property (nonatomic, strong) NSURL *videoUrl;
@property (nonatomic, strong) NSURL *imageThumbnailUrl;
@property (nonatomic, strong) NSArray <NSString *> *authors;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *details;
@property (nonatomic, strong) NSString *duration;

@property (nonatomic, strong) NSData *imageData;

//- (instancetype)initWithTitle:(NSString *)title
//                       author:(NSString *)author
//                     duration:(NSString *)duration
//                      details:(NSString *)details
//                     imageUrl:(NSURL *)imageUrl
//                     videoUrl:(NSURL *)videoUrl
//                     favorite:(BOOL)favorite;
//
//- (instancetype)initWithTitle:(NSString *)title
//                       author:(NSString *)author
//                     duration:(NSString *)duration
//                      details:(NSString *)details
//                     imageUrl:(NSURL *)imageUrl
//                     videoUrl:(NSURL *)videoUrl;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end


NS_ASSUME_NONNULL_END
