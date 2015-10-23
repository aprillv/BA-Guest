//
//  Login.m
//  BuildersAccessPo
//
//  Created by amy zhao on 13-3-1.
//  Copyright (c) 2013年 eloveit. All rights reserved.
//
#import "Mysql.h"
#import "Login.h"
#import "wcfService.h"
#import "forgetPs1.h"
#import "cl_pin.h"
#import "Reachability.h"
#import <QuartzCore/QuartzCore.h>
#import "baControl.h"
#import "findcommunity.h"
#import "cl_guest.h"

#define NAVBAR_HEIGHT   44
#define PROMPT_HEIGHT   70
#define DIGIT_SPACING   10
#define DIGIT_WIDTH     61
#define DIGIT_HEIGHT    40
#define MARKER_WIDTH    16
#define MARKER_HEIGHT   16
#define MARKER_X        22
#define MARKER_Y        18
#define MESSAGE_HEIGHT  74
#define FAILED_LCAP     19
#define FAILED_RCAP     19
#define FAILED_HEIGHT   26
#define FAILED_MARGIN   10
#define TEXTFIELD_MARGIN 8
#define SLIDE_DURATION  0.3

@interface Login ()<UITextFieldDelegate, UIAlertViewDelegate, CustomKeyboardDelegate, MBProgressHUDDelegate>
@end



@implementation Login{
    NSString     *name;
    NSString                     *pwd;
    BOOL transiting;
//    BOOL isenter;
    
//    UISwitch *switchView;
    UITextField         *usernameField;
    UITextField         *passwordField;
    CustomKeyboard *keyboard;
    MBProgressHUD *HUD;
    
    //for syncronize
    int curentindex;
    NSMutableArray *rtnlist;
    UIButton *checkButton;
    
    BOOL ischecked;
    UIScrollView *sv;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    self.title=@"Guest Registration";
    
    [self doInitPage];
    
	NSString *filePath = [self dataFilePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        
        //NSData *reader = [NSData dataWithContentsOfFile:filePath];
		NSArray *arr = [[NSArray alloc] initWithContentsOfFile:filePath];
		usernameField.text = [arr objectAtIndex:0];
		pwd=[arr objectAtIndex:1];
        name=usernameField.text;
        
		passwordField.text = @"******";
		ischecked=YES;
         [checkButton setImage: [UIImage imageNamed:@"chked.png"] forState:UIControlStateNormal];
    }else{
    ischecked=NO;
          [checkButton setImage: [UIImage imageNamed:@"chk.png"] forState:UIControlStateNormal];
    }
    
    UIColor * cg1 =[UIColor whiteColor] ;
    
    UIColor * cg = [UIColor lightGrayColor];
    [[UITabBar appearance] setTintColor:cg];
    //
    [[UITabBarItem appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      cg1, UITextAttributeTextColor,
      [UIFont boldSystemFontOfSize:9.0], UITextAttributeFont,
      [UIColor darkGrayColor], UITextAttributeTextShadowColor,
      nil] forState:UIControlStateNormal];
    
    [[UIToolbar appearance] setTintColor:cg];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [[UISearchBar appearance] setTintColor:cg];
    keyboard=[[CustomKeyboard alloc]init];
    keyboard.delegate=self;
    [usernameField setInputAccessoryView:[keyboard getToolbarWithPrevNextDone:NO :TRUE]];
    usernameField.delegate=self;
    passwordField.delegate=self;
    usernameField.returnKeyType=UIReturnKeyDone;
    passwordField.returnKeyType=UIReturnKeyDone;
    [passwordField setInputAccessoryView:[keyboard getToolbarWithPrevNextDone:TRUE :NO]];
    
//    isenter=YES;
}

//-(void)viewDidAppear:(BOOL)animated{
//    if (![[self unlockPasscode] isEqualToString:@"0"] && isenter) {
//        [self enterPasscode:nil];
//        
//    }
//    isenter=NO;
//}

-(void)viewWillAppear:(BOOL)animated{
//    self.navigationController.navigationBarHidden=NO;
    if (!ischecked) {
        passwordField.text=@"";
    }
    transiting=NO;
}


// custom keyboard
- (void)nextClicked{
    [passwordField becomeFirstResponder];
}

- (void)previousClicked{
    [usernameField becomeFirstResponder];
}

- (void)doneClicked{
    [sv setContentOffset:CGPointMake(0, 0)]; 
    [usernameField resignFirstResponder];
    [passwordField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField;{
    [self login:nil];
    return NO;
}

-(void)doInitPage{
    
    
    int x;
    int y;
    int xw;
    int xh;
    int xx;
//    NSLog(@"%f -- %f", self.view.frame.size.width, self.view.frame.size.height);
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
    self.view=[bc GetCommenFrame1:xw andxh:xh];
    UIScrollView *v3=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 160, xw, xh-185)];
    [self.view addSubview:v3];
    sv=v3;
    
    y=30;
    x=15;
    sv.contentSize=CGSizeMake(xw,xh-183);
    
    UILabel *lbl;
    lbl =[[UILabel alloc]initWithFrame:CGRectMake(xx+320, y, 544, 21)];
    lbl.text=@"Members Login";
    lbl.font=[UIFont boldSystemFontOfSize:18.0];
    [sv addSubview:lbl];
    y=y+61+x;
    
    lbl =[[UILabel alloc]initWithFrame:CGRectMake(xx, y, 544, 21)];
    lbl.text=@"Email";
    [sv addSubview:lbl];
    lbl =[[UILabel alloc]initWithFrame:CGRectMake(xx+400, y, 544, 21)];
    lbl.text=@"Password";
    [sv addSubview:lbl];
    y=y+21+x;

    
   UITextField * emailField=[[UITextField alloc]initWithFrame:CGRectMake(xx, y, 350, 40)];
    [emailField setBorderStyle:UITextBorderStyleRoundedRect];
    //    [emailField setBorderStyle:UITextBorderStyleNone];
    //    emailField.layer.cornerRadius=0.0f;
    //    emailField.layer.masksToBounds=YES;
    //    emailField.layer.borderColor=[[UIColor grayColor]CGColor];
    //    emailField.layer.borderWidth= 3.0f;
    emailField.enabled=NO;
    [sv addSubview: emailField];
    
    usernameField=[[UITextField alloc]initWithFrame:CGRectMake(xx+3, y+9, 344, 31)];
//    [usernameField setBorderStyle:UITextBorderStyleRoundedRect];
      [usernameField setBorderStyle:UITextBorderStyleNone];
    [usernameField addTarget:self action:@selector(textFieldDoneEditing:) forControlEvents:UIControlEventEditingDidEndOnExit];
    usernameField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    usernameField.keyboardType=UIKeyboardTypeEmailAddress;
    [sv addSubview: usernameField];
   [usernameField addTarget:self action:@selector(dddddddd:) forControlEvents:UIControlEventEditingDidBegin];
    
    emailField=[[UITextField alloc]initWithFrame:CGRectMake(xx+400, y, 350, 40)];
    [emailField setBorderStyle:UITextBorderStyleRoundedRect];
    //    [emailField setBorderStyle:UITextBorderStyleNone];
    //    emailField.layer.cornerRadius=0.0f;
    //    emailField.layer.masksToBounds=YES;
    //    emailField.layer.borderColor=[[UIColor grayColor]CGColor];
    //    emailField.layer.borderWidth= 3.0f;
    emailField.enabled=NO;
    
    [sv addSubview: emailField];
    
    passwordField=[[UITextField alloc]initWithFrame:CGRectMake(xx+403, y+9, 344, 31)];
    [passwordField addTarget:self action:@selector(dddddddd:) forControlEvents:UIControlEventEditingDidBegin];
//    [passwordField setBorderStyle:UITextBorderStyleRoundedRect];
     [passwordField setBorderStyle:UITextBorderStyleNone];
    [passwordField addTarget:self action:@selector(textFieldDoneEditing:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [passwordField setSecureTextEntry:YES];
    [sv addSubview: passwordField];
    y=y+55+x;
    
//    UITextField *text1=[[UITextField alloc]initWithFrame:CGRectMake(xx, y-3, 350, 44)];
//    [text1 setBorderStyle:UITextBorderStyleRoundedRect];
//    text1.enabled=NO;
//    text1.text=@"";
//    [sv addSubview: text1];
    
    checkButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [checkButton setFrame:CGRectMake(xx, y, 50, 40)];
    [checkButton addTarget:self action:@selector(CheckboxClicked:) forControlEvents:UIControlEventTouchDown];
    [checkButton setImageEdgeInsets:UIEdgeInsetsMake(2.0, -10.0, 5.0, 5.0)];
  
    [checkButton setTitleEdgeInsets:UIEdgeInsetsMake(2.0, 0.0, 5.0, 5.0)];
    [checkButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //     [checkButton.titleLabel setFont:[UIFont boldSystemFontOfSize:17.0f]];
    ischecked=YES;
    [checkButton setTitle:@"" forState:UIControlStateNormal];
    [sv addSubview:checkButton];
    
//    lbl =[[UILabel alloc]initWithFrame:CGRectMake(xx+55, y+8, 120, 21)];
//    lbl.text=@"Remember Me";
//    [sv addSubview:lbl];
    
    UIButton *tt=[UIButton buttonWithType:UIButtonTypeCustom];
    [tt setFrame:CGRectMake(xx+45, y, 295, 44)];
  
    [tt setTitleColor: [UIColor blackColor] forState:UIControlStateNormal ];
//    [tt.titleLabel setTextAlignment:NSTextAlignmentLeft];
//    [tt.titleLabel setText:@" Remember Me"];
    [tt setTitle:@"Remember Me                                   " forState:UIControlStateNormal];
       [tt addTarget:self action:@selector(CheckboxClicked:) forControlEvents:UIControlEventTouchDown];
    [sv addSubview:tt];
    
//    switchView= [[UISwitch alloc] initWithFrame:CGRectMake(xx+117, y+4, 100.0f, 28.0f)];
//    ischecked = NO;
//    [sv addSubview:switchView];
//    [switchView addTarget:self action:@selector(CheckboxClicked:) forControlEvents:UIControlEventValueChanged];
    
    UIButton *btn1 = [bc getButton:[UIColor grayColor] andrect:CGRectMake(0, 0, 150, 44)];
    [btn1 setFrame:CGRectMake(xx+600, y, 150, 44)];
    [btn1 setTitle:@"Login" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchDown];
    [sv addSubview:btn1];
    y=y+50+x;
    
//    btn1=[UIButton buttonWithType:UIButtonTypeCustom];
//    [btn1 setFrame:CGRectMake(xx, y, 182, 44)];
//
//    [btn1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    [btn1 setTitle:@"Forgot Your Password" forState:UIControlStateNormal];
//    [btn1 addTarget:self action:@selector(ForgotPasOnclick:) forControlEvents:UIControlEventTouchDown];
//    [sv addSubview:btn1];
    
}
-(IBAction)dddddddd:(id)sender{
    
    [sv setContentOffset:CGPointMake(0,80) animated:YES];
}
- (NSString *)dataFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"save"];
}

- (void)creatFiles: (NSString *)pwd1 {
    
    NSString *user_name = [Mysql TrimText:usernameField.text];
    NSString *filePath = [self dataFilePath];
	//NSFileManager *fileManager =[NSFileManager defaultManager];
	if ([[NSFileManager defaultManager]fileExistsAtPath:filePath]) {
		NSError* error;
		[[NSFileManager defaultManager]removeItemAtPath:filePath error:&error];
	}
	//NSData *data = (NSData *)[self TrimText:self.usernameField.text];
	//[fileManager createFileAtPath:filePath contents:data attributes:nil];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:user_name];
	[array addObject:pwd1];
    [array writeToFile:filePath atomically:YES];
    
}

- (IBAction) ForgotPasOnclick: (id) sender{
    if (transiting) {
        return;
    }else{
        transiting=YES;
        forgetps1 *fp = [forgetps1 alloc];
        fp.managedObjectContext=self.managedObjectContext;
        [self.navigationController pushViewController:fp animated:YES];
    }
}

- (IBAction) CheckboxClicked : (id) sender{
    if (!ischecked)  {
        
        ischecked=YES;
        [checkButton setImage:[UIImage imageNamed:@"chked.png"] forState:UIControlStateNormal];
        
      

       	}else {
            ischecked=NO;
            [checkButton setImage:[UIImage imageNamed:@"chk.png"] forState:UIControlStateNormal];
            
            NSString *filePath = [self dataFilePath];
            if ([[NSFileManager defaultManager]fileExistsAtPath:filePath]) {
                NSError* error;
                [[NSFileManager defaultManager]removeItemAtPath:filePath error:&error];
            }
            
            passwordField.text=@"";
            
            [self deletealldata];

                    
	}
}

-(void)deletealldata{
    cl_pin *mf =[[cl_pin alloc]init];
    mf.managedObjectContext=self.managedObjectContext;
    [mf deletePin];
    
    cl_guest *mf3 =[[cl_guest alloc]init];
    mf3.managedObjectContext=self.managedObjectContext;
    [mf3 deleteData];    
}
- (IBAction) login: (UIButton *) sender{
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.labelText=@"   Login...   ";
    HUD.dimBackground = YES;
    HUD.delegate = self;
    [HUD show:YES];
    
    [self autoUpd];
}

-(void)autoUpd{
    
    Reachability* curReach  = [Reachability reachabilityWithHostName: @"ws.buildersaccess.com"];
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    if (netStatus ==NotReachable) {
        [HUD hide:YES];
        for (UIWindow* window in [UIApplication sharedApplication].windows) {
            NSArray* subviews = window.subviews;
            if ([subviews count] > 0){
                for (UIAlertView* cc in subviews) {
                    if ([cc isKindOfClass:[UIAlertView class]]) {
                        [cc dismissWithClickedButtonIndex:0 animated:YES];
                        
                    }
                }
            }
            
        }
        
        UIAlertView *alert=[self getErrorAlert:@"We are temporarily unable to connect to BuildersAccess, please check your internet connection and try again. Thanks for your patience."];
        [alert show];
        
        transiting=NO;
    }else{
        wcfService* service = [wcfService service];
        NSString*   version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
        
        [service xisupdate_ipad2:self action:@selector(xisupdate_iphoneHandler:) version:version];
        
    }
}
- (void) xisupdate_iphoneHandler: (id) value {
    
    
    
    
    // Handle errors
    if([value isKindOfClass:[NSError class]]) {
        NSError *error = value;
        NSLog(@"%@", [error localizedDescription]);
        [HUD hide:YES];
        
        
        UIAlertView *alert=[self getErrorAlert:@"We are temporarily unable to connect to BuildersAccess, please check your internet connection and try again. Thanks for your patience."];
        [alert show];
        
        transiting=NO;
        return;
    }
    
    // Handle faults
    if([value isKindOfClass:[SoapFault class]]) {
        SoapFault *sf =value;
        NSLog(@"%@", [sf description]);
        [HUD hide:YES];
        UIAlertView *alert = [self getErrorAlert: value];
        [alert show];
        transiting=NO;
        return;
    }
    
    NSString* result = (NSString*)value;
    if ([result isEqualToString:@"1"]) {
        [HUD hide:YES];
     
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:DownLoad_InstallLink]];
        
    }else{
        [self doLogin];
    }
    
    
}
- (void) doLogin{
    if (transiting) {
        return;
    }else{
        transiting=YES;
    }
    
    [usernameField resignFirstResponder];
    [passwordField resignFirstResponder];
    
	NSString *user_name = [Mysql TrimText:usernameField.text];
    NSString *pass_word = [Mysql TrimText:passwordField.text];
	if (user_name.length==0){
        [HUD hide:YES];
		UIAlertView *alert = [self getErrorAlert: @"Please Input All Fields"];
        [alert show];
        [usernameField becomeFirstResponder];
        transiting=NO;
	}else if(pass_word.length==0){
        [HUD hide:YES];
        UIAlertView *alert = [self getErrorAlert: @"Please Input All Fields"];
        [alert show];
		
        [passwordField becomeFirstResponder];
        transiting=NO;
    }else if ([Mysql IsEmail:user_name]==NO) {
        [HUD hide:YES];
        UIAlertView *alert = [self getErrorAlert: @"Please Input invalid email"];
        [alert show];
        [usernameField becomeFirstResponder];
        transiting=NO;
	} else{
        
        NSString *myMD5Pas;
		if (pwd != nil && [pass_word isEqualToString:@"******"]==YES) {
			myMD5Pas = pwd;
		} else {
			myMD5Pas = [Mysql md5:pass_word];
		}
        //        NSLog(@"%@", myMD5Pas);
        Reachability* curReach  = [Reachability reachabilityWithHostName: @"ws.buildersaccess.com"];
        NetworkStatus netStatus = [curReach currentReachabilityStatus];
        if (netStatus ==NotReachable) {
            [HUD hide:YES];
            UIAlertView *alert=[self getErrorAlert:@"We are temporarily unable to connect to BuildersAccess, please check your internet connection and try again. Thanks for your patience."];
            [alert show];
            transiting=NO;
        }else{
            wcfService* service = [wcfService service];
            
            //            if([self.dd1.titleLabel.text isEqualToString:@"Builder"]){
            //
            //
            //
            //            }
            //            NSLog(@"%@", myMD5Pas);
            [service xCheckLogin:self action:@selector(xCheckLoginHandler:) xemail: user_name xpassword: myMD5Pas EquipmentType:@"3"];
        }
	}
}

- (void) xCheckLoginHandler: (id) value {
    [HUD hide:YES];
    // Handle errors
    if([value isKindOfClass:[NSError class]]) {
        
        
        NSError *error = value;
        NSLog(@"%@", [error localizedDescription]);
        UIAlertView *alert=[self getErrorAlert:@"We are temporarily unable to connect to BuildersAccess, please check your internet connection and try again. Thanks for your patience."];
        [alert show];
        transiting=NO;
        return;
    }
    
    // Handle faults
    if([value isKindOfClass:[SoapFault class]]) {
        SoapFault *sf =value;
        NSLog(@"%@", [sf description]);
        UIAlertView *alert = [self getErrorAlert: value];
        [alert show];
        transiting=NO;
        return;
    }
    
    wcfKeyValueItem* result = (wcfKeyValueItem*)value;
//    NSLog(@"%@", result);
    if (![result.Key isEqualToString:@"0"] ){
//        xget=[result.Key intValue];
        NSString *user_name = [Mysql TrimText:usernameField.text];
        cl_pin *mp =[[cl_pin alloc]init];
        mp.managedObjectContext=self.managedObjectContext;
        int rtn =[mp IsUser:user_name];
        if (rtn==-1){
            [self deletealldata];
            [mp addToXpin:user_name andpincode:@"0"];
        }else if(rtn==0){
            [self deletealldata];
            [mp addToXpin:user_name andpincode:@"0"];
        }
        
        
        NSString *pass_word = [Mysql TrimText:passwordField.text];
        NSString *myMD5Pas;
        if (pwd != nil && [pass_word isEqualToString:@"******"]==YES) {
            myMD5Pas = pwd;
        } else {
            myMD5Pas = [Mysql md5:pass_word];
        }
        
        if (ischecked) {
            
            if (pwd == nil) {
                [self creatFiles:myMD5Pas];
            } else if ([pass_word isEqualToString:@"******"]==NO || ![name isEqualToString:user_name]) {
                [self creatFiles:myMD5Pas];
            }
            
            [userInfo setUserName:user_name andPwd:myMD5Pas];
            [userInfo inituserNameServer:result.Value];
            [self CancletPin];
//            [self dosync1];
            
            
        }else {
            [userInfo setUserName:user_name andPwd:myMD5Pas];
            
            NSString *filePath = [self dataFilePath];
            if ([[NSFileManager defaultManager]fileExistsAtPath:filePath]) {
                NSError* error;
                [[NSFileManager defaultManager]removeItemAtPath:filePath error:&error];
            }
        
           
   
            
             [self deletealldata];
            
            [self CancletPin];
        }
        
    }else{
        UIAlertView *alert = [self getErrorAlert: @"Email and Password not found"];
        [alert show];
        [usernameField becomeFirstResponder];
        transiting=NO;
        return;
    }
    
}




//-(void)dosync{
//    Reachability* curReach  = [Reachability reachabilityWithHostName: @"ws.buildersaccess.com"];
//    NetworkStatus netStatus = [curReach currentReachabilityStatus];
//    
//    if (netStatus ==NotReachable) {
//        [self.navigationController popToRootViewControllerAnimated:NO];
//    }else{
//        
//        
//        
//        if (curentindex < [rtnlist count]) {
//            if (curentindex==0) {
//                HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
//                HUD.mode = MBProgressHUDModeDeterminateHorizontalBar;
//                [self.navigationController.view addSubview:HUD];
//                HUD.labelText=@"Syncronizing local data to server...";
//                HUD.progress=0;
//                [HUD layoutSubviews];
//                HUD.dimBackground = YES;
//                HUD.delegate = self;
//                [HUD show:YES];
//            }else{
//                HUD.progress=curentindex*1.0/[rtnlist count];
//            }
//            
//            
//            NSEntityDescription *steve1= [rtnlist objectAtIndex:curentindex];
//            NSString *msg;
//            if ([[steve1 valueForKey:@"realtoryn"] integerValue]==1){
//                msg = [NSString stringWithFormat:@"Agent First Name: %@;Agent Last Name: %@;Realtor Company: %@", [steve1 valueForKey:@"realtorfirstnm"],[steve1 valueForKey:@"realtorlastnm"],[steve1 valueForKey:@"brokernm"]];
//            }else{
//                msg=@"No Realtor";
//            }
//            
//              NSString *tt =[NSString stringWithFormat:@"{'IdWeb':'%@','IdCia':'%@','IdSub':'%@','WebNm':'%@','FirstNm':'%@','LastNm':'%@','PhoneNo':'%@','Email':'%@', 'HearAboutUs':'%@','Sendyn':'%@', 'Msg':'%@','Refdate':'%@','IdwebArea':'%@'}", [steve1 valueForKey:@"idweb"], [steve1 valueForKey:@"idcia"], [steve1 valueForKey:@"idsub"],[steve1 valueForKey:@"webcommunitynm"],  [steve1 valueForKey:@"firstNm"], [steve1 valueForKey:@"lastNm"], [steve1 valueForKey:@"phonenumber"], [steve1 valueForKey:@"email"] ,[steve1 valueForKey:@"hearaboutus"], [steve1 valueForKey:@"sendyn"],  msg , [steve1 valueForKey:@"refdate"],[steve1 valueForKey:@"idarea"]  ];
//            
//            wcfService *ws =[wcfService service];
//            [ws xUpdCommunity:self action:@selector(afterxUpdCommunity:) xemail:[userInfo getUserName] xpassword:[userInfo getUserPwd] guestData:tt EquipmentType:@"5"];
//        }else{
//            [HUD hide];
//            [self CancletPin];
//        }
//        
//    }
//}

//-(void)dosync2:(MBProgressHUD *)HUD1{
//    Reachability* curReach  = [Reachability reachabilityWithHostName: @"ws.buildersaccess.com"];
//    NetworkStatus netStatus = [curReach currentReachabilityStatus];
//    
//    if (netStatus ==NotReachable) {
//        [HUD1 hide];
//        [self.navigationController popToRootViewControllerAnimated:NO];
//    }else{
//        
//        
//        
//        if (curentindex < [rtnlist count]) {
//            if (curentindex==0) {
//              
//            }else{
//                HUD1.progress=curentindex*1.0/[rtnlist count];
//            }
//            
//            
//            NSEntityDescription *steve1= [rtnlist objectAtIndex:curentindex];
//            NSString *msg;
//            if ([[steve1 valueForKey:@"realtoryn"] integerValue]==1){
//                msg = [NSString stringWithFormat:@"Agent First Name: %@;Agent Last Name: %@;Realtor Company: %@", [steve1 valueForKey:@"realtorfirstnm"],[steve1 valueForKey:@"realtorlastnm"],[steve1 valueForKey:@"brokernm"]];
//            }else{
//                msg=@"No Realtor";
//            }
//            
//            NSString *tt =[NSString stringWithFormat:@"{'IdWeb':'%@','IdCia':'%@','IdSub':'%@','WebNm':'%@','FirstNm':'%@','LastNm':'%@','PhoneNo':'%@','Email':'%@', 'HearAboutUs':'%@','Sendyn':'%@', 'Msg':'%@','Refdate':'%@','IdwebArea':'%@'}", [steve1 valueForKey:@"idweb"], [steve1 valueForKey:@"idcia"], [steve1 valueForKey:@"idsub"],[steve1 valueForKey:@"webcommunitynm"],  [steve1 valueForKey:@"firstNm"], [steve1 valueForKey:@"lastNm"], [steve1 valueForKey:@"phonenumber"], [steve1 valueForKey:@"email"] ,[steve1 valueForKey:@"hearaboutus"], [steve1 valueForKey:@"sendyn"],  msg , [steve1 valueForKey:@"refdate"],[steve1 valueForKey:@"idarea"]  ];
//            
//            wcfService *ws =[wcfService service];
//            [ws xUpdCommunity:self action:@selector(afterxUpdCommunity:) xemail:[userInfo getUserName] xpassword:[userInfo getUserPwd] guestData:tt EquipmentType:@"5"];
//        }else{
//            
//            [self CancletPin];
//        }
//        
//    }
//}


-(void)CancletPin{
    [super CancletPin];
    [HUD hide];
  [userInfo initCiaInfo:1 andNm:@""];
    findcommunity *fy =[findcommunity alloc];
    fy.managedObjectContext=self.managedObjectContext;
    [self.navigationController pushViewController:fy animated:NO];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	if (alertView.tag == 0) {
        switch (buttonIndex) {
			case 0:
                transiting=NO;
				break;
			default:
                [self getciaList];
                break;
		}
		return;
	}
}

-(void)getciaList {
    Reachability* curReach  = [Reachability reachabilityWithHostName: @"ws.buildersaccess.com"];
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    if (netStatus ==NotReachable) {
        UIAlertView *alert=[self getErrorAlert:@"internet"];
        [alert show];
    }else{
        HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        HUD.mode = MBProgressHUDModeDeterminateHorizontalBar;
        [self.navigationController.view addSubview:HUD];
        HUD.labelText=@"Loading Communities...";
        
        HUD.progress=0;
        [HUD layoutSubviews];
        HUD.dimBackground = YES;
        HUD.delegate = self;
        [HUD show:YES];
        
        wcfService* service = [wcfService service];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
        [service xGetCommunity:self action:@selector(vGetCiaListHandler:) xemail: [userInfo getUserName] xpassword: [[userInfo getUserPwd] copy] EquipmentType:@"3"];
    }
}




- (IBAction)textFieldDoneEditing:(id)sender {
    [sv setContentOffset:CGPointMake(0, 0) animated:YES];
	[sender resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

@end
