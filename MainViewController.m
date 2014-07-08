//
//  MainViewController.m
//  fb-paper
//
//  Created by Shiva Jaini on 7/3/14.
//  Copyright (c) 2014 Shiva Jaini. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)panHeadlineGesture:(UIPanGestureRecognizer *)sender;
@property (weak, nonatomic) IBOutlet UIView *headlineView;
@property (weak, nonatomic) IBOutlet UIImageView *menuImageView;
- (IBAction)onTapHeadline:(UITapGestureRecognizer *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *headlineImageView;
@property (nonatomic, assign) float headlineOffsetY;
@property (nonatomic, assign) float headlineOriginalY;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
//    [self performSelector:@selector(cycleofimages) withObject:nil afterDelay:2];
    self.scrollView.contentSize = CGSizeMake(1445, 254);
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
-(void)cycleofimages{
    UIImage *image1 = [UIImage imageNamed:@"headlines-image"];
    UIImage *image2 = [UIImage imageNamed:@"headlines-image2"];
    UIImage *image3 = [UIImage imageNamed:@"headlines-image3"];
    [UIView animateWithDuration:1 delay:2 options:UIViewAnimationOptionAutoreverse |UIViewAnimationOptionRepeat animations:^{
        [self.headlineImageView setImage:image2];
    } completion:nil];
    
}
*/
- (IBAction)panHeadlineGesture:(UIPanGestureRecognizer *)panGestureRecognizer {
    CGPoint location = [panGestureRecognizer locationInView:self.view];
  //  CGPoint velocity = [panGestureRecognizer velocityInView:self.view];
    
    
    
    if(panGestureRecognizer.state == UIGestureRecognizerStateBegan){
        NSLog(@"Pan began");
        CGPoint startingPoint = [panGestureRecognizer locationInView:self.view];
        self.headlineOffsetY = startingPoint.y;
        self.headlineOriginalY = self.headlineView.frame.origin.y;
    }
    else if(panGestureRecognizer.state == UIGestureRecognizerStateChanged){
 
        if (self.headlineOriginalY == 0 && self.headlineView.frame.origin.y - self.headlineOriginalY < 0) {
            
            self.headlineView.frame = CGRectMake(self.headlineView.frame.origin.x,(location.y - self.headlineOffsetY) * .15, self.headlineView.frame.size.width, self.headlineView.frame.size.height);
            
        } else {
            
            self.headlineView.frame = CGRectMake(self.headlineView.frame.origin.x,self.headlineOriginalY + location.y - self.headlineOffsetY, self.headlineView.frame.size.width, self.headlineView.frame.size.height);
            
        }
   
        
        if(location.y<50){
            [UIView animateWithDuration:0.5 animations:^{
                self.menuImageView.alpha = 0.4;
            } completion:nil];
            
        }else{
            [UIView animateWithDuration:0.5 animations:^{
                self.menuImageView.alpha = 1;
            } completion:nil];
        
        }
    }else if (panGestureRecognizer.state == UIGestureRecognizerStateEnded){
        CGPoint velocity = [panGestureRecognizer velocityInView:self.view];

        NSLog(@"Pan ended");
        if(velocity.y<0 || (self.headlineView.frame.origin.y - self.headlineOriginalY < 0)){
            [UIView animateWithDuration:0.5 animations:^{
                self.headlineView.center = CGPointMake(self.headlineView.center.x, self.view.center.y);
                self.menuImageView.alpha = 0.4;
            } completion:nil];
        }else{
            [UIView animateWithDuration:0.5 animations:^{
                self.headlineView.center = CGPointMake(self.headlineView.center.x, self.view.center.y+525);
                self.menuImageView.alpha = 1;
            } completion:nil];
            
        }
    }
    
}
- (IBAction)onTapHeadline:(UITapGestureRecognizer *)tapGestureRecognizer {
    CGPoint point = [tapGestureRecognizer locationInView:self.view];
    if(point.y>528){
        [UIView animateWithDuration:0.5 animations:^{
            self.headlineView.center = CGPointMake(self.headlineView.center.x, self.view.center.y);
            self.menuImageView.alpha = 0.4;
        } completion:nil];
    }
    
}
@end
