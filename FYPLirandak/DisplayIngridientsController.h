//
//  DisplayIngridientsController.h
//  FYPLirandak
//
//  Created by Liranda Krasniqi on 30/04/2016.
//  Copyright © 2016 Liranda Krasniqi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DisplayIngridientsController : UIViewController
{
    NSMutableArray*DisplayUserIngridients;
    NSArray *parsedIngrideints;
    NSMutableArray *usersChosenIngredientsParsed ;

}
@property (strong, nonatomic) IBOutlet UILabel *IngLabel;
@property (strong, nonatomic) IBOutlet UIButton *DisplayRecipeList;
@property (strong, nonatomic) NSMutableArray*DisplayUserIngridients;
@property (strong, nonatomic) NSString* passData;
@property (nonatomic, retain)  NSMutableArray* recipes;
 @property (nonatomic, retain)  NSMutableArray *recipeIDsToBeDisplayed;
@property (nonatomic, retain) NSMutableArray *usersChosenIngredientsParsed ;
-(void) findTheRightRecipe;
-(IBAction)DisplayRecipeList:(id)sender ;
-(NSMutableArray*)ParseData;




@end
