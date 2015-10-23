//
//  GuestLogls.m
//  BA_GuestRegistration
//
//  Created by roberto ramirez on 11/7/13.
//  Copyright (c) 2013 lovetthomes. All rights reserved.
//

#import "GuestLogls.h"
#import "Reachability.h"
#import "userInfo.h"
#import "Mysql.h"
#import "wcfService.h"
#import "guest.h"
#import "realtorCell.h"
#import "guestlsfirstCell.h"

@interface GuestLogls ()<guestlsfirstCellDelegate>

@end

@implementation GuestLogls{
    UITabBar *ntabbar;
    UIScrollView *uv;
    UITableView *ciatbview;
    NSMutableArray *rtnls;
    guestlsfirstCell *cell2;
    UIButton *btnNext;
}

@synthesize idmastercia, idrealtor, xtype;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//-(void)loadView{
//    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
//    view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
//    
//    self.view = view;
//    
//    if (view.frame.size.height>480) {
//        ntabbar=[[UITabBar alloc]initWithFrame:CGRectMake(0, 370+84, 320, 50)];
//    }else{
//        
//        ntabbar=[[UITabBar alloc]initWithFrame:CGRectMake(0, 366, 320, 50)];
//    }
//    [view addSubview:ntabbar];
//    
//    UITabBarItem *firstItem0 = [[UITabBarItem alloc]initWithTitle:@"Home" image:[UIImage imageNamed:@"home.png"] tag:1];
//    UITabBarItem *fi =[[UITabBarItem alloc]init];
//    UITabBarItem *f2 =[[UITabBarItem alloc]init];
//    UITabBarItem *firstItem2 = [[UITabBarItem alloc]initWithTitle:@"Refresh" image:[UIImage imageNamed:@"refresh3.png"] tag:2];
//    NSArray *itemsArray =[NSArray arrayWithObjects: firstItem0, fi, f2, firstItem2, nil];
//    [ntabbar setItems:itemsArray animated:YES];
//    [[ntabbar.items objectAtIndex:0]setAction:@selector(gohome:) ];
//    [[ntabbar.items objectAtIndex:1]setEnabled:NO ];
//    [[ntabbar.items objectAtIndex:2]setEnabled:NO ];
// [[ntabbar.items objectAtIndex:3]setAction:@selector(dorefresh:) ];
//    
//    if (self.view.frame.size.height>480) {
//        uv =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 370+84)];
//    }else{
//        uv =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 364)];
//    }
//    
//    [view addSubview:uv];
//    
//    view.backgroundColor=[UIColor whiteColor];
//    
//    [self.navigationItem setHidesBackButton:YES];
//    [self.navigationItem setLeftBarButtonItem:[self getbackButton]];
//    
//    
//}

-(IBAction)dorefresh:(id)sender{
    [self getInfo];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"Guest Registration";
    
    [[ntabbar.items objectAtIndex:13]setImage:[UIImage imageNamed:@"refresh3.png"] ];
    [[ntabbar.items objectAtIndex:13]setTitle:@"Refresh" ];
    [[ntabbar.items objectAtIndex:13] setEnabled:YES];
    [[ntabbar.items objectAtIndex:13]setAction:@selector(dorefresh:) ];
    
    
    btnNext = [UIButton buttonWithType:UIButtonTypeCustom];
    if ([self getIsTwoPart]) {
        btnNext.frame = CGRectMake(10, 6, 40, 32);
    }else{
        btnNext.frame = CGRectMake(60, 6, 40, 32);
    }
    [btnNext addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    UIImage *btnNextImageNormal = [UIImage imageNamed:@"back1"];
    [btnNext setImage:btnNextImageNormal forState:UIControlStateNormal];
    [self.navigationBar addSubview:btnNext];
    
	[self getInfo];
}
-(void)gobig:(id)sender{
    [super gobig:sender];
    [ciatbview reloadData];
    btnNext.frame = CGRectMake(60, 6, 40, 32);
}

-(void)gosmall:(id)sender{
    [super gosmall:sender];
    [ciatbview reloadData];
    btnNext.frame = CGRectMake(10, 6, 40, 32);
}
-(void)getInfo{
    Reachability* curReach  = [Reachability reachabilityWithHostName: @"ws.buildersaccess.com"];
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    if (netStatus ==NotReachable) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        UIAlertView *alert=[self getErrorAlert:@"There is not available network!"];
        [alert show];
    }else{
        wcfService *service =[wcfService service];
        NSLog(@"%@ %@", idmastercia, idrealtor);
        [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
        [service xGetRealtorGuestLog:self action:@selector(xGetRealtorGuestLogHandler:) xemail:[userInfo getUserName] xpassword:[userInfo getUserPwd] xmasterciaid:idmastercia xid:idrealtor type:xtype  EquipmentType:@"3"];
    }
    
}

-(void)doaClicked:(NSString *)str :(BOOL)isup{
    [rtnls sortUsingComparator:^NSComparisonResult(wcfGuestSearchItem* obj1, wcfGuestSearchItem* obj2) {
        if (isup) {
            return [[obj1 valueForKey:str] compare:[obj2 valueForKey:str]];
        }else{
            return [[obj2 valueForKey:str] compare:[obj1 valueForKey:str]];
        }
        
    }];
    [ciatbview reloadData];
}


- (void) xGetRealtorGuestLogHandler: (id) value {
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
    
    rtnls =[(wcfArrayOfGuestSearchItem *)value toMutableArray];
    if (ciatbview) {
        
        [ciatbview reloadData];
        [ntabbar setSelectedItem:nil];
    }else{
//        if (self.view.frame.size.height>480) {
//            ciatbview=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 364+84)];
//            uv.contentSize=CGSizeMake(320.0,364+85);
//        }else{
//            ciatbview=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 364)];
//            uv.contentSize=CGSizeMake(320.0,365);
//        }
//        ciatbview.rowHeight=66;
//        ciatbview.tag=2;
//        [uv addSubview:ciatbview];
//        ciatbview.delegate = self;
//        ciatbview.dataSource = self;
        
        int dw = self.uw.frame.size.width;
        int dh = self.uw.frame.size.height;
        
        if ([rtnls count]*44+44<dh) {
            dh=[rtnls count]*44+44;
        }
        
        
        ciatbview=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, dw, dh)];
        ciatbview.rowHeight=44;
        ciatbview.autoresizingMask=UIViewAutoresizingFlexibleWidth;
        ciatbview.tag=2;
        [self.uw addSubview:ciatbview];
        ciatbview.delegate = self;
        ciatbview.dataSource = self;
        
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag==1) {
        return [super tableView:tableView numberOfRowsInSection:section];
    }else{
    return [rtnls count]; // or self.items.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag==1) {
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }else{
//    static NSString *CellIdentifier = @"Cell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil)
//    {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
//    }
//    
//    wcfGuestSearchItem *cia =[rtnls objectAtIndex:indexPath.row];
//    
//    cell.textLabel.text = cia.Name;
//    cell.detailTextLabel.numberOfLines=2;
//    cell.detailTextLabel.text=[NSString stringWithFormat:@"%@\n%@", cia.WebCommunity, cia.Status];
//    
//    
//    [cell .imageView setImage:nil];
//    return cell;
//    }
        
        static NSString *CellIdentifier = @"Cell";
        
        realtorCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell = [[realtorCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        wcfGuestSearchItem *cia =[rtnls objectAtIndex:indexPath.row];
        cell.agent=cia.WebCommunity;
        cell.company=cia.Name;
        cell.Status=cia.Status;
        return cell;
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	if (tableView.tag==1) {
        return 0;
    }else
        return 44.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (!cell2) {
        cell2 = [[guestlsfirstCell alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 44)];
        cell2.accessoryType = UITableViewCellAccessoryNone;
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        cell2.delegate=self;
    }
    return cell2;
    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag==1) {
        return [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    }else{
    Reachability* curReach  = [Reachability reachabilityWithHostName: @"ws.buildersaccess.com"];
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    if (netStatus ==NotReachable) {
        UIAlertView *alert=[self getErrorAlert:@"We are temporarily unable to connect to BuildersAccess, please check your internet connection and try again. Thanks for your patience."];
        [alert show];
    }else{
        wcfService* service = [wcfService service];
        NSString*   version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        [service xisupdate_iphone:self action:@selector(xisupdate_iphoneHandler1:) version:version];
    }
    }
}
- (void) xisupdate_iphoneHandler1: (id) value {
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
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-services://?action=download-manifest&url=http://www.buildersaccess.com/iphone/BA_GuestRegistration.plist"]];
        
    }else {
        NSIndexPath *indexPath = [ciatbview indexPathForSelectedRow];
        
        [ciatbview deselectRowAtIndexPath:indexPath animated:YES];
        
        wcfGuestSearchItem *kv =[rtnls objectAtIndex:indexPath.row];
        guest *gf =[guest alloc];
        gf.managedObjectContext=self.managedObjectContext;
        gf.idrealtor=idrealtor;
        gf.idcia=[NSString stringWithFormat:@"%d", [userInfo getCiaId] ];
        gf.idmastercia=self.idmastercia;
                gf.communityitem=[[wcfCommunityItem alloc]init];
                gf.communityitem.IdWeb=kv.IdCommunity;
                gf.idguest=kv.IdGuest;
        gf.menulist=self.menulist;
        gf.detailstrarr=self.detailstrarr;
        gf.tbindex=self.tbindex;
        [self.navigationController pushViewController:gf animated:NO];
        
//        guestinfo *gf =[guestinfo alloc];
//        gf.managedObjectContext=self.managedObjectContext;
//        gf.idrealtor=@"";
//        gf.idmastercia=idmastercia;
//        gf.idcia=kv.IdCia;
//        gf.communityitem=[[wcfCommunityItem alloc]init];
//        gf.communityitem.IdWeb=kv.IdCommunity;
//        gf.idguest=kv.IdGuest;
//        [self.navigationController pushViewController:gf animated:YES];
        
        
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
