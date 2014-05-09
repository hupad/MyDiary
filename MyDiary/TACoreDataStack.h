//
//  TACoreDataStack.h
//  MyDiary
//
//  Created by Harish Upadhyayula on 5/7/14.
//  Copyright (c) 2014 tensor apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TACoreDataStack : NSObject

+ (instancetype)defaultStack;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
