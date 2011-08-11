    //
//  addDataViewController.m
//  delicious memory
//
//  Created by Chia Lin on 2011/7/12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "addDataViewController.h"
#import "delicious_memoryAppDelegate.h"


@implementation addDataViewController
@synthesize imagePickerController,cameraBtn;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)init{

	[super init];
	self.imagePickerController = [[[UIImagePickerController alloc] init] autorelease];
	self.imagePickerController.delegate = self;
	
	UIImage *buttonImage = [UIImage imageNamed:@"capture-button.png"];
	
	UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
	button.frame = CGRectMake(130.0, 5.0, buttonImage.size.width, buttonImage.size.height);
	[button setBackgroundImage:buttonImage forState:UIControlStateNormal];
	
	[button addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
	self.cameraBtn = button;
	
	[button release];
	return self;
}
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

#pragma mark -
#pragma mark ViewController

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
/*
- (void)viewDidLoad {
	
	[super viewDidLoad];
	//NSLog(@"in viewDidLoad");


}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[imagePickerController release];
    [self.cameraBtn release];
    [super dealloc];
}

#pragma mark -
#pragma mark TakePicture

-(void)customizeCamera{
    
    //UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 400, 100, 100) ];
    //btn.backgroundColor=[UIColor whiteColor];
       //self.imagePickerController.showsCameraControls = NO;
    UIImage *buttonImage = [UIImage imageNamed:@"capture-button.png"];
	
	UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
	button.frame = CGRectMake(230, 420, 50, 50);
	[button addTarget:self action:@selector(pickFromAlbum:) forControlEvents:UIControlEventTouchUpInside];
     [self.imagePickerController.view addSubview:button];

    //NSArray *items = [NSArray arrayWithObjects: systemItem, nil];
    //[self.imagePickerController.toolbar setItems:items];
    
}
-(void)pickFromAlbum:(id)sender{
    UIImagePickerController *picker=[[UIImagePickerController alloc]init ];
    picker.delegate=self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [imagePickerController presentModalViewController:picker animated:YES];
    [UIApplication sharedApplication].statusBarHidden=NO;

    [picker release];
}
-(void)cameraAction{
    //[(delicious_memoryAppDelegate *)[[UIApplication sharedApplication] delegate] tabBarController].UIModalTransitionStyle = UIModalTransitionStyleFlipHorizontal ;
    
	if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
		self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        
		//customize camera control
        [self customizeCamera];

        [[(delicious_memoryAppDelegate *)[[UIApplication sharedApplication] delegate] tabBarController] presentModalViewController:self.imagePickerController animated:YES];
	}else{
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        
        [[(delicious_memoryAppDelegate *)[[UIApplication sharedApplication] delegate] tabBarController] presentModalViewController:self.imagePickerController animated:YES];
         }
}



#pragma mark -
#pragma mark UIImagePickerControllerDelegate

// this get called when an image has been chosen from the library or taken from the camera
//
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"prepare");
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    if(picker.sourceType == UIImagePickerControllerSourceTypeCamera){
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    }
    UIViewController *test = [[UIViewController alloc]initWithNibName:@"inputNewInfoView" bundle:nil];
   
    [picker pushViewController:test animated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[picker dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)modalView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
	{
		case 0://add to ordered
		{
            NSLog(@"ordered");
            [self cameraAction];
            break;
		}
		case 1://add to unordered
		{
            NSLog(@"unordered");
            [self cameraAction];
            break;
		}//index 2 is cancel button

	}
}
#pragma mark -
#pragma mark API

- (void)addAction:(id)sender
{
	UIActionSheet *styleAlert = [[UIActionSheet alloc] initWithTitle:@"New Order"
                                                            delegate:self cancelButtonTitle:@"Cancel"
                                              destructiveButtonTitle:nil
                                                   otherButtonTitles:	@"加到吃過的",
                                                                        @"加到想去吃的",
                                                                        nil,
                                                                        nil];
	
	// use the same style as the nav bar
	//styleAlert.actionSheetStyle = self.navigationController.navigationBar.barStyle;
	
	[styleAlert showInView:[(delicious_memoryAppDelegate *)[[UIApplication sharedApplication] delegate] tabBarController].view];
	[styleAlert release];
}
@end
