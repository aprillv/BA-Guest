//
//  reminderCell.m
//  BA-Guest
//
//  Created by roberto ramirez on 1/24/14.
//  Copyright (c) 2014 lovetthomes. All rights reserved.
//

#import "reminderCell.h"

@implementation reminderCell{
    UILabel *lblagent;
    UILabel *lblcompany;
    UILabel *lblstatus;
}

@synthesize consultant, webcommunity, subject;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}



- (void)drawRect:(CGRect)rect{
    int tx=2;
    int dw =self.frame.size.width;
    
    lblagent = [[UILabel alloc] initWithFrame: CGRectMake( tx, 0, dw*.2, 44)];
    lblagent.text=consultant;
    lblagent.textColor=[UIColor blackColor];
    [self.contentView addSubview: lblagent];
    tx=tx+dw*.2;
    
    UILabel * label = [[UILabel alloc] initWithFrame: CGRectMake( tx, 0, 1, 44)];
    label.backgroundColor=[UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1];
    [self.contentView addSubview: label];
    tx=tx+3;
    
    lblcompany = [[UILabel alloc] initWithFrame: CGRectMake( tx, 0, dw*.3, 44)];
    lblcompany.text=webcommunity;
    [self.contentView addSubview: lblcompany];
    tx=tx+dw*.3;
    
    label = [[UILabel alloc] initWithFrame: CGRectMake( tx, 0, 1, 44)];
    label.backgroundColor=[UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1];
    [self.contentView addSubview: label];
    tx=tx+3;
    
    
    
    lblstatus = [[UILabel alloc] initWithFrame: CGRectMake( tx, 0, dw-tx, 44)];
    lblstatus.text=subject;
    [self.contentView addSubview: lblstatus];
}

//-(void)SetDetailWithId:(NSString *)idd withName:(NSString *)name WithPname:(NSString *)pname WithStatus:(NSString *)status{
//    [lblid setText:idd];
//    [lblname setText:name];
//    [lblpname setText:pname];
//    [lblstatus setText:status];
//
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
