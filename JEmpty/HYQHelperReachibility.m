//
//  HYQHelperReachibility.m
//  HYQark
//
//  Created by __无邪_ on 15/5/5.
//  Copyright (c) 2015年 __无邪_. All rights reserved.
//

#import "HYQHelperReachibility.h"

#define REMOTEHOSTNAME @"www.baidu.com"
#define REMOTEHOSTFULLYNAME @"http://www.baidu.com"
@interface HYQHelperReachibility ()

@end

@implementation HYQHelperReachibility


+ (HYQHelperReachibility *)sharedInstance{
    static HYQHelperReachibility *reachability = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        reachability = [[HYQHelperReachibility alloc] init];
        reachability.isReachable = YES;
    });
    return reachability;
}


- (void)startMonitoringInternetStates{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        BOOL isCan = NO;
        BOOL isCanWifi = NO;
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                isCan = YES;
                isCanWifi = NO;
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                isCan = YES;
                isCanWifi = YES;
            }
                break;
            default:
                break;
        }
        
        self.isReachable = isCan;
        self.isReachableWifi = isCanWifi;
        if (isCan) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loadDataNow" object:nil];
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"HYQNET" object:@(status)];
        
        NSLog(@"【Reachability: %@】", AFStringFromNetworkReachabilityStatus(status));
    }];

}

@end
