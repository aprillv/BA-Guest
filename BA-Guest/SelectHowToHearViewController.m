//
//  SelectHowToHearViewController.m
//  BA-Guest
//
//  Created by April on 3/10/16.
//  Copyright © 2016 lovetthomes. All rights reserved.
//

#import "SelectHowToHearViewController.h"

@interface SelectHowToHearViewController ()<UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation SelectHowToHearViewController{
    NSArray *rtnlist;
}



//func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
//    let point = touch.locationInView(view)
//    return !CGRectContainsPoint(tableview.frame, point)
//}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.view.superview.backgroundColor = [[UIColor alloc]initWithRed:0 green:0 blue:0 alpha:0.2];
}
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    CGPoint point = [touch locationInView: self.view];
    return  !CGRectContainsPoint(self.tableview.frame, point);
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    rtnlist = @[@"-Please Select-"
                , @"Our Website"
                , @"Social Media"
                , @"HAR"
                , @"Drive By"
                , @"Other Website"
                , @"Word of Mouth"
                , @"Realtor"
                ];
}
#pragma mark - TableView Methods
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *lbl = [[UILabel alloc]init];
    lbl.text = @"HOW DID YOU HEAR ABOUT US";
    lbl.textAlignment = NSTextAlignmentCenter;
    [lbl sizeToFit];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableview.frame.size.width, 44.0)];
    CGRect ct = lbl.frame;
    ct.origin = CGPointMake((self.tableview.frame.size.width - ct.size.width)/2, (44-ct.size.height)/2.0);
    lbl.frame = ct;
    [view addSubview:lbl];
    view.backgroundColor = [[UIColor alloc] initWithRed: 220/255.0 green: 220/255.0 blue: 220/255.0 alpha: 1.0f];
    return view;
}


-(IBAction)dismissSelf:(UITapGestureRecognizer *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [rtnlist count]; // or self.items.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    cell.textLabel.text = rtnlist[indexPath.row];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        [self dismissViewControllerAnimated:YES completion:^{
        if (self.delegate) {
            [self.delegate selectedItem:rtnlist[indexPath.row]];
        }
    }];
}
- (CGSize)preferredContentSize {
    return self.tableview.contentSize;
}


@end
