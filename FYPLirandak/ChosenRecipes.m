//
//  ChosenRecipes.m
//  FYPLirandak
//
//  Created by Liranda Krasniqi on 18/04/2016.
//  Copyright © 2016 Liranda Krasniqi. All rights reserved.
//

#import "ChosenRecipes.h"


@interface ChosenRecipes ()



@end

@implementation ChosenRecipes
@synthesize recipeID;

 -(void)viewDidLoad {
    [super viewDidLoad];
     
    
   
     NSString *recipeIDToBeAppended=self.recipeID;
     NSLog(@"%@",recipeIDToBeAppended);
    NSString *url=@"http://www.yummly.com/recipe/";
    url = [url stringByAppendingString:recipeIDToBeAppended];
    //[[RecipeObject recipeObject] ViewRecipeInstruction ];
    NSLog(@"%@", url);
    
    
    
    [_DisplayRecipeView loadRequest: [NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    
    
    _DisplayRecipeView.scalesPageToFit = YES;
    _DisplayRecipeView.autoresizesSubviews = YES;
    _DisplayRecipeView.frame=self.view.bounds;
     
     _DisplayRecipeView.autoresizesSubviews = YES;
     _DisplayRecipeView.frame=self.view.bounds;
     
     self.DisplayRecipeView.scalesPageToFit = YES;
     self.DisplayRecipeView.contentMode = UIViewContentModeScaleAspectFit;
     
     //http://stackoverflow.com/questions/10666484/html-content-fit-in-uiwebview-without-zooming-out
     CGSize contentSize = _DisplayRecipeView.scrollView.contentSize;
     CGSize viewSize = _DisplayRecipeView.bounds.size;
     float rw = viewSize.width / contentSize.width;
     _DisplayRecipeView.scrollView.minimumZoomScale = rw;
     _DisplayRecipeView.scrollView.maximumZoomScale = rw;
     _DisplayRecipeView.scrollView.zoomScale = rw;
     
     
    
}


@end
