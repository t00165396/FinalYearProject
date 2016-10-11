//
//  RecipeDetailViewController.m
//  RecipeApp
//
//  Created by Liranda Krasniqi on 05/11/2015.
//  Copyright © 2015 fyp. All rights reserved.
//

#import "RecipeDetailViewController.h"
#import "RequestManager.h"
#import "WebViewController.h"


@interface RecipeDetailViewController ()

@property (nonatomic, strong) RecipeInstructions *recipeMethod;


@end

@implementation RecipeDetailViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}


- (void)setRecipeObject:(RecipeObject *)recipeObject{
    _recipeObject = recipeObject;
    _recipeObject.detailDelegate = self;
    _recipeObject.imageDelegate = self;
   if (!_recipeObject.recipeName) {
        [_recipeObject downloadRecipeDetail];
   
       
   }
    
    if (!_recipeObject.image) {
        [_recipeObject downloadImage];
    }
    
    [self updateLayout];
}

- (void)setRecipeInstruction:(RecipeInstructions *)recipeInstruction{
    _recipeInstruction = recipeInstruction;
    _recipeInstruction.detailDelegate=self;
    [_recipeInstruction downloadRecipeDetail];
    
    [self updateLayout];
}


- (void)updateLayout {
    self.title = _recipeObject.recipeName;
    [_recipeText setText:_recipeObject.recipeName];
    [_recipeText scrollRangeToVisible:NSMakeRange(0, 0)];
    
    
    
    [[RequestManager manager] downloadRecipeDetail:_recipeObject.recipeId block: ^(BOOL succeed, RecipeInstructions* Results){
    if(succeed)
       
        _ingredientsLabel.text=[NSString stringWithFormat:@" Total Preperation Time: %@", Results.totalTime];
       
        _NoServingsLabel.text=[NSString stringWithFormat:@" Number of Servings: %@", Results.numberOfServings];

        _ingredientsText.text = [Results.ingredientLines componentsJoinedByString:@"\n"];
        [_ingredientsText scrollRangeToVisible:NSMakeRange(0, 0)];

    
    }];
    
    
   
    
    if (_recipeObject.image) {
        [_activityIndicator setHidden:YES];
        [_image setHidden:NO];
        [_activityIndicator stopAnimating];
        [_image setImage:_recipeObject.image];
    } else {
        [_activityIndicator setHidden:NO];
        [_image setHidden:YES];
        [_activityIndicator startAnimating];
    }
    
}

- (void)recipeObject:(RecipeObject*)receipeObject didReceiveDetail:(NSString*)detail {
    if (_recipeObject == receipeObject) {
        [self updateLayout];
    }
}


- (void)recipeInstruction:(RecipeInstructions*)receipeInstruction didReceiveDetail:(NSString*)detail {
    if (_recipeInstruction == receipeInstruction) {
        [self updateLayout];
    }
}



- (void)recipeObject:(RecipeObject*)receipeObject didReceiveImage:(UIImage*)image {
    if (_recipeObject == receipeObject) {
        [self updateLayout];
    }
}

@end