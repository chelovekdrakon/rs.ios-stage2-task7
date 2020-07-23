//
//  RSHomeTabViewController.m
//  rs.ios-stage2-task7
//
//  Created by Фёдор Морев on 7/21/20.
//  Copyright © 2020 Фёдор Морев. All rights reserved.
//

#import "UIColor+RSColors.h"
#import "RSSearchTabViewController.h"
#import "RSSearchTableViewController.h"

@interface RSSearchTabViewController () <UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating, UISearchResultsUpdating>
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) RSSearchTableViewController *tableViewController;
@end

@implementation RSSearchTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self layoutScreen];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - Layout

- (void)layoutScreen {
    self.searchBar = [UISearchBar new];
    self.searchBar.delegate = self;
    self.searchBar.barStyle = UIBarStyleBlack;
    self.searchBar.tintColor = [UIColor whiteColor];
    self.searchBar.barTintColor = [UIColor blackColor];
    self.searchBar.translatesAutoresizingMaskIntoConstraints = NO;
    
    if (@available(iOS 13.0, *)) {
        self.searchBar.searchTextField.backgroundColor = [UIColor darkGrayColor];
        self.searchBar.searchTextField.leftView.tintColor = [UIColor whiteColor];
        self.searchBar.searchTextField.textColor = [UIColor whiteColor];
    }
    
    [self.view addSubview:self.searchBar];
    
    self.tableViewController = [RSSearchTableViewController new];
    self.tableViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.tableViewController willMoveToParentViewController:self]; // Necessary to call?
    [self addChildViewController:self.tableViewController];
    [self.view addSubview:self.tableViewController.view];
    [self.tableViewController didMoveToParentViewController:self];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.searchBar.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [self.searchBar.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
        [self.searchBar.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
        
        [self.tableViewController.view.topAnchor constraintEqualToAnchor:self.searchBar.bottomAnchor],
        [self.tableViewController.view.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
        [self.tableViewController.view.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
        [self.tableViewController.view.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
    ]];
}

#pragma mark - UISearchBar Delegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    self.tableViewController.searchText = searchText;
}

#pragma mark - UISearchController Delegate

#pragma mark - UISearchResults Updating

- (void)updateSearchResultsForSearchController:(nonnull UISearchController *)searchController {
    NSLog(@"update search results");
}

@end
