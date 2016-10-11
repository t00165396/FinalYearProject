//
//  SecondViewController.m
//  FYPLirandak
//
//  Created by Liranda Krasniqi on 10/02/2016.
//  Copyright © 2016 Liranda Krasniqi. All rights reserved.
//

#import "SecondViewController.h"
#import "RequestManager.h"
#import "DatabaseConnection.h"
#import "CreateUserFridgeDB.h"


@interface SecondViewController ()


@end
@implementation SecondViewController


@synthesize recipeIDsToBeDisplayed;
@synthesize  recipes;
@synthesize  usersChosenIngredientsParsed;
@synthesize ingController;



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib
    recipes=self.recipes;
   self.DisplayUsersIngredients.dataSource=self;
    [_DisplayUsersIngredients setEditing:YES animated:YES ];
    self.DisplayUsersIngredients.allowsMultipleSelectionDuringEditing = YES;
    userIngredientsArray=[[CreateUserFridgeDB getSharedInstance] returnUsersIngredients];
     [[CreateUserFridgeDB getSharedInstance] createDB];
    [[DatabaseConnection DBconnection] OpenDB];
    recipeIDsToBeDisplayed=[[NSMutableArray alloc] init];
    
    [[DatabaseConnection DBconnection] deleteRecipeIDsTable];
  
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    return [userIngredientsArray count];

}
//https://www.youtube.com/watch?v=TTOIYorkuGs 

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 static NSString *cellID=@"Cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell==Nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        
    }
    cell.textLabel.text=[userIngredientsArray objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellEditingStyleInsert;
    cell.tintColor=[UIColor blueColor ];
    
    return cell;
}

-(UITableViewCellEditingStyle *)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *) indexPath{
    return UITableViewCellAccessoryCheckmark;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (IBAction)searchData:(id)sender {
    
    [[DatabaseConnection DBconnection] OpenDB];
    NSString *listOfIngredients = @"&allowedIngredient[]=";
    NSString *userIngredientAsString=@" ";
    usersChosenIngredientsParsed=[[NSMutableArray alloc] init];
   NSArray  *indexPath = [self.DisplayUsersIngredients indexPathsForSelectedRows];
   
   
    for(NSIndexPath *index in indexPath)
    {
        
        NSString *userIngridients = [userIngredientsArray objectAtIndex:index.row];
        userIngredientAsString=[userIngredientsArray objectAtIndex:index.row];
        

        
        if([indexPath lastObject]!=index)
        {
            listOfIngredients = [listOfIngredients stringByAppendingString:[userIngridients stringByAppendingString:@"&allowedIngredient[]="]];
            [ usersChosenIngredientsParsed addObject:userIngredientAsString ];
            
        }
        else
        {
            listOfIngredients = [listOfIngredients stringByAppendingString:userIngridients];
            [ usersChosenIngredientsParsed addObject:userIngredientAsString ];
            
        }
    }
    [[DatabaseConnection DBconnection] OpenDB];
    [[DatabaseConnection DBconnection] SaveUserIngridients:usersChosenIngredientsParsed];
    
    [[RequestManager manager] searchByIngredient:listOfIngredients block:^(BOOL succeed, NSArray* results){}];
    
    
    


    //[self findTheRightRecipe];
    
    
   
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
  recipeViewController.IDsToBeDisplayed=[[NSMutableArray alloc]initWithArray:self.recipeIDsToBeDisplayed];
}



-(NSMutableArray *)setValue:(NSMutableArray*)array
{
    NSMutableArray *newArray = [[NSMutableArray alloc] init];
    newArray = [array mutableCopy];
    return newArray;
}






@end
