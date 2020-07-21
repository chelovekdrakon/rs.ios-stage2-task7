//
//  AppDelegate.h
//  rs.ios-stage2-task7
//
//  Created by Фёдор Морев on 7/21/20.
//  Copyright © 2020 Фёдор Морев. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow *window;
@property (readonly, strong) NSPersistentContainer *persistentContainer;


- (void)saveContext;

@end

