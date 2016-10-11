//
//  RecipeTableViewCell.m
//  RecipeApp
//
//  Created by Liranda Krasniqi on 05/11/2015.
//  Copyright © 2015 fyp. All rights reserved.
//

#import "RecipeTableViewCell.h"

@implementation RecipeTableViewCell

- (void)setRecipeObject:(RecipeObject *)recipeObject
{
    _recipeObject = recipeObject;
    _recipeObject.thumbDelegate = self;
    if (!_recipeObject.thumbnail)
    {
        [_recipeObject downloadThumbnail];
    }
    [self updateLayout];
}

- (void)updateLayout {
    [_titleLabel setText:_recipeObject.recipeName];
   
    
    if (_recipeObject.thumbnail) {
        [_thumbnail setImage:_recipeObject.thumbnail];
        [_activityIndicator stopAnimating];
        [_thumbnail setHidden:NO];
        [_activityIndicator setHidden:YES];
    } else {
        [_thumbnail setHidden:YES];
        [_activityIndicator setHidden:NO];
        [_activityIndicator startAnimating];
    }
}

- (void)recipeObject:(RecipeObject*)recipeObject didReceiveThumbnail:(UIImage*)thumbnail {
    if (recipeObject == _recipeObject) {
        [self updateLayout];
    }
}

@end
