//
//  cl_guest.m
//  BA-Guest
//
//  Created by roberto ramirez on 2/5/14.
//  Copyright (c) 2014 lovetthomes. All rights reserved.
//

#import "cl_guest.h"

@implementation cl_guest
@synthesize managedObjectContext;

-(BOOL)addToGuest:(NSManagedObject *)steve{
    NSError *error = nil;
    
    
    
    BOOL isSaveSuccess=[self.managedObjectContext save:&error];
    
    if (!isSaveSuccess) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"BA-Guest"
                              message:[NSString stringWithFormat:@"Error: %@,%@",error,[error userInfo]]
                              delegate:self
                              cancelButtonTitle:nil
                              otherButtonTitles:@"OK", nil];
        [alert show];
        return NO;
    }
    
    return  YES;
}

-(NSMutableArray *)getGuest{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Guest" inManagedObjectContext:self.managedObjectContext];
    [request setEntity:entity];
        
       
        NSPredicate *predicate = [NSPredicate predicateWithFormat: @"submityn =0"];
        [request setPredicate:predicate];
        
        NSSortDescriptor *sortDescriptor =[[NSSortDescriptor alloc]initWithKey:@"refdate" ascending:YES];
        
        NSArray *sortDescriptions = [[NSArray alloc]initWithObjects:sortDescriptor, nil];
        [request setSortDescriptors:sortDescriptions];
        
        NSError *error = nil;
        NSMutableArray *rtnlist= [[self.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
        
        //    [rtnlist sortUsingComparator:^NSComparisonResult(NSEntityDescription * obj1, NSEntityDescription * obj2) {
        //        if ([obj1 valueForKey:@"planname"]==nil || [[obj1 valueForKey:@"planname"] isEqualToString:@""]) {
        //            return NSOrderedDescending;
        //        }else{
        //            return  NSOrderedAscending;
        //        }
        //
        //    }];
        
            for (entity in rtnlist) {
                NSLog(@"%@", entity);
            }
        
        //    NSLog(@"%@", [entity valueForKey:@"idnumber"]);
        return rtnlist;
}

-(BOOL)deleteData{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Guest"inManagedObjectContext:self.managedObjectContext];
    [request setEntity:entity];
    
    NSError *error = nil;
    NSMutableArray *mutableFetchResult = [[self.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResult == nil) {
        NSLog(@"Error: %@,%@",error,[error userInfo]);
    }
    for (NSManagedObject *entry1 in mutableFetchResult) {
        [self.managedObjectContext deleteObject:entry1];
        
    }
    
    if (![self.managedObjectContext save:&error]) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"BuildersAccess"
                              message:[NSString stringWithFormat:@"Error: %@,%@",error,[error userInfo]]
                              delegate:self
                              cancelButtonTitle:nil
                              otherButtonTitles:@"OK", nil];
        [alert show];
        return NO;
    }
    return  YES;

}

@end
