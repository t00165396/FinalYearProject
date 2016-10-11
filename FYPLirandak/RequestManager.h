//
//  RequestManager.h
//  RecipeApp
//
//  Created by Liranda Krasniqi on 05/11/2015.
//  Copyright © 2015 fyp. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RecipeInstructions.h"



@interface RequestManager : NSObject

+ (RequestManager*)manager;

- (void)searchForRecipe:(NSString*)keyword block:(void (^)(BOOL succeed, NSArray *recipeObjectArray))callbackBlock;
- (void)downloadRecipeDetail:(NSString*)recipeId block:(void (^)(BOOL, RecipeInstructions *))callbackBlock;

- (void)searchByIngredient:(NSString*)keyword block:(void (^)(BOOL succeed, NSArray *recipeObjectArray))callbackBlock;

-(void)searchQuantityOfIngredient;

@property (nonatomic,strong) NSMutableArray *recipeIDs;

@end
