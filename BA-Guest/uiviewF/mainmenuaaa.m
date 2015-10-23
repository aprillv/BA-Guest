//
//  mainmenuaaa.m
//  BuildersAccess
//
//  Created by amy zhao on 13-6-4.
//  Copyright (c) 2013年 eloveit. All rights reserved.
//

#import "mainmenuaaa.h"
//#import "ciaList.h"
#import "wcfKeyValueItem.h"
#import <QuartzCore/QuartzCore.h>
#import "Mysql.h"
//#import "favorite.h"
//#import "myprofile.h"
//#import "cl_cia.h"
#import "userInfo.h"
//#import "cl_phone.h"
//#import "cl_project.h"
#import "Reachability.h"
//#import "phonelist.h"
//#import "projectls.h"
#import "MBProgressHUD.h"
#import "wcfService.h"
//#import "cl_sync.h"
//#import "forapprove.h"
#import "mastercialist.h"
//#import "kirbytitle.h"
//#import "mainmenu.h"
#import "cl_config.h"
#import "baControl.h"
//#import "qacalendarViewController.h"
//#import "multiSearch.h"
//#import "cialist.h"
//#import "newRealtor1.h"
//#import "realtor.h"

#define NAVBAR_HEIGHT   44

@interface mainmenuaaa ()<MBProgressHUDDelegate>{
    MBProgressHUD *HUD;
}
@end

int currentpage, pageno;
NSString *atitle;

@implementation mainmenuaaa{
    int tbindex2;
}
@synthesize  navigationBar, tbindex, xget, menulist, detailstrarr, uw;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    return self;
}

- (void)loadView {
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.view = view;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
   
    self.navigationController.navigationBarHidden=YES;
    if (!menulist) {
        self.menulist =[[NSMutableArray alloc]init];
        self.detailstrarr=[[NSMutableArray alloc]init];
        wcfKeyValueItem *kv;
        NSString *details;
        kv =[[wcfKeyValueItem alloc]init];
        kv.Key=@"New Realtors";
        details = @"";
        [detailstrarr addObject:details];
        kv.Value=@"add.png";
        [menulist addObject:kv];
        
        kv =[[wcfKeyValueItem alloc]init];
        kv.Key=@"New Guest with Realtor";
        details = @"";
        [detailstrarr addObject:details];
        kv.Value=@"add.png";
        [menulist addObject:kv];
        
        kv =[[wcfKeyValueItem alloc]init];
        kv.Key=@"New Guest without Realtor";
        details = @"";
        [detailstrarr addObject:details];
        kv.Value=@"add.png";
        [menulist addObject:kv];
        
        kv =[[wcfKeyValueItem alloc]init];
        kv.Key=@"Realtor Multi Search";
        kv.Value=@"zoom.png";
        details = @"";
        [detailstrarr addObject:details];
        [menulist addObject:kv];
        kv =[[wcfKeyValueItem alloc]init];
        kv.Key=@"Guest Multi Search";
        kv.Value=@"zoom.png";
        details = @"";
        [detailstrarr addObject:details];
        [menulist addObject:kv];
        
    }
    
    int xw;
    int xh;
    if (self.view.bounds.size.width==748.0f) {
        xw= self.view.bounds.size.height;
        xh=self.view.bounds.size.width+1;
        
    }else{
        xw= self.view.bounds.size.width;
        xh=self.view.bounds.size.height+1;
    }
    
    
    UINavigationBar* navigationBar1 =  [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 300, NAVBAR_HEIGHT)];
//    navigationBar1.tintColor=[UIColor colorWithRed:0.1960784314 green:0.30980392159999998 blue:0.52156862749999999 alpha:1.f];
    UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:@"Menu"];
//    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"[="
//                                                                   style:UIBarButtonItemStyleDone target:self action:@selector(gobig:)];
//    
//    item.leftBarButtonItem=leftButton;
    item.hidesBackButton = YES;
    navigationBar1.tag=101;
    [navigationBar1 pushNavigationItem:item animated:NO];
    
//    
//    UIButton *menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
//    [menuButton setTitle:@"[=" forState:UIControlStateNormal];
//    [menuButton addTarget:self action:@selector(gobig:) forControlEvents:UIControlEventTouchUpInside];
//    [menuButton setImage:[UIImage imageNamed:@"menuIcon"] forState:UIControlStateNormal];
//    UIView *menuButtonContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
//    [menuButtonContainer addSubview:menuButton];
//    UINavigationItem*ui= [navigationBar1.items objectAtIndex:0];
//    ui.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButtonContainer];
//    

    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"[=" style:UIBarButtonItemStyleBordered target:self action:@selector(gobig:) ];
    //    anotherButton.title=@"Inspector";
    UINavigationItem*ui= [navigationBar1.items objectAtIndex:0];
    ui.leftBarButtonItem=anotherButton;
   
    [self.view addSubview:navigationBar1];
    
    
    ciatbview1=[[UITableView alloc] initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, 300, xh-NAVBAR_HEIGHT-1)];
    ciatbview1.rowHeight = 70;
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:ciatbview1];
    ciatbview1.delegate = self;
    ciatbview1.dataSource = self;
    ciatbview1.tag=1;
    [ciatbview1 selectRowAtIndexPath:[NSIndexPath indexPathForRow:tbindex inSection:0] animated:NO scrollPosition:0];
    if ((![self getIsTwoPart])) {
        navigationBar =  [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, xw, NAVBAR_HEIGHT)];
        UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"=]" style:UIBarButtonItemStyleBordered target:self action:@selector(gosmall:) ];
      
        
//       UIButton* loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        [loginButton.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
//        loginButton.frame=CGRectMake(0, 12, 60, 30);
//        
//        UIImage *image ;
//        
//            image =[mysql createImageWithColor:[UIColor grayColor]] ;
//            [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        CALayer *imageLayer = [CALayer layer];
//        imageLayer.frame = CGRectMake(0, 0, loginButton.frame.size.width, loginButton.frame.size.height);
//        imageLayer.contents = (id) image.CGImage;
//        
//        imageLayer.masksToBounds = YES;
//        imageLayer.cornerRadius = 4;
//        imageLayer.borderColor=[UIColor darkGrayColor].CGColor;
//        imageLayer.borderWidth=1.0f;
//        
//        UIGraphicsBeginImageContext(loginButton.frame.size);
//        [imageLayer renderInContext:UIGraphicsGetCurrentContext()];
//        UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        
//        [loginButton setBackgroundImage:roundedImage forState:UIControlStateNormal];
//        
//        
//        
//        //        loginButton.layer.cornerRadius = 5.0;
//        [loginButton setTitle:@"=]" forState:UIControlStateNormal];
//         [loginButton addTarget:self action:@selector(gosmall:) forControlEvents:UIControlEventTouchDown];
//        
////        UIButton *btn1 = [baControl getGrayButton];
////        btn1.titleLabel.font=[UIFont systemFontOfSize:13.0];
////        [btn1 setFrame:CGRectMake(0, 0, 60, 30)];
////        [btn1 setTitle:@"=]" forState:UIControlStateNormal];
////        [btn1 addTarget:self action:@selector(gosmall:) forControlEvents:UIControlEventTouchDown];
//        
////        menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
////        [menuButton setTitle:@"=]" forState:UIControlStateNormal];
////        [menuButton addTarget:self action:@selector(gosmall:) forControlEvents:UIControlEventTouchUpInside];
////        [menuButton setImage:[UIImage imageNamed:@"menuIcon"] forState:UIControlStateNormal];
//        UIView *menuButtonContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
//        [menuButtonContainer addSubview:loginButton];
        
        
        
        item = [[UINavigationItem alloc] initWithTitle:@"BA Guest Registration"];
       
        item.leftBarButtonItem=anotherButton;
        
        uw=[[UIView alloc]initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, xw, xh-51-NAVBAR_HEIGHT)];
        ntabbar=[[UITabBar alloc]initWithFrame:CGRectMake(0, xh-51, xw, 50)];
        
    }else{
        
        navigationBar =  [[UINavigationBar alloc] initWithFrame:CGRectMake(301, 0, xw-301, NAVBAR_HEIGHT)];
        item = [[UINavigationItem alloc] initWithTitle:@"BA Guest Registration"];
        
        uw=[[UIView alloc]initWithFrame:CGRectMake(301, NAVBAR_HEIGHT, xw-301, xh-51-NAVBAR_HEIGHT)];
        ntabbar=[[UITabBar alloc]initWithFrame:CGRectMake(301, xh-51, xw-301, 50)];
    }
    
    navigationBar.items = [NSArray arrayWithObject:item];
    
//    navigationBar.tintColor=[UIColor colorWithRed:0.196078 green:0.309804 blue:0.521569 alpha:1.f];
    
    UINavigationBar *navigationBar3 =  [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, xw, 50)];
    
//    navigationBar3.tintColor=[UIColor colorWithRed:0.000078 green:0.093804 blue:0.300569 alpha:1.f];
    navigationBar3.tag=100;
    navigationBar3.autoresizingMask=UIViewAutoresizingFlexibleWidth;
    [ntabbar addSubview:navigationBar3];
    
    [self.view addSubview:navigationBar];
    
    NSArray *itemsArray =[NSArray arrayWithObjects: [[UITabBarItem alloc]init], [[UITabBarItem alloc]init], [[UITabBarItem alloc]init], [[UITabBarItem alloc]init], [[UITabBarItem alloc]init], [[UITabBarItem alloc]init], [[UITabBarItem alloc]init],[[UITabBarItem alloc]init], [[UITabBarItem alloc]init], [[UITabBarItem alloc]init], [[UITabBarItem alloc]init], [[UITabBarItem alloc]init], [[UITabBarItem alloc]init], [[UITabBarItem alloc]init], nil];
    [ntabbar setItems:itemsArray animated:NO];
//    UITabBarItem *uim =[UITabBarItem alloc];

    for (int i=0; i<14; i++) {
        [[ntabbar.items objectAtIndex:i]setEnabled:NO ];
    }
    [self.view addSubview:ntabbar];
    [uw setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:uw];
    
    
}
-(void)continueClicked:(NSString *)xemail :(NSString *)xmobile :(int)xtype{
//    if (xtype==0) {
//        realtor *nr =[realtor alloc];
//        nr.managedObjectContext=self.managedObjectContext;
//        nr.idmastercia=self.idmastercia;
//        nr.regEmail=xemail;
//        nr.idrealtor=@"";
//        nr.regMobile=[Mysql TrimText:xmobile];
//        [nr setIsTwoPart:NO];
//        nr.menulist=self.menulist;
//        nr.detailstrarr=self.detailstrarr;
//        nr.tbindex=self.tbindex;
//        [self gootoonextPage:nr];
//    }else{
//    
//    }
}
-(IBAction)gosmall:(id)sender{
    int xw;
    int xh;
    if (self.view.bounds.size.width==748.0f) {
        xw= self.view.bounds.size.height;
        xh=self.view.bounds.size.width+1;
        
    }else{
        xw= self.view.bounds.size.width;
        xh=self.view.bounds.size.height+1;
    }
    navigationBar.frame=CGRectMake(301, 0, xw-301, NAVBAR_HEIGHT);
    
    uw.frame=CGRectMake(301, NAVBAR_HEIGHT, xw-301, xh-51-NAVBAR_HEIGHT);
    ntabbar.frame=CGRectMake(301, xh-51, xw-301, 50);
    UINavigationItem *item= [navigationBar.items objectAtIndex:0];
    item.leftBarButtonItem=nil;
    [self setIsTwoPart:YES];
}

-(IBAction)gobig:(id)sender{
    int xw;
    int xh;
    if (self.view.bounds.size.width==748.0f) {
        xw= self.view.bounds.size.height;
        xh=self.view.bounds.size.width+1;
        
    }else{
        xw= self.view.bounds.size.width;
        xh=self.view.bounds.size.height+1;
    }
    navigationBar.frame=CGRectMake(0, 0, xw, NAVBAR_HEIGHT);
    
    uw.frame=CGRectMake(0, NAVBAR_HEIGHT, xw, xh-51-NAVBAR_HEIGHT);
    ntabbar.frame=CGRectMake(0, xh-51, xw, 50);
    
    UINavigationItem *item= [navigationBar.items objectAtIndex:0];
    item.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"=]" style:UIBarButtonItemStyleBordered target:self action:@selector(gosmall:)];
    [self setIsTwoPart:NO];
}

-(void)changePin{
    wcfKeyValueItem *kv= [menulist objectAtIndex:([menulist count]-4)];
    
    NSString *str =[detailstrarr objectAtIndex:([menulist count]-4)];
    if ([[self unlockPasscode] isEqualToString:@"0"] || [[self unlockPasscode] isEqualToString:@"1"]){
        kv.Key=@"Set PIN";
        kv.Value=@"sp.png";
        str =@"Add security level to your account";
    }else{
        kv.Key=@"Reset PIN";
        kv.Value=@"lock_open.png";
        str =@"Reset security level to your account";
    }
    [detailstrarr removeObjectAtIndex:([menulist count]-4)];
    [detailstrarr insertObject:str atIndex:([menulist count]-4)];
    [ciatbview1 reloadData];
}



-(void)viewWillAppear:(BOOL)animated{
    [ntabbar setSelectedItem:nil];
    if ( [self getIsTwoPart] && uw.frame.size.width==self.view.bounds.size.width) {
        [self gosmall:nil];
    }else if ( (![self getIsTwoPart]) && uw.frame.size.width!=self.view.bounds.size.width){
        [self gobig:nil];
    }
}


-(void)gootoonextPage:(mainmenuaaa *)ma{
//    if ([[self.navigationController.viewControllers lastObject] isKindOfClass:[mainmenu class]]) {
//        [self.navigationController pushViewController:ma animated:NO];
//    }else{
//        NSMutableArray *controllers = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
//        while ([controllers count]>2) {
//            [controllers removeLastObject];
//        }
//        [controllers addObject:ma];
//        [self.navigationController setViewControllers:controllers animated:NO];
//    }
}
-(void)setTitle:(NSString *)title1{
    UINavigationItem *item = [navigationBar.items objectAtIndex:0];
    [item setTitle:title1];
}

-(NSString *)getTitle{
    UINavigationItem *item = [navigationBar.items objectAtIndex:0];
    return item.title;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [menulist count]; // or self.items.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.frame.size.height==754) {
        tableView.frame=CGRectMake(0, NAVBAR_HEIGHT, 300, 704);
    }
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    wcfKeyValueItem *kv = [menulist objectAtIndex:indexPath.row];
    
    cell.textLabel.text = kv.Key;
    cell.detailTextLabel.numberOfLines=2;
    cell.detailTextLabel.font=[UIFont systemFontOfSize:16.0];
    cell.detailTextLabel.text = [detailstrarr objectAtIndex:indexPath.row];
    [cell.detailTextLabel sizeToFit];
    [cell .imageView setImage:[UIImage imageNamed:kv.Value]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"dsfasdfsdf");
    Reachability* curReach  = [Reachability reachabilityWithHostName: @"ws.buildersaccess.com"];
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    if (netStatus ==NotReachable) {
        UIAlertView *alert=[self getErrorAlert:@"We are temporarily unable to connect to BuildersAccess, please check your internet connection and try again. Thanks for your patience."];
        [alert show];
    }else{
        tbindex2=indexPath.row;
        wcfService* service = [wcfService service];
        NSString*   version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        [service xisupdate_ipad:self action:@selector(xisupdate_iphoneHandler9999:) version:version];
    }
}
- (void) xisupdate_iphoneHandler9999: (id) value {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    // Handle errors
    if([value isKindOfClass:[NSError class]]) {
        NSError *error = value;
        NSLog(@"%@", [error localizedDescription]);
        UIAlertView *alert=[self getErrorAlert:@"We are temporarily unable to connect to BuildersAccess, please check your internet connection and try again. Thanks for your patience."];
        [alert show];
        return;
    }
    
    // Handle faults
    if([value isKindOfClass:[SoapFault class]]) {
        SoapFault *sf =value;
        NSLog(@"%@", [sf description]);
        UIAlertView *alert = [self getErrorAlert: value];
        [alert show];
        return;
    }
    
    NSString* result = (NSString*)value;
    if ([result isEqualToString:@"1"]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-services://?action=download-manifest&url=http://www.buildersaccess.com/iphone/BA-Guest.plist"]];
        
    }else{
        [self gotonextpage999];
    }
    
    
}

-(BOOL)getIsTwoPart{
    cl_config *fa = [[cl_config alloc]init];
    fa.managedObjectContext=self.managedObjectContext;
    return [fa getIsTwoPart];
    
};
-(void)setIsTwoPart:(BOOL)bl{
    cl_config *fa = [[cl_config alloc]init];
    fa.managedObjectContext=self.managedObjectContext;
    return [fa setIsTwoPart:bl];
};

-(void)gotonextpage999{
    NSIndexPath *indexPath = [ciatbview1 indexPathForSelectedRow];
    [ciatbview1 deselectRowAtIndexPath:indexPath animated:YES];
    wcfKeyValueItem *kv  =[menulist objectAtIndex:indexPath.row];
    atitle=kv.Key;
    if ([atitle isEqualToString:@"Realtor Multi Search"]) {
        multiSearch *ms =[multiSearch alloc];
        ms.managedObjectContext=self.managedObjectContext;
        ms.xtype=1;
        ms.idmastercia=self.idmastercia;
        ms.isfrommainmenu=YES;
        ms.detailstrarr=self.detailstrarr;
        ms.menulist=self.menulist;
        [ms setIsTwoPart:NO];
        ms.tbindex=indexPath.row;
        [self gootoonextPage:ms];
    }else if ([atitle isEqualToString:@"Guest Multi Search"]) {
        cialist *ma =[cialist alloc];
        ma.managedObjectContext=self.managedObjectContext;
        ma.detailstrarr=self.detailstrarr;
        ma.idmastercia=self.idmastercia;
        ma.menulist=self.menulist;
        [ma setIsTwoPart:NO];
        ma.xtype2=1;
        ma.isfrommainmenu=YES;
        ma.tbindex=indexPath.row;
        [self gootoonextPage:ma];
        
    }else if ([atitle isEqualToString:@"New Realtors"]) {
        newRealtor1 *nr =[newRealtor1 alloc];
        nr.managedObjectContext=self.managedObjectContext;
//        nr.detailstrarr=self.detailstrarr;
//        nr.menulist=self.menulist;
//        nr.tbindex=indexPath.row;
//        [nr setIsTwoPart:NO];
        nr.delegate=self;
        if (![[self.navigationController.viewControllers lastObject] isKindOfClass:[mainmenu class]]) {
           
            NSMutableArray *controllers = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
            while ([controllers count]>2) {
                [controllers removeLastObject];
            }
           [self.navigationController setViewControllers:controllers animated:NO];
        }
        nr.xtype=0;
        nr.modalPresentationStyle = UIModalPresentationFormSheet;
        //        testVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:nr animated:YES completion:^() {
            //            NSLog(@"ffff");
        }];
        nr.view.superview.frame = CGRectMake(0, 0, 500, 288);//it's important to do this after presentModalViewController
        nr.view.superview.center = self.view.center;
    }else if ([atitle isEqualToString:@"New Guest with Realtor"]) {
        
        cialist *ma =[cialist alloc];
        ma.managedObjectContext=self.managedObjectContext;
        ma.detailstrarr=self.detailstrarr;
        ma.idmastercia=self.idmastercia;
        ma.menulist=self.menulist;
        [ma setIsTwoPart:NO];
        ma.xtype2=2;
        ma.isfrommainmenu=YES;
        ma.tbindex=indexPath.row;
        [self gootoonextPage:ma];
        

    }else if ([atitle isEqualToString:@"New Guest without Realtor"]) {
        cialist *ma =[cialist alloc];
        ma.managedObjectContext=self.managedObjectContext;
        ma.detailstrarr=self.detailstrarr;
        ma.idmastercia=self.idmastercia;
        ma.menulist=self.menulist;
        [ma setIsTwoPart:NO];
        ma.xtype2=3;
        ma.isfrommainmenu=YES;
        ma.tbindex=indexPath.row;
        [self gootoonextPage:ma];
//        newRealtor1 *nr =[newRealtor1 alloc];
//        nr.managedObjectContext=self.managedObjectContext;
//        nr.delegate=self;
//        if (![[self.navigationController.viewControllers lastObject] isKindOfClass:[mainmenu class]]) {
//            
//            NSMutableArray *controllers = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
//            while ([controllers count]>2) {
//                [controllers removeLastObject];
//            }
//            [self.navigationController setViewControllers:controllers animated:NO];
//        }
//        nr.xtype=2;
//        nr.modalPresentationStyle = UIModalPresentationFormSheet;
//        //        testVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//        [self presentViewController:nr animated:YES completion:^() {
//            //            NSLog(@"ffff");
//        }];
//        nr.view.superview.frame = CGRectMake(0, 0, 500, 288);//it's important to do this after presentModalViewController
//        nr.view.superview.center = self.view.center;
    }else{
    
       if([kv.Key isEqualToString:@"Logout"]){
            [self logout:nil];
        }else if([kv.Key hasPrefix:@"Project"] || [kv.Key hasPrefix:@"Vendor"]){
//            [self logout:nil];
            atitle=kv.Key;
            wcfService *service =[wcfService service];
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
            [service xGetMasterCia:self action:@selector(xGetMasterCiaHandler1111:) xemail:[userInfo getUserName] password:[userInfo getUserPwd]  EquipmentType:@"5"];
        }else if([kv.Key isEqualToString:@"Set PIN"]){
            [self setPasscode:nil];
        }else if([kv.Key isEqualToString:@"Reset PIN"]){
            [self changePasscode:nil];
        }else if([kv.Key isEqualToString:@"For Approve"]){
            wcfService *service =[wcfService service];
            [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
            [service xGetMasterCia:self action:@selector(xGetMasterCiaHandler1111:) xemail:[userInfo getUserName] password:[userInfo getUserPwd]  EquipmentType:@"5"];
            
       
       
        }else if([kv.Key isEqualToString:@"Selection Calendar"]){
            
//            [userInfo initCiaInfo:1 andNm:@""];
//            selectioncalendar *k =[[selectioncalendar alloc]init];
//            k.managedObjectContext=self.managedObjectContext;
//            k.title=kv.Key;
//            k.menulist=self.menulist;
//            k.detailstrarr=self.detailstrarr;
//            k.tbindex=indexPath.row;
//            [k setIsTwoPart:NO];
//            [self gootoonextPage:k];
        }else if([kv.Key isEqualToString:@"QA Calendar"]){
            
            [userInfo initCiaInfo:1 andNm:@""];
//            qacalendarViewController *k =[[qacalendarViewController alloc]init];
//            k.managedObjectContext=self.managedObjectContext;
//            k.title=kv.Key;
//            k.menulist=self.menulist;
//            k.detailstrarr=self.detailstrarr;
//            k.tbindex=indexPath.row;
//            [k setIsTwoPart:NO];
//            [self gootoonextPage:k];
            
        }else{
           
        }
    }
    
    
}

- (void)orientationChanged{
    int xw;
    int xh;
    if (self.view.bounds.size.width==748.0f) {
        xw= self.view.bounds.size.height;
        xh=self.view.bounds.size.width+1;
        
    }else{
        xw= self.view.bounds.size.width;
        xh=self.view.bounds.size.height+1;
    }
    
    bool isBig;
    if (ntabbar.frame.origin.x==0) {
        isBig=YES;
    }else{
        isBig=NO;
    }
    if (self.view.bounds.size.width==1024.0f && ciatbview1.frame.size.height!=748) {
        for (UIView *uh in self.view.subviews) {
            if (isBig) {
                if (uh.tag==1) {
                    uh.frame=CGRectMake(uh.frame.origin.x, uh.frame.origin.y, uh.frame.size.width,xh-1-NAVBAR_HEIGHT);
                }else if (uh.tag==101) {
                    uh.frame=CGRectMake(uh.frame.origin.x, uh.frame.origin.y, 300, NAVBAR_HEIGHT);
                }else if (uh==ntabbar) {
                    uh.frame=CGRectMake(0, xh-51, xw, 50);
                    //                    NSLog(@"%@", [ntabbar viewWithTag:100]);
                    //                    [ntabbar viewWithTag:100].frame=CGRectMake(0, xh-51, xw, 50);
                }else if (uh==navigationBar) {
                    uh.frame=CGRectMake(0, 0, xw, NAVBAR_HEIGHT);
                }else{
                    uh.frame=CGRectMake(0, uh.frame.origin.y, xw, xh-95);
                }
            }else{
                if (uh.tag==1) {
                    uh.frame=CGRectMake(uh.frame.origin.x, uh.frame.origin.y, uh.frame.size.width,xh-1-NAVBAR_HEIGHT);
                }else if (uh.tag==101) {
                    uh.frame=CGRectMake(uh.frame.origin.x, uh.frame.origin.y, 300, NAVBAR_HEIGHT);
                }else if (uh==ntabbar) {
                    uh.frame=CGRectMake(301, xh-51, xw-301, 50);
                    //                    NSLog(@"%@", [ntabbar viewWithTag:100]);
                    //                    [ntabbar viewWithTag:100].frame=CGRectMake(301, xh-51, xw-301, 50);
                }else if (uh==navigationBar) {
                    uh.frame=CGRectMake(301, 0, xw-301, NAVBAR_HEIGHT);
                }else{
                    uh.frame=CGRectMake(uh.frame.origin.x, uh.frame.origin.y, xw-301, xh-95);
                }
                
            }
            
        }
    }else if (self.view.bounds.size.width==768.0f && ciatbview1.frame.size.height!=1004 ){
        for (UIView *uh in self.view.subviews) {
            if (isBig) {
                if (uh.tag==1) {
                    uh.frame=CGRectMake(uh.frame.origin.x, uh.frame.origin.y, uh.frame.size.width,xh-1-NAVBAR_HEIGHT);
                }else if (uh.tag==101) {
                    uh.frame=CGRectMake(uh.frame.origin.x, uh.frame.origin.y, 300, NAVBAR_HEIGHT);
                }else if (uh==ntabbar) {
                    uh.frame=CGRectMake(0, xh-51, xw, 50);
                }else if (uh==navigationBar) {
                    uh.frame=CGRectMake(0, 0, xw, NAVBAR_HEIGHT);
                }else{
                    uh.frame=CGRectMake(0, uh.frame.origin.y, xw, xh-95);
                }
            }else{
                if (uh.tag==1) {
                    uh.frame=CGRectMake(0, NAVBAR_HEIGHT, 300, xh-1-NAVBAR_HEIGHT);
                }else if (uh.tag==101) {
                    uh.frame=CGRectMake(0, 0, 300, NAVBAR_HEIGHT);
                }else if (uh==ntabbar) {
                    uh.frame=CGRectMake(301, xh-51, xw-301, 50);
                }else if (uh==navigationBar) {
                    uh.frame=CGRectMake(301, 0, xw-301, NAVBAR_HEIGHT);
                }else{
                    uh.frame=CGRectMake(uh.frame.origin.x, uh.frame.origin.y, xw-301, xh-95);
                }
            }
        }
    }
    
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}

-(BOOL)shouldAutorotate
{
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
