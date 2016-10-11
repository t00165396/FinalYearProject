//
//  RecipeByIngredient.m
//  FYPLirandak
//
//  Created by Liranda Krasniqi on 01/03/2016.
//  Copyright © 2016 Liranda Krasniqi. All rights reserved.
//

#import "RecipeByIngredient.h"

@implementation RecipeByIngredient
- (id)initWithId:(NSString*)recipeId title:(NSString*)recipeName ingredients :(NSArray*) ingredients;
{
    self = [super init];
    if (self) {
        _recipeId=recipeId;
        _recipeName=recipeName;
        _ingredients=ingredients;
        
        
    }
    
    return self;
}

@end
