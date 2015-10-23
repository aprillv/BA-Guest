//
//  findrealtorfirstCell.m
//  BA-Guest
//
//  Created by roberto ramirez on 1/22/14.
//  Copyright (c) 2014 lovetthomes. All rights reserved.
//

#import "findrealtorfirstCell.h"

@implementation findrealtorfirstCell{
    BOOL agentup;
    BOOL cnameup;
    BOOL statusup;
}

@synthesize delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        agentup=NO;
        cnameup=NO;
        statusup=NO;
        // Initialization code
    }
    return self;
}



- (void)drawRect:(CGRect)rect{
    int tx=0;
    int dw =self.frame.size.width;
    UIButton *btn1 = [[UIButton alloc] initWithFrame: CGRectMake( tx, 0, 92, 44)];
    
    [btn1 setTitle:@"Reg.Date" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn1 setBackgroundColor:[UIColor lightGrayColor]];
    //     btn1.autoresizingMask=UIViewAutoresizingFlexibleWidth;
    //    [btn1.titleLabel setFont:[UIFont boldSystemFontOfSize:17.0]];
    //     [btn1 setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [btn1 addTarget:self action:@selector(idclick) forControlEvents:UIControlEventTouchDown];
    [self.contentView addSubview:btn1];
    tx= tx+92;
    
    UILabel* label = [[UILabel alloc] initWithFrame: CGRectMake( tx, 0, 1, 44)];
    label.backgroundColor=[UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1];
    //     label.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin;
    [self.contentView addSubview: label];
    tx=tx+1;
    
    btn1 = [[UIButton alloc] initWithFrame: CGRectMake( tx, 0, dw*.28+2, 44)];
    [btn1 setTitle:@"Broker Name" forState:UIControlStateNormal];
    //     [btn1.titleLabel setFont:[UIFont boldSystemFontOfSize:17.0]];
    [btn1 setBackgroundColor:[UIColor lightGrayColor]];
    //     btn1.autoresizingMask=UIViewAutoresizingFlexibleWidth;
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(pronameclick) forControlEvents:UIControlEventTouchDown];
    [self.contentView addSubview:btn1];
    tx= tx+dw*.28+2;
    
    label = [[UILabel alloc] initWithFrame: CGRectMake( tx, 0, 1, 44)];
    label.backgroundColor=[UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1];
    //     label.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin;
    [self.contentView addSubview: label];
    tx=tx+1;
    
    btn1 = [[UIButton alloc] initWithFrame: CGRectMake( tx, 0, dw*.28+2, 44)];
    [btn1 setTitle:@"Agent Name" forState:UIControlStateNormal];
    //     [btn1.titleLabel setFont:[UIFont boldSystemFontOfSize:17.0]];
    [btn1 setBackgroundColor:[UIColor lightGrayColor]];
    //     btn1.autoresizingMask=UIViewAutoresizingFlexibleWidth;
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(pronameclick) forControlEvents:UIControlEventTouchDown];
    [self.contentView addSubview:btn1];
    tx= tx+dw*.28+2;
    
    
    label = [[UILabel alloc] initWithFrame: CGRectMake( tx, 0, 1, 44)];
    label.backgroundColor=[UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1];
    //     label.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin;
    [self.contentView addSubview: label];
    tx=tx+1;
    
    btn1 = [[UIButton alloc] initWithFrame: CGRectMake( tx, 0, dw-tx, 44)];
    [btn1 setTitle:@"Email" forState:UIControlStateNormal];
    //     [btn1.titleLabel setFont:[UIFont boldSystemFontOfSize:17.0]];
    [btn1 setBackgroundColor:[UIColor lightGrayColor]];
    //     btn1.autoresizingMask=UIViewAutoresizingFlexibleWidth;
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(statusclick) forControlEvents:UIControlEventTouchDown];
    [self.contentView addSubview:btn1];
    
}
//
//cell.agent=cia.NAgent;
//cell.company=cia.NCompany;
//cell.Status=cia.Status;

-(void)idclick{
    agentup=!agentup;
    if (delegate) {
        return [delegate doaClickeded:@"NAgent" :agentup];
    }
}
-(void)pronameclick{
    cnameup=!cnameup;
    if (delegate) {
        return [delegate doaClickeded:@"NCompany" :cnameup];
    }
}
-(void)statusclick{
    cnameup=!cnameup;
    if (delegate) {
        return [delegate doaClickeded:@"Status" :cnameup];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
