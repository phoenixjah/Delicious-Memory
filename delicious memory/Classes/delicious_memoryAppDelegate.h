//
//  delicious_memoryAppDelegate.h
//  delicious memory
//
//  Created by Chia Lin on 2011/7/2.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class addDataViewController;

@interface delicious_memoryAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate,
													UIImagePickerControllerDelegate,UINavigationBarDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
	
	addDataViewController *addDataController;
	
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@property (nonatomic, retain) addDataViewController *addDataController;
@end
