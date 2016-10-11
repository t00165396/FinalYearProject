//
//  ListOfRecipesViewController.h
//  FYPLirandak
//
//  Created by Liranda Krasniqi on 19/04/2016.
//  Copyright © 2016 Liranda Krasniqi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ListOfRecipesViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>{

    NSMutableArray *IDsToBeDisplayed;
   
    
}

@property (strong, nonatomic) IBOutlet UITableView *DisplayListOfRecipesView;
@property (strong, nonatomic) IBOutlet UILabel *testLabel;
@property (nonatomic,strong) NSMutableArray *IDsToBeDisplayed;

@end
