//
//  RecipeByIngredient.h
//  FYPLirandak
//
//  Created by Liranda Krasniqi on 01/03/2016.
//  Copyright © 2016 Liranda Krasniqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecipeByIngredient : NSObject

@property (nonatomic, strong) NSString *recipeId;
@property (nonatomic, strong) NSString *recipeName;
@property (nonatomic, strong) NSArray *ingredients;


- (id)initWithId:(NSString*)recipeId title:(NSString*)recipeName ingredients :(NSArray*) ingredients;



@end
