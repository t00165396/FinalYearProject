//
//  DatabaseConnection.m
//  FYPLirandak
//
//  Created by Liranda Krasniqi on 01/03/2016.
//  Copyright © 2016 Liranda Krasniqi. All rights reserved.
//

#import "DatabaseConnection.h"
#import <sqlite3.h>
#import "RecipeByIngredient.h"

@interface RecipeByIngredient ()
@property (nonatomic, strong) RecipeByIngredient *recipeByingredient;

@end


@implementation DatabaseConnection

static DatabaseConnection* sharedInstance;
static sqlite3 *database = nil;
static sqlite3_stmt *statement = nil;

+(DatabaseConnection *)DBconnection {
    if (!sharedInstance)
    {
        sharedInstance = [[DatabaseConnection alloc] init];
    }
    
    return sharedInstance;
}


//http://www.tutorialspoint.com/ios/ios_sqlite_database.htm
NSString *databasePath;

sqlite3 *contactDB;

- (void)OpenDB {
    
    NSString *docsDir;
    NSArray *dirPaths;
    

    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //docsDir = [dirPaths objectAtIndex:0];
    docsDir = dirPaths[0];
    
    // Build the path to the database file
   databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"recipe.sqlite"]];
//
   // databasePath = [[NSBundle mainBundle] pathForResource:@"recipe" ofType:@"sqlite"];
    

    
    NSLog(@"%@", databasePath);
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath: databasePath ] == NO)
    {
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &contactDB) != SQLITE_OK)
        {
            char *errMsg;

             const char *sql_stmt = "CREATE TABLE IF NOT EXISTS RECIPES(ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, INGRIDIENTS TEXT,recipeID TEXT)";
            const char *sql_stmt1 = "CREATE TABLE IF NOT EXISTS RecipeWithIngridients(ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, INGRIDIENTS TEXT,recipeID TEXT)";

            
            if (sqlite3_exec(contactDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                NSLog(@"Failed to create table");

            }
            
            if (sqlite3_exec(contactDB, sql_stmt1, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                NSLog(@"Failed to create  table");
                
            }
            sqlite3_close(contactDB);
            
            
        } else {
            NSLog(@"Failed to open/create database");
        }
        
        
        
    }
}




- (void) saveData: (NSString*) recipeID name:(NSString*)name  ingredients:(NSString*)ingredients
{
    
 
    sqlite3_stmt    *statement;
//   // RecipeByIngredient *recipeByingredient;

    
    const char *dbpath = [databasePath UTF8String];
   
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO RECIPES( NAME, INGRIDIENTS, recipeID) VALUES ( \"%@\",  \"%@\",\"%@\")", name, ingredients,recipeID];
        
        const char *insert_stmt = [insertSQL UTF8String];
        
        sqlite3_prepare_v2(contactDB, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
              NSLog(@"Recipe has been added");
            
        } else {
            NSLog(@"Failed to add recipe");
        }
        sqlite3_finalize(statement);
        sqlite3_close(contactDB);
    }
}

- (void) saveQuantityOfIngredients: (NSString*) recipeID name:(NSString*)name  ingredients:(NSString*)ingredients
{
    sqlite3_stmt    *statement;
    
    const char *dbpath = [databasePath UTF8String];
    
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO RecipeWithIngridients( NAME, INGRIDIENTS, recipeID) VALUES ( \"%@\",  \"%@\",\"%@\")",name, ingredients,recipeID];
        
        const char *insert_stmt = [insertSQL UTF8String];
        
        sqlite3_prepare_v2(contactDB, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"RecipeWithIngridients  has been added");
            
        } else {
            NSLog(@"Failed to add RecipeWithIngridients");
        }
        sqlite3_finalize(statement);
        sqlite3_close(contactDB);
    }
}

-(void)SaveRecipeIDs:(NSString *)recipeID

{
    
    
    sqlite3_stmt    *statement;
    //   // RecipeByIngredient *recipeByingredient;
    
    
    const char *dbpath = [databasePath UTF8String];
    
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO RecipeIDs( recipeID) VALUES ( \"%@\")",recipeID];
        
        const char *insert_stmt = [insertSQL UTF8String];
        
        sqlite3_prepare_v2(contactDB, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"id has been added");
            
        } else {
            NSLog(@"Failed to add id");
        }
        sqlite3_finalize(statement);
        sqlite3_close(contactDB);
    }

}

-(void)SaveUserIngridients:(NSMutableArray *)ingridients

{
    
    
    sqlite3_stmt    *statement;
    //   // RecipeByIngredient *recipeByingredient;
    
    
    const char *dbpath = [databasePath UTF8String];
    
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO UserIngridients(name) VALUES ( \"%@\")",ingridients];
        
        const char *insert_stmt = [insertSQL UTF8String];
        
        sqlite3_prepare_v2(contactDB, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"ingridients has been added");
            
        } else {
            NSLog(@"Failed to add ingridient");
        }
        sqlite3_finalize(statement);
        sqlite3_close(contactDB);
    }
    
}

-(void)deleteRecipeIDsTable{
    
  
    sqlite3_stmt    *statement;

    
    const char *dbpath = [databasePath UTF8String];
    
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *deleteSQL = [NSString stringWithFormat: @"Delete From RecipeIDs"];
        
        const char *delete_stmt = [deleteSQL UTF8String];
        
        sqlite3_prepare_v2(contactDB, delete_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"Table has been deleted");
            
        } else {
            NSLog(@"Failed to delete table");
        }
        sqlite3_finalize(statement);
        sqlite3_close(contactDB);
    }


}


- (NSMutableArray*) readRecipeIDs
{
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt    *statement;
    NSMutableArray *recipId =[[NSMutableArray alloc] init];
   NSString*recipIdAstring;
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT * From RECIPES"];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
          while(sqlite3_step(statement) == SQLITE_ROW)
            {
                @try{
                recipIdAstring = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                    [recipId addObject:recipIdAstring];
                   // NSLog(@" this is the recipe id %@ ",recipId);
               
//                
//                NSString *recipeID = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                
                NSString *ingridients = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                
            }
                @catch (NSException * e) {
                    NSLog(@"Exception: %@", e);
                }
            }
            
            
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    return recipId;
}

-(NSMutableArray*) readRecipeIDsToBeDisplayedtoUser{

    
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt    *statement;
    NSMutableArray *recipId =[[NSMutableArray alloc] init];
    NSString*recipIdAstring;
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT * From RecipeIDs"];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while(sqlite3_step(statement) == SQLITE_ROW)
            {
                @try{
                    recipIdAstring = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                    [recipId addObject:recipIdAstring];
                 
                    
                }
                @catch (NSException * e) {
                    NSLog(@"Exception: %@", e);
                }
            }
            
            
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    return recipId;
}


- (NSMutableArray*) readAllRecipes
{
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt    *statement;
    NSMutableArray *outer =[[NSMutableArray alloc] init];
    
    NSString*recipeIngreidientsAsString;
    NSString *recipeID;
    
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT * From RecipeWithIngridients"];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while(sqlite3_step(statement) == SQLITE_ROW)
            {
                @try{
                    NSMutableArray *inner =[[NSMutableArray alloc] init];
                    
                     recipeID = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                    [inner addObject:recipeID];
                   
                    
                    recipeIngreidientsAsString = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                    //[recipes addObject:recipeIngreidientsAsString];
                    // NSLog(@" this is the recipe ing %@ ",recipeIngreidientsAsString);
                  NSArray *parsedIngredients = [recipeIngreidientsAsString componentsSeparatedByString:@","];
                    
                    [inner addObjectsFromArray :parsedIngredients];
                    
                    //[recipes addObject:recipeDetails];
                    
//                    [outer insertObject: [NSArray arrayWithObjects: inner, nil] atIndex: count];
//                    count++;
                    
                    [outer addObject:inner];
                 

                 
                    
                }
                @catch (NSException * e) {
                    NSLog(@"Exception: %@", e);
                }
            }
            
            
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    return outer;
}

-(NSString*) readUserChosenIngridients{
    
    
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt    *statement;
    
    NSString*userChosenIngridient;
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT * From UserIngridients ORDER BY IngID DESC LIMIT 1"];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while(sqlite3_step(statement) == SQLITE_ROW)
            {
                @try{
                    userChosenIngridient = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                  
                
                }
                @catch (NSException * e) {
                    NSLog(@"Exception: %@", e);
                }
            }
            
            
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    return userChosenIngridient;
}



-(void)copyDB{
    sqlite3 *database;
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"recipe.sqlite"];
    success = [fileManager fileExistsAtPath:writableDBPath];
    // The writable database does not exist, so copy the default to the appropriate location.
    if(!success)
    {
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"recipe.sqlite"];
        success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
        if (!success) {
            NSLog(@"%s","Failed to copy DB");
            return;
        }
    }
  

}
@end
