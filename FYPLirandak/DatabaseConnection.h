//
//  DatabaseConnection.h
//  FYPLirandak
//
//  Created by Liranda Krasniqi on 01/03/2016.
//  Copyright © 2016 Liranda Krasniqi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface DatabaseConnection : NSObject


+ (DatabaseConnection*)DBconnection;
- (void)OpenDB;
- (void) saveData: (NSString*) recipeID name:(NSString*)name  ingredients:(NSString*)ingredients;
- (void) saveQuantityOfIngredients: (NSString*) recipeID name:(NSString*)name  ingredients:(NSString*)ingredients;
-(NSMutableArray* ) readRecipeIDs;
-(NSMutableArray* ) readAllRecipes;
-(void)SaveRecipeIDs: (NSString*) recipeID;
-(void)SaveUserIngridients:(NSMutableArray*) ingridients;
-(NSString*)readUserChosenIngridients;
-(NSMutableArray* ) readRecipeIDsToBeDisplayedtoUser;
-(void) deleteRecipeIDsTable;
-(void) copyDB;



@end
