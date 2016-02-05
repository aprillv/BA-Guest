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
#import "guestsubmit.h"


@interface newguest ()<UIPickerViewDelegate, UIPickerViewDataSource, CustomKeyboardDelegate, UIAlertViewDelegate, MBProgressHUDDelegate, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@end

@implementation newguest{
    UITextField *firstnameField;
    UITextField *lastnameField;
    UITextField *phonenoField;
    UITextField *emailField;
    UITextField *realtorfirstnameField;
    UITextField *realtorlastnameField;
    UITextField *brokernameField;
    UIButton *hearField;
    UIImageView *iv;
    UIScrollView *sv;
    UIPickerView *ddpicker;
    NSMutableArray *pickerhear;
    CustomKeyboard *keyboard;
    MBProgressHUD *HUD;
    bool ischecked;
    bool ischecked1;
    UIButton * checkButton;
    UIButton * checkButton1;
    UIButton * checkButton2;
    NSManagedObject *steve;
    NSMutableArray *rtnlist;
    int curentindex;
    UIView * tt9;
    int donext;
    UITableViewCell *cell2;
    
    //    UITextField *phonenoField1;
    UITextField *emailField1;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillhide:) name:UIKeyboardWillHideNotification object:nil];
    
    [self doinit];
    
    
    
}

-(IBAction)keyboardWillShow:(id)sender{
    [self gobiga];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField;{
    [self dologin];
    return NO;
}
-(IBAction)keyboardWillhide:(id)sender{
    
    [self gosmalla];
    [sv setContentOffset:CGPointMake(0,0) animated:YES];
}

-(void)doinit{
    //    int x;
    int y;
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
    
    baControl *bc =[[baControl alloc]init];
    if ([idcia isEqualToString:@"100"] || [idcia isEqualToString:@"306"]) {
        self.view=[bc GetCommenFrame100:xw andxh:xh];
    }else{
        self.view=[bc GetCommenFrame101:xw andxh:xh];
    }
    
    UIButton *logoutbtn =[bc getButton:[UIColor grayColor] andrect:CGRectMake(0, 0, 130, 40)];
    logoutbtn.frame=CGRectMake(xw-150, 25, 130, 40);
    [logoutbtn setTitle:@"Go Back" forState:UIControlStateNormal];
    [logoutbtn addTarget:self action:@selector(dologout:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:logoutbtn];
    
    sv =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 120, xw, xh-120)];
    
    [self.view addSubview:sv];
    
    
    xx=125;
    y=15;
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(xx, y, xw-xx*2, 45)];
    lbl.numberOfLines=2;
    lbl.text=[NSString stringWithFormat:@"Thank you for visiting %@. Please fill out the following information so we can better assist you!", commnunitynm];
    [sv addSubview:lbl];
    y=y+60;
    
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(xx, y, 10, 25)];
    lbl.text=@"*";
    lbl.textColor=[UIColor redColor];
    [sv addSubview:lbl];
    
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(xx+10, y, 150, 25)];
    lbl.text=@"FIRST NAME";
    [sv addSubview:lbl];
    
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(xx+400, y, 10, 25)];
    lbl.text=@"*";
    lbl.textColor=[UIColor redColor];
    [sv addSubview:lbl];
    
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(xx+410, y, 100, 25)];
    lbl.text=@"LAST NAME";
    [sv addSubview:lbl];
    y=y+30;
    
    firstnameField=[[UITextField alloc]initWithFrame:CGRectMake(xx, y, 380, 31)];
    [firstnameField setBorderStyle:UITextBorderStyleRoundedRect];
    [firstnameField addTarget:self action:@selector(textFieldDoneEditing:) forControlEvents:UIControlEventEditingDidEndOnExit];
    firstnameField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [sv addSubview: firstnameField];
    
    lastnameField=[[UITextField alloc]initWithFrame:CGRectMake(xx+400, y, 380, 31)];
    [lastnameField setBorderStyle:UITextBorderStyleRoundedRect];
    [lastnameField addTarget:self action:@selector(textFieldDoneEditing:) forControlEvents:UIControlEventEditingDidEndOnExit];
    lastnameField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    //    [lastnameField setSecureTextEntry:YES];
    [sv addSubview: lastnameField];
    y=y+40;
    
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(xx, y, 10, 25)];
    lbl.text=@"*";
    lbl.textColor=[UIColor redColor];
    [sv addSubview:lbl];
    
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(xx+10, y, 200, 25)];
    lbl.text=@"CELL PHONE NUMBER";
    [sv addSubview:lbl];
    
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(xx+400, y, 10, 25)];
    lbl.text=@"*";
    lbl.textColor=[UIColor redColor];
    [sv addSubview:lbl];
    
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(xx+410, y, 100, 25)];
    lbl.text=@"EMAIL";
    [sv addSubview:lbl];
    y=y+30;
    
    phonenoField=[[UITextField alloc]initWithFrame:CGRectMake(xx, y, 380, 31)];
    [phonenoField setBorderStyle:UITextBorderStyleRoundedRect];
    [phonenoField addTarget:self action:@selector(textFieldDoneEditing1:) forControlEvents:UIControlEventEditingDidEndOnExit];
    phonenoField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    phonenoField.keyboardType =UIKeyboardTypeNumberPad;
    [sv addSubview: phonenoField];
    
    emailField=[[UITextField alloc]initWithFrame:CGRectMake(xx+400, y, 380, 31)];
    [emailField setBorderStyle:UITextBorderStyleRoundedRect];
    [emailField addTarget:self action:@selector(textFieldDoneEditing:) forControlEvents:UIControlEventEditingDidEndOnExit];
    //    [emailField setSecureTextEntry:YES];
    emailField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    emailField.keyboardType=UIKeyboardTypeEmailAddress;
    [sv addSubview: emailField];
    y=y+40;
    
    
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(xx, y, 380, 25)];
    lbl.text=@"HOW DID YOU HEAR ABOUT US";
    [sv addSubview:lbl];
    
    //    lbl=[[UILabel alloc]initWithFrame:CGRectMake(xx+400, y+20, 300, 40)];
    //    lbl.numberOfLines=2;
    //    lbl.text=[NSString stringWithFormat:@"Send me updated information about %@ and this community.", cianm];
    //
    //    [sv addSubview:lbl];
    
    //    switchView=[[UISegmentedControl alloc]initWithItems:[[NSMutableArray alloc]initWithObjects:@"Yes", @"No", nil]];
    //    switchView.frame=CGRectMake(xx+680, y+32, 100.0f, 28.0f);
    //    [sv addSubview:switchView];
    //    [switchView addTarget:self action:@selector(CheckboxClicked:) forControlEvents:UIControlEventValueChanged];
    //    switchView.selectedSegmentIndex=0;
    
    checkButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [checkButton setFrame:CGRectMake(xx+400, y+10, 50, 40)];
    [checkButton addTarget:self action:@selector(CheckboxClicked:) forControlEvents:UIControlEventTouchDown];
    [checkButton setImageEdgeInsets:UIEdgeInsetsMake(2.0, -10.0, 5.0, 5.0)];
    [checkButton setImage: [UIImage imageNamed:@"chked.png"] forState:UIControlStateNormal];
    [checkButton setTitleEdgeInsets:UIEdgeInsetsMake(2.0, 0.0, 5.0, 5.0)];
    [checkButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //     [checkButton.titleLabel setFont:[UIFont boldSystemFontOfSize:17.0f]];
    ischecked=YES;
    [checkButton setTitle:@"" forState:UIControlStateNormal];
    [sv addSubview:checkButton];
    
    
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(xx+440, y, 330, 50)];
    lbl.text=[NSString stringWithFormat:@"Send me updated information about %@ and this community.", cianm];
    lbl.numberOfLines=2;
    [sv addSubview:lbl];
    
    y=y+30;
    
    
    UITextField *text1=[[UITextField alloc]initWithFrame:CGRectMake(xx, y, 380, 30)];
    [text1 setBorderStyle:UITextBorderStyleRoundedRect];
    text1.enabled=NO;
    text1.text=@"";
    [sv addSubview: text1];
    
    hearField=[UIButton buttonWithType: UIButtonTypeCustom];
    [hearField setFrame:CGRectMake(xx+10, y+4, 330, 21)];
    [hearField setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [hearField setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [hearField setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 23)];
    [hearField.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [hearField addTarget:self action:@selector(popupscreen5) forControlEvents:UIControlEventTouchDown];
    
    [sv addSubview:hearField];
    
    y=y+40+20;
    
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(xx, y, 400, 25)];
    //    lbl.text=@"WILL YOU HAVE A REALTOR?";
    lbl.text=@"DO YOU PLAN ON USING A REALTOR?";
    [sv addSubview:lbl];
    y=y+30;
    checkButton1=[UIButton buttonWithType:UIButtonTypeCustom];
    [checkButton1 setFrame:CGRectMake(xx, y, 50, 36)];
    [checkButton1 addTarget:self action:@selector(CheckboxClicked3:) forControlEvents:UIControlEventTouchDown];
    //    [checkButton1 setImageEdgeInsets:UIEdgeInsetsMake(2.0, -0.0, 5.0, 5.0)];
    [checkButton1 setImage: [UIImage imageNamed:@"rdo.png"] forState:UIControlStateNormal];
    [checkButton1 setImage: [UIImage imageNamed:@"mask.png"] forState:UIControlStateHighlighted];
    //    [checkButton1 setTitleEdgeInsets:UIEdgeInsetsMake(2.0, -40.0, 5.0, 5.0)];
    //    [checkButton1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //     [checkButton.titleLabel setFont:[UIFont boldSystemFontOfSize:17.0f]];
    ischecked1=YES;
    //    [checkButton1 setTitle:@"No" forState:UIControlStateNormal];
    [sv addSubview:checkButton1];
    
    UIButton*tt=[UIButton buttonWithType:UIButtonTypeCustom];
    [tt setFrame:CGRectMake(xx+40, y, 50, 40)];
    //    [tt addTarget:self action:@selector(CheckboxClicked3:) forControlEvents:UIControlEventTouchDown];
    //    [checkButton setImageEdgeInsets:UIEdgeInsetsMake(2.0, -10.0, 5.0, 5.0)];
    //    [checkButton setImage: [UIImage imageNamed:@"chked.png"] forState:UIControlStateNormal];
    //    [checkButton setTitleEdgeInsets:UIEdgeInsetsMake(2.0, 0.0, 5.0, 5.0)];
    [tt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //     [checkButton.titleLabel setFont:[UIFont boldSystemFontOfSize:17.0f]];
    [tt setTitle:@"No" forState:UIControlStateNormal];
    [sv addSubview:tt];
    
    
    checkButton2=[UIButton buttonWithType:UIButtonTypeCustom];
    [checkButton2 setFrame:CGRectMake(xx+100, y, 50, 36)];
    [checkButton2 addTarget:self action:@selector(CheckboxClicked4:) forControlEvents:UIControlEventTouchDown];
    //    [checkButton2 setImageEdgeInsets:UIEdgeInsetsMake(2.0, -50.0, 5.0, 5.0)];
    [checkButton2 setImage: [UIImage imageNamed:@"rdoed.png"] forState:UIControlStateNormal];
    [checkButton2 setImage: [UIImage imageNamed:@"mask.png"] forState:UIControlStateHighlighted];
    
    //    [checkButton2 setTitleEdgeInsets:UIEdgeInsetsMake(2.0, -40.0, 5.0, 5.0)];
    //    [checkButton2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //     [checkButton.titleLabel setFont:[UIFont boldSystemFontOfSize:17.0f]];
    
    //    [checkButton2 setTitle:@"Yes" forState:UIControlStateNormal];
    [sv addSubview:checkButton2];
    
    tt=[UIButton buttonWithType:UIButtonTypeCustom];
    [tt setFrame:CGRectMake(xx+140, y, 50, 40)];
    //    [tt addTarget:self action:@selector(CheckboxClicked3:) forControlEvents:UIControlEventTouchDown];
    //    [checkButton setImageEdgeInsets:UIEdgeInsetsMake(2.0, -10.0, 5.0, 5.0)];
    //    [checkButton setImage: [UIImage imageNamed:@"chked.png"] forState:UIControlStateNormal];
    //    [checkButton setTitleEdgeInsets:UIEdgeInsetsMake(2.0, 0.0, 5.0, 5.0)];
    [tt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    //     [checkButton.titleLabel setFont:[UIFont boldSystemFontOfSize:17.0f]];
    [tt setTitle:@"Yes" forState:UIControlStateNormal];
    [sv addSubview:tt];
    
    y=y+40+10;
    
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(xx, y, 400, 25)];
    lbl.text=@"IF YES, PLEASE PROVIDE";
    [sv addSubview:lbl];
    y=y+30+10;
    
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(xx, y, 10, 25)];
    lbl.text=@"*";
    lbl.textColor=[UIColor redColor];
    [sv addSubview:lbl];
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(xx+10, y, 200, 25)];
    lbl.text=@"AGENT FIRST NAME";
    [sv addSubview:lbl];
    
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(xx+400, y, 10, 25)];
    lbl.text=@"*";
    lbl.textColor=[UIColor redColor];
    [sv addSubview:lbl];
    
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(xx+410, y, 200, 25)];
    lbl.text=@"AGENT LAST NAME";
    [sv addSubview:lbl];
    y=y+30;
    
    
    realtorfirstnameField=[[UITextField alloc]initWithFrame:CGRectMake(xx, y, 380, 31)];
    [realtorfirstnameField setBorderStyle:UITextBorderStyleRoundedRect];
    [realtorfirstnameField addTarget:self action:@selector(dddddddd:) forControlEvents:UIControlEventEditingDidBegin];
    
    [realtorlastnameField addTarget:self action:@selector(textFieldDoneEditing:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    realtorfirstnameField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [sv addSubview: realtorfirstnameField];
    
    realtorlastnameField=[[UITextField alloc]initWithFrame:CGRectMake(xx+400, y, 380, 31)];
    realtorlastnameField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [realtorlastnameField setBorderStyle:UITextBorderStyleRoundedRect];
    [realtorlastnameField addTarget:self action:@selector(dddddddd:) forControlEvents:UIControlEventEditingDidBegin];
    [emailField addTarget:self action:@selector(dddddddd0:) forControlEvents:UIControlEventEditingDidBegin];
    [realtorlastnameField addTarget:self action:@selector(textFieldDoneEditing:) forControlEvents:UIControlEventEditingDidEndOnExit];
    //    [realtorlastnameField setSecureTextEntry:YES];
    [sv addSubview: realtorlastnameField];
    y=y+40;
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(xx, y, 10, 25)];
    lbl.text=@"*";
    lbl.textColor=[UIColor redColor];
    [sv addSubview:lbl];
    
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(xx+10, y, 300, 25)];
    //    lbl.text=@"REALTOR CELL PHONE NUMBER";
    lbl.text=@"REALTOR EMAIL";
    [sv addSubview:lbl];
    
    //    lbl=[[UILabel alloc]initWithFrame:CGRectMake(xx+400, y, 10, 25)];
    //    lbl.text=@"*";
    //    lbl.textColor=[UIColor redColor];
    //    [sv addSubview:lbl];
    //
    //    lbl=[[UILabel alloc]initWithFrame:CGRectMake(xx+410, y, 200, 25)];
    //    lbl.text=@"REALTOR EMAIL";
    //    [sv addSubview:lbl];
    y=y+30;
    
    //    phonenoField1=[[UITextField alloc]initWithFrame:CGRectMake(xx, y, 380, 31)];
    //    [phonenoField1 setBorderStyle:UITextBorderStyleRoundedRect];
    //    [phonenoField1 addTarget:self action:@selector(textFieldDoneEditing:) forControlEvents:UIControlEventEditingDidEndOnExit];
    //    [phonenoField1 addTarget:self action:@selector(dddddddd1:) forControlEvents:UIControlEventEditingDidBegin];
    //    phonenoField1.autocapitalizationType = UITextAutocapitalizationTypeNone;
    //    phonenoField1.keyboardType =UIKeyboardTypeNumberPad;
    //    [sv addSubview: phonenoField1];
    
    emailField1=[[UITextField alloc]initWithFrame:CGRectMake(xx, y, 780, 31)];
    [emailField1 setBorderStyle:UITextBorderStyleRoundedRect];
    [emailField1 addTarget:self action:@selector(textFieldDoneEditing:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [emailField1 addTarget:self action:@selector(dddddddd1:) forControlEvents:UIControlEventEditingDidBegin];
    //    [emailField setSecureTextEntry:YES];
    emailField1.autocapitalizationType = UITextAutocapitalizationTypeNone;
    emailField1.keyboardType=UIKeyboardTypeEmailAddress;
    [sv addSubview: emailField1];
    y=y+40;
    
    
    
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(xx, y, 200, 25)];
    lbl.text=@"REALTOR COMPANY";
    [sv addSubview:lbl];
    y=y+30;
    
    brokernameField=[[UITextField alloc]initWithFrame:CGRectMake(xx, y, 780, 31)];
    [brokernameField setBorderStyle:UITextBorderStyleRoundedRect];
    [brokernameField addTarget:self action:@selector(textFieldDoneEditing:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [brokernameField addTarget:self action:@selector(dddddddd2:) forControlEvents:UIControlEventEditingDidBegin];
    brokernameField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [sv addSubview: brokernameField];
    y=y+60;
    
    //    Mysql *mq =[[Mysql alloc]init];
    //    iv =[[UIImageView alloc]initWithImage:[mq createImageWithColor:[UIColor orangeColor]]];
    //    iv.frame=CGRectMake(xx, y, 380, 44);
    //    iv.layer.masksToBounds=YES;
    //    iv.layer.cornerRadius=5.0f;
    //    [sv addSubview:iv];
    
    UIButton *btn1 = [bc getButton:[UIColor orangeColor] andrect:CGRectMake(0, 0, 380, 44)];
    [btn1 setFrame:CGRectMake(xx, y, 380, 44)];
    [btn1 setTitle:@"Submit" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(dologin) forControlEvents:UIControlEventTouchDown];
    [sv addSubview:btn1];
    
    //    UIButton *btn1=[UIButton buttonWithType:UIButtonTypeCustom];
    //    [btn1 setFrame:CGRectMake(xx, y, 380, 44)];
    //    [btn1 setTitle:@"Submit" forState:UIControlStateNormal];
    //    [btn1 addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchDown];
    ////    [btn1 addTarget:self action:@selector(login:) forControlEvents:UIControlStateHighlighted];
    //    [sv addSubview:btn1];
    
    
    
    btn1 = [bc getButton:[UIColor grayColor] andrect:CGRectMake(0, 0, 380, 44)];
    [btn1 setFrame:CGRectMake(xx+400, y, 380, 44)];
    [btn1 setTitle:@"Clear" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(doclear:) forControlEvents:UIControlEventTouchDown];
    [sv addSubview:btn1];
    
    sv.contentSize=CGSizeMake(xw, xh+100);
    
    
    keyboard=[[CustomKeyboard alloc]init];
    keyboard.delegate=self;
    int i=10;
    for (UITextField *uf in sv.subviews) {
        if ([uf isKindOfClass:[UITextField class]]) {
            uf.tag=i++;
            uf.text=@"";
            uf.delegate=self;
            uf.returnKeyType=UIReturnKeyDone;
        }
    }
    
    [firstnameField setInputAccessoryView:[keyboard getToolbarWithPrevNextDone:NO :YES]];
    [lastnameField setInputAccessoryView:[keyboard getToolbarWithPrevNextDone:YES :YES]];
    [phonenoField setInputAccessoryView:[keyboard getToolbarWithPrevNextDone:YES :YES]];
    [emailField setInputAccessoryView:[keyboard getToolbarWithPrevNextDone:YES :YES]];
    [realtorfirstnameField setInputAccessoryView:[keyboard getToolbarWithPrevNextDone:YES :YES]];
    [realtorlastnameField setInputAccessoryView:[keyboard getToolbarWithPrevNextDone:YES :YES]];
    //    [phonenoField1 setInputAccessoryView:[keyboard getToolbarWithPrevNextDone:YES :YES]];
    [emailField1 setInputAccessoryView:[keyboard getToolbarWithPrevNextDone:YES :YES]];
    [brokernameField setInputAccessoryView:[keyboard getToolbarWithPrevNextDone:YES :NO]];
    
    
    [hearField setTitle:@"-Please Select-" forState:UIControlStateNormal];
    
    
}


//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    NSString *candidate = [[textField text] stringByReplacingCharactersInRange:range withString:string];
//    if (!candidate || [candidate length] < 1 || [candidate isEqualToString:@""])
//    {
//        return YES;
//    }
//    NSDecimalNumber *number = [NSDecimalNumber decimalNumberWithString:candidate];
//    if (!number || [number isEqualToNumber:[NSDecimalNumber notANumber]])
//    {
//        return NO;
//    }
//    return YES;
//}


-(IBAction)CheckboxClicked3:(id)sender{
    [self doneClicked];
    ischecked1=NO;
    [checkButton1 setImage:[UIImage imageNamed:@"rdoed.png"] forState:UIControlStateNormal];
    [checkButton2 setImage:[UIImage imageNamed:@"rdo.png"] forState:UIControlStateNormal];
    realtorfirstnameField.enabled=NO;
    realtorlastnameField.enabled=NO;
    //    phonenoField1.enabled=NO;
    emailField1.enabled=NO;
    brokernameField.enabled=NO;
}

-(IBAction)CheckboxClicked4:(id)sender{
    [self doneClicked];
    ischecked1=YES;
    [checkButton2 setImage:[UIImage imageNamed:@"rdoed.png"] forState:UIControlStateNormal];
    [checkButton1 setImage:[UIImage imageNamed:@"rdo.png"] forState:UIControlStateNormal];
    realtorfirstnameField.enabled=YES;
    realtorlastnameField.enabled=YES;
    //    phonenoField1.enabled=YES;
    emailField1.enabled=YES;
    brokernameField.enabled=YES;
}

-(IBAction)CheckboxClicked:(id)sender{
    [self doneClicked];
    if (ischecked == NO) {
		ischecked=YES;
		[checkButton setImage:[UIImage imageNamed:@"chked.png"] forState:UIControlStateNormal];
	}else {
		ischecked=NO;
		[checkButton setImage:[UIImage imageNamed:@"chk.png"] forState:UIControlStateNormal];
    }
}
-(void)gobiga{
    int xh;
    int xw;
    if (self.view.bounds.size.width==748.0f) {
        xw= self.view.bounds.size.height;
        xh=self.view.bounds.size.width+1;
    }else{
        xw= self.view.bounds.size.width;
        xh=self.view.bounds.size.height+1;
    }
    
    sv.contentSize=CGSizeMake(xw, xh+300);
}

-(void)gosmalla{
    int xh;
    int xw;
    if (self.view.bounds.size.width==748.0f) {
        xw= self.view.bounds.size.height;
        xh=self.view.bounds.size.width+1;
    }else{
        xw= self.view.bounds.size.width;
        xh=self.view.bounds.size.height+1;
    }
    
    sv.contentSize=CGSizeMake(xw, xh);
}

-(IBAction)textFieldDoneEditing:(UITextField *)sender{
    [sv setContentOffset:CGPointMake(0,0) animated:YES];
}

-(IBAction)textFieldDoneEditing1:(UITextField *)sender{
    [sv setContentOffset:CGPointMake(0,0) animated:YES];
    if (sender==phonenoField) {
        
    }
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
-(IBAction)dddddddd0:(id)sender{
    
    [sv setContentOffset:CGPointMake(0,65) animated:YES];
}
-(IBAction)dddddddd:(id)sender{
    
    [sv setContentOffset:CGPointMake(0,255+40) animated:YES];
}
-(IBAction)dddddddd1:(id)sender{
    [sv setContentOffset:CGPointMake(0,325+40) animated:YES];
}

-(IBAction)dddddddd2:(id)sender{
    [sv setContentOffset:CGPointMake(0,395+40) animated:YES];
}
-(void)doneClicked{
    [sv setContentOffset:CGPointMake(0,0) animated:YES];
    for (UITextField *uf in sv.subviews) {
        if ([uf isKindOfClass:[UITextField class]]) {
            [uf resignFirstResponder];
        }
    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    //    if (!fromsearch) {
    [self doclear:nil];
    //            }
    
}
-(UITextField *)getfirstresponser{
    for (UITextField *uf in sv.subviews) {
        if ([uf isKindOfClass:[UITextField class]] && [uf isFirstResponder]) {
            return uf;
        }
    }
    return nil;
}

-(void)previousClicked{
    UITextField *td =[self getfirstresponser];
    if (td.tag==15) {
        [[sv viewWithTag:13] becomeFirstResponder];
    }else{
        [[sv viewWithTag:td.tag-1 ] becomeFirstResponder];
    }
    
}

-(void)nextClicked{
    UITextField *td =[self getfirstresponser];
    if (td.tag==13) {
        [[sv viewWithTag:15] becomeFirstResponder];
    }else{
        [[sv viewWithTag:td.tag+1 ] becomeFirstResponder];
    }
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


-(void)dologin{
    if (fromsearch) {
        [self dologin2];
    }else{
        donext=5;
        [self doupdatechk];
    }
    
}

-(void)dologin2{
    NSString *yu=[self validateNumber:phonenoField.text];
    
    
    
    if ( [[Mysql TrimText:firstnameField.text] isEqualToString:@""]) {
        UIAlertView *tw =[self getErrorAlert:@"Please enter first name."];
        [tw show];
        [firstnameField becomeFirstResponder];
        return;
    }else if([[Mysql TrimText:lastnameField.text] isEqualToString:@""]) {
        UIAlertView *tw =[self getErrorAlert:@"Please enter last name."];
        [tw show];
        [lastnameField becomeFirstResponder];
        return;
    }else if (yu.length!=10){
        phonenoField.text=yu;
        UIAlertView *alert=[self getErrorAlert:@"Please enter 10 numbers."];
        [alert show];
        [phonenoField becomeFirstResponder];
        return;
    }else if([[Mysql TrimText:phonenoField.text] isEqualToString:@""]) {
        UIAlertView *tw =[self getErrorAlert:@"Please enter cell phone number."];
        [tw show];
        [phonenoField becomeFirstResponder];
        return;
    }else if( [[Mysql TrimText:emailField.text] isEqualToString:@""]) {
        UIAlertView *tw =[self getErrorAlert:@"Please enter email address."];
        [tw show];
        [emailField becomeFirstResponder];
        return;
    }else if ([Mysql IsEmail:[Mysql TrimText:emailField.text]]==NO) {
        UIAlertView *alert = [self getErrorAlert: @"Please enter a valid email address."];
        [alert show];
        [emailField becomeFirstResponder];
        return;
    }else if([hearField.currentTitle isEqualToString:@"-Please Select-"]){
        UIAlertView *alert = [self getErrorAlert: @"Please select how did you hear about us."];
        alert.tag=10;
        alert.delegate=self;
        [alert show];
        
        return;
    }
    
    phonenoField.text=yu;
    
    if (ischecked1==YES) {
        //        NSLog(@"%@", @"ttt");
        
        if (![[Mysql TrimText:realtorfirstnameField.text] isEqualToString:@""] || ![[Mysql TrimText:realtorlastnameField.text] isEqualToString:@""] || ![[Mysql TrimText:emailField1.text] isEqualToString:@""]) {
            if ( [[Mysql TrimText:realtorfirstnameField.text] isEqualToString:@""]) {
                UIAlertView *tw =[self getErrorAlert:@"Please enter Agent's First Name."];
                [tw show];
                [realtorfirstnameField becomeFirstResponder];
                return;
                //        }else if([[Mysql TrimText:phonenoField1.text] isEqualToString:@""]) {
                //            UIAlertView *tw =[self getErrorAlert:@"Please enter cell phone number."];
                //            [tw show];
                //            [phonenoField1 becomeFirstResponder];
                //            return;
            }else if( [[Mysql TrimText:realtorlastnameField.text] isEqualToString:@""]) {
                UIAlertView *tw =[self getErrorAlert:@"Please enter Agent's Last Name."];
                [tw show];
                [realtorlastnameField becomeFirstResponder];
                return;
            }else if( [[Mysql TrimText:emailField1.text] isEqualToString:@""]) {
                UIAlertView *tw =[self getErrorAlert:@"Please enter email address."];
                [tw show];
                [emailField1 becomeFirstResponder];
                return;
            }else if ([Mysql IsEmail:[Mysql TrimText:emailField1.text]]==NO) {
                UIAlertView *alert = [self getErrorAlert: @"Please enter a valid email address."];
                [alert show];
                [emailField1 becomeFirstResponder];
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
        [self popupscreen5];
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
                [realtorfirstnameField becomeFirstResponder];
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
    //    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    //    HUD.mode = MBProgressHUDModeDeterminateHorizontalBar;
    //    [self.navigationController.view addSubview:HUD];
    //    HUD.labelText=@"        Saving...        ";
    //
    //    HUD.progress=0;
    //    [HUD layoutSubviews];
    //    HUD.dimBackground = YES;
    //    HUD.delegate = self;
    //    [HUD show:YES];
    
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
    
    [steve setValue:[Mysql TrimText:firstnameField.text] forKey:@"firstNm"];
    [steve setValue:[Mysql TrimText:lastnameField.text] forKey:@"lastNm"];
    [steve setValue:hearField.currentTitle forKey:@"hearaboutus"];
    NSString *js= [NSString stringWithFormat:@"%@-%@-%@",
                   [phonenoField.text substringWithRange:NSMakeRange(0, 3)],
                   [phonenoField.text substringWithRange:NSMakeRange(3, 3)],
                   [phonenoField.text substringWithRange:NSMakeRange(6, 4)]];
    [steve setValue:js forKey:@"phonenumber"];
    [steve setValue:[Mysql TrimText:emailField.text] forKey:@"email"];
    [steve setValue:[Mysql TrimText:realtorfirstnameField.text] forKey:@"realtorfirstnm"];
    [steve setValue:[Mysql TrimText:realtorlastnameField.text] forKey:@"realtorlastnm"];
    //    [steve setValue:[Mysql TrimText:phonenoField1.text] forKey:@"rphonenumber"];
    [steve setValue:[Mysql TrimText:emailField1.text] forKey:@"remail"];
    
    [steve setValue:[Mysql TrimText:brokernameField.text] forKey:@"brokernm"];
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
    
    if (netStatus ==NotReachable) {
        [HUD hide];
        guestsubmit *gb =[guestsubmit alloc];
        if (![[Mysql TrimText:realtorfirstnameField.text]isEqualToString:@""]) {
            if ([[Mysql TrimText:brokernameField.text] isEqualToString:@""]) {
                gb.addmsg = [NSString stringWithFormat:@"Agent First Name: %@\nAgent Last Name: %@", [Mysql TrimText:realtorfirstnameField.text], [Mysql TrimText:realtorlastnameField.text]];
            }else{
                gb.addmsg = [NSString stringWithFormat:@"Agent First Name: %@\nAgent Last Name: %@\nRealtor Company: %@", [Mysql TrimText:realtorfirstnameField.text], [Mysql TrimText:realtorlastnameField.text], [Mysql TrimText:brokernameField.text]];
            }
        }else{
            gb.addmsg=@"No Realtor";
        }
        gb.managedObjectContext=self.managedObjectContext;
        gb.commnunitynm=self.commnunitynm;
        gb.idcia=self.idcia;
        
        
        
        
        [self.navigationController pushViewController:gb animated:NO];
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
        
        NSString *tt =[NSString stringWithFormat:@"{'IdWeb':'%@','RealtorName':'%@','AgentFName':'%@','AgentLName':'%@','IdCia':'%@','IdSub':'%@','WebNm':'%@','FirstNm':'%@','LastNm':'%@','PhoneNo':'%@','Email':'%@', 'HearAboutUs':'%@','Sendyn':'%@', 'Msg':'%@','Refdate':'%@','IdwebArea':'%@','Realtoryn':'%@','RealtorPhoneNo':'%@','RealtorEmail':'%@'}", self.idweb,[steve valueForKey:@"brokernm"],[steve valueForKey:@"realtorfirstnm"],[steve valueForKey:@"realtorlastnm"], self.idcia, self.idsub,self.commnunitynm,  [steve valueForKey:@"firstNm"], [steve valueForKey:@"lastNm"], [steve valueForKey:@"phonenumber"], [steve valueForKey:@"email"] ,[steve valueForKey:@"hearaboutus"], [steve valueForKey:@"sendyn"],  msg , [steve valueForKey:@"refdate"],self.idarea, ra, @" ", [steve valueForKey:@"remail"]  ];
        
        //        NSLog(@"%@", tt);
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
            guestsubmit *gb =[guestsubmit alloc];
            if (![[Mysql TrimText:realtorfirstnameField.text]isEqualToString:@""]) {
                if ([[Mysql TrimText:brokernameField.text] isEqualToString:@""]) {
                    gb.addmsg = [NSString stringWithFormat:@"Agent First Name: %@\nAgent Last Name: %@", [Mysql TrimText:realtorfirstnameField.text], [Mysql TrimText:realtorlastnameField.text]];
                }else{
                    gb.addmsg = [NSString stringWithFormat:@"Agent First Name: %@\nAgent Last Name: %@\nRealtor Company: %@", [Mysql TrimText:realtorfirstnameField.text], [Mysql TrimText:realtorlastnameField.text], [Mysql TrimText:brokernameField.text]];
                }
            }else{
                gb.addmsg=@"No Realtor";
            }
            gb.managedObjectContext=self.managedObjectContext;
            gb.idcia=self.idcia;
            gb.commnunitynm=self.commnunitynm;
            [self.navigationController pushViewController:gb animated:NO];
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
            
            
            guestsubmit *gb =[guestsubmit alloc];
            if (![[Mysql TrimText:realtorfirstnameField.text]isEqualToString:@""]) {
                if ([[Mysql TrimText:brokernameField.text] isEqualToString:@""]) {
                    gb.addmsg = [NSString stringWithFormat:@"Agent First Name: %@\nAgent Last Name: %@", [Mysql TrimText:realtorfirstnameField.text], [Mysql TrimText:realtorlastnameField.text]];
                }else{
                    gb.addmsg = [NSString stringWithFormat:@"Agent First Name: %@\nAgent Last Name: %@\nRealtor Company: %@", [Mysql TrimText:realtorfirstnameField.text], [Mysql TrimText:realtorlastnameField.text], [Mysql TrimText:brokernameField.text]];
                }
            }else{
                gb.addmsg=@"No Realtor";
            }
            gb.idcia=self.idcia;
            gb.commnunitynm=self.commnunitynm;
            gb.managedObjectContext=self.managedObjectContext;
            
            
            [self.navigationController pushViewController:gb animated:NO];
        }
        
    }
    
}

-(void)popupscreen5{
    [self doneClicked];
    tt9 =[[UIView alloc]initWithFrame:self.view.frame];
    tt9.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    
    
    pickerhear =[[NSMutableArray alloc]initWithObjects:@"-Please Select-", @"Our Website", @"HAR", @"Drive By", @"Other Website", @"Word of Mouth",@"Realtor", nil];
    
    UITableView *dd =[[UITableView alloc]initWithFrame:CGRectMake(200, 220, tt9.frame.size.width-400, 44*8)];
    dd.delegate=self;
    dd.dataSource=self;
    dd.layer.cornerRadius=2.0f;
    [tt9 addSubview:dd];
    [self.view addSubview:tt9];
    
}

//-(void)popupscreen5{
//    [self popupscreen:4];
//}

//-(void)popupscreen:(int)xtag{
//
//    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"\n\n\n\n\n\n\n\n\n" delegate:nil
//                                                    cancelButtonTitle:nil
//                                               destructiveButtonTitle:@"Select"
//                                                    otherButtonTitles:nil];
//
//
//
//    [actionSheet setTag:xtag];
//    actionSheet.delegate=self;
//
//    if (ddpicker ==nil) {
////         pickerhear =[[NSMutableArray alloc]initWithObjects:@"-Please Select-", @"Our Website", @"Drive by", @"HAR", @"Google", @"Yahoo", @"Friend/Relative", @"Sign", @"Realtor", @"Billboard", @"Magazine", @"Newspaper", @"Other", nil];
//        pickerhear =[[NSMutableArray alloc]initWithObjects:@"-Please Select-", @"Our Website", @"HAR", @"Drive by", @"Other Website", @"Word of Mouth", nil];
//
//        ddpicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 370, 200)];
//        ddpicker.showsSelectionIndicator = YES;
//    }
//    ddpicker.delegate = self;
//    ddpicker.dataSource = self;
//    ddpicker.tag=xtag;
//    [actionSheet addSubview:ddpicker];
//    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
//
//        [actionSheet showFromRect:hearField.frame inView:sv animated:NO];
//
//
//}


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
    [hearField setTitle:[pickerhear objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    
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
        
        [hearField setTitle:[pickerhear objectAtIndex: [ddpicker selectedRowInComponent:0]] forState:UIControlStateNormal];
        
    }
}


-(IBAction)doclear:(id)sender{
    for (UITextField *uf in sv.subviews) {
        if ([uf isKindOfClass:[UITextField class]]) {
            uf.text=@"";
        }
    }
    
    
    if (fromsearch) {
        //                NSLog(@"%@", ei);
        firstnameField.text=ei.FirstNm;
        lastnameField.text=ei.LastNm;
        phonenoField.text=ei.PhoneNo;
        emailField.text=ei.Email;
        
        if ([ei.Sendyn boolValue]) {
            ischecked=YES;
            [checkButton setImage:[UIImage imageNamed:@"chked.png"] forState:UIControlStateNormal];
        }else{
            ischecked=NO;
            [checkButton setImage:[UIImage imageNamed:@"chk.png"] forState:UIControlStateNormal];
        }
        [hearField setTitle:ei.HearAboutUs forState:UIControlStateNormal];
        
        
        
        
        //        [checkButton1 setEnabled:NO];
        //        [checkButton2 setEnabled:NO];
        
        if (ei.AgentFName) {
            
            if ([ei.RealtorEmail isEqualToString:@"will_have@realtor.com"]) {
                realtorfirstnameField.text=@"";
                realtorlastnameField.text=@"";
                //            phonenoField1.text=ei.RealtorPhoneNo;
                emailField1.text=@"";
                brokernameField.text=@"";
                
                [checkButton1 setEnabled:YES];
                [checkButton2 setEnabled:YES];
                
            }else{
                realtorfirstnameField.text=ei.AgentFName;
                realtorlastnameField.text=ei.AgentLName;
                //            phonenoField1.text=ei.RealtorPhoneNo;
                emailField1.text=ei.RealtorEmail;
                brokernameField.text=ei.RealtorName;
                [realtorlastnameField setEnabled:NO];
                [realtorfirstnameField setEnabled:NO];
                //            [phonenoField1 setEnabled:NO];
                [emailField1 setEnabled:NO];
                [brokernameField setEnabled:NO];
                [checkButton1 setEnabled:NO];
                [checkButton2 setEnabled:NO];
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
                [realtorlastnameField setEnabled:YES];
                [realtorfirstnameField setEnabled:YES];
                [emailField1 setEnabled:YES];
                [brokernameField setEnabled:YES];
                [checkButton2 setImage:[UIImage imageNamed:@"rdoed.png"] forState:UIControlStateNormal];
                [checkButton1 setImage:[UIImage imageNamed:@"rdo.png"] forState:UIControlStateNormal];
                [checkButton1 setEnabled:YES];
                [checkButton2 setEnabled:YES];
                
            }else{
                ischecked1=NO;
                [realtorlastnameField setEnabled:NO];
                [realtorfirstnameField setEnabled:NO];
                [emailField1 setEnabled:NO];
                [brokernameField setEnabled:NO];
                [checkButton1 setImage:[UIImage imageNamed:@"rdoed.png"] forState:UIControlStateNormal];
                [checkButton2 setImage:[UIImage imageNamed:@"rdo.png"] forState:UIControlStateNormal];
                [checkButton1 setEnabled:NO];
                [checkButton2 setEnabled:NO];
            }
        }
        
        
    }else{
        ischecked1=YES;
        ischecked=YES;
        [checkButton1 setImage:[UIImage imageNamed:@"rdo.png"] forState:UIControlStateNormal];
        [checkButton2 setImage:[UIImage imageNamed:@"rdoed.png"] forState:UIControlStateNormal];
        [checkButton setImage:[UIImage imageNamed:@"chked.png"] forState:UIControlStateNormal];
        [hearField setTitle:@"-Please Select-" forState:UIControlStateNormal];
        
        
        
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
        //        HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        //        HUD.mode = MBProgressHUDModeDeterminateHorizontalBar;
        //        [self.navigationController.view addSubview:HUD];
        //        HUD.labelText=@"       Updating...       ";
        //
        //        HUD.progress=0;
        //        [HUD layoutSubviews];
        //        HUD.dimBackground = YES;
        //        HUD.delegate = self;
        //        [HUD show:YES];
        
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
        [steve setValue:[Mysql TrimText:firstnameField.text] forKey:@"firstNm"];
        [steve setValue:[Mysql TrimText:lastnameField.text] forKey:@"lastNm"];
        [steve setValue:hearField.currentTitle forKey:@"hearaboutus"];
        NSString *js= [NSString stringWithFormat:@"%@-%@-%@",
                       [phonenoField.text substringWithRange:NSMakeRange(0, 3)],
                       [phonenoField.text substringWithRange:NSMakeRange(3, 3)],
                       [phonenoField.text substringWithRange:NSMakeRange(6, 4)]];
        [steve setValue:js forKey:@"phonenumber"];
        [steve setValue:[Mysql TrimText:emailField.text] forKey:@"email"];
        [steve setValue:[Mysql TrimText:realtorfirstnameField.text] forKey:@"realtorfirstnm"];
        [steve setValue:[Mysql TrimText:realtorlastnameField.text] forKey:@"realtorlastnm"];
        //        [steve setValue:[Mysql TrimText:phonenoField1.text] forKey:@"rphonenumber"];
        [steve setValue:[Mysql TrimText:emailField1.text] forKey:@"remail"];
        [steve setValue:[Mysql TrimText:brokernameField.text] forKey:@"brokernm"];
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
            if (!realtorfirstnameField.enabled) {
                msg = [NSString stringWithFormat:@"Agent First Name: %@;Agent Last Name: %@;Realtor Company: %@", [steve valueForKey:@"realtorfirstnm"],[steve valueForKey:@"realtorlastnm"],[steve valueForKey:@"brokernm"]];
            }
            
            NSString *ra;
            if ([[steve valueForKey:@"realtoryn"] integerValue]==1) {
                ra=@"True";
            }else{
                ra=@"False";
            }
            //                NSString *tt =[NSString stringWithFormat:@"{'IdWeb':'%@','RealtorName':'%@','AgentFName':'%@','AgentLName':'%@','IdCia':'%@','IdSub':'%@','WebNm':'%@','FirstNm':'%@','LastNm':'%@','PhoneNo':'%@','Email':'%@', 'HearAboutUs':'%@','Sendyn':'%@', 'Msg':'%@','Refdate':'%@','IdwebArea':'%@','Realtoryn':'%@','RealtorPhoneNo':'%@','RealtorEmail':'%@'}", self.idweb,[steve valueForKey:@"brokernm"],[steve valueForKey:@"realtorfirstnm"],[steve valueForKey:@"realtorlastnm"], self.idcia, self.idsub,self.commnunitynm,  [steve valueForKey:@"firstNm"], [steve valueForKey:@"lastNm"], [steve valueForKey:@"phonenumber"], [steve valueForKey:@"email"] ,[steve valueForKey:@"hearaboutus"], [steve valueForKey:@"sendyn"],  msg , [steve valueForKey:@"refdate"],self.idarea, ra, [steve valueForKey:@"rphonenumber"], [steve valueForKey:@"remail"]  ];
            
            NSString *tt =[NSString stringWithFormat:@"{'IdWeb':'%@','RealtorName':'%@','AgentFName':'%@','AgentLName':'%@','IdCia':'%@','IdSub':'%@','WebNm':'%@','FirstNm':'%@','LastNm':'%@','PhoneNo':'%@','Email':'%@', 'HearAboutUs':'%@','Sendyn':'%@', 'Msg':'%@','Refdate':'%@','IdwebArea':'%@','Realtoryn':'%@','RealtorPhoneNo':'%@','RealtorEmail':'%@'}", self.idweb,[steve valueForKey:@"brokernm"],[steve valueForKey:@"realtorfirstnm"],[steve valueForKey:@"realtorlastnm"], self.idcia, self.idsub,self.commnunitynm,  [steve valueForKey:@"firstNm"], [steve valueForKey:@"lastNm"], [steve valueForKey:@"phonenumber"], [steve valueForKey:@"email"] ,[steve valueForKey:@"hearaboutus"], [steve valueForKey:@"sendyn"],  msg , [steve valueForKey:@"refdate"],self.idarea, ra, @" ", [steve valueForKey:@"remail"]  ];
            
            
            //            NSLog(@"%@ %ld", tt, ei.idnumber);
            wcfService *wseee =[wcfService service];
            
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
            
            NSString *tt =[NSString stringWithFormat:@"{'IdWeb':'%@','RealtorName':'%@','AgentFName':'%@','AgentLName':'%@','IdCia':'%@','IdSub':'%@','WebNm':'%@','FirstNm':'%@','LastNm':'%@','PhoneNo':'%@','Email':'%@', 'HearAboutUs':'%@','Sendyn':'%@', 'Msg':'%@','Refdate':'%@','IdwebArea':'%@','Realtoryn':'%@','RealtorPhoneNo':'%@','RealtorEmail':'%@'}", self.idweb,[steve valueForKey:@"brokernm"],[steve valueForKey:@"realtorfirstnm"],[steve valueForKey:@"realtorlastnm"], self.idcia, self.idsub,self.commnunitynm,  [steve valueForKey:@"firstNm"], [steve valueForKey:@"lastNm"], [steve valueForKey:@"phonenumber"], [steve valueForKey:@"email"] ,[steve valueForKey:@"hearaboutus"], [steve valueForKey:@"sendyn"],  msg , [steve valueForKey:@"refdate"],self.idarea, ra, @" ", [steve valueForKey:@"remail"]  ];
            
            
            
            //                    NSLog(@"%@", tt);
            wcfService *ws =[wcfService service];
            [ws xUpdCommunity2:self action:@selector(afterxUpdCommunity2222:) xemail:[userInfo getUserName] xpassword:[userInfo getUserPwd] guestData:tt EquipmentType:@"5"];
        }else{
            [HUD hide];
            [self.navigationController popToRootViewControllerAnimated:NO];
        }
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
