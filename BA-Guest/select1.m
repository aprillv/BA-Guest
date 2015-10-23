//
//  select1.m
//  BA-Guest
//
//  Created by roberto ramirez on 2/7/14.
//  Copyright (c) 2014 lovetthomes. All rights reserved.
//

#import "select1.h"
#import "select2.h"
#import "newguest.h"
#import "baControl.h"

@interface select1 ()

@end

@implementation select1{
    int donext;
}
@synthesize idcia, idweb, cianm, commnunitynm, idarea, idsub;

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
    
    [self doInitPage];
}

-(void)doInitPage{
    
    
    int x;
    int y;
    int xw;
    int xh;
    int xx;
    if (self.view.bounds.size.width==748.0f) {
        xx =135;
        xw= self.view.bounds.size.height;
        xh=self.view.bounds.size.width+1;
    }else{
        xx =112;
        xw= self.view.bounds.size.width;
        xh=self.view.bounds.size.height+1;
    }
    
    baControl *bc =[[baControl alloc]init];
    if ([idcia isEqualToString:@"100"] || [idcia isEqualToString:@"306"]) {
        self.view=[bc GetCommenFrame100r:xw andxh:xh];
    }else{
        self.view=[bc GetCommenFrame101r:xw andxh:xh];
    }
    
    UIButton *logoutbtn =[bc getButton:[UIColor grayColor] andrect:CGRectMake(0, 0, 130, 40)];
    logoutbtn.frame=CGRectMake(xw-150, 25, 130, 40);
    [logoutbtn setTitle:@"Logout" forState:UIControlStateNormal];
    [logoutbtn addTarget:self action:@selector(dologout:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:logoutbtn];
    
    
    UIScrollView *v3=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 120, xw, xh-185)];
    [self.view addSubview:v3];
    UIScrollView *sv=v3;
    
    y=0;
    x=15;
    sv.contentSize=CGSizeMake(xw,xh-183);
    
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(xx, y, 400, 45)];
    lbl.font=[UIFont systemFontOfSize:18.0];
    lbl.text=[NSString stringWithFormat:@"Thank you for visiting %@.", commnunitynm];
    [sv addSubview:lbl];
    y=y+200;
    
    xx=200;
    
    UIButton *btn1 = [bc getButton1:[UIColor orangeColor] andrect:CGRectMake(0, 0, 233, 133) andradius:25.0f];
    [btn1 setFrame:CGRectMake(xx, y, 233, 133)];
    [btn1 setTitle:@"New Guest" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(donewguest) forControlEvents:UIControlEventTouchDown];
    [sv addSubview:btn1];
    
    btn1 = [bc getButton1:[UIColor orangeColor] andrect:CGRectMake(0, 0, 233, 133) andradius:25.0f];
    [btn1 setFrame:CGRectMake(xx+400, y, 233, 133)];
    [btn1 setTitle:@"Return Guest" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchDown];
    [sv addSubview:btn1];
    y=y+50+x;
    
    
    
}

-(void)donewguest{
    donext=1;
  [self dosync1];
}

-(IBAction)login:(id)sender{
    donext=2;
    [self dosync1];
}

-(IBAction)dologout:(id)sender{
    donext=3;
     [self dosync1];
//    [self.navigationController popToRootViewControllerAnimated:NO];
    
    
}


-(void)CancletPin{
    [super CancletPin];
    if (donext==3) {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }else if(donext==2){
        select2 *tt = [select2 alloc];
        tt.managedObjectContext=self.managedObjectContext;
        tt.idweb=self.idweb;
        tt.idcia=self.idcia;
        tt.cianm=self.cianm;
        tt.commnunitynm=self.commnunitynm;
        tt.idarea=self.idarea;
        tt.idsub=self.idsub;
        [self.navigationController pushViewController:tt animated:NO];
    }else{
        newguest *tt = [newguest alloc];
        tt.managedObjectContext=self.managedObjectContext;
        tt.idweb=self.idweb;
        tt.idcia=self.idcia;
        tt.cianm=self.cianm;
        tt.commnunitynm=self.commnunitynm;
        tt.idarea=self.idarea;
        tt.idsub=self.idsub;
        tt.fromsearch=NO;
        [self.navigationController pushViewController:tt animated:NO];
    }
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
