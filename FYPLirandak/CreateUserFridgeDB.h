//
//  CreateUserFridgeDB.h
//  FYPLirandak
//
//  Created by Liranda Krasniqi on 09/04/2016.
//  Copyright © 2016 Liranda Krasniqi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
//http://www.tutorialspoint.com/ios/ios_sqlite_database.htm

@interface CreateUserFridgeDB : NSObject

{
    NSString *pathtoDB;
}

+(CreateUserFridgeDB*)getSharedInstance;
-(BOOL)createDB;
-(BOOL) saveData;
- (NSArray*) returnUsersIngredients;
-(NSString* ) readUserDetails;

@end
