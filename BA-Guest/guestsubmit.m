
//
//  guestsubmit.m
//  BA-Guest
//
//  Created by roberto ramirez on 2/5/14.
//  Copyright (c) 2014 lovetthomes. All rights reserved.
//

#import "guestsubmit.h"
#import "baControl.h"

@interface guestsubmit ()

@end

@implementation guestsubmit

@synthesize addmsg, idcia, commnunitynm;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self doinit];
}


-(void)doinit{
    //    int x;
    int y;
    int xw;
    int xh;
    int xx;
    if (self.view.bounds.size.width==748.0f) {
        xx =150;
        xw= self.view.bounds.size.height;
        xh=self.view.bounds.size.width+1;
    }else{
        xx =112;
        xw= self.view.bounds.size.width;
        xh=self.view.bounds.size.height+1;
    }
    
    baControl *bc =[[baControl alloc]init];
    if ([idcia isEqualToString:@"101"]  || [idcia isEqualToString:@"306"]) {
        self.view=[bc GetCommenFrame101:xw andxh:xh];
    }else{
        self.view=[bc GetCommenFrame100:xw andxh:xh];
    }
    
//    UIButton *logoutbtn =[bc getButton:[UIColor grayColor] andrect:CGRectMake(0, 0, 130, 40)];
//    logoutbtn.frame=CGRectMake(xw-150, 40, 130, 40);
//    [logoutbtn setTitle:@"Logout" forState:UIControlStateNormal];
//    [logoutbtn addTarget:self action:@selector(dologout:) forControlEvents:UIControlEventTouchDown];
//    [self.view addSubview:logoutbtn];
    
    
    UIScrollView *sv =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 160, xw, xh-204)];
    sv.contentSize=CGSizeMake(xw, xh-203);
    [self.view addSubview:sv];
    
    
    xx=125;
    y=50;
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(xx+160, y, 500, 75)];
    lbl.numberOfLines=2;
    lbl.font=[UIFont systemFontOfSize:20.0f];
    lbl.text=[NSString stringWithFormat:@"Thank you for registering with %@.\nWe look forward to helping you find your new home.", commnunitynm];
    [sv addSubview:lbl];
    y=y+120;
    
//    lbl=[[UILabel alloc]initWithFrame:CGRectMake(xx, y, xw-xx*2, 70)];
//    lbl.numberOfLines=3;
////    lbl.font=[UIFont systemFontOfSize:20.0f];
//    lbl.text=addmsg;
//    [sv addSubview:lbl];
//    y=y+100;
    
//   UIButton * btn1 = [bc getButton:[UIColor orangeColor] andrect:CGRectMake(0, 250, 280, 44)];
//    [btn1 setFrame:CGRectMake(xx+250, y, 280, 44)];
//    [btn1 setTitle:@"Close" forState:UIControlStateNormal];
//    [btn1 addTarget:self action:@selector(doclear:) forControlEvents:UIControlEventTouchDown];
//    [sv addSubview:btn1];
    
   UIButton * btn1 = [bc getButton:[UIColor orangeColor] andrect:CGRectMake(0, 0, 380, 44)];
    [btn1 setFrame:CGRectMake(xx+250+40, y, 200, 44)];
    [btn1 setTitle:@"Close" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(doclear:) forControlEvents:UIControlEventTouchDown];
    [sv addSubview:btn1];
    
    
   
}




-(IBAction)doclear:(id)sender{
    
    [self dosync1];
}

-(void)CancletPin{
    [super CancletPin];
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:NO];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
