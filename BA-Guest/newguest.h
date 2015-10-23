//
//  newguest.h
//  BA-Guest
//
//  Created by roberto ramirez on 2/5/14.
//  Copyright (c) 2014 lovetthomes. All rights reserved.
//

#import "fViewController.h"

@class wcfGuestEntryItem1;

@interface newguest : fViewController

@property(nonatomic, retain) NSString *idcia;
@property(nonatomic, retain) NSString *cianm;
@property(nonatomic, retain) NSString *commnunitynm;
@property(nonatomic, retain) NSString *idweb;
@property(nonatomic, retain) NSString *idarea;
@property(nonatomic, retain) NSString *idsub;
@property bool fromsearch;
@property(nonatomic, retain) wcfGuestEntryItem1 *ei;
@end
