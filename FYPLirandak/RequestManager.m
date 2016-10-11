//
//  RequestManager.m
//  RecipeApp
//
//  Created by Liranda Krasniqi on 05/11/2015.
//  Copyright © 2015 fyp. All rights reserved.
//

#import "RequestManager.h"
#import "RecipeObject.h"
#import "RecipeInstructions.h"
#import "DetailSearchResult.h"
#import "RecipeByIngredient.h"
#import  "DatabaseConnection.h"
#import "SecondViewController.h"



//example of search http://api.yummly.com/v1/api/recipes?_app_id=39fd9427&_app_key=264eafb5fe4af135d19d0878c603c2a0&q=soup

//example of get http://api.yummly.com/v1/api/recipe/Avocado-cream-pasta-sauce-recipe-306039?_app_id=39fd9427&_app_key=264eafb5fe4af135d19d0878c603c2a0



 //NSString *urlString = [NSString stringWithFormat:@"http://api.yummly.com/v1/api/recipes?_app_id=39fd9427&_app_key=264eafb5fe4af135d19d0878c603c2a0&q=%@", escapedSearchText];


@interface RequestManager()

@property (nonatomic, assign) BOOL isRequestingSearch;

@end

@implementation RequestManager
@synthesize recipeIDs;

static RequestManager* sharedInstance;

+(RequestManager *)manager {
    if (!sharedInstance)
    {
        sharedInstance = [[RequestManager alloc] init];
    }
    
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if(self) {
        _isRequestingSearch = NO;
    }
    
    return self;
}

#pragma mark search request
- (void)searchForRecipe:(NSString *)keyword block:(void (^)(BOOL, NSArray *))callbackBlock {
  
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        BOOL succeed = NO;
        NSArray *results = nil;
        
        // create url
        NSString *urlStr = [NSString stringWithFormat: @"http://api.yummly.com/v1/api/recipes?_app_id=39fd9427&_app_key=264eafb5fe4af135d19d0878c603c2a0&q=%@&maxResult=100&start=10&requirePictures=true",keyword];
        NSLog(@"Url is %@", urlStr);
        
        
        NSURL *url = [NSURL URLWithString:urlStr];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        NSURLResponse *response;
        NSError *error;
       
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
  
        if(!error)
        {
            
            results = [self parseRecipeSearchResponse:responseData];
            if (results) {
                succeed = YES;
            }
        }
        
       
        dispatch_async( dispatch_get_main_queue(), ^{
            callbackBlock(succeed, results);
        });
    });
}

- (void)searchByIngredient:(NSString *)keyword block:(void (^)(BOOL, NSArray *))callbackBlock {

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        BOOL succeed = NO;
        NSArray *results = nil;
        
        
        NSString *urlStr = [NSString stringWithFormat: @"http://api.yummly.com/v1/api/recipes?_app_id=39fd9427&_app_key=264eafb5fe4af135d19d0878c603c2a0%@",keyword];
        
//             NSString *urlStr = [NSString stringWithFormat: @"http://api.yummly.com/v1/api/recipes?_app_id=39fd9427&_app_key=264eafb5fe4af135d19d0878c603c2a0&q=pizza&allowedIngredient[]=garlic&allowedIngredient[]=pepper&allowedIngredient[]=tomatoes&allowedIngredient[]=mushrooms"];
        NSLog(@"New URl %@", urlStr);
        
        
        NSURL *url = [NSURL URLWithString:urlStr];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        NSURLResponse *response;
        NSError *error;
        
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
        if(!error)
        {
            
            results = [self parseRecipeSearchByIngredientResponse:responseData];
            if (results) {
                succeed = YES;
            }
        }
        
        
        dispatch_async( dispatch_get_main_queue(), ^{
            callbackBlock(succeed, results);
        });
    });

}


#pragma mark - JSON Serialization/Parse

- (NSArray*)parseRecipeSearchResponse:(NSData*)response {
    NSMutableArray *results = nil;
    
    NSError *error;
    NSDictionary* resultAsJSON = [NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:&error];
    if (!error) {
        //create array to store data from api
        NSArray *resultList = [resultAsJSON objectForKey:@"matches"];
        if (resultList) {
            results = [[NSMutableArray alloc] init];
            // create recipe objects from the dictionary and add it to the results array
            for (int i = 0; i < [resultList count]; i++) {
                NSDictionary *recipeAsDict = [resultList objectAtIndex:i];
                if (recipeAsDict)
                {
                    // get string in the dictionary according to their key
                    NSString *recipeId = [recipeAsDict objectForKey:@"id"];
                    NSString *title = [recipeAsDict objectForKey:@"recipeName"];
                    NSString *smallImage ;
                    NSString *largeImage;
                    
                    NSArray *urlArray = [recipeAsDict valueForKey:@"smallImageUrls"];
                    if (urlArray) {
                        if ([urlArray count] > 0) {
                            NSString *url = [urlArray objectAtIndex:0];
                            smallImage = url;
                        }
                    }
                   
                    NSArray *LargeImageArray = [recipeAsDict valueForKey:@"imageUrlsBySize"];
                    if (LargeImageArray) {
                        if ([LargeImageArray count] > 0) {
                            NSString *url = [urlArray objectAtIndex:0];
                            largeImage = url;
                        }
                    }
                    
                    
                    NSArray *ingredientsArray = [recipeAsDict valueForKey:@"ingredients"];
                    NSMutableString *str = [NSMutableString string];
                    
                    for (int i = 0; i < [ingredientsArray count]; i++) {
                        if (ingredientsArray[i] != 0) {
                            [str appendFormat:@"%@", ingredientsArray[i]];
                        }
                    }

                  
                    RecipeObject *recipe = [[RecipeObject alloc] initWithId:recipeId title:title thumbnailUrl:smallImage imageUrl:largeImage ingredients:str];
                    [results addObject:recipe];
                }
            }
        }
    }
    
    
    return results;
}

- (NSArray*)parseRecipeSearchByIngredientResponse:(NSData*)response {
    NSMutableArray *results = nil;
    
    [[DatabaseConnection DBconnection] OpenDB];

    
    NSError *error;
    NSDictionary* resultAsJSON = [NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:&error];
    if (!error) {
        //create array to store data from api
        NSArray *resultList = [resultAsJSON objectForKey:@"matches"];
        if (resultList) {
            results = [[NSMutableArray alloc] init];
            // create recipe objects from the dictionary and add it to the results array
            for (int i = 0; i < [resultList count]; i++) {
                NSDictionary *recipeAsDict = [resultList objectAtIndex:i];
                if (recipeAsDict)
                {
                    // get string in the dictionary according to their key
                    NSString *recipeId = [recipeAsDict objectForKey:@"id"];
                    NSString *title = [recipeAsDict objectForKey:@"recipeName"];
                    NSArray *ingredientsArray = [recipeAsDict valueForKey:@"ingredients"];
                    NSMutableString *str = [NSMutableString string];
                    
                    for (int i = 0; i < [ingredientsArray count]; i++) {
                        if (ingredientsArray[i] != 0) {
                            [str appendFormat:@",%@", ingredientsArray[i]];
                        }
                    }
                    
                    
                    RecipeByIngredient *recipe=[[RecipeByIngredient alloc] initWithId:recipeId title: title ingredients:ingredientsArray];
                    [results addObject:recipe];
                    
                    [[DatabaseConnection DBconnection] OpenDB];
                    [[DatabaseConnection DBconnection] saveData:recipeId name:title
                                                    ingredients:str];
                    
                    
                }
            }
        }
    }
    [[RequestManager manager] searchQuantityOfIngredient];
    
    return results;
}


#pragma mark detail request
- (void)downloadRecipeDetail:(NSString*)recipeId block:(void (^)(BOOL, RecipeInstructions *))callbackBlock {
   
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        BOOL succeed = NO;
        RecipeInstructions *recipeDetail = nil;
        
         NSString *urlStr = [NSString stringWithFormat:@"http://api.yummly.com/v1/api/recipe/%@?_app_id=39fd9427&_app_key=264eafb5fe4af135d19d0878c603c2a0", recipeId];
        
          NSLog(@"This is the url is %@", urlStr);
    
        
        NSURL *url = [NSURL URLWithString:urlStr];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        NSURLResponse *response;
        NSError *error;
        
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
        if(!error)
        {
           
            recipeDetail = [self parseRecipeDetailResponse:responseData];
            if (recipeDetail) {
                succeed = YES;
            }
        }
        
        
        dispatch_async( dispatch_get_main_queue(), ^{
            callbackBlock(succeed, recipeDetail);
        });
    });
}




- (RecipeInstructions*)parseRecipeDetailResponse:(NSData*)response {
    
    
    NSError *error;
    NSDictionary* resultAsJSON = [NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:&error];
    RecipeInstructions *recipeInstruction = [[RecipeInstructions alloc]init];

    if (!error) {
        
        NSString *recipeName = resultAsJSON[@"name"];
        NSLog(@"%@",recipeName);
        
        NSString *totalTime = resultAsJSON[@"totalTime"];
        NSDictionary *recipeSource = resultAsJSON[@"source"];
        NSArray *arrayImages = resultAsJSON[@"images"];
        NSArray *arrayIngredients = resultAsJSON[@"ingredientLines"];
        NSNumber *numberOfServings = resultAsJSON[@"numberOfServings"];
        NSString *sourceRecipeURL = resultAsJSON[@"source"][@"sourceRecipeUrl"];
        
        recipeInstruction.recipeName=recipeName;
        recipeInstruction.totalTime=totalTime;
        recipeInstruction.recipeURL=sourceRecipeURL;
        recipeInstruction.numberOfServings=numberOfServings;
        recipeInstruction.ingredientLines=arrayIngredients;
        recipeInstruction.sourceRecipeURL=recipeSource;
        for (NSDictionary *dict in arrayImages){
                      recipeInstruction.bigImage = dict[@"hostedLargeUrl"];
                    }
        
        
NSLog(@"SourceRecipe-%@",recipeInstruction.recipeURL);
        
        NSLog(@"recipe name-%@",recipeInstruction.recipeName);
//
//        recipeMethods= [[RecipeInstructions alloc] initWithId: recipeName recipeName: recipeName sourceRecipe: sourceRecipeURL imageUrl:sourceRecipeURL ingredients:arrayIngredients recipeURL:sourceRecipeURL totalTime:totalTime numberOfServings:numberOfServings];


        
        
    }
    
    return recipeInstruction;
}

-(void)searchQuantityOfIngredient {
    
   
        BOOL succeed = NO;
        NSArray *results = nil;
        
    [[DatabaseConnection DBconnection] OpenDB];
    NSArray * allRecipeIDs=[[DatabaseConnection DBconnection] readRecipeIDs];
    for (int i =0;i<allRecipeIDs.count; i++)
    {
    
    NSString *urlStr = [NSString stringWithFormat:@"http://api.yummly.com/v1/api/recipe/%@?_app_id=39fd9427&_app_key=264eafb5fe4af135d19d0878c603c2a0", allRecipeIDs[i]];
        
        
      //  NSLog(@"This is the url is %@", urlStr);
        
        NSURL *url = [NSURL URLWithString:urlStr];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        NSURLResponse *response;
        NSError *error;
        
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
        if(!error)
        {
            
            results = [self parseIngredients:responseData];
            if (results) {
                succeed = YES;
            }
        }
   
    }
  
        
}

- (NSArray*)parseIngredients:(NSData*)response {
    NSMutableArray *results = nil;
    
    [[DatabaseConnection DBconnection] OpenDB];
    
    
    NSError *error;
    NSDictionary* resultAsJSON = [NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:&error];
    

    if (!error) {
        
        NSString *title = resultAsJSON[@"name"];
         NSString *recipeId = resultAsJSON[@"id"];
        NSArray *ingredientsArray = resultAsJSON[@"ingredientLines"];
        NSMutableString *str = [NSMutableString string];
                    
                    for (int i = 0; i < [ingredientsArray count]; i++) {
                        if (ingredientsArray[i] != 0) {
                            [str appendFormat:@",%@", ingredientsArray[i]];
                        }
                    }
        
        RecipeByIngredient *recipe=[[RecipeByIngredient alloc] initWithId:recipeId title: title ingredients:ingredientsArray];
        [results addObject:recipe];
        
        [[DatabaseConnection DBconnection] OpenDB];
        [[DatabaseConnection DBconnection] saveQuantityOfIngredients:recipeId name:title
                                                    ingredients:str];
        
                    
                }
    return results;

    }
    

@end

