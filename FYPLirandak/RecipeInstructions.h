//
//  RecipeInstructions.h
//  FYPLirandak
//
//  Created by Liranda Krasniqi on 18/02/2016.
//  Copyright © 2016 Liranda Krasniqi. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RecipeObject.h"



@class RecipeInstructions;
@protocol RecipeObjectDetailDelegate <NSObject>
@required

//- (void)recipeInstructions:(RecipeInstructions*)receipeObject didReceiveDetail:(NSString*)detail;
@end


@interface RecipeInstructions : NSObject

@property (nonatomic, weak) id<RecipeObjectDetailDelegate> detailDelegate;
@property (nonatomic, strong) NSString * imageURL;
//@property (nonatomic, strong) id ingredientLines;
@property (nonatomic, strong) NSNumber * numberOfServings;
@property (nonatomic, strong) NSString * recipeName;
@property (nonatomic, strong) NSString * sourceRecipe;
@property (nonatomic, strong) NSString * totalTime;
@property (nonatomic, strong) NSString * recipeURL;
@property (nonatomic, strong) NSString  *bigImage;
@property (nonatomic, strong) NSArray  *ingredientLines;
@property (nonatomic, strong) NSDictionary *sourceRecipeURL;



- (id)initWithId:(NSString*)recipeId recipeName:(NSString*)recipeName sourceRecipe:(NSString*)sourceRecipe imageUrl:(NSString*)bigIamge ingredients :(NSArray*) ingredients recipeURL:(NSString*) recipeURL totalTime:(NSString*) totalTime numberOfServings :(NSNumber*) numberOFServings;



//

//@property (nonatomic, copy) NSString  *bigImage;

//@property (nonatomic, copy) NSString *sourceRecipeURL;
//@property (nonatomic, copy) NSString *source2;

//@property (nonatomic, copy) NSArray  *ingredientLines;

//@property (nonatomic) NSNumber *totalTimeInSeconds;



- (void)downloadRecipeDetail;


@end
