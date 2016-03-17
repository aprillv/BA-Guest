//
//  select2.m
//  BA-Guest
//
//  Created by roberto ramirez on 2/7/14.
//  Copyright (c) 2014 lovetthomes. All rights reserved.
//

#import "select2.h"
#import "baControl.h"
#import "newguest.h"
#import <QuartzCore/QuartzCore.h>
#import "Mysql.h"
#import "wcfService.h"
#import "Reachability.h"
#import "userInfo.h"
#import "MBProgressHUD.h"

@interface select2 ()<MBProgressHUDDelegate, UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *phonenoField;
@property (strong, nonatomic) IBOutlet UITextField *emailField;
@property (strong, nonatomic) IBOutlet UIButton *searchBtn;
@property (strong, nonatomic) IBOutlet UIButton *clearBtn;
@property (strong, nonatomic) IBOutlet UILabel *communityLbl;
@property (strong, nonatomic) IBOutlet UIImageView *ciaLogo;
@property (strong, nonatomic) IBOutlet UIButton *gobackBtn;
@property (strong, nonatomic) IBOutlet UIScrollView *sv;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *svContentSize;

@end

@implementation select2{
    UILabel *errorlbl;
    MBProgressHUD *HUD;
    int donext;
//    wcfGuestEntryItem *rtt;
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
    
//    [self doInitPage];
    
    if ([idcia isEqualToString:@"100"]) {
        self.ciaLogo.image = [UIImage imageNamed:@"Lovetthomes-LOGO"];
    }else{
        self.ciaLogo.image = [UIImage imageNamed:@"InTownHomes-LOGO"];
    }
    self.communityLbl.text = commnunitynm;
    
    self.searchBtn.layer.cornerRadius = 5.0;
    self.clearBtn.layer.cornerRadius = 5.0;
    self.gobackBtn.layer.cornerRadius = 5.0;
    self.searchBtn.backgroundColor = [UIColor orangeColor];
    
    self.clearBtn.backgroundColor = [UIColor orangeColor];
    self.gobackBtn.backgroundColor = [[UIColor alloc] initWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
}

- (BOOL)textFieldShouldReturn: (UITextField *)textField;{
    if (textField == self.phonenoField) {
        [self dolookfor];
        return YES;
    }
    [self doSearch:nil];
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    [self.sv setContentOffset:CGPointMake(0,0) animated:YES];
    self.svContentSize.constant = 0;
    [self.sv updateConstraintsIfNeeded];
}
-(void)goclear{
    [self.phonenoField setText:@""];
    [self.emailField setText:@""];
    errorlbl.hidden=YES;
}

-(IBAction)dologout:(id)sender{
    donext =1;
    [self dosync1];
    
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    self.svContentSize.constant = 180;
     [self.sv updateConstraintsIfNeeded];
 [self.sv setContentOffset:CGPointMake(0,80) animated:YES];
    return YES;
}

-(void)CancletPin{
    [super CancletPin];
    if (donext==1) {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }else if(donext==2){
     [self.navigationController popViewControllerAnimated:NO];
    }else{
        errorlbl.hidden=YES;
        
        NSString *sphone =[Mysql TrimText:self.phonenoField.text];
        NSString *semail =[Mysql TrimText:self.emailField.text];
        if ([sphone isEqualToString:@""]&&[semail isEqualToString:@""]) {
            UIAlertView *tt=[self getErrorAlert:@"Please enter cell phone number or email to search."];
            [tt show];
            [self.phonenoField becomeFirstResponder];
            return;
            //    }else if ([sphone isEqualToString:@""]){
            //        if (semail.length<4) {
            //            UIAlertView *tt=[self getErrorAlert:@"Please enter more than 4 charactors to search."];
            //            [tt show];
            //            [emailField becomeFirstResponder];
            //            return;
            //        }
            //}else if ([semail isEqualToString:@""]){
            //    if (semail.length<4) {
            //        UIAlertView *tt=[self getErrorAlert:@"Please enter more than 4 charactors to search."];
            //        [tt show];
            //        [phonenoField becomeFirstResponder];
            //        return;
            //    }
        }else if(!([semail isEqualToString:@""])){
            if ([Mysql IsEmail:[Mysql TrimText:self.emailField.text]]==NO) {
                UIAlertView *alert = [self getErrorAlert: @"Please enter a valid email address."];
                [alert show];
                [self.emailField becomeFirstResponder];
                return;
            }}
        HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        [self.navigationController.view addSubview:HUD];
        HUD.labelText=@"   Searching...   ";
        HUD.dimBackground = YES;
        HUD.delegate = self;
        [HUD show:YES];
        Reachability* curReach  = [Reachability reachabilityWithHostName: @"ws.buildersaccess.com"];
        NetworkStatus netStatus = [curReach currentReachabilityStatus];
        if (netStatus ==NotReachable) {
            [HUD hide];
            UIAlertView *alert=[self getErrorAlert:@"We are temporarily unable to connect to BuildersAccess, please check your internet connection and try again. Thanks for your patience."];
            [alert show];
            
            
        }else{
//            NSLog(@"%@ %@", self.idweb, self.idcia);
            wcfService* service = [wcfService service];
            if (sphone.length==10) {
                sphone=[NSString stringWithFormat:@"%@-%@-%@",
                        [sphone substringWithRange:NSMakeRange(0, 3)],
                        [sphone substringWithRange:NSMakeRange(3, 3)],
                        [sphone substringWithRange:NSMakeRange(6, 4)]];

            }

            [service xCheckGuest1:self action:@selector(afterxUpdCommunity:) xemail:[userInfo getUserName] xpassword:[userInfo getUserPwd]  xidcia:self.idcia xidcommunity:self.idweb  xregEmail:semail xregMobile:sphone EquipmentType:@"6"];
            
        }
    }
}
- (IBAction)doBack:(id)sender {
    [self goBack];
}

-(void)goBack{
    
    donext =2;
    [self dosync1];
    
   
}
- (IBAction)doSearch:(id)sender {
    [self dolookfor];
}
- (IBAction)doClear:(id)sender {
    [self goclear];
}
-(void)dolookfor{
    
    donext=3;
    
    if (self.phonenoField.text.length != 0) {
        self.phonenoField.text = [self validateNumber:self.phonenoField.text];
        if (self.phonenoField.text.length != 10) {
            UIAlertView *alert = [self getErrorAlert:@"Please enter 10 numbers."];
            [alert show];
            [self.phonenoField becomeFirstResponder];
            return;
        }
    }
    [self.emailField resignFirstResponder];
    [self.phonenoField resignFirstResponder];
   
    [self dosync1];
    
    
    

}

- (NSString *)validateNumber:(NSString*)number {
    
    
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    NSString *ttt=@"";
    NSString * string;
    NSRange range;
    while (i < number.length) {
        string = [number substringWithRange:NSMakeRange(i, 1)];
        range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length != 0) {
            ttt=[NSString stringWithFormat:@"%@%@", ttt, string];
            
        }
        
        i++;
    }
    return ttt;
}


- (void) afterxUpdCommunity: (id) value {
    [HUD hide];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
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
   wcfGuestEntryItem1* rtt=(wcfGuestEntryItem1 *)value;
    if (rtt.idnumber==0) {
        errorlbl.hidden=NO;
    }else{
        newguest *tt =  [[UIStoryboard storyboardWithName:@"Storyboard" bundle:nil] instantiateViewControllerWithIdentifier:@"newguest"];
        tt.managedObjectContext=self.managedObjectContext;
        tt.idweb=self.idweb;
        tt.idcia=self.idcia;
        tt.cianm=self.cianm;
        tt.commnunitynm=self.commnunitynm;
        tt.idarea=self.idarea;
        tt.idsub=self.idsub;
        tt.fromsearch=YES;
        tt.ei=rtt;
//        NSLog(@"%@", tt.ei);
        [self.navigationController pushViewController:tt animated:NO];
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
