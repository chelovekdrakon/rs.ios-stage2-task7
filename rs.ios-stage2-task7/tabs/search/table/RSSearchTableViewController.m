//
//  RSSearchTableViewController.m
//  rs.ios-stage2-task7
//
//  Created by Фёдор Морев on 7/22/20.
//  Copyright © 2020 Фёдор Морев. All rights reserved.
//

#import "RSVideosService.h"
#import "UIColor+RSColors.h"
#import "RSSearchTableViewController.h"
#import "RSSearchTableViewCell.h"

@interface RSSearchTableViewController () <UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation RSSearchTableViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.dataSource = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_UTILITY, 0), ^{
        [[RSVideosService sharedService] loadVideos:^(NSMutableArray * _Nonnull videos, NSError * _Nonnull error) {
            if (!error) {
                weakSelf.dataSource = videos;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.tableView reloadData];
                });
            }
        }];
        
    });
    
    self.tableView = [UITableView new];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor blackColor];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.tableView registerClass:RSSearchTableViewCell.class forCellReuseIdentifier:[RSSearchTableViewCell cellId]];
    
    [self.view addSubview:self.tableView];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.tableView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
        [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
        [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
    ]];
}

#pragma mark - UITableView Data Source

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    RSSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[RSSearchTableViewCell cellId] forIndexPath:indexPath];
    
    RSTedVideoContent *video = self.dataSource[indexPath.row];
    
    __weak typeof(self) weakSelf = self;
    
    if (video.imageData) {
        UIImage *image = [UIImage imageWithData:video.imageData];
        cell.imageView.image = image;
    } else {
        UIImage *image = [UIImage imageNamed:@"ted3"];
        cell.imageView.image = image;
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_UTILITY, 0), ^{
            NSData *imageData = [NSData dataWithContentsOfURL:video.imageUrl];
            video.imageData = imageData;
        
            dispatch_async(dispatch_get_main_queue(), ^{
                NSArray <NSIndexPath *> *visibleRows = [weakSelf.tableView indexPathsForVisibleRows];
                
                if ((indexPath.row <= visibleRows.lastObject.row) && (indexPath.row >= visibleRows.firstObject.row)) {
                    UIImage *image = [UIImage imageWithData:imageData];
                    cell.imageView.image = image;
                }
            });
        });
    }
    
    cell.textLabel.text = [video.authors componentsJoinedByString:@" and "];
    cell.detailTextLabel.text = video.title;
    cell.imageCaption = video.duration;
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource count];
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120.0f;
}

@end
