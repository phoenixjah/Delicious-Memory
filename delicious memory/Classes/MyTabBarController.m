//
//  MyTabBarController.m
//  delicious memory
//
//  Created by Chia Lin on 2011/7/13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyTabBarController.h"


@implementation MyTabBarController


// Create a custom UIButton and add it to the center of our tab bar
-(void) addCenterButtonWithImage:(UIImage*)buttonImage highlightImage:(UIImage*)highlightImage
{
	UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
	button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
	[button setBackgroundImage:buttonImage forState:UIControlStateNormal];
	[button setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
	
	CGFloat heightDifference = buttonImage.size.height - self.tabBar.frame.size.height;
	if (heightDifference < 0){
		//button.center = self.tabBar.center;
		NSLog(@"button %f, tabBar %f",button.center.x,self.tabBar.center.x);
	}else{
		CGPoint center = self.tabBar.center;
		center.y = center.y - heightDifference/2.0;
		button.center = center;
	}
	
	[self.view addSubview:button];
}


- (void)dealloc {
    [super dealloc];
}


@end
