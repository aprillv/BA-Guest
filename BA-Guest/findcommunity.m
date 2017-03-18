
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
#import "BA_Guest-Swift.h"

@interface findcommunity ()<CustomKeyboardDelegate, UISearchBarDelegate, communityfirstcellDelegate, UITableViewDataSource, UITableViewDelegate, MBProgressHUDDelegate>
@property (strong, nonatomic) IBOutlet UITableView *ciatbview;
//@property (strong, nonatomic) IBOutlet UISearchBar *searchtxt;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewheight;
@property (strong, nonatomic) IBOutlet UITextField *txtField;

@end

@implementation findcommunity{
    MBProgressHUD *HUD;
    CustomKeyboard *keyboard;
    NSString *idguest;
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
    
    self.viewheight.constant = 1.0 / [UIScreen mainScreen].scale;
    self.txtField.text = @"";
    self.txtField.placeholder = @"Search";
    self.txtField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.txtField.layer.cornerRadius = 5.0f;
    self.txtField.leftViewMode = UITextFieldViewModeAlways;
    self.txtField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search"]];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:self.txtField];
    
    self.title=@"Find a Community";
    [self.navigationItem setHidesBackButton:YES];
    self.view.backgroundColor=[UIColor whiteColor];
    [self doInit];
    rtnlist1=rtnlist;
    
    [self dorefresh:nil];
    
}


-(void)textFieldDidChange:(NSNotification *)notifications{
    NSString *str;
    str=[NSString stringWithFormat:@"IdCia like '%@*' or WebCommunity like [c]'*%@*' or WebArea like [c]'*%@*' or City like [c]'*%@*' or CiaName like [c]'*%@*'", self.txtField.text, self.txtField.text, self.txtField.text, self.txtField.text, self.txtField.text];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat: str];
    rtnlist=[[rtnlist1 filteredArrayUsingPredicate:predicate] mutableCopy];
    [self.ciatbview reloadData];
}

-(void)doInit{
//    int xw;
//    int xh;
//    int xx;
//    if (self.view.bounds.size.width==748.0f) {
//        xx =150;
//        xw= self.view.bounds.size.height;
//        xh=self.view.bounds.size.width+1;
//    }else{
//        xx =112;
//        xw= self.view.bounds.size.width;
//        xh=self.view.bounds.size.height+1;
//    }
//    
//    xh3=xh-205;   
//    baControl *bc =[[baControl alloc]init];
//    self.view=[bc GetCommenFrame2:xw andxh:xh];
//    searchtxt=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 140, xw, 44)];
//    [self.view addSubview:searchtxt];
//    searchtxt.delegate=self;
    

}

-(IBAction)dologout:(id)sender{
    [self dosync1];
    
}

-(void)CancletPin{
    [super CancletPin];
[self.navigationController popToRootViewControllerAnimated:NO];
}


- (void)doneClicked{
    [self.txtField resignFirstResponder];
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    [self.txtField resignFirstResponder];
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
//                NSLog(@"%@ %@", [userInfo getUserName], [userInfo getUserPwd]);
                [service xGetCommunity:self action:@selector(xGetMasterCiaHandler:) xemail:[userInfo getUserName] xpassword:[userInfo getUserPwd] EquipmentType: @"3"];
//                NSLog(@"%@ %@", [userInfo getUserName], [userInfo getUserPwd]);
            }
        }else if(donext==2){
            NSIndexPath *indexPath = [self.ciatbview indexPathForSelectedRow];
            
            [self.ciatbview deselectRowAtIndexPath:indexPath animated:YES];
            wcfCommunityItem *ci =[rtnlist objectAtIndex:indexPath.row];
            select1 *tt = [[UIStoryboard storyboardWithName:@"Storyboard" bundle:nil] instantiateViewControllerWithIdentifier:@"select1"];
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
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
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
   
//    if (ciatbview) {
        self.txtField.text=@"";
        [self.ciatbview reloadData];
//        [ntabbar setSelectedItem:nil];
//    }else{
//        int dw = searchtxt.frame.size.width;
//        CGFloat t=[rtnlist count]*44+44;
//        if (t>xh3-44) {
//            t=xh3-44;
//        }
//        ciatbview=[[UITableView alloc] initWithFrame:CGRectMake(0,184, dw, t)];
//       
//        ciatbview.autoresizingMask=UIViewAutoresizingFlexibleWidth;
//        ciatbview.tag=2;
//        ciatbview.rowHeight=44;
//        [self.view addSubview:ciatbview];
//        ciatbview.delegate = self;
//        ciatbview.dataSource = self;
//        ciatbview.separatorColor = [UIColor clearColor];
//    }
}


#pragma mark - TableView Methods
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [tableView dequeueReusableCellWithIdentifier:@"headCell"];
   
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [rtnlist count]; // or self.items.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
        static NSString *CellIdentifier = @"communityCell";
        
        communityCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        wcfCommunityItem *item =[rtnlist objectAtIndex:indexPath.row];
    [cell setCellContent:item];
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
    [self.ciatbview reloadData];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.txtField resignFirstResponder];
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

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
