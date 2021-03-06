//
//  ViewController.m
//  DistanceCalc
//
//  Created by Andres on 1/2/16.
//  Copyright (c) 2016 Andres. All rights reserved.
//

#import "ViewController.h"
#import "DistanceGetter/DGDistanceRequest.h"

@interface ViewController ()
@property (nonatomic) DGDistanceRequest *req;

@property (weak, nonatomic) IBOutlet UITextField *location0;
@property (weak, nonatomic) IBOutlet UITextField *location1;
@property (weak, nonatomic) IBOutlet UILabel *distance1;
@property (weak, nonatomic) IBOutlet UITextField *location2;
@property (weak, nonatomic) IBOutlet UILabel *distance2;
@property (weak, nonatomic) IBOutlet UITextField *location3;
@property (weak, nonatomic) IBOutlet UILabel *distance3;
@property (weak, nonatomic) IBOutlet UITextField *location4;
@property (weak, nonatomic) IBOutlet UILabel *distance4;
@property (weak, nonatomic) IBOutlet UIButton *calculateBtn;

@end

@implementation ViewController

- (IBAction)calculateTapped:(id)sender {
    self.calculateBtn.enabled = NO;
    
    self.req = [DGDistanceRequest alloc];
    NSString *initialLocation = self.location0.text;
    NSArray *destination = @[self.location1.text, self.location2.text, self.location3.text, self.location4.text];
    self.req = [self.req initWithLocationDescriptions:destination sourceDescription:initialLocation];
    
    __weak ViewController *weakSelf = self;
    
    self.req.callback = ^void(NSArray *responses){
        ViewController *strongSelf = weakSelf;
        if(!strongSelf) return;
        UILabel *distances[] = {strongSelf.distance1, strongSelf.distance2, strongSelf.distance3, strongSelf.distance4};
        NSNull *nullValue = [NSNull null];
        
        for (int i = 0; i < responses.count; i++){
            if(responses[i]!=nullValue){
                distances[i].text=[NSString stringWithFormat:@"%.2f km", [responses[i] floatValue]/1000.0];
            }
            else{
                distances[i].text = @"";
            }
            strongSelf.calculateBtn.enabled = YES;
            strongSelf.req = nil;
        }
    };
    
    [self.req start];
}


@end
