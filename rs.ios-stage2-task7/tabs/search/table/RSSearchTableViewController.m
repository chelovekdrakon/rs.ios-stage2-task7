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
@property(nonatomic, copy) NSArray *dataSource;
@end

@implementation RSSearchTableViewController {
    NSString *_searchText;
}

@synthesize searchText;

- (instancetype)init {
    self = [super init];
    if (self) {
        self.dataSource = [NSArray array];
        _searchText = @"";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self initTableViewDataSource];
    
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

- (void)initTableViewDataSource {
    __weak typeof(self) weakSelf = self;
    
    [[RSVideosService sharedService] getVideos:^(NSMutableArray * _Nonnull videos, NSError * _Nonnull error) {
        if (!error) {
            weakSelf.dataSource = videos;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView reloadData];
            });
        }
    }];
}

- (void)filterTableViewDataSource:(NSString *)text {
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(RSTedVideoContent *video, NSDictionary<NSString *,id> *bindings) {
        if ([video.title.lowercaseString containsString:text.lowercaseString]) {
            return true;
        } else {
            return false;
        }
    }];
    NSArray *resultDataSource = [self.dataSource filteredArrayUsingPredicate:predicate];
    self.dataSource = resultDataSource;
    [self.tableView reloadData];
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

#pragma mark - KVC

- (NSString *)searchText {
    return _searchText;
}

- (void)setSearchText:(NSString *)searchText {
    [self willChangeValueForKey:@"searchText"];
    if (_searchText.length > 0 && searchText.length == 0) {
        [self initTableViewDataSource];
    } else {
        [self filterTableViewDataSource:searchText];
    }
    _searchText = searchText;
    [self didChangeValueForKey:@"searchText"];
}

@end
