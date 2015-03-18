//
//  InterfaceController.m
//  appleWatchSample WatchKit Extension
//
//  Created by satoutakeshi on 2015/03/18.
//  Copyright (c) 2015年 satoutakeshi. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()
- (IBAction)sendToiPhone;
@property NSInteger count;
@property (weak, nonatomic) IBOutlet WKInterfaceImage *watchImage;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
    
    self.count = 0;
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (IBAction)sendToiPhone {
    self.count ++;
    [WKInterfaceController openParentApplication:@{
                                                   //watchからiPhoneへ送るデータ
                                                  @"watchValue":[[NSNumber alloc] initWithInteger:self.count]
                                                  }
                                           reply:^(NSDictionary *replyInfo, NSError *error){
                                               
                                                      //iPhoneからwatchへ送られたデータ
                                                      NSData *nekoData = replyInfo[@"nekoImage"];
                                               
                                                      //iPhoneからNSDataで送れば画像が出る。
                                                      [self.watchImage setImageData:nekoData];
                                               

                                                  }];
}
@end



