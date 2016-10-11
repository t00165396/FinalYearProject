//
//  ListOfRecipesViewController.m
//  FYPLirandak
//
//  Created by Liranda Krasniqi on 19/04/2016.
//  Copyright © 2016 Liranda Krasniqi. All rights reserved.
//

#import "ListOfRecipesViewController.h"
#import "DatabaseConnection.h"
#import  "ChosenRecipes.h"
#import "RequestManager.h"

@interface ListOfRecipesViewController ()
@property (nonatomic, strong) ChosenRecipes *detailVC;

@end

@implementation ListOfRecipesViewController
@synthesize testLabel ,IDsToBeDisplayed, DisplayListOfRecipesView;



- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    [[DatabaseConnection DBconnection] OpenDB];
      
    IDsToBeDisplayed=[[DatabaseConnection DBconnection] readRecipeIDsToBeDisplayedtoUser];
   
    
  
    
    //NSLog(@"%@",self.IDsToBeDisplayed);
    
    self.DisplayListOfRecipesView.dataSource=self;
    
    self.DisplayListOfRecipesView.delegate=self;
   
    

    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [IDsToBeDisplayed count];

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"Cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell==Nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        
        
    }
    cell.textLabel.text=[IDsToBeDisplayed objectAtIndex:indexPath.row];
  
   
    
    return cell;
}



-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{


    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        
        _detailVC = [segue destinationViewController];
        
        if ([DisplayListOfRecipesView indexPathForSelectedRow]) {
            _detailVC.recipeID = [IDsToBeDisplayed objectAtIndex:[DisplayListOfRecipesView indexPathForSelectedRow].row];
            [_detailVC.view setHidden:NO];
        }
    }
    
    
    

}
@end
