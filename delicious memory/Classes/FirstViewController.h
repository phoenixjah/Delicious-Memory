//
//  FirstViewController.h
//  delicious memory
//
//  Created by Chia Lin on 2011/7/2.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyMenuTableViewController;

@interface FirstViewController : UIViewController <UINavigationBarDelegate, UIActionSheetDelegate>
{
    MyMenuTableViewController *orderedMenu;
    MyMenuTableViewController *unorderedMenu;
}
@property (nonatomic,retain) MyMenuTableViewController *orderedMenu;
@property (nonatomic,retain) MyMenuTableViewController *unorderedMenu;

@end
