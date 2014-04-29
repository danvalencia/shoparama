//
//  DetailViewController.h
//  Shoparama
//
//  Created by Daniel Valencia on 3/31/14.
//  Copyright (c) 2014 Daniel Valencia Co. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
