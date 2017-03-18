//
//  communityfirstcell.m
//  BA-Guest
//
//  Created by roberto ramirez on 1/22/14.
//  Copyright (c) 2014 lovetthomes. All rights reserved.
//

#import "communityfirstcell.h"

@implementation communityfirstcell{
    BOOL idup;
    BOOL cnameup;
}


@synthesize delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        idup=NO;
        cnameup=NO;
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    int tx=0;
    int dw =self.frame.size.width;
    UIButton *btn1 = [[UIButton alloc] initWithFrame: CGRectMake( tx, 0, 112, 44)];
    
    [btn1 setTitle:@"Co.#" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn1 setBackgroundColor:[UIColor lightGrayColor]];
    [btn1 addTarget:self action:@selector(idclick) forControlEvents:UIControlEventTouchDown];
    [self.contentView addSubview:btn1];
    tx= tx+112;
    
    UILabel* label = [[UILabel alloc] initWithFrame: CGRectMake( tx, 0, 1, 44)];
    label.backgroundColor=[UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1];
    [self.contentView addSubview: label];
    tx=tx+1;
    
    btn1 = [[UIButton alloc] initWithFrame: CGRectMake( tx, 0, dw*.2, 44)];
    [btn1 setTitle:@"Company" forState:UIControlStateNormal];
    [btn1 setBackgroundColor:[UIColor lightGrayColor]];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(pronameclick) forControlEvents:UIControlEventTouchDown];
    [self.contentView addSubview:btn1];
    tx= tx+dw*0.2;
    
    label = [[UILabel alloc] initWithFrame: CGRectMake( tx, 0, 1, 44)];
    label.backgroundColor=[UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1];
    [self.contentView addSubview: label];
    tx=tx+1;
    
    btn1 = [[UIButton alloc] initWithFrame: CGRectMake( tx, 0, dw*0.12, 44)];
    [btn1 setTitle:@"City" forState:UIControlStateNormal];
    [btn1 setBackgroundColor:[UIColor lightGrayColor]];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(pronameclick1) forControlEvents:UIControlEventTouchDown];
    [self.contentView addSubview:btn1];
   tx= tx+dw*0.12;
    
    label = [[UILabel alloc] initWithFrame: CGRectMake( tx, 0, 1, 44)];
    label.backgroundColor=[UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1];
    [self.contentView addSubview: label];
    tx=tx+1;
    
    btn1 = [[UIButton alloc] initWithFrame: CGRectMake( tx, 0, dw*.24, 44)];
    [btn1 setTitle:@"Area Name" forState:UIControlStateNormal];
    [btn1 setBackgroundColor:[UIColor lightGrayColor]];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(pronameclick2) forControlEvents:UIControlEventTouchDown];
    [self.contentView addSubview:btn1];
    tx= tx+dw*0.24;
    
    label = [[UILabel alloc] initWithFrame: CGRectMake( tx, 0, 1, 44)];
    label.backgroundColor=[UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1];
    [self.contentView addSubview: label];
    tx=tx+1;
    
    btn1 = [[UIButton alloc] initWithFrame: CGRectMake( tx, 0, dw-tx, 44)];
    [btn1 setTitle:@"Web Community" forState:UIControlStateNormal];
    [btn1 setBackgroundColor:[UIColor lightGrayColor]];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(pronameclick3) forControlEvents:UIControlEventTouchDown];
    [self.contentView addSubview:btn1];
}
//cell.idcia=cia.IdCia;
//cell.webnm=cia.WebCommunity;
//cell.webarea=cia.WebArea;
//cell.city=cia.City;
//cell.cianame=cia.CiaName;
-(void)idclick{
    idup=!idup;
    if (delegate) {
        return [delegate doaClicked:@"IdCia" :idup];
    }
}
-(void)pronameclick{
    cnameup=!cnameup;
    if (delegate) {
        return [delegate doaClicked:@"CiaName" :cnameup];
    }
}

-(void)pronameclick1{
    cnameup=!cnameup;
    if (delegate) {
        return [delegate doaClicked:@"City" :cnameup];
    }
}

-(void)pronameclick2{
    cnameup=!cnameup;
    if (delegate) {
        return [delegate doaClicked:@"WebArea" :cnameup];
    }
}
-(void)pronameclick3{
    cnameup=!cnameup;
    if (delegate) {
        return [delegate doaClicked:@"WebCommunity" :cnameup];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
