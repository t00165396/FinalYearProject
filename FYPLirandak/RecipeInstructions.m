//
//  RecipeInstructions.m
//  FYPLirandak
//
//  Created by Liranda Krasniqi on 18/02/2016.
//  Copyright © 2016 Liranda Krasniqi. All rights reserved.
//

#import "RecipeInstructions.h"
#import "RequestManager.h"


@interface RecipeInstructions()
@property (nonatomic, assign) BOOL isFetchingThumbnail;
@property (nonatomic, assign) BOOL isFetchingImage;
@property (nonatomic, assign) BOOL isFetchingDetail;

@end


@implementation RecipeInstructions



- (id)initWithId:(NSString*)recipeId recipeName:(NSString*)recipeName sourceRecipe:(NSString*)sourceRecipe imageUrl:(NSString*)bigIamge ingredients :(NSArray*) ingredients recipeURL:(NSString*) recipeURL totalTime:(NSString*) totalTime numberOfServings :(NSNumber*) numberOFServings;
{
    self = [super init];
    if (self) {
        
        _isFetchingThumbnail = NO;
        _isFetchingImage = NO;
        _isFetchingDetail = NO;
        _recipeName=recipeName;
        _sourceRecipe=sourceRecipe;
        _bigImage=bigIamge;
        _ingredientLines=ingredients;
        _recipeURL=recipeURL;
        _totalTime=totalTime;
        _numberOfServings=numberOFServings;
        
        
    }
    
    return self;
}





@end


