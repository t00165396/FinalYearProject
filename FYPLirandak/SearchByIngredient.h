//
//  SearchByIngredient.h
//  FYPLirandak
//
//  Created by Liranda Krasniqi on 01/03/2016.
//  Copyright © 2016 Liranda Krasniqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchByIngredient : NSObject

- (void)searchForRecipe:(NSString*)keyword block:(void (^)(BOOL succeed, NSArray *recipeObjectArray))callbackBlock;

@end
