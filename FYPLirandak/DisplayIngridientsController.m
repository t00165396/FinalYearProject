//
//  DisplayIngridientsController.m
//  FYPLirandak
//
//  Created by Liranda Krasniqi on 30/04/2016.
//  Copyright © 2016 Liranda Krasniqi. All rights reserved.
//

#import "DisplayIngridientsController.h"
#import "DatabaseConnection.h"

@implementation DisplayIngridientsController
@synthesize DisplayUserIngridients, DisplayRecipeList, IngLabel;
@synthesize passData,recipes,recipeIDsToBeDisplayed, usersChosenIngredientsParsed;

- (void)viewDidLoad {
    

    
    IngLabel.text=@"";
    [super viewDidLoad];
    
}

-(IBAction)DisplayRecipeList:(id)sender {
    [self ParseData];
  
    [self findTheRightRecipe];
}
-(NSMutableArray*)ParseData{
    [[DatabaseConnection DBconnection] OpenDB];
    passData= [[DatabaseConnection DBconnection] readUserChosenIngridients];
    NSLog(@"%@",passData);
    
    NSString *removeSpaces = [passData stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *removeNcharacter=[removeSpaces stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSString *removeOpeningBrackets=[removeNcharacter stringByReplacingOccurrencesOfString:@"(" withString:@""];
    NSString *removeClosingBrackets=[removeOpeningBrackets stringByReplacingOccurrencesOfString:@")" withString:@""];
    
    //IngLabel.text=parsedIngrideints;
    parsedIngrideints = [removeClosingBrackets componentsSeparatedByString:@","];
    
    usersChosenIngredientsParsed = [NSMutableArray arrayWithArray:parsedIngrideints];
    
    NSString *tmpString1 = [usersChosenIngredientsParsed objectAtIndex:0];
    NSLog(@"String at index 1 = %@", tmpString1);
    NSLog(@"%@",usersChosenIngredientsParsed);

    return usersChosenIngredientsParsed;


}


-(void) findTheRightRecipe{
    
    [[DatabaseConnection DBconnection] OpenDB];
    recipes=[[DatabaseConnection DBconnection] readAllRecipes];
    recipeIDsToBeDisplayed=[[NSMutableArray alloc] init];
    
    NSMutableArray *rightRecipe;
    int numberOfMatches=0;
    NSMutableArray *rowArray;
    
    for (int i = 0; i < recipes.count; i++) {
        rowArray = recipes[i];
        
        for (int k=1;k<rowArray.count;k++)
        {
            for (int j=0;j<usersChosenIngredientsParsed.count;j++)
            {
                
                if ( [rowArray[k] hasSuffix: usersChosenIngredientsParsed[j] ])
                {
                    
                    numberOfMatches++;
                    break;
                }
            }
            
            if(numberOfMatches==usersChosenIngredientsParsed.count)
                break;
        }
        
        if(numberOfMatches>=2)
        {
            @try{
                rightRecipe = [NSMutableArray arrayWithArray:rowArray];
                
                
                [rightRecipe addObjectsFromArray:rightRecipe ];
                numberOfMatches=0;
                NSString *recipeIDs=rightRecipe[0];
                [recipeIDsToBeDisplayed addObject: recipeIDs];
                [[DatabaseConnection DBconnection] OpenDB];
                [[DatabaseConnection DBconnection] SaveRecipeIDs:recipeIDs];
                
            }
            @catch (NSException * e) {
                NSLog(@"Exception: %@", e);
            }
        }
    }
    
    NSLog(@"%@", recipeIDsToBeDisplayed);
//    recipeViewController.IDsToBeDisplayed=[[NSMutableArray alloc]initWithArray:self.recipeIDsToBeDisplayed];
}



@end
