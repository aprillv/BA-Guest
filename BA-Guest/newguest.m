//
//  newguest.m
//  BA-Guest
//
//  Created by roberto ramirez on 2/5/14.
//  Copyright (c) 2014 lovetthomes. All rights reserved.
//

#import "newguest.h"
#import "baControl.h"
#import <QuartzCore/QuartzCore.h>
#import "Mysql.h"
#import "CustomKeyboard.h"
#import "cl_guest.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
#import "wcfService.h"
#import "userInfo.h"
//#import "BA_Guest-Swift.h"
#import "SelectHowToHearViewController.h"


@interface newguest ()<UIPickerViewDelegate, UIPickerViewDataSource, CustomKeyboardDelegate, UIAlertViewDelegate, MBProgressHUDDelegate, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, SelectHowToHearDelegate>
@property (strong, nonatomic) IBOutlet UIView *sv2;
@property (strong, nonatomic) IBOutlet UIButton *hearBtn;
@property (strong, nonatomic) IBOutlet UITextField *brokernameField;
@property (strong, nonatomic) IBOutlet UIImageView *cialogo;
@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) IBOutlet UILabel *communityLbl;
@property (strong, nonatomic) IBOutlet UITextField *firstnameField;
@property (strong, nonatomic) IBOutlet UITextField *lastnameField;
@property (strong, nonatomic) IBOutlet UITextField *phonenoField;
@property (strong, nonatomic) IBOutlet UITextField *emailField;
@property (strong, nonatomic) IBOutlet UITextField *realtorfirstnameField;
@property (strong, nonatomic) IBOutlet UITextField *realtorlastnameField;
@property (strong, nonatomic) IBOutlet UIButton *checkButton;
@property (strong, nonatomic) IBOutlet UIScrollView *sv;
@property (strong, nonatomic) IBOutlet UITextField *emailField1;
@property (strong, nonatomic) IBOutlet UIButton *checkButton1;
@property (strong, nonatomic) IBOutlet UIButton *checkButton2;
@property (strong, nonatomic) IBOutlet UIButton *submitBtn;
@property (strong, nonatomic) IBOutlet UIButton *clearBtn;
@property (strong, nonatomic) IBOutlet UILabel *SendMelbl;
- (IBAction)doSubmit:(UIButton *)sender;

- (IBAction)doClear:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *priorityLowBtn;
@property (weak, nonatomic) IBOutlet UIButton *priorityMediumBtn;
@property (weak, nonatomic) IBOutlet UIButton *priorityHighBtn;
@property (weak, nonatomic) IBOutlet UILabel *priorityLowLbl;
@property (weak, nonatomic) IBOutlet UILabel *priorityMediumLbl;
@property (weak, nonatomic) IBOutlet UILabel *priorityHighLbl;
- (IBAction)selPriority:(UIButton *)sender;

//@property (nonatomic, strong) IQKeyboardReturnKeyHandler    *returnKeyHandler;

@end

//hearaboutus 在本地数据库中这个字段存储了【hearaboutus;priority】 这么做是为了用户更新app的时候不需要卸载app，因为改动数据库会导致app crash
@implementation newguest{
    UIImageView *iv;
    UIPickerView *ddpicker;
    NSMutableArray *pickerhear;
    CustomKeyboard *keyboard;
    MBProgressHUD *HUD;
    bool ischecked;
    bool ischecked1;
    NSManagedObject *steve;
    NSMutableArray *rtnlist;
    int curentindex;
    UIView * tt9;
    int donext;
    UITableViewCell *cell2;
    
    CGFloat contentHeight;
}
@synthesize idcia, idweb, cianm, commnunitynm, idarea, idsub,fromsearch, ei;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillhide:) name:UIKeyboardWillHideNotification object:nil];
    
    [self doclear:nil];
}

- (void)keyboardWasShown:(NSNotification *)notification
{
    
    // Get the size of the keyboard.
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    //Given size may not account for screen rotation
    int height = MIN(keyboardSize.height,keyboardSize.width);
    
    if (self.sv.contentSize.height != contentHeight + height-80){
        self.sv.contentSize = CGSizeMake(self.sv.frame.size.width, contentHeight + height-80);
    }
    

    
}


-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    if (!self.fromsearch) {
        ei = [[wcfGuestEntryItem1 alloc] init];
         ei.priority = @"2 - Medium";
    }
    
    contentHeight = self.sv2.frame.size.height;
    
    if ([idcia isEqualToString:@"100"]) {
        self.cialogo.image = [UIImage imageNamed:@"Lovetthomes-LOGO"];
    }else{
        self.cialogo.image = [UIImage imageNamed:@"InTownHomes-LOGO"];
    }
    
//"1 - Low", "2 - Medium", "3 - High"
//    [self.priorityBtn setTitle: @"2 - Medium" forState: UIControlStateNormal];
   
//    NSLog(@"ei.priority %@", ei.priority);
    self.communityLbl.text = commnunitynm;
    
    self.SendMelbl.text=[NSString stringWithFormat:@"Send me updated information about %@ and this community.", cianm];
    
    self.submitBtn.layer.cornerRadius = 5.0;
    self.clearBtn.layer.cornerRadius = 5.0;
    self.backBtn.layer.cornerRadius = 5.0;
    self.submitBtn.backgroundColor = [UIColor orangeColor];
    
    self.clearBtn.backgroundColor = [UIColor orangeColor];
    self.backBtn.backgroundColor = [[UIColor alloc] initWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
    
    [self.submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.clearBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    keyboard=[[CustomKeyboard alloc]init];
    keyboard.delegate=self;
    
    [self.firstnameField setInputAccessoryView:[keyboard getToolbarWithPrevNextDone:NO :YES]];
    [self.lastnameField setInputAccessoryView:[keyboard getToolbarWithPrevNextDone:YES :YES]];
    [self.phonenoField setInputAccessoryView:[keyboard getToolbarWithPrevNextDone:YES :YES]];
    [self.emailField setInputAccessoryView:[keyboard getToolbarWithPrevNextDone:YES :YES]];
    [self.realtorfirstnameField setInputAccessoryView:[keyboard getToolbarWithPrevNextDone:YES :YES]];
    [self.realtorlastnameField setInputAccessoryView:[keyboard getToolbarWithPrevNextDone:YES :YES]];
    [self.emailField1 setInputAccessoryView:[keyboard getToolbarWithPrevNextDone:YES :YES]];
    [self.brokernameField setInputAccessoryView:[keyboard getToolbarWithPrevNextDone:YES :NO]];

    self.firstnameField.delegate = self;
    self.lastnameField.delegate = self;
    self.phonenoField.delegate = self;
    self.emailField.delegate = self;
    self.realtorfirstnameField.delegate = self;
    self.realtorlastnameField.delegate = self;
    self.emailField1.delegate = self;
    self.brokernameField.delegate = self;
    
    
}

-(IBAction)keyboardWillShow:(id)sender{
    [self gobiga];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField;{
    [textField resignFirstResponder];
    [self dologin2];
    return NO;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self.sv setContentOffset: CGPointMake(0, textField.frame.origin.y-120)];
    return YES;
}

-(IBAction)keyboardWillhide:(id)sender{
    
    [self gosmalla];
    self.sv.contentSize = CGSizeMake(self.sv.frame.size.width, contentHeight);
//    [self.sv setContentOffset:CGPointMake(0,0) animated:YES];
}

    


-(IBAction)RadioNoClick:(id)sender{
    [self doneClicked];
    ischecked1=NO;
    [self.checkButton1 setImage:[UIImage imageNamed:@"rdoed.png"] forState:UIControlStateNormal];
    [self.checkButton2 setImage:[UIImage imageNamed:@"rdo.png"] forState:UIControlStateNormal];
    self.realtorfirstnameField.enabled=NO;
    self.realtorlastnameField.enabled=NO;
    //    phonenoField1.enabled=NO;
    self.emailField1.enabled=NO;
    self.brokernameField.enabled=NO;
}

-(IBAction)RadioYesClick:(id)sender{
    [self doneClicked];
    ischecked1=YES;
    [self.checkButton2 setImage:[UIImage imageNamed:@"rdoed.png"] forState:UIControlStateNormal];
    [self.checkButton1 setImage:[UIImage imageNamed:@"rdo.png"] forState:UIControlStateNormal];
    self.realtorfirstnameField.enabled=YES;
    self.realtorlastnameField.enabled=YES;
    //    phonenoField1.enabled=YES;
    self.emailField1.enabled=YES;
    self.brokernameField.enabled=YES;
}

-(IBAction)CheckboxClicked:(id)sender{
    [self doneClicked];
    if (ischecked == NO) {
		ischecked=YES;
		[self.checkButton setImage:[UIImage imageNamed:@"chked.png"] forState:UIControlStateNormal];
	}else {
		ischecked=NO;
		[self.checkButton setImage:[UIImage imageNamed:@"chk.png"] forState:UIControlStateNormal];
    }
}
-(void)gobiga{
//    int xh;
//    int xw;
//    if (self.view.bounds.size.width==748.0f) {
//        xw= self.view.bounds.size.height;
//        xh=self.view.bounds.size.width+1;
//    }else{
//        xw= self.view.bounds.size.width;
//        xh=self.view.bounds.size.height+1;
//    }
//    
//    self.sv.contentSize=CGSizeMake(xw, xh+300);
}

-(void)gosmalla{
//    int xh;
//    int xw;
//    if (self.view.bounds.size.width==748.0f) {
//        xw= self.view.bounds.size.height;
//        xh=self.view.bounds.size.width+1;
//    }else{
//        xw= self.view.bounds.size.width;
//        xh=self.view.bounds.size.height+1;
//    }
//    
//    self.sv.contentSize=CGSizeMake(xw, xh);
}

//-(IBAction)textFieldDoneEditing:(UITextField *)sender{
//    [self.sv setContentOffset:CGPointMake(0,0) animated:YES];
//}
//
//-(IBAction)textFieldDoneEditing1:(UITextField *)sender{
//    [self.sv setContentOffset:CGPointMake(0,0) animated:YES];
//    if (sender==self.phonenoField) {
//        
//    }
//}


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
-(void)doneClicked{
//    [self.sv setContentOffset:CGPointMake(0,0) animated:YES];
    [self.view endEditing: YES];
    
}


-(UITextField *)getfirstresponser{
    for (UITextField *uf in self.sv2.subviews) {
        if ([uf isKindOfClass:[UITextField class]] && [uf isFirstResponder]) {
            return uf;
        }
    }
    return nil;
}

-(void)previousClicked{
    UITextField *td =[self getfirstresponser];
//    if (td.tag==15) {
//        [[self.sv2 viewWithTag:13] becomeFirstResponder];
//    }else{
        [[self.sv2 viewWithTag:td.tag-1 ] becomeFirstResponder];
//    }
    
}

-(void)nextClicked{
    UITextField *td =[self getfirstresponser];
//    if (td.tag==13) {
//        [[self.sv2 viewWithTag:15] becomeFirstResponder];
//    }else{
        [[self.sv2 viewWithTag:td.tag+1 ] becomeFirstResponder];
//    }
}

-(IBAction)CheckboxClicked1:(id)sender{
    
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
        
        if (donext==5) {
            [self dologin2];
        }
        
    }
    
    
}

- (IBAction)doSubmit:(UIButton *)sender{
//    [self dologin];
    [self dologin2];
}


- (IBAction)doClear:(id)sender{
    [self doclear:sender];
}
-(void)dologin{
    if (fromsearch) {
        [self dologin2];
    }else{
        donext=5;
        [self doupdatechk];
    }
    
}

-(void)dologin2{
    NSString *yu=[self validateNumber:self.phonenoField.text];
    
    
    
    if ( [[Mysql TrimText:self.firstnameField.text] isEqualToString:@""]) {
        UIAlertView *tw =[self getErrorAlert:@"Please enter first name."];
        [tw show];
        [self.firstnameField becomeFirstResponder];
        return;
    }else if([[Mysql TrimText:self.lastnameField.text] isEqualToString:@""]) {
        UIAlertView *tw =[self getErrorAlert:@"Please enter last name."];
        [tw show];
        [self.lastnameField becomeFirstResponder];
        return;
    }else if (yu.length!=10){
        self.phonenoField.text=yu;
        UIAlertView *alert=[self getErrorAlert:@"Please enter 10 numbers."];
        [alert show];
        [self.phonenoField becomeFirstResponder];
        return;
    }else if([[Mysql TrimText:self.phonenoField.text] isEqualToString:@""]) {
        UIAlertView *tw =[self getErrorAlert:@"Please enter cell phone number."];
        [tw show];
        [self.phonenoField becomeFirstResponder];
        return;
    }else if( [[Mysql TrimText:self.emailField.text] isEqualToString:@""]) {
        UIAlertView *tw =[self getErrorAlert:@"Please enter email address."];
        [tw show];
        [self.emailField becomeFirstResponder];
        return;
    }else if ([Mysql IsEmail:[Mysql TrimText:self.emailField.text]]==NO) {
        UIAlertView *alert = [self getErrorAlert: @"Please enter a valid email address."];
        [alert show];
        [self.emailField becomeFirstResponder];
        return;
    }else if([self.hearBtn.currentTitle isEqualToString:@"-Please Select-"]){
        UIAlertView *alert = [self getErrorAlert: @"Please select how did you hear about us."];
        alert.tag=10;
        alert.delegate=self;
        [alert show];
        
        return;
    }
    
    self.phonenoField.text=yu;
    
    if (ischecked1==YES) {
        //        NSLog(@"%@", @"ttt");
        
        if (![[Mysql TrimText:self.realtorfirstnameField.text] isEqualToString:@""] || ![[Mysql TrimText:self.realtorlastnameField.text] isEqualToString:@""] || ![[Mysql TrimText:self.emailField1.text] isEqualToString:@""]) {
            if ( [[Mysql TrimText:self.realtorfirstnameField.text] isEqualToString:@""]) {
                UIAlertView *tw =[self getErrorAlert:@"Please enter Agent's First Name."];
                [tw show];
                [self.realtorfirstnameField becomeFirstResponder];
                return;
                //        }else if([[Mysql TrimText:phonenoField1.text] isEqualToString:@""]) {
                //            UIAlertView *tw =[self getErrorAlert:@"Please enter cell phone number."];
                //            [tw show];
                //            [phonenoField1 becomeFirstResponder];
                //            return;
            }else if( [[Mysql TrimText:self.realtorlastnameField.text] isEqualToString:@""]) {
                UIAlertView *tw =[self getErrorAlert:@"Please enter Agent's Last Name."];
                [tw show];
                [self.realtorlastnameField becomeFirstResponder];
                return;
            }else if( [[Mysql TrimText:self.emailField1.text] isEqualToString:@""]) {
                UIAlertView *tw =[self getErrorAlert:@"Please enter email address."];
                [tw show];
                [self.emailField1 becomeFirstResponder];
                return;
            }else if ([Mysql IsEmail:[Mysql TrimText:self.emailField1.text]]==NO) {
                UIAlertView *alert = [self getErrorAlert: @"Please enter a valid email address."];
                [alert show];
                [self.emailField1 becomeFirstResponder];
                return;
                
            }
            
            UIAlertView *alert = nil;
            alert = [[UIAlertView alloc]
                     initWithTitle:@"Confirmation"
                     message:@"Are you sure you want to submit?"
                     delegate:self
                     cancelButtonTitle:@"Cancel"
                     otherButtonTitles:@"OK", nil];
            alert.tag =2;
            [alert show];
            
        }else{
            UIAlertView *alert = nil;
            alert = [[UIAlertView alloc]
                     initWithTitle:@"Confirmation"
                     message:@"Are you sure you want to continue without realtor information?"
                     delegate:self
                     cancelButtonTitle:@"Cancel"
                     otherButtonTitles:@"OK", nil];
            alert.tag =4;
            [alert show];
        }
        
        
        
    }else{
        UIAlertView *alert = nil;
        alert = [[UIAlertView alloc]
                 initWithTitle:@"Confirmation"
                 message:@"Are you sure you want to submit?"
                 delegate:self
                 cancelButtonTitle:@"Cancel"
                 otherButtonTitles:@"OK", nil];
        alert.tag =2;
        [alert show];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	if (alertView.tag == 10){
        
    }else if(alertView.tag == 2){
        switch (buttonIndex) {
            case 1:
            {
                //                donext=1;
                if (fromsearch) {
                    [self updguest];
                }else{
                    [self addaguest];
                    
                }
            }
                break;
                
            default:
                break;
        }
    }else if(alertView.tag == 4){
        switch (buttonIndex) {
            case 1:
            {
                //                donext=1;
                if (fromsearch) {
                    [self updguest];
                }else{
                    [self addaguest];
                    
                }
            }
                break;
                
            default:
                [self.realtorfirstnameField becomeFirstResponder];
                break;
        }
    }
    
    
}

-(void)updguest{
    donext=2;
    [self dosync1];
    
    
    
}
-(void)addaguest{
    
    donext=1;
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.labelText=@"   Submiting...   ";
    HUD.dimBackground = YES;
    HUD.delegate = self;
    [HUD show:YES];
    
    
    steve = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:[self managedObjectContext]];
    [steve setValue:idarea forKey:@"idarea"];
    [steve setValue:idweb forKey:@"idweb"];
    [steve setValue:idcia forKey:@"idcia"];
    [steve setValue:commnunitynm forKey:@"webcommunitynm"];
    [steve setValue:idsub forKey:@"idsub"];
    
    [steve setValue:[Mysql TrimText:self.firstnameField.text] forKey:@"firstNm"];
    [steve setValue:[Mysql TrimText:self.lastnameField.text] forKey:@"lastNm"];
    [steve setValue:[NSString stringWithFormat:@"%@;%@", self.hearBtn.currentTitle, ei.priority] forKey:@"hearaboutus"];
    NSString *js= [NSString stringWithFormat:@"%@-%@-%@",
                   [self.phonenoField.text substringWithRange:NSMakeRange(0, 3)],
                   [self.phonenoField.text substringWithRange:NSMakeRange(3, 3)],
                   [self.phonenoField.text substringWithRange:NSMakeRange(6, 4)]];
    [steve setValue:js forKey:@"phonenumber"];
    [steve setValue:[Mysql TrimText:self.emailField.text] forKey:@"email"];
    [steve setValue:[Mysql TrimText:self.realtorfirstnameField.text] forKey:@"realtorfirstnm"];
    [steve setValue:[Mysql TrimText:self.realtorlastnameField.text] forKey:@"realtorlastnm"];
    //    [steve setValue:[Mysql TrimText:phonenoField1.text] forKey:@"rphonenumber"];
    [steve setValue:[Mysql TrimText:self.emailField1.text] forKey:@"remail"];
    
    [steve setValue:[Mysql TrimText:self.brokernameField.text] forKey:@"brokernm"];
    if (ischecked1) {
        [steve setValue:[NSNumber numberWithBool:YES] forKey:@"realtoryn"];
    }else{
        [steve setValue:[NSNumber numberWithBool:NO] forKey:@"realtoryn"];
    }
    if (ischecked) {
        [steve setValue:[NSNumber numberWithBool:YES] forKey:@"sendyn"];
    }else{
        [steve setValue:[NSNumber numberWithBool:NO] forKey:@"sendyn"];
    }
    [steve setValue:[NSNumber numberWithBool:NO] forKey:@"submityn"];
    [steve setValue:[[NSDate alloc] init] forKey:@"refdate"];
    
    cl_guest *cg =[[cl_guest alloc]init];
    cg.managedObjectContext=self.managedObjectContext;
    [cg addToGuest:steve];
    
    Reachability* curReach  = [Reachability reachabilityWithHostName: @"ws.buildersaccess.com"];
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
//    NSLog(@"%@", netStatus);
    if (netStatus == NotReachable) {
        [HUD hide];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"FromNewGuest"];
        [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:2] animated:NO];
//        guestsubmit *gb =[guestsubmit alloc];
//        if (![[Mysql TrimText:self.realtorfirstnameField.text]isEqualToString:@""]) {
//            if ([[Mysql TrimText:self.brokernameField.text] isEqualToString:@""]) {
//                gb.addmsg = [NSString stringWithFormat:@"Agent First Name: %@\nAgent Last Name: %@", [Mysql TrimText:self.realtorfirstnameField.text], [Mysql TrimText:self.realtorlastnameField.text]];
//            }else{
//                gb.addmsg = [NSString stringWithFormat:@"Agent First Name: %@\nAgent Last Name: %@\nRealtor Company: %@", [Mysql TrimText:self.realtorfirstnameField.text], [Mysql TrimText:self.realtorlastnameField.text], [Mysql TrimText:self.brokernameField.text]];
//            }
//        }else{
//            gb.addmsg=@"No Realtor";
//        }
//        gb.managedObjectContext=self.managedObjectContext;
//        gb.commnunitynm=self.commnunitynm;
//        gb.idcia=self.idcia;
//        
//        
//        
//        
//        [self.navigationController pushViewController:gb animated:NO];
    }else{
        rtnlist=nil;
        NSString *msg;
        if ([[steve valueForKey:@"realtoryn"] integerValue]==1){
            if ([[steve valueForKey:@"brokernm"] isEqualToString:@""]) {
                msg = [NSString stringWithFormat:@"Agent First Name: %@;Agent Last Name: %@", [steve valueForKey:@"realtorfirstnm"],[steve valueForKey:@"realtorlastnm"]];
            }else{
                msg = [NSString stringWithFormat:@"Agent First Name: %@;Agent Last Name: %@;Realtor Company: %@", [steve valueForKey:@"realtorfirstnm"],[steve valueForKey:@"realtorlastnm"],[steve valueForKey:@"brokernm"]];
            }
            
        }else{
            msg=@"No Realtor";
        }
        //        NSLog(@"%@", self.commnunitynm);
        NSString *ra;
        if ([[steve valueForKey:@"realtoryn"] integerValue]==1) {
            ra=@"True";
        }else{
            ra=@"False";
        }
        
        //         NSString *tt =[NSString stringWithFormat:@"{'IdWeb':'%@','RealtorName':'%@','AgentFName':'%@','AgentLName':'%@','IdCia':'%@','IdSub':'%@','WebNm':'%@','FirstNm':'%@','LastNm':'%@','PhoneNo':'%@','Email':'%@', 'HearAboutUs':'%@','Sendyn':'%@', 'Msg':'%@','Refdate':'%@','IdwebArea':'%@','Realtoryn':'%@','RealtorPhoneNo':'%@','RealtorEmail':'%@'}",  [steve1 valueForKey:@"idweb"],[steve1 valueForKey:@"brokernm"],[steve1 valueForKey:@"realtorfirstnm"],[steve1 valueForKey:@"realtorlastnm"], [steve1 valueForKey:@"idcia"], [steve1 valueForKey:@"idsub"],[steve1 valueForKey:@"webcommunitynm"],  [steve1 valueForKey:@"firstNm"], [steve1 valueForKey:@"lastNm"], [steve1 valueForKey:@"phonenumber"], [steve1 valueForKey:@"email"] ,[steve1 valueForKey:@"hearaboutus"], [steve1 valueForKey:@"sendyn"],  msg , [steve1 valueForKey:@"refdate"],[steve1 valueForKey:@"idarea"], ra, [steve1 valueForKey:@"rphonenumber"], [steve1 valueForKey:@"remail"]  ];
        
        //        NSString *tt =[NSString stringWithFormat:@"{'IdWeb':'%@','RealtorName':'%@','AgentFName':'%@','AgentLName':'%@','IdCia':'%@','IdSub':'%@','WebNm':'%@','FirstNm':'%@','LastNm':'%@','PhoneNo':'%@','Email':'%@', 'HearAboutUs':'%@','Sendyn':'%@', 'Msg':'%@','Refdate':'%@','IdwebArea':'%@','Realtoryn':'%@','RealtorPhoneNo':'%@','RealtorEmail':'%@'}", self.idweb,[steve valueForKey:@"brokernm"],[steve valueForKey:@"realtorfirstnm"],[steve valueForKey:@"realtorlastnm"], self.idcia, self.idsub,self.commnunitynm,  [steve valueForKey:@"firstNm"], [steve valueForKey:@"lastNm"], [steve valueForKey:@"phonenumber"], [steve valueForKey:@"email"] ,[steve valueForKey:@"hearaboutus"], [steve valueForKey:@"sendyn"],  msg , [steve valueForKey:@"refdate"],self.idarea, ra, [steve valueForKey:@"rphonenumber"], [steve valueForKey:@"remail"]  ];
        
//        NSString *tt =[NSString stringWithFormat:@"{'IdWeb':'%@','RealtorName':'%@','AgentFName':'%@','AgentLName':'%@','IdCia':'%@','IdSub':'%@','WebNm':'%@','FirstNm':'%@','LastNm':'%@','PhoneNo':'%@','Email':'%@', 'HearAboutUs':'%@','Sendyn':'%@', 'Msg':'%@','Refdate':'%@','IdwebArea':'%@','Realtoryn':'%@','RealtorPhoneNo':'%@','RealtorEmail':'%@'}", self.idweb,[steve valueForKey:@"brokernm"],[steve valueForKey:@"realtorfirstnm"],[steve valueForKey:@"realtorlastnm"], self.idcia, self.idsub,self.commnunitynm,  [steve valueForKey:@"firstNm"], [steve valueForKey:@"lastNm"], [steve valueForKey:@"phonenumber"], [steve valueForKey:@"email"] ,[steve valueForKey:@"hearaboutus"], [steve valueForKey:@"sendyn"],  msg , [steve valueForKey:@"refdate"],self.idarea, ra, @" ", [steve valueForKey:@"remail"]  ];
        
        NSString *tmp =[steve valueForKey:@"hearaboutus"];
        NSString *hearaboutus;
        NSString *priority;
        if ([tmp containsString:@";"]) {
            NSInteger loc = [tmp rangeOfString:@";"].location;
            hearaboutus = [tmp substringToIndex:loc];
            priority = [tmp substringFromIndex:loc + 1];
        }else{
            hearaboutus = tmp;
            priority = @"2 - Medium";
        }
        NSDictionary *param = @{@"IdWeb": self.idweb
                                , @"RealtorName": [steve valueForKey:@"brokernm"]
                                , @"AgentFName": [steve valueForKey:@"realtorfirstnm"]
                                , @"AgentLName": [steve valueForKey:@"realtorlastnm"]
                                , @"IdCia": self.idcia
                                , @"IdSub": self.idsub
                                , @"priority": priority
                                , @"WebNm": self.commnunitynm
                                , @"FirstNm": [steve valueForKey:@"firstNm"]
                                , @"LastNm": [steve valueForKey:@"lastNm"]
                                , @"PhoneNo": [steve valueForKey:@"phonenumber"]
                                , @"Email": [steve valueForKey:@"email"]
                                , @"HearAboutUs": hearaboutus
                                , @"Sendyn": [steve valueForKey:@"sendyn"]
                                , @"Msg": msg
                                , @"Refdate": [NSString stringWithFormat:@"%@", [steve valueForKey:@"refdate"]]
                                , @"IdwebArea": self.idarea
                                , @"Realtoryn": ra
                                , @"RealtorPhoneNo": @" "
                                , @"RealtorEmail": [steve valueForKey:@"remail"]
                                };
                NSLog([NSString stringWithFormat:@"%@", param]);
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:param
                                                           options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                             error:&error];
        
        NSString *tt = @"";
        if (! jsonData) {
            NSLog(@"Got an error: %@", error);
        } else {
            tt = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
        NSLog(tt);
        wcfService *ws =[wcfService service];
        [ws xUpdCommunity2:self action:@selector(afterxUpdCommunity2222:) xemail:[userInfo getUserName] xpassword:[userInfo getUserPwd] guestData:tt EquipmentType:@"5"];
        
    }
}

- (void) afterxUpdCommunity2222: (id) value {
    
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
    
    NSString* result = (NSString*)value;
    
    
    if (fromsearch) {
        [HUD hide];
        if ([result isEqualToString:@"1"]) {
//            guestsubmit *gb =[guestsubmit alloc];
//            if (![[Mysql TrimText:self.realtorfirstnameField.text]isEqualToString:@""]) {
//                if ([[Mysql TrimText:self.brokernameField.text] isEqualToString:@""]) {
//                    gb.addmsg = [NSString stringWithFormat:@"Agent First Name: %@\nAgent Last Name: %@", [Mysql TrimText:self.realtorfirstnameField.text], [Mysql TrimText:self.realtorlastnameField.text]];
//                }else{
//                    gb.addmsg = [NSString stringWithFormat:@"Agent First Name: %@\nAgent Last Name: %@\nRealtor Company: %@", [Mysql TrimText:self.realtorfirstnameField.text], [Mysql TrimText:self.realtorlastnameField.text], [Mysql TrimText:self.brokernameField.text]];
//                }
//            }else{
//                gb.addmsg=@"No Realtor";
//            }
//            gb.managedObjectContext=self.managedObjectContext;
//            gb.idcia=self.idcia;
//            gb.commnunitynm=self.commnunitynm;
//            [self.navigationController pushViewController:gb animated:NO];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"FromNewGuest"];
            [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:2] animated:NO];
        }else if ([result isEqualToString:@"-1"] || [result isEqualToString:@"0"]){
            UIAlertView *alert = [self getErrorAlert: @"Update fail. Please try again later."];
            [alert show];
            return;
        }else{
            UIAlertView *alert = [self getErrorAlert: result];
            [alert show];
            return;
        }
    }else{
        if (rtnlist && [rtnlist count]>0 ) {
            if ([result isEqualToString:@"1"]) {
                NSManagedObject *steve1= [rtnlist objectAtIndex:curentindex];
                [steve1 setValue:[NSNumber numberWithBool:YES] forKey:@"submityn"];
                
                cl_guest *cg =[[cl_guest alloc]init];
                cg.managedObjectContext=self.managedObjectContext;
                [cg addToGuest:steve1];
                
            }else{
                
            }
            
            curentindex+=1;
            [self dosync];
            
        }else{
            [HUD hide];
            if ([result isEqualToString:@"1"]) {
                [steve setValue:[NSNumber numberWithBool:YES] forKey:@"submityn"];
                
                cl_guest *cg =[[cl_guest alloc]init];
                cg.managedObjectContext=self.managedObjectContext;
                [cg addToGuest:steve];
                
            }
            
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"FromNewGuest"];
            [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:2] animated:NO];
            
//            guestsubmit *gb =[guestsubmit alloc];
//            if (![[Mysql TrimText:self.realtorfirstnameField.text]isEqualToString:@""]) {
//                if ([[Mysql TrimText:self.brokernameField.text] isEqualToString:@""]) {
//                    gb.addmsg = [NSString stringWithFormat:@"Agent First Name: %@\nAgent Last Name: %@", [Mysql TrimText:self.realtorfirstnameField.text], [Mysql TrimText:self.realtorlastnameField.text]];
//                }else{
//                    gb.addmsg = [NSString stringWithFormat:@"Agent First Name: %@\nAgent Last Name: %@\nRealtor Company: %@", [Mysql TrimText:self.realtorfirstnameField.text], [Mysql TrimText:self.realtorlastnameField.text], [Mysql TrimText:self.brokernameField.text]];
//                }
//            }else{
//                gb.addmsg=@"No Realtor";
//            }
//            gb.idcia=self.idcia;
//            gb.commnunitynm=self.commnunitynm;
//            gb.managedObjectContext=self.managedObjectContext;
//            
//            
//            [self.navigationController pushViewController:gb animated:NO];
        }
        
    }
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString: @"howdidyouhear" ]) {
        [self.view endEditing:YES];
    
        SelectHowToHearViewController *pc = (SelectHowToHearViewController *)segue.destinationViewController;
        pc.delegate = self;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 44.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    
    if (!cell2) {
        cell2 = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 44)];
        cell2.accessoryType = UITableViewCellAccessoryNone;
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        cell2.backgroundColor=[UIColor lightGrayColor];
        cell2.textLabel.font=[UIFont boldSystemFontOfSize:16.0];
        cell2.textLabel.textAlignment=NSTextAlignmentCenter;
        
    }
    cell2.textLabel.text=@"HOW DID YOU HEAR ABOUT US";
    
    return cell2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [pickerhear count]; // or self.items.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.text=[pickerhear objectAtIndex:indexPath.row];
        [cell.textLabel setFont:[UIFont systemFontOfSize:17.0]];
    }
    //config the cell
    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tt9 removeFromSuperview];
    tt9=nil;
    [self.hearBtn setTitle:[pickerhear objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    
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


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return [pickerhear count];
    
    
}
-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return [pickerhear objectAtIndex:row];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet1 clickedButtonAtIndex:(NSInteger)buttonIndex{
    //    NSLog(@"%d %d", buttonIndex, [ddpicker selectedRowInComponent:0]);
    if (buttonIndex == 0) {
        
        [self.hearBtn setTitle:[pickerhear objectAtIndex: [ddpicker selectedRowInComponent:0]] forState:UIControlStateNormal];
        
    }
}


-(IBAction)doclear:(id)sender{
    for (UITextField *uf in self.sv2.subviews) {
        if ([uf isKindOfClass:[UITextField class]]) {
            uf.text=@"";
        }
    }
    
    
    if (fromsearch) {
       
        for(int i = 100; i < 103; i++) {
            UILabel *lbl = [self.sv2 viewWithTag:i + 10];
//            NSLog(lbl.text);
            UIButton *btn = [self.sv2 viewWithTag:i];
            if ([lbl.text isEqualToString: ei.priority]) {
//                NSLog(@"iiii%@", ei.priority);
                [btn setImage:[UIImage imageNamed:@"rdoed.png"] forState:UIControlStateNormal];
            }else{
//                NSLog(@"iiii-");
                [btn setImage:[UIImage imageNamed:@"rdo.png"] forState:UIControlStateNormal];
            }
        }
        self.firstnameField.text=ei.FirstNm;
        self.lastnameField.text=ei.LastNm;
        self.phonenoField.text=ei.PhoneNo;
        self.emailField.text=ei.Email;
        
        if ([ei.Sendyn boolValue]) {
            ischecked=YES;
            [self.checkButton setImage:[UIImage imageNamed:@"chked.png"] forState:UIControlStateNormal];
        }else{
            ischecked=NO;
            [self.checkButton setImage:[UIImage imageNamed:@"chk.png"] forState:UIControlStateNormal];
        }
        [self.hearBtn setTitle:ei.HearAboutUs forState:UIControlStateNormal];
        
        
        
        
        //        [checkButton1 setEnabled:NO];
        //        [checkButton2 setEnabled:NO];
        
        if (ei.AgentFName) {
            
            if ([ei.RealtorEmail isEqualToString:@"will_have@realtor.com"]) {
                self.realtorfirstnameField.text=@"";
                self.realtorlastnameField.text=@"";
                //            phonenoField1.text=ei.RealtorPhoneNo;
                self.emailField1.text=@"";
                self.brokernameField.text=@"";
                
                [self.checkButton1 setEnabled:YES];
                [self.checkButton2 setEnabled:YES];
                
            }else{
                self.realtorfirstnameField.text=ei.AgentFName;
                self.realtorlastnameField.text=ei.AgentLName;
                //            phonenoField1.text=ei.RealtorPhoneNo;
                self.emailField1.text=ei.RealtorEmail;
                self.brokernameField.text=ei.RealtorName;
                [self.realtorlastnameField setEnabled:NO];
                [self.realtorfirstnameField setEnabled:NO];
                //            [phonenoField1 setEnabled:NO];
                [self.emailField1 setEnabled:NO];
                [self.brokernameField setEnabled:NO];
                [self.checkButton1 setEnabled:NO];
                [self.checkButton2 setEnabled:NO];
            }
            
            //            brokernameField.text=ei.RealtorName;
            //            realtorfirstnameField.text=ei.AgentFName;
            //            realtorlastnameField.text=ei.AgentLName;
            ////            phonenoField1.text=ei.RealtorPhoneNo;
            //            emailField1.text=ei.RealtorEmail;
            //            brokernameField.text=ei.RealtorName;
            //
            
        }else{
            
            
            
            if ([ei.RealtorEmail isEqualToString:@"will_have@realtor.com"]) {
                ischecked1=YES;
                [self.realtorlastnameField setEnabled:YES];
                [self.realtorfirstnameField setEnabled:YES];
                [self.emailField1 setEnabled:YES];
                [self.brokernameField setEnabled:YES];
                [self.checkButton2 setImage:[UIImage imageNamed:@"rdoed.png"] forState:UIControlStateNormal];
                [self.checkButton1 setImage:[UIImage imageNamed:@"rdo.png"] forState:UIControlStateNormal];
                [self.checkButton1 setEnabled:YES];
                [self.checkButton2 setEnabled:YES];
                
            }else{
                ischecked1=NO;
                [self.realtorlastnameField setEnabled:NO];
                [self.realtorfirstnameField setEnabled:NO];
                [self.emailField1 setEnabled:NO];
                [self.brokernameField setEnabled:NO];
                [self.checkButton1 setImage:[UIImage imageNamed:@"rdoed.png"] forState:UIControlStateNormal];
                [self.checkButton2 setImage:[UIImage imageNamed:@"rdo.png"] forState:UIControlStateNormal];
                [self.checkButton1 setEnabled:NO];
                [self.checkButton2 setEnabled:NO];
            }
        }
        
        
    }else{
        ischecked1=YES;
        ischecked=YES;
        [self.checkButton1 setImage:[UIImage imageNamed:@"rdo.png"] forState:UIControlStateNormal];
        [self.checkButton2 setImage:[UIImage imageNamed:@"rdoed.png"] forState:UIControlStateNormal];
        [self.checkButton setImage:[UIImage imageNamed:@"chked.png"] forState:UIControlStateNormal];
        [self.hearBtn setTitle:@"-Please Select-" forState:UIControlStateNormal];
        
        self.realtorfirstnameField.enabled = YES;
        self.realtorlastnameField.enabled = YES;
        self.emailField1.enabled = YES;
        self.brokernameField.enabled = YES;
        
    }
    
    
    
}

-(IBAction)dologout:(id)sender{
    donext =3;
    [super dosync1];
    
    
}

-(void)CancletPin{
    [super CancletPin];
    if (donext ==3) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:NO];
    }else if(donext==2){
       
        HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        [self.navigationController.view addSubview:HUD];
        HUD.labelText=@"   Submiting...   ";
        HUD.dimBackground = YES;
        HUD.delegate = self;
        [HUD show:YES];
        
        
        steve = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:[self managedObjectContext]];
        [steve setValue:idarea forKey:@"idarea"];
        [steve setValue:idweb forKey:@"idweb"];
        [steve setValue:idcia forKey:@"idcia"];
        [steve setValue:commnunitynm forKey:@"webcommunitynm"];
        [steve setValue:idsub forKey:@"idsub"];
        [steve setValue:[Mysql TrimText:self.firstnameField.text] forKey:@"firstNm"];
        [steve setValue:[Mysql TrimText:self.lastnameField.text] forKey:@"lastNm"];
        //hearaboutus store hearaboutus and priority
        [steve setValue:[NSString stringWithFormat:@"%@;%@", self.hearBtn.currentTitle, ei.priority] forKey:@"hearaboutus"];
        NSString *js= [NSString stringWithFormat:@"%@-%@-%@",
                       [self.phonenoField.text substringWithRange:NSMakeRange(0, 3)],
                       [self.phonenoField.text substringWithRange:NSMakeRange(3, 3)],
                       [self.phonenoField.text substringWithRange:NSMakeRange(6, 4)]];
        [steve setValue:js forKey:@"phonenumber"];
        [steve setValue:[Mysql TrimText:self.emailField.text] forKey:@"email"];
        [steve setValue:[Mysql TrimText:self.realtorfirstnameField.text] forKey:@"realtorfirstnm"];
        [steve setValue:[Mysql TrimText:self.realtorlastnameField.text] forKey:@"realtorlastnm"];
        //        [steve setValue:[Mysql TrimText:phonenoField1.text] forKey:@"rphonenumber"];
        [steve setValue:[Mysql TrimText:self.emailField1.text] forKey:@"remail"];
        [steve setValue:[Mysql TrimText:self.brokernameField.text] forKey:@"brokernm"];
        if (ischecked1) {
            [steve setValue:[NSNumber numberWithBool:YES] forKey:@"realtoryn"];
        }else{
            [steve setValue:[NSNumber numberWithBool:NO] forKey:@"realtoryn"];
        }
        if (ischecked) {
            [steve setValue:[NSNumber numberWithBool:YES] forKey:@"sendyn"];
        }else{
            [steve setValue:[NSNumber numberWithBool:NO] forKey:@"sendyn"];
        }
        [steve setValue:[NSNumber numberWithBool:YES] forKey:@"submityn"];
        [steve setValue:[[NSDate alloc] init] forKey:@"refdate"];
        
        Reachability* curReach  = [Reachability reachabilityWithHostName: @"ws.buildersaccess.com"];
        NetworkStatus netStatus = [curReach currentReachabilityStatus];
        
        if (netStatus ==NotReachable) {
            [HUD hide];
            UIAlertView *alert=[self getErrorAlert:@"We are temporarily unable to connect to BuildersAccess, please check your internet connection and try again. Thanks for your patience."];
            [alert show];
            return;
        }else{
            rtnlist=nil;
            NSString *msg;
            if ([[steve valueForKey:@"realtoryn"] integerValue]==1){
                if ([[steve valueForKey:@"brokernm"] isEqualToString:@""]) {
                    msg = [NSString stringWithFormat:@"Agent First Name: %@;Agent Last Name: %@", [steve valueForKey:@"realtorfirstnm"],[steve valueForKey:@"realtorlastnm"]];
                }else{
                    msg = [NSString stringWithFormat:@"Agent First Name: %@;Agent Last Name: %@;Realtor Company: %@", [steve valueForKey:@"realtorfirstnm"],[steve valueForKey:@"realtorlastnm"],[steve valueForKey:@"brokernm"]];
                }
            }else{
                msg=@"No Realtor";
            }
            if (!self.realtorfirstnameField.enabled) {
                msg = [NSString stringWithFormat:@"Agent First Name: %@;Agent Last Name: %@;Realtor Company: %@", [steve valueForKey:@"realtorfirstnm"],[steve valueForKey:@"realtorlastnm"],[steve valueForKey:@"brokernm"]];
            }
            
            NSString *ra;
            if ([[steve valueForKey:@"realtoryn"] integerValue]==1) {
                ra=@"True";
            }else{
                ra=@"False";
            }
            //                NSString *tt =[NSString stringWithFormat:@"{'IdWeb':'%@','RealtorName':'%@','AgentFName':'%@','AgentLName':'%@','IdCia':'%@','IdSub':'%@','WebNm':'%@','FirstNm':'%@','LastNm':'%@','PhoneNo':'%@','Email':'%@', 'HearAboutUs':'%@','Sendyn':'%@', 'Msg':'%@','Refdate':'%@','IdwebArea':'%@','Realtoryn':'%@','RealtorPhoneNo':'%@','RealtorEmail':'%@'}", self.idweb,[steve valueForKey:@"brokernm"],[steve valueForKey:@"realtorfirstnm"],[steve valueForKey:@"realtorlastnm"], self.idcia, self.idsub,self.commnunitynm,  [steve valueForKey:@"firstNm"], [steve valueForKey:@"lastNm"], [steve valueForKey:@"phonenumber"], [steve valueForKey:@"email"] ,[steve valueForKey:@"hearaboutus"], [steve valueForKey:@"sendyn"],  msg , [steve valueForKey:@"refdate"],self.idarea, ra, [steve valueForKey:@"rphonenumber"], [steve valueForKey:@"remail"]  ];
            NSString *tmp =[steve valueForKey:@"hearaboutus"];
                   NSString *hearaboutus;
                   NSString *priority;
                   if ([tmp containsString:@";"]) {
                       NSInteger loc = [tmp rangeOfString:@";"].location;
                       hearaboutus = [tmp substringToIndex:loc];
                       priority = [tmp substringFromIndex:loc + 1];
                   }else{
                       hearaboutus = tmp;
                       priority = @"2 - Medium";
                   }
            NSString *tt =[NSString stringWithFormat:@"{'IdWeb':'%@','priority':'%@','RealtorName':'%@','AgentFName':'%@','AgentLName':'%@','IdCia':'%@','IdSub':'%@','WebNm':'%@','FirstNm':'%@','LastNm':'%@','PhoneNo':'%@','Email':'%@', 'HearAboutUs':'%@','Sendyn':'%@', 'Msg':'%@','Refdate':'%@','IdwebArea':'%@','Realtoryn':'%@','RealtorPhoneNo':'%@','RealtorEmail':'%@'}", self.idweb, priority, [steve valueForKey:@"brokernm"],[steve valueForKey:@"realtorfirstnm"],[steve valueForKey:@"realtorlastnm"], self.idcia, self.idsub,self.commnunitynm,  [steve valueForKey:@"firstNm"], [steve valueForKey:@"lastNm"], [steve valueForKey:@"phonenumber"], [steve valueForKey:@"email"] ,hearaboutus, [steve valueForKey:@"sendyn"],  msg , [steve valueForKey:@"refdate"],self.idarea, ra, @" ", [steve valueForKey:@"remail"]  ];
            
            
//                        NSLog(@"%@ %ld", tt, ei.idnumber);
            wcfService *wseee =[wcfService service];
//            NSLog(@"ei.priority %@", ei.priority);
            [wseee xUpdGuest2:self action:@selector(afterxUpdCommunity2222:) xemail:[userInfo getUserName] xpassword:[userInfo getUserPwd] xidnumber:[NSString stringWithFormat:@"%ld", ei.idnumber] guestData:tt EquipmentType:@"5"];
            
            
            
        }
    }else{
        
    }
    
}

-(void)dosync{
    Reachability* curReach  = [Reachability reachabilityWithHostName: @"ws.buildersaccess.com"];
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    
    if (netStatus ==NotReachable) {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }else{
        
        
        
        if (curentindex < [rtnlist count]) {
            if (curentindex==0) {
                HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
                HUD.mode = MBProgressHUDModeDeterminateHorizontalBar;
                [self.navigationController.view addSubview:HUD];
                HUD.labelText=@"Syncronizing to server...";
                
                HUD.progress=0;
                [HUD layoutSubviews];
                HUD.dimBackground = YES;
                HUD.delegate = self;
                [HUD show:YES];
            }else{
                HUD.progress=curentindex*1.0/[rtnlist count];
            }
            
            
            NSEntityDescription *steve1= [rtnlist objectAtIndex:curentindex];
            NSString *msg;
            if ([[steve1 valueForKey:@"realtoryn"] integerValue]==1){
                if ([[steve valueForKey:@"brokernm"] isEqualToString:@""]) {
                    msg = [NSString stringWithFormat:@"Agent First Name: %@;Agent Last Name: %@", [steve valueForKey:@"realtorfirstnm"],[steve valueForKey:@"realtorlastnm"]];
                }else{
                    msg = [NSString stringWithFormat:@"Agent First Name: %@;Agent Last Name: %@;Realtor Company: %@", [steve valueForKey:@"realtorfirstnm"],[steve valueForKey:@"realtorlastnm"],[steve valueForKey:@"brokernm"]];
                }
                
            }else{
                msg=@"No Realtor";
            }
            
            NSString *ra;
            
            if ([[steve valueForKey:@"realtoryn"] integerValue]==1) {
                ra=@"True";
            }else{
                ra=@"False";
            }
            
            //           NSString *tt =[NSString stringWithFormat:@"{'IdWeb':'%@','RealtorName':'%@','AgentFName':'%@','AgentLName':'%@','IdCia':'%@','IdSub':'%@','WebNm':'%@','FirstNm':'%@','LastNm':'%@','PhoneNo':'%@','Email':'%@', 'HearAboutUs':'%@','Sendyn':'%@', 'Msg':'%@','Refdate':'%@','IdwebArea':'%@','Realtoryn':'%@','RealtorPhoneNo':'%@','RealtorEmail':'%@'}", self.idweb,[steve valueForKey:@"brokernm"],[steve valueForKey:@"realtorfirstnm"],[steve valueForKey:@"realtorlastnm"], self.idcia, self.idsub,self.commnunitynm,  [steve valueForKey:@"firstNm"], [steve valueForKey:@"lastNm"], [steve valueForKey:@"phonenumber"], [steve valueForKey:@"email"] ,[steve valueForKey:@"hearaboutus"], [steve valueForKey:@"sendyn"],  msg , [steve valueForKey:@"refdate"],self.idarea, ra, [steve valueForKey:@"rphonenumber"], [steve valueForKey:@"remail"]  ];
//
//            NSString *tt =[NSString stringWithFormat:@"{'IdWeb':'%@','RealtorName':'%@','AgentFName':'%@','AgentLName':'%@','IdCia':'%@','IdSub':'%@','WebNm':'%@','FirstNm':'%@','LastNm':'%@','PhoneNo':'%@','Email':'%@', 'HearAboutUs':'%@','Sendyn':'%@', 'Msg':'%@','Refdate':'%@','IdwebArea':'%@','Realtoryn':'%@','RealtorPhoneNo':'%@','RealtorEmail':'%@'}", self.idweb,[steve valueForKey:@"brokernm"],[steve valueForKey:@"realtorfirstnm"],[steve valueForKey:@"realtorlastnm"], self.idcia, self.idsub,self.commnunitynm,  [steve valueForKey:@"firstNm"], [steve valueForKey:@"lastNm"], [steve valueForKey:@"phonenumber"], [steve valueForKey:@"email"] ,[steve valueForKey:@"hearaboutus"], [steve valueForKey:@"sendyn"],  msg , [steve valueForKey:@"refdate"],self.idarea, ra, @" ", [steve valueForKey:@"remail"]  ];
            NSString *tmp =[steve valueForKey:@"hearaboutus"];
            NSString *hearaboutus;
            NSString *priority;
            if ([tmp containsString:@";"]) {
                NSInteger loc = [tmp rangeOfString:@";"].location;
                hearaboutus = [tmp substringToIndex:loc];
                priority = [tmp substringFromIndex:loc + 1];
            }else{
                hearaboutus = tmp;
                priority = @"2 - Medium";
            }
            NSDictionary *param = @{@"IdWeb": self.idweb
                                    , @"RealtorName": [steve valueForKey:@"brokernm"]
                                    , @"AgentFName": [steve valueForKey:@"realtorfirstnm"]
                                    , @"AgentLName": [steve valueForKey:@"realtorlastnm"]
                                    , @"priority": priority
                                    , @"IdCia": self.idcia
                                    , @"IdSub": self.idsub
                                    , @"WebNm": self.commnunitynm
                                    , @"FirstNm": [steve valueForKey:@"firstNm"]
                                    , @"LastNm": [steve valueForKey:@"lastNm"]
                                    , @"PhoneNo": [steve valueForKey:@"phonenumber"]
                                    , @"Email": [steve valueForKey:@"email"]
                                    , @"HearAboutUs":hearaboutus
                                    , @"Sendyn": [steve valueForKey:@"sendyn"]
                                    , @"Msg": msg
                                    , @"Refdate": [NSString stringWithFormat:@"%@", [steve valueForKey:@"refdate"]]
                                    , @"IdwebArea": self.idarea
                                    , @"Realtoryn": ra
                                    , @"RealtorPhoneNo": @" "
                                    , @"RealtorEmail": [steve valueForKey:@"remail"]
                                    };
                    NSLog([NSString stringWithFormat:@"%@", param]);
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:param
                                                               options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                                 error:&error];
            
            NSString *tt = @"";
            if (! jsonData) {
                NSLog(@"Got an error: %@", error);
            } else {
                tt = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            }
            
                                NSLog(@"%@", tt);
            wcfService *ws =[wcfService service];
            [ws xUpdCommunity2:self action:@selector(afterxUpdCommunity2222:) xemail:[userInfo getUserName] xpassword:[userInfo getUserPwd] guestData:tt EquipmentType:@"5"];
        }else{
            [HUD hide];
            [self.navigationController popToRootViewControllerAnimated:NO];
        }
        
    }
}

-(void)selectedItem:(NSString *)itemName{
    [self.hearBtn setTitle:itemName forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)selPriority:(UIButton *)sender {
    for (int i = 100; i < 103; i++) {
        UIButton *btn = [self.sv2 viewWithTag: i];
        [btn setImage:[UIImage imageNamed: sender.tag == i ? @"rdoed.png" : @"rdo.png"] forState:UIControlStateNormal];
        if (sender.tag == i) {
            UILabel *lbl = [self.sv2 viewWithTag: i + 10];
                   ei.priority = lbl.text;
//                    NSLog(@"==ei.priority %@", ei.priority);
        }
        
    }}
@end
