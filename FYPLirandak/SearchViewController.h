//
//  ViewController.h
//  RecipeApp
//
//  Created by Liranda Krasniqi on 05/11/2015.
//  Copyright © 2015 fyp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (nonatomic, strong) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end

