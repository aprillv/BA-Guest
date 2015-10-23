
//
//  findcommunity.m
//  BA-Guest
//
//  Created by roberto ramirez on 1/22/14.
//  Copyright (c) 2014 lovetthomes. All rights reserved.
//

#import "findcommunity.h"
#import "Mysql.h"
#import <QuartzCore/QuartzCore.h>
#import "userInfo.h"
#import "wcfKeyValueItem.h"
#import "wcfService.h"
#import "Reachability.h"
#import "MBProgressHUD.h"
#import "CustomKeyboard.h"
#import "select1.h"
#import "communitycell.h"
#import "communityfirstcell.h"
#import "baControl.h"

@interface findcommunity ()<CustomKeyboardDelegate, UISearchBarDelegate, communityfirstcellDelegate, UITableViewDataSource, UITableViewDelegate, MBProgressHUDDelegate>

@end

@implementation findcommunity{
    MBProgressHUD *HUD;
    CustomKeyboard *keyboard;
    NSString *idguest;
    UITableView *ciatbview;
    UISearchBar *searchtxt;
    UIScrollView *uv;
    communityfirstcell *cell2;
    int xh3;
    NSMutableArray *rtnlist;
    NSMutableArray *rtnlist1;
    
    int donext;
}


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
    
    self.title=@"Find a Community";
    [self.navigationItem setHidesBackButton:YES];
    self.view.backgroundColor=[UIColor whiteColor];
    [self doInit];
    rtnlist1=rtnlist;
    
    
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
    UIButton *logoutbtn =[bc getButton:[UIColor grayColor] andrect:CGRectMake(0, 0, 130, 40)];
    logoutbtn.frame=CGRectMake(xw-150, 25, 130, 40);
    [logoutbtn setTitle:@"Logout" forState:UIControlStateNormal];
    [logoutbtn addTarget:self action:@selector(dologout:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:logoutbtn];
    
    searchtxt.autoresizingMask=UIViewAutoresizingFlexibleWidth;
    searchtxt.delegate=self;
    keyboard=[[CustomKeyboard alloc]init];
    keyboard.delegate=self;
    [searchtxt setInputAccessoryView:[keyboard getToolbarWithDone]];    
    [self dorefresh:nil];
    
}


-(void)doInit{
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
    
    xh3=xh-205;   
    baControl *bc =[[baControl alloc]init];
    self.view=[bc GetCommenFrame2:xw andxh:xh];
    searchtxt=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 140, xw, 44)];
    [self.view addSubview:searchtxt];
    searchtxt.delegate=self;
    

}

-(IBAction)dologout:(id)sender{
    [self dosync1];
    
}

-(void)CancletPin{
    [super CancletPin];
[self.navigationController popToRootViewControllerAnimated:NO];
}


- (void)doneClicked{
    [searchtxt resignFirstResponder];
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    [searchtxt resignFirstResponder];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    UITableView *tbview=(UITableView *)[self.view viewWithTag:2];
    
    NSString *str;
    str=[NSString stringWithFormat:@"IdCia like '%@*' or WebCommunity like [c]'*%@*' or WebArea like [c]'*%@*' or City like [c]'*%@*' or CiaName like [c]'*%@*'", searchtxt.text, searchtxt.text, searchtxt.text, searchtxt.text, searchtxt.text];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat: str];
    rtnlist=[[rtnlist1 filteredArrayUsingPredicate:predicate] mutableCopy];
    [tbview reloadData];
    
}


-(IBAction)dorefresh:(id)sender{
    
    Reachability* curReach  = [Reachability reachabilityWithHostName: @"ws.buildersaccess.com"];
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    if (netStatus ==NotReachable) {
        UIAlertView *alert=[self getErrorAlert:@"We are temporarily unable to connect to BuildersAccess, please check your internet connection and try again. Thanks for your patience."];
        [alert show];
    }else{
        HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        [self.navigationController.view addSubview:HUD];
        HUD.labelText=@"   Downloading communities...   ";
        HUD.dimBackground = YES;
        HUD.delegate = self;
        [HUD show:YES];
       
        donext=1;
        [self doupdatechk];
    }
}

-(void)doupdatechk{
    wcfService* service = [wcfService service];
    NSString*   version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    
    [service xisupdate_ipad2:self action:@selector(xisupdate_iphoneHandler:) version:version];
}

- (void) xisupdate_iphoneHandler: (id) value {
    // Handle errors
    if([value isKindOfClass:[NSError class]]) {
        [HUD hide];
        NSError *error = value;
        NSLog(@"%@", [error localizedDescription]);
        UIAlertView *alert=[self getErrorAlert:@"We are temporarily unable to connect to BuildersAccess, please check your internet connection and try again. Thanks for your patience."];
        [alert show];
        return;
    }
    
    // Handle faults
    if([value isKindOfClass:[SoapFault class]]) {
        [HUD hide];
        SoapFault *sf =value;
        NSLog(@"%@", [sf description]);
        UIAlertView *alert = [self getErrorAlert: value];
        [alert show];
        return;
    }
    
    NSString* result = (NSString*)value;
    if ([result isEqualToString:@"1"]) {
        [HUD hide];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:DownLoad_InstallLink]];
        
    }else{
        if (donext==1) {
            Reachability* curReach  = [Reachability reachabilityWithHostName: @"ws.buildersaccess.com"];
            NetworkStatus netStatus = [curReach currentReachabilityStatus];
            if (netStatus ==NotReachable) {
                [HUD hide];
                UIAlertView *alert=[self getErrorAlert:@"There is not available network!"];
                [alert show];
            }else{
                wcfService *service =[wcfService service];
                
                [service xGetCommunity:self action:@selector(xGetMasterCiaHandler:) xemail:[userInfo getUserName] xpassword:[userInfo getUserPwd] EquipmentType: @"3"];
            }
        }else if(donext==2){
            NSIndexPath *indexPath = [ciatbview indexPathForSelectedRow];
            
            [ciatbview deselectRowAtIndexPath:indexPath animated:YES];
            wcfCommunityItem *ci =[rtnlist objectAtIndex:indexPath.row];
            select1 *tt = [select1 alloc];
            tt.managedObjectContext=self.managedObjectContext;
            tt.idweb=ci.IdWeb;
            tt.idcia=ci.IdCia;
            tt.cianm=ci.CiaName;
            tt.commnunitynm=ci.WebCommunity;
            tt.idarea=ci.IdArea;
            tt.idsub=ci.IdSub;
            [self.navigationController pushViewController:tt animated:NO];
        }
        
        
    }
    
    
}


- (void) xGetMasterCiaHandler: (id) value {
    [HUD hide];
    
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
    
    // Do something with the NSMutableArray* result
    wcfArrayOfCommunityItem *cg =(wcfArrayOfCommunityItem *)value;
    rtnlist= [cg toMutableArray];
    rtnlist1=rtnlist;
   
    if (ciatbview) {
        searchtxt.text=@"";
        [ciatbview reloadData];
//        [ntabbar setSelectedItem:nil];
    }else{
        int dw = searchtxt.frame.size.width;
        int t=[rtnlist count]*44+44;
        if (t>xh3-44) {
            t=xh3-44;
        }
        ciatbview=[[UITableView alloc] initWithFrame:CGRectMake(0,184, dw, t)];
       
        ciatbview.autoresizingMask=UIViewAutoresizingFlexibleWidth;
        ciatbview.tag=2;
        ciatbview.rowHeight=44;
        [self.view addSubview:ciatbview];
        ciatbview.delegate = self;
        ciatbview.dataSource = self;
    }
}


#pragma mark - TableView Methods
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView.tag==1) {return 0;}else{
        return 44.0f;}
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{ if (tableView.tag==1) {
    return nil;
}else{
    if (!cell2) {
        cell2 = [[communityfirstcell alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 44)];
        cell2.accessoryType = UITableViewCellAccessoryNone;
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        cell2.delegate=self;
    }
    return cell2;
}
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return [rtnlist count]; // or self.items.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
        static NSString *CellIdentifier = @"Cell";
        
        communitycell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell = [[communitycell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        wcfCommunityItem *cia =[rtnlist objectAtIndex:indexPath.row];
        cell.idcia=cia.IdCia;
    cell.webnm=cia.WebCommunity;
    cell.webarea=cia.WebArea;
    cell.city=cia.City;
        cell.cianame=cia.CiaName;
        return cell;
        
}




-(void)doaClicked:(NSString *)str :(BOOL)isup{
    [rtnlist sortUsingComparator:^NSComparisonResult(wcfKeyValueItem* obj1, wcfKeyValueItem* obj2) {
        
        if (isup) {
            return [[obj1 valueForKey:str] compare:[obj2 valueForKey:str]];
        }else{
            return [[obj2 valueForKey:str] compare:[obj1 valueForKey:str]];
        }

        
        
    }];
    [ciatbview reloadData];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Reachability* curReach  = [Reachability reachabilityWithHostName: @"ws.buildersaccess.com"];
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    if (netStatus ==NotReachable) {
        UIAlertView *alert=[self getErrorAlert:@"We are temporarily unable to connect to BuildersAccess, please check your internet connection and try again. Thanks for your patience."];
        [alert show];
    }else{
        donext=2;
        [self doupdatechk];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
