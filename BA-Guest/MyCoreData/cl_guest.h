//
//  cl_guest.h
//  BA-Guest
//
//  Created by roberto ramirez on 2/5/14.
//  Copyright (c) 2014 lovetthomes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface cl_guest : NSObject
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

-(BOOL)addToGuest:(NSManagedObject *)steve;
-(NSMutableArray *)getGuest;

-(BOOL)deleteData;

@end
