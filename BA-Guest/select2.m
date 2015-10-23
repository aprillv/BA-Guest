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

@end

@implementation select2{
    UITextField *emailField;
    UITextField *phonenoField;
    UILabel *errorlbl;
    MBProgressHUD *HUD;
    int donext;
    UIScrollView *sv;
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
    
    [self doInitPage];
    [phonenoField setText:@""];
    [emailField setText:@""];
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
    if ([idcia isEqualToString:@"100"]  || [idcia isEqualToString:@"306"]) {
        self.view=[bc GetCommenFrame100r:xw andxh:xh];
    }else{
        self.view=[bc GetCommenFrame101r:xw andxh:xh];
    }
    
    UIButton *logoutbtn =[bc getButton:[UIColor grayColor] andrect:CGRectMake(0, 0, 130, 40)];
    logoutbtn.frame=CGRectMake(xw-150, 25, 130, 40);
    [logoutbtn setTitle:@"Go Back" forState:UIControlStateNormal];
    [logoutbtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:logoutbtn];
    
    
    UIScrollView *v3=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 120, xw, xh-185)];
    [self.view addSubview:v3];
    sv=v3;
    
    y=0;
    x=15;
    sv.contentSize=CGSizeMake(xw,xh-183);
    
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(xx, y, 400, 45)];
    lbl.font=[UIFont systemFontOfSize:18.0];
    lbl.text=[NSString stringWithFormat:@"Thank you for visiting %@.", commnunitynm];
    [sv addSubview:lbl];
    y=y+100;
    
    xx=240;
    
    
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(xx, y, 400, 30)];
    lbl.text=@"Guest Cell Phone Number";
    [sv addSubview:lbl];
    y=y+40;
   
    
    phonenoField=[[UITextField alloc]initWithFrame:CGRectMake(xx, y, 450, 40)];
    [phonenoField setBorderStyle:UITextBorderStyleRoundedRect];
//       [phonenoField setBorderStyle:UITextBorderStyleNone];
//    phonenoField.layer.cornerRadius=0.0f;
//    phonenoField.layer.masksToBounds=YES;
//    phonenoField.layer.borderColor=[[UIColor grayColor]CGColor];
//    phonenoField.layer.borderWidth= 3.0f;
    phonenoField.enabled=NO;
    [sv addSubview: phonenoField];
    
    phonenoField=[[UITextField alloc]initWithFrame:CGRectMake(xx+3, y+9, 444, 31)];
    [phonenoField addTarget:self action:@selector(textFieldDoneEditing:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [phonenoField setBorderStyle:UITextBorderStyleNone];
//    phonenoField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    phonenoField.keyboardType =UIKeyboardTypeNumberPad;
    phonenoField.returnKeyType=UIReturnKeySearch;
    phonenoField.delegate=self;
    [sv addSubview: phonenoField];
    
   
    y=y+50;
    
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(xx, y, 400, 30)];
    lbl.text=@"Guest Email Address";
    [sv addSubview:lbl];
    y=y+40;
    
    emailField=[[UITextField alloc]initWithFrame:CGRectMake(xx, y, 450, 40)];
    [emailField setBorderStyle:UITextBorderStyleRoundedRect];
//    [emailField setBorderStyle:UITextBorderStyleNone];
//    emailField.layer.cornerRadius=0.0f;
//    emailField.layer.masksToBounds=YES;
//    emailField.layer.borderColor=[[UIColor grayColor]CGColor];
//    emailField.layer.borderWidth= 3.0f;
    emailField.enabled=NO;
    [sv addSubview: emailField];
    
    emailField=[[UITextField alloc]initWithFrame:CGRectMake(xx+3, y+9, 444, 40)];
   [emailField setBorderStyle:UITextBorderStyleNone];
    [emailField addTarget:self action:@selector(textFieldDoneEditing:) forControlEvents:UIControlEventEditingDidEndOnExit];
    emailField.delegate=self;
    //    [emailField setSecureTextEntry:YES];
     emailField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    emailField.keyboardType=UIKeyboardTypeEmailAddress;
    emailField.returnKeyType=UIReturnKeySearch;
    [emailField addTarget:self action:@selector(dddddddd:) forControlEvents:UIControlEventEditingDidBegin];
    [sv addSubview: emailField];
    
    y= y+100;
    
   
    
    
    
    UIButton *btn1 = [bc getButton1:[UIColor orangeColor] andrect:CGRectMake(0, 0, 150, 44) andradius:5.0f];
    [btn1 setFrame:CGRectMake(xx, y, 150, 44)];
    [btn1 setTitle:@"Search" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(dolookfor) forControlEvents:UIControlEventTouchDown];
    [sv addSubview:btn1];
    
    btn1 = [bc getButton1:[UIColor grayColor] andrect:CGRectMake(0, 0, 150, 44) andradius:5.0f];
    [btn1 setFrame:CGRectMake(xx+300, y, 150, 44)];
    [btn1 setTitle:@"Clear" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(goclear) forControlEvents:UIControlEventTouchDown];
    [sv addSubview:btn1];
    y=y+50+x;
    
    
    errorlbl=[[UILabel alloc]initWithFrame:CGRectMake(xx, y, 400, 30)];
    errorlbl.text=@"* Cell phone or email not found.";
    errorlbl.textColor=[UIColor redColor];
    errorlbl.hidden=YES;
    [sv addSubview:errorlbl];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField;{
    
    [self dolookfor];
    return NO;
}
-(void)goclear{
    [phonenoField setText:@""];
    [emailField setText:@""];
    errorlbl.hidden=YES;
}

-(IBAction)dologout:(id)sender{
    donext =1;
    [self dosync1];
    
    
}

-(IBAction)dddddddd:(id)sender{
    
    [sv setContentOffset:CGPointMake(0,100) animated:YES];
}

-(void)CancletPin{
    [super CancletPin];
    if (donext==1) {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }else if(donext==2){
     [self.navigationController popViewControllerAnimated:NO];
    }else{
        errorlbl.hidden=YES;
        
        NSString *sphone =[Mysql TrimText:phonenoField.text];
        NSString *semail =[Mysql TrimText:emailField.text];
        if ([sphone isEqualToString:@""]&&[semail isEqualToString:@""]) {
            UIAlertView *tt=[self getErrorAlert:@"Please enter cell phone number or email to search."];
            [tt show];
            [phonenoField becomeFirstResponder];
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
            if ([Mysql IsEmail:[Mysql TrimText:emailField.text]]==NO) {
                UIAlertView *alert = [self getErrorAlert: @"Please enter a valid email address."];
                [alert show];
                [emailField becomeFirstResponder];
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

-(void)goBack{
    
    donext =2;
    [self dosync1];
    
   
}
-(void)dolookfor{
    
    donext=3;
    
    if (phonenoField.text.length!=0) {
        phonenoField.text=[self validateNumber:phonenoField.text];
        if (phonenoField.text.length!=10) {
            UIAlertView *alert=[self getErrorAlert:@"Please enter 10 numbers."];
            [alert show];
            [phonenoField becomeFirstResponder];
            return;
        }
    }
   
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
        newguest *tt = [newguest alloc];
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

-(IBAction)textFieldDoneEditing:(UITextField *)sender{
    [sv setContentOffset:CGPointMake(0, 0)];
    [sender resignFirstResponder];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
