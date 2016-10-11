//
//  ChosenRecipes.h
//  FYPLirandak
//
//  Created by Liranda Krasniqi on 18/04/2016.
//  Copyright © 2016 Liranda Krasniqi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ChosenRecipes : UIViewController
{

    
    NSString *recipeID;
   

}

@property (strong, nonatomic)   IBOutlet UIWebView *DisplayRecipeView;
@property (nonatomic, retain) NSString* recipeID;

@end
