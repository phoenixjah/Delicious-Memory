//
//  delicious_memoryAppDelegate.h
//  delicious memory
//
//  Created by Chia Lin on 2011/7/2.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyTabBarController;

@interface delicious_memoryAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    MyTabBarController *tabBarController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MyTabBarController *tabBarController;

@end
