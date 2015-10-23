//
//  projectCell.h
//  BuildersAccess
//
//  Created by roberto ramirez on 11/14/13.
//  Copyright (c) 2013 eloveit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface realtorCell : UITableViewCell
//-(void)SetDetailWithId:(NSString *)idd withName:(NSString *)name WithPname:(NSString *)pname WithStatus:(NSString *)status;
@property (nonatomic, retain)  NSString         *agent;
@property (nonatomic, retain)  NSString         *company;
@property (nonatomic, retain)  NSString         *status;
@end
