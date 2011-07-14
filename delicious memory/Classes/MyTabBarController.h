//
//  MyTabBarController.h
//  delicious memory
//
//  Created by Chia Lin on 2011/7/13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MyTabBarController : UITabBarController {

}
// Create a custom UIButton and add it to the center of our tab bar
-(void) addCenterButtonWithImage:(UIImage*)buttonImage highlightImage:(UIImage*)highlightImage;

@end
