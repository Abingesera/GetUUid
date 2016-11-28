//
//  ViewController.m
//  GetUUid
//
//  Created by 掌金 on 16/4/21.
//  Copyright © 2016年 zhangjin. All rights reserved.
//

#import "ViewController.h"
#import "MyUUIDManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *uuid = [MyUUIDManager getUUID];
    NSLog(@"uuid: %@",uuid);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
