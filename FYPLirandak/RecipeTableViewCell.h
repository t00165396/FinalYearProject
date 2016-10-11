//
//  RecipeTableViewCell.h
//  RecipeApp
//
//  Created by Liranda Krasniqi on 05/11/2015.
//  Copyright © 2015 fyp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecipeObject.h"


@interface RecipeTableViewCell : UITableViewCell <RecipeObjectThumbnailDelegate>

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) IBOutlet UIImageView *thumbnail;



@property (nonatomic, strong) RecipeObject *recipeObject;


@end
