//
//  FirstViewController.h
//  delicious memory
//
//  Created by Chia Lin on 2011/7/2.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FirstViewController : UIViewController <UINavigationBarDelegate, UITableViewDelegate,
                                                   UITableViewDataSource, UIActionSheetDelegate>
{
	UITableView	*myTableView;
	NSMutableArray *menuList;

}
@property (nonatomic, retain) IBOutlet UITableView *myTableView;
@property (nonatomic, retain) NSMutableArray *menuList;

@end
