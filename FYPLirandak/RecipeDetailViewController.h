//
//  RecipeDetailViewController.h
//  RecipeApp
//
//  Created by Liranda Krasniqi on 05/11/2015.
//  Copyright © 2015 fyp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecipeObject.h"
#import "RecipeInstructions.h"
#import "DetailSearchResult.h"


@interface RecipeDetailViewController : UIViewController <RecipeObjectImageDelegate, RecipeObjectDetailDelegate>



@property (nonatomic, retain) IBOutlet UIImageView *image;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) IBOutlet UITextView *recipeText;

@property (nonatomic, retain) IBOutlet UITextView *ingredientsText;

@property (nonatomic, strong) IBOutlet UILabel *ingredientsLabel;
@property (nonatomic, strong) IBOutlet UILabel *NoServingsLabel;


@property (nonatomic, retain) RecipeObject *recipeObject;
@property (nonatomic, retain) RecipeInstructions *recipeInstruction;


@end
