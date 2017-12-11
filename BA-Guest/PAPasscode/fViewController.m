//
//  fViewController.m
//  CoreData
//
//  Created by amy zhao on 13-2-26.
//  Copyright (c) 2013年 eloveit. All rights reserved.
//

#import "fViewController.h"
#import "userInfo.h"
#import "cl_pin.h"
//#import "cl_project.h"
//#import "cl_favorite.h"
//#import "cl_cia.h"
#import "cl_guest.h"
#import "Login.h"
#import "Reachability.h"
#import "wcfService.h"





@interface fViewController ()<MBProgressHUDDelegate>

@end

@implementation fViewController{
    MBProgressHUD *HUD222;
    NSMutableArray *rtnlist222;
    int curentindex222;
    
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
    
	// Do any additional setup after loading the view.
}

-(void)dosync1{
    Reachability* curReach  = [Reachability reachabilityWithHostName: @"ws.buildersaccess.com"];
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    
    if (netStatus ==NotReachable) {
        [self CancletPin];
        
    }else{
        
        
        [self doupdatechk666];
    }
    
    
    
}

-(void)doupdatechk666{
    wcfService* service = [wcfService service];
    NSString*   version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    
    [service xisupdate_ipad2:self action:@selector(xisupdate_iphoneHandler639:) version:version];
}

- (void) xisupdate_iphoneHandler639: (id) value {
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
        
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:DownLoad_InstallLink]];
        
    }else{
        cl_guest *cg =[[cl_guest alloc]init];
        cg.managedObjectContext=self.managedObjectContext;
        rtnlist222= [cg getGuest];
        if ([rtnlist222 count]>0) {
            curentindex222=0;
            
            
            HUD222 = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
            HUD222.mode = MBProgressHUDModeDeterminateHorizontalBar;
            [self.navigationController.view addSubview:HUD222];
            HUD222.labelText=@"Syncronizing local data to server...";
            HUD222.progress=0;
            [HUD222 layoutSubviews];
            HUD222.dimBackground = YES;
            HUD222.delegate = self;
            [HUD222 show:YES];
            
            [self dosync2:HUD222 andci:curentindex222 andarray:rtnlist222];
        }else{
            [self CancletPin];
        }

    }
}
- (void) afterxUpdCommunity3333: (id) value {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    // Handle errors
    if([value isKindOfClass:[NSError class]]) {
        [HUD222 hide];
        [self CancletPin];
//        NSError *error = value;
//        NSLog(@"%@", [error localizedDescription]);
//        UIAlertView *alert=[self getErrorAlert:@"We are temporarily unable to connect to BuildersAccess, please check your internet connection and try again. Thanks for your patience."];
//        [alert show];
//        return;
    }
    
    // Handle faults
    if([value isKindOfClass:[SoapFault class]]) {
        [HUD222 hide];
        [self CancletPin];
//        SoapFault *sf =value;
//        NSLog(@"%@", [sf description]);
//        UIAlertView *alert = [self getErrorAlert: value];
//        [alert show];
//        return;
    }
    
    NSString* result = (NSString*)value;
    
//    NSLog(@"%@", result);
    
    if (rtnlist222 && [rtnlist222 count]>0 ) {
        if ([result isEqualToString:@"1"]) {
            NSManagedObject *steve1= [rtnlist222 objectAtIndex:curentindex222];
            [steve1 setValue:[NSNumber numberWithBool:YES] forKey:@"submityn"];
            [self.managedObjectContext save:nil];
//            NSLog(@"%@", steve1);
            cl_guest *cg =[[cl_guest alloc]init];
            cg.managedObjectContext=self.managedObjectContext;
            [cg addToGuest:steve1];
            [cg getGuest];
            
        }else{
            
        }
        
        curentindex222+=1;
        [self dosync2:HUD222 andci:curentindex222 andarray:rtnlist222];
        
    }else{
        [self CancletPin];
    }
    
}

-(void)dosync2:(MBProgressHUD *)HUD1 andci:(int)curentindex andarray:(NSMutableArray *) rtnlist{
    curentindex222=curentindex;
    HUD222=HUD1;
    rtnlist222=rtnlist;
    Reachability* curReach  = [Reachability reachabilityWithHostName: @"ws.buildersaccess.com"];
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    
    if (netStatus ==NotReachable) {
        [HUD1 hide];
      [self CancletPin];
    }else{
        
        
        
        if (curentindex < [rtnlist count]) {
            if (curentindex==0) {
                
            }else{
                HUD1.progress=curentindex*1.0/[rtnlist count];
            }
            
            
            NSEntityDescription *steve1= [rtnlist objectAtIndex:curentindex];
            NSString *msg;
            if ([[steve1 valueForKey:@"realtoryn"] integerValue]==1){
                if ([[steve1 valueForKey:@"brokernm"] isEqualToString:@""]) {
                    msg = [NSString stringWithFormat:@"Agent First Name: %@;Agent Last Name: %@", [steve1 valueForKey:@"realtorfirstnm"],[steve1 valueForKey:@"realtorlastnm"]];
                }else{
                    msg = [NSString stringWithFormat:@"Agent First Name: %@;Agent Last Name: %@;Realtor Company: %@", [steve1 valueForKey:@"realtorfirstnm"],[steve1 valueForKey:@"realtorlastnm"],[steve1 valueForKey:@"brokernm"]];
                }
            }else{
                msg=@"No Realtor";
            }
            
//            NSString *tt =[NSString stringWithFormat:@"{'IdWeb':'%@','IdCia':'%@','IdSub':'%@','WebNm':'%@','FirstNm':'%@','LastNm':'%@','PhoneNo':'%@','Email':'%@', 'HearAboutUs':'%@','Sendyn':'%@', 'Msg':'%@','Refdate':'%@','IdwebArea':'%@'}", [steve1 valueForKey:@"idweb"], [steve1 valueForKey:@"idcia"], [steve1 valueForKey:@"idsub"],[steve1 valueForKey:@"webcommunitynm"],  [steve1 valueForKey:@"firstNm"], [steve1 valueForKey:@"lastNm"], [steve1 valueForKey:@"phonenumber"], [steve1 valueForKey:@"email"] ,[steve1 valueForKey:@"hearaboutus"], [steve1 valueForKey:@"sendyn"],  msg , [steve1 valueForKey:@"refdate"],[steve1 valueForKey:@"idarea"]  ];
//
            NSString *ra;
            
            if ([[steve1 valueForKey:@"realtoryn"] integerValue]==1) {
                ra=@"True";
            }else{
                ra=@"False";
            }
            
//              NSString *tt =[NSString stringWithFormat:@"{'IdWeb':'%@','RealtorName':'%@','AgentFName':'%@','AgentLName':'%@','IdCia':'%@','IdSub':'%@','WebNm':'%@','FirstNm':'%@','LastNm':'%@','PhoneNo':'%@','Email':'%@', 'HearAboutUs':'%@','Sendyn':'%@', 'Msg':'%@','Refdate':'%@','IdwebArea':'%@','Realtoryn':'%@','RealtorPhoneNo':'%@','RealtorEmail':'%@'}",  [steve1 valueForKey:@"idweb"],[steve1 valueForKey:@"brokernm"],[steve1 valueForKey:@"realtorfirstnm"],[steve1 valueForKey:@"realtorlastnm"], [steve1 valueForKey:@"idcia"], [steve1 valueForKey:@"idsub"],[steve1 valueForKey:@"webcommunitynm"],  [steve1 valueForKey:@"firstNm"], [steve1 valueForKey:@"lastNm"], [steve1 valueForKey:@"phonenumber"], [steve1 valueForKey:@"email"] ,[steve1 valueForKey:@"hearaboutus"], [steve1 valueForKey:@"sendyn"],  msg , [steve1 valueForKey:@"refdate"],[steve1 valueForKey:@"idarea"], ra, [steve1 valueForKey:@"rphonenumber"], [steve1 valueForKey:@"remail"]  ];
            
//             NSString *tt =[NSString stringWithFormat:@"{'IdWeb':'%@','RealtorName':'%@','AgentFName':'%@','AgentLName':'%@','IdCia':'%@','IdSub':'%@','WebNm':'%@','FirstNm':'%@','LastNm':'%@','PhoneNo':'%@','Email':'%@', 'HearAboutUs':'%@','Sendyn':'%@', 'Msg':'%@','Refdate':'%@','IdwebArea':'%@','Realtoryn':'%@','RealtorPhoneNo':'%@','RealtorEmail':'%@'}",  [steve1 valueForKey:@"idweb"],[steve1 valueForKey:@"brokernm"],[steve1 valueForKey:@"realtorfirstnm"],[steve1 valueForKey:@"realtorlastnm"], [steve1 valueForKey:@"idcia"], [steve1 valueForKey:@"idsub"],[steve1 valueForKey:@"webcommunitynm"],  [steve1 valueForKey:@"firstNm"], [steve1 valueForKey:@"lastNm"], [steve1 valueForKey:@"phonenumber"], [steve1 valueForKey:@"email"] ,[steve1 valueForKey:@"hearaboutus"], [steve1 valueForKey:@"sendyn"],  msg , [steve1 valueForKey:@"refdate"],[steve1 valueForKey:@"idarea"], ra, @"", [steve1 valueForKey:@"remail"]  ];
//
//            NSLog(@"%@ %@ %@",[userInfo getUserName], [userInfo getUserPwd], tt);
            NSDictionary *param = @{@"IdWeb": [steve1 valueForKey:@"idweb"]
                                    , @"RealtorName": [steve1 valueForKey:@"brokernm"]
                                    , @"AgentFName": [steve1 valueForKey:@"realtorfirstnm"]
                                    , @"AgentLName": [steve1 valueForKey:@"realtorlastnm"]
                                    , @"IdCia": [steve1 valueForKey:@"idcia"]
                                    , @"IdSub": [steve1 valueForKey:@"idsub"]
                                    , @"WebNm": [steve1 valueForKey:@"webcommunitynm"]
                                    , @"FirstNm": [steve1 valueForKey:@"firstNm"]
                                    , @"LastNm": [steve1 valueForKey:@"lastNm"]
                                    , @"PhoneNo": [steve1 valueForKey:@"phonenumber"]
                                    , @"Email": [steve1 valueForKey:@"email"]
                                    , @"HearAboutUs": [steve1 valueForKey:@"hearaboutus"]
                                    , @"Sendyn": [steve1 valueForKey:@"sendyn"]
                                    , @"Msg": msg
                                    , @"Refdate": [NSString stringWithFormat:@"%@", [steve1 valueForKey:@"refdate"]]
                                    , @"IdwebArea": [steve1 valueForKey:@"idarea"]
                                    , @"Realtoryn": ra
                                    , @"RealtorPhoneNo": @" "
                                    , @"RealtorEmail": [steve1 valueForKey:@"remail"]
                                    };
            //        NSLog([NSString stringWithFormat:@"%@", param]);
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
            wcfService *ws =[wcfService service];
            [ws xUpdCommunity2:self action:@selector(afterxUpdCommunity3333:) xemail:[userInfo getUserName] xpassword:[userInfo getUserPwd] guestData:tt EquipmentType:@"5"];
        }else{
            
            [self CancletPin];
        }
        
    }
}


-(UIAlertView *)getErrorAlert:(NSString *)str{
    UIAlertView *alertView = [[UIAlertView alloc]
                          initWithTitle:@"Error"
                          message:str
                          delegate:self
                          cancelButtonTitle:nil
                          otherButtonTitles:@"OK", nil];
    
    return alertView;
}

-(UIAlertView *)getSuccessAlert:(NSString *)str{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Success"
                          message:str
                          delegate:self
                          cancelButtonTitle:nil
                          otherButtonTitles:@"OK", nil];
    return alert;
}


-(IBAction)logout:(id)sender{
   
    [userInfo setUserName:[userInfo getUserName] andPwd:nil];
    [userInfo initCiaInfo:0 andNm:nil];
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)setPasscode:(id)sender {
    PAPasscodeViewController *passcodeViewController = [[PAPasscodeViewController alloc] initForAction:PasscodeActionSet];
    passcodeViewController.delegate = self;
    passcodeViewController.simple = _simpleSwitch.on;
    [self presentViewController:passcodeViewController animated:YES completion:nil];
}

- (IBAction)enterPasscode:(id)sender {
    PAPasscodeViewController *passcodeViewController = [[PAPasscodeViewController alloc] initForAction:PasscodeActionEnter];
    passcodeViewController.delegate = self;
    passcodeViewController.passcode = [self unlockPasscode];
    passcodeViewController.simple = _simpleSwitch.on;
    [self presentViewController:passcodeViewController animated:YES completion:nil];
}


-(void)changePin{}

- (IBAction)changePasscode:(id)sender {
    PAPasscodeViewController *passcodeViewController = [[PAPasscodeViewController alloc] initForAction:PasscodeActionChange];
    passcodeViewController.delegate = self;
    passcodeViewController.passcode = [self unlockPasscode];
    passcodeViewController.simple = _simpleSwitch.on;
    [self presentViewController:passcodeViewController animated:YES completion:nil];
}

#pragma mark - PAPasscodeViewControllerDelegate

- (void)g:(PAPasscodeViewController *)controller{
    
    
    [self dismissViewControllerAnimated:YES completion:^() {
        cl_pin *mp=[[cl_pin alloc]init];
        mp.managedObjectContext=self.managedObjectContext;
        [mp deletePin];
        
//        cl_cia *ma =[[cl_cia alloc]init];
//        ma.managedObjectContext=self.managedObjectContext;
//        [ma deletaAll];
//        
//        cl_project *mj =[[cl_project alloc]init];
//        mj.managedObjectContext=self.managedObjectContext;
//        [mj deletaAllCias];
//        
        cl_guest *mf =[[cl_guest alloc]init];
        mf.managedObjectContext =self.managedObjectContext;
        [mf deleteData];
        
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"save"];
        if ([[NSFileManager defaultManager]fileExistsAtPath:filePath]) {
            NSError* error;
            [[NSFileManager defaultManager]removeItemAtPath:filePath error:&error];
        }
        [userInfo setUserName:nil andPwd:nil];
        
//        Login * a =[[self.navigationController childViewControllers] objectAtIndex:0];
//        a.passwordField.text=@"";
////        [a.checkButton setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
//        
//        
//        a.ischecked=NO;
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
}

- (void)PAPasscodeViewControllerDidCancel:(PAPasscodeViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:^() {
        [self CancletPin];
    }];
    
}

-(void)CancletPin{
    [HUD222 hide];
}
- (void)PAPasscodeViewControllerDidEnterPasscode:(PAPasscodeViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:^() {
//        [[[UIAlertView alloc] initWithTitle:nil message:@"Passcode entered correctly" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }];
    
   
}

- (void)PAPasscodeViewControllerDidSetPasscode:(PAPasscodeViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:^() {
        
       
        cl_pin *mp=[[cl_pin alloc]init];
        mp.managedObjectContext=self.managedObjectContext;
        [mp addToXpin:[userInfo getUserName] andpincode:controller.passcode];
        [self changePin];
    }];
}

- (void)PAPasscodeViewControllerDidChangePasscode:(PAPasscodeViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:^() {
        cl_pin *mp=[[cl_pin alloc]init];
        mp.managedObjectContext=self.managedObjectContext;
        [mp deletePin];
        [self changePin];
    }];
}

- (void)viewDidUnload {
    [self setSimpleSwitch:nil];
    [super viewDidUnload];
}



- (NSString *)unlockPasscode
{
    //Provide the ABLockScreen with a code to verify against
    //    return 1234;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Xpin"inManagedObjectContext:self.managedObjectContext];
    [request setEntity:entity];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"pincode"ascending:NO];
    NSArray *sortDescriptions = [[NSArray alloc]initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptions];
    
    
    NSError *error = nil;
    NSMutableArray *mutableFetchResult = [[self.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    
    if ([mutableFetchResult count]==0) {
        return @"0";
    }else{
        NSManagedObject *entry1 = [mutableFetchResult objectAtIndex:0];
        return [entry1 valueForKey:@"pincode"];
        
        
    }
    
}

- (NSString *)lastUser
{
    //Provide the ABLockScreen with a code to verify against
    //    return 1234;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Xpin"inManagedObjectContext:self.managedObjectContext];
    [request setEntity:entity];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"pincode"ascending:NO];
    NSArray *sortDescriptions = [[NSArray alloc]initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptions];
    
    
    NSError *error = nil;
    NSMutableArray *mutableFetchResult = [[self.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    
    if ([mutableFetchResult count]==0) {
        return @"0";
    }else{
        
        
          NSManagedObject *entry1 = [mutableFetchResult objectAtIndex:0];
        return [entry1 valueForKey:@"email"];
    }
    
}






@end
