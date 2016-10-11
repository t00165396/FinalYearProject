//
//  CreateUserFridgeDB.m
//  FYPLirandak
//
//  Created by Liranda Krasniqi on 09/04/2016.
//  Copyright © 2016 Liranda Krasniqi. All rights reserved.
//

#import "CreateUserFridgeDB.h"

static CreateUserFridgeDB *sharedInstance = nil;
static sqlite3 *database = nil;
static sqlite3_stmt *statement = nil;

@implementation CreateUserFridgeDB

+(CreateUserFridgeDB*)getSharedInstance{
    if (!sharedInstance) {
        sharedInstance = [[super allocWithZone:NULL]init];
        [sharedInstance createDB];
    }
    return sharedInstance;
}

//http://www.tutorialspoint.com/ios/ios_sqlite_database.htm

-(BOOL)createDB{
    NSString *docsDir;
    NSArray *dirPaths;
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    // Build the path to the database file
   
    
//    pathtoDB = [[NSString alloc] initWithString:
//                [docsDir stringByAppendingPathComponent: @"UsersFridge.sqlite"]];
    pathtoDB = [[NSBundle mainBundle] pathForResource:@"UsersFridge" ofType:@"sqlite"];
    
    
    NSLog(@"%@", pathtoDB);
    
    BOOL isSuccess = YES;
    NSFileManager *filemgr = [NSFileManager defaultManager];
    if ([filemgr fileExistsAtPath: pathtoDB ] == NO)
    {
        const char *dbpath = [pathtoDB UTF8String];
        if (sqlite3_open(dbpath, &database) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt =
            "CREATE TABLE IF NOT EXISTS fridge_contents(item_id INTEGER PRIMARY KEY AUTOINCREMENT,Name TEXT, Quantity Text,expiration_date TEXT DEFAULT NULL);";
            if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg)
                != SQLITE_OK)
            {
                isSuccess = NO;
                NSLog(@"Failed to create table");
            }
            sqlite3_close(database);
            return  isSuccess;
        }
        else {
            isSuccess = NO;
            NSLog(@"Failed to open/create database");
        }
    }
    return isSuccess;
}

- (BOOL) saveData
{
    
    const char *dbpath = [pathtoDB UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO fridge_contents (Name,Quantity) values('Eggs','12') INSERT INTO fridge_contents (Name,Quantity) values(' Milk','1 litre');"];
                                const char *insert_stmt = [insertSQL UTF8String];
                                sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
                                if (sqlite3_step(statement) == SQLITE_DONE)
                                {
                                    return YES;
                                } 
                                else {
                                    return NO;
                                }
                                sqlite3_reset(statement);
                                }
                                return NO;
    
    
}

- (NSArray*) returnUsersIngredients
{
    const char *dbpath = [pathtoDB UTF8String];
    NSMutableArray *resultArray = [[NSMutableArray alloc]init];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"select * from fridge_contents;" ];
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(database,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            
                while(sqlite3_step(statement) == SQLITE_ROW)
                {
                    @try{
//                
//                        NSString *quantity = [[NSString alloc]initWithUTF8String:
//                                              (const char *) sqlite3_column_text(statement, 2)];
//                        [resultArray addObject:quantity];
                NSString *name = [[NSString alloc] initWithUTF8String:
                                        (const char *) sqlite3_column_text(statement, 1)];
                [resultArray addObject:name];
                
                
            }
            
                
                    @catch (NSException * e) {
                        NSLog(@"Exception: %@", e);
                    }
            
        }
            }
    
    }
    return resultArray;
}


- (NSString*) readUserDetails
{
    
    const char *dbpath = [pathtoDB UTF8String];
    sqlite3_stmt    *statement;
    NSString*userDetails;
    
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT * From Users"];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while(sqlite3_step(statement) == SQLITE_ROW)
            {
                @try{
                    userDetails = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                   
                    
                }
                @catch (NSException * e) {
                    NSLog(@"Exception: %@", e);
                }
            }
            
            
            sqlite3_finalize(statement);
        }
        sqlite3_close(database);
    }
    return userDetails;
}
                                                        


@end
