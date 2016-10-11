//
//  SecondViewController.h
//  FYPLirandak
//
//  Created by Liranda Krasniqi on 10/02/2016.
//  Copyright © 2016 Liranda Krasniqi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SearchByIngredient.h"
#import "ListOfRecipesViewController.h"
#import "DisplayIngridientsController.h"


@interface SecondViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

{
    NSArray *userIngredientsArray;
    NSMutableArray *recipeIDsToBeDisplayed;
    NSMutableArray *usersChosenIngredientsParsed ;
    IBOutlet UIButton *searchButton;
    ListOfRecipesViewController *recipeViewController;
    NSMutableArray* recipes;

}


 @property (nonatomic, retain)  NSMutableArray *recipeIDsToBeDisplayed;
@property (nonatomic, retain)  NSMutableArray* recipes;
@property (nonatomic, retain) NSMutableArray *usersChosenIngredientsParsed ;
@property (nonatomic, strong) SearchByIngredient *searchByIngredient;
@property (weak, nonatomic) IBOutlet UITableView *DisplayUsersIngredients;
 @property (retain, nonatomic)  DisplayIngridientsController *ingController;


- (IBAction)searchData:(id)sender;
-(void) findTheRightRecipe;
-(NSMutableArray *)setValue:(NSMutableArray*)array;




@end

