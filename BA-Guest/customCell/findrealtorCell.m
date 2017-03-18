//
//  findrealtorCell.m
//  BA-Guest
//
//  Created by roberto ramirez on 1/22/14.
//  Copyright (c) 2014 lovetthomes. All rights reserved.
//

#import "findrealtorCell.h"

@implementation findrealtorCell{
    UILabel *lblagent;
    UILabel *lblcompany;
    UILabel *lblstatus;
}

@synthesize regdate, brokername, agentname, email;

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
    
    lblagent = [[UILabel alloc] initWithFrame: CGRectMake( tx, 0, 90, 44)];
    lblagent.text=regdate;
    lblagent.textColor=[UIColor blackColor];
    [self.contentView addSubview: lblagent];
    tx=tx+90;
    
    UILabel * label = [[UILabel alloc] initWithFrame: CGRectMake( tx, 0, 1, 44)];
    label.backgroundColor=[UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1];
    [self.contentView addSubview: label];
    tx=tx+3;
    
    lblcompany = [[UILabel alloc] initWithFrame: CGRectMake( tx, 0, dw*.28, 44)];
    lblcompany.text=brokername;
    [self.contentView addSubview: lblcompany];
    tx=tx+dw*.28;
    
    label = [[UILabel alloc] initWithFrame: CGRectMake( tx, 0, 1, 44)];
    label.backgroundColor=[UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1];
    [self.contentView addSubview: label];
    tx=tx+3;
    
    lblcompany = [[UILabel alloc] initWithFrame: CGRectMake( tx, 0, dw*.28, 44)];
    lblcompany.text=agentname;
    [self.contentView addSubview: lblcompany];
    tx=tx+dw*.28;
    
    label = [[UILabel alloc] initWithFrame: CGRectMake( tx, 0, 1, 44)];
    label.backgroundColor=[UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1];
    [self.contentView addSubview: label];
    tx=tx+3;
    
    
    lblstatus = [[UILabel alloc] initWithFrame: CGRectMake( tx, 0, dw-tx, 44)];
    lblstatus.text=email;
    [self.contentView addSubview: lblstatus];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
