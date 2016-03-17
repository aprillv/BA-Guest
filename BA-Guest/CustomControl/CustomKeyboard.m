//
//  CustomKeyboard.m
//
//  Created by Kalyan Vishnubhatla on 10/9/12.
//
//

#import "CustomKeyboard.h"

@implementation CustomKeyboard
@synthesize delegate;

- (id)init {
    self = [super init];
    if (self){
        
    }
    return self;
}

- (UIToolbar *)getToolbarWithPrevNextDone:(BOOL)prevEnabled :(BOOL)nextEnabled
{    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setBarStyle:UIBarStyleDefault];
    [toolbar sizeToFit];
    
    NSMutableArray *itemsArray = [[NSMutableArray alloc] init];
   [[UISegmentedControl appearance] setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName: @"Futura" size:15.0], NSForegroundColorAttributeName: [UIColor darkGrayColor]} forState:UIControlStateNormal];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName: @"Futura" size:15.0], NSForegroundColorAttributeName: [UIColor darkGrayColor]} forState:UIControlStateNormal];
    
    UISegmentedControl *tabNavigation = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Previous", @"Next", nil]];
//    tabNavigation.segmentedControlStyle = UISegmentedControlStylePlain;
//    tabNavigation.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
    tabNavigation.layer.cornerRadius = 5.0f;
    
    [tabNavigation setEnabled:prevEnabled forSegmentAtIndex:0];
    [tabNavigation setEnabled:nextEnabled forSegmentAtIndex:1];
    tabNavigation.momentary = YES;
    [tabNavigation addTarget:self action:@selector(segmentedControlHandler:) forControlEvents:UIControlEventValueChanged];
    
//    UIBarButtonItem *doneButton2 =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(userClickedDone:)];
//    [itemsArray addObject:doneButton2];
    
    UIBarButtonItem *barSegment = [[UIBarButtonItem alloc] initWithCustomView:tabNavigation];
    
    [itemsArray addObject:barSegment];

    UIBarButtonItem *flexButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [itemsArray addObject:flexButton];
    
    UIBarButtonItem *doneButton =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(userClickedDone:)];
    [itemsArray addObject:doneButton];

    toolbar.items = itemsArray;
        
    return toolbar;
}

//- (UIToolbar *)getToolbarWithDone
//{
//    UIToolbar *toolbar = [[UIToolbar alloc] init];
//    [toolbar setBarStyle:UIBarStyleBlackTranslucent];
//    [toolbar sizeToFit];
//    
//    NSMutableArray *itemsArray = [[NSMutableArray alloc] init];
//    
//    UIBarButtonItem *flexButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
//    [itemsArray addObject:flexButton];
//    
//    UIBarButtonItem *doneButton =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(userClickedDone:)];
//    [itemsArray addObject:doneButton];
//    
//    toolbar.items = itemsArray;
//    
//    return toolbar;
//}


- (UIToolbar *)getToolbarWithDone
{
    
    
    return [self getToolbarWithPrevNextDone:NO :NO];
}


/* Previous / Next segmented control changed value */
- (void)segmentedControlHandler:(id)sender
{
    if (delegate){
        switch ([(UISegmentedControl *)sender selectedSegmentIndex]) {
            case 0:
                [delegate previousClicked];
                break;
            case 1:
                [delegate nextClicked];
                break;
            default:
                break;
        }
    }
}

- (void)userClickedDone:(id)sender {
    if (delegate){
        [delegate doneClicked];
    }
}

@end
