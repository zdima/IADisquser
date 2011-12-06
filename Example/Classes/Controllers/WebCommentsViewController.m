//
// WebCommentsViewController.m
// Disquser
// 
// Copyright (c) 2011 Ikhsan Assaat. All Rights Reserved 
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//


#import "WebCommentsViewController.h"
#import "IADisquser.h"

@interface WebCommentsViewController (PrivateMethods)
- (void)hideGradientView;
- (void)getComments;
@end

@implementation WebCommentsViewController

@synthesize threadIdentifier;

- (void)dealloc {
    [webView release];
    [indicator release];
    [threadIdentifier release];
    [super dealloc];
}

- (void)hideGradientBackground:(UIView*)theView {
    for (UIView* subview in theView.subviews) {
        if ([subview isKindOfClass:[UIImageView class]])
            subview.hidden = YES;
        
        [self hideGradientBackground:subview];
    }
}

- (UIWebView *)webView {
    if (!webView) {
        webView = [[UIWebView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 416.0)];
        [webView setDataDetectorTypes:UIDataDetectorTypeNone];
        [webView setBackgroundColor:[UIColor clearColor]];
        [webView setDelegate:self];
        [self hideGradientBackground:webView];
        [webView setOpaque:NO];
        [self.view addSubview:webView];
    }
    
    return webView;
}

- (UIActivityIndicatorView *)indicator {
    if (!indicator) {
        indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [indicator setCenter:[self webView].center];
        [indicator setHidesWhenStopped:YES];
        [self.view addSubview:indicator];
    }
    
    return indicator;
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // set view's interface
    [self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    UIBarButtonItem *refresh = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(getComments)] autorelease];
    [self.navigationItem setRightBarButtonItem:refresh];
    [self webView];
    [self indicator];
    
    // fire the method for fetching comments
    [self getComments];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
    [webView release];
    webView = nil;
    [indicator release];
    indicator = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Web View Delegate Methods

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    // stop the activity indicator
    [[self indicator] stopAnimating];
    [[self webView] setAlpha:1.0];
}

#pragma mark - Request Disqus Comments

- (void)getComments {
    // start activity indicator
    [[self indicator] startAnimating];
    [[self webView] setAlpha:0.5];
    
    // make the html for the disqus' comments
    NSString *htmlFilePath = [[NSBundle mainBundle] pathForResource:@"disqus" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:htmlFilePath encoding:NSUTF8StringEncoding error:nil];
    __block NSString *contentHtml = @"";
    
    [IADisquser getCommentsFromThreadIdentifier:threadIdentifier 
                              success:^(NSArray *comments) {
                                  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                                  [dateFormatter setDateFormat:@"dd/MM/yy HH:mm:ss"];
                                  
                                  // reverse array, display mode : oldest comment on top
                                  NSArray *reverseComments = [[comments reverseObjectEnumerator] allObjects];
                                  
                                  for (IADisqusComment *aComment in reverseComments) {
                                      contentHtml = [contentHtml stringByAppendingFormat:
                                                     @"<div class='comment'>\n"
                                                     "\t<div class='avatar'><img src='%@'></div>\n"
                                                     "\t<div class='name'><b>%@</b></div>\n"
                                                     "\t<div class='date'>%@</div>\n"
                                                     "\t<div class='message'>%@</div>\n"
                                                     "</div><br \\>\n\n",
                                                     aComment.authorAvatar, aComment.authorName, [dateFormatter stringFromDate:aComment.date], aComment.htmlMessage];
                                  }
                                  
                                  [[self webView] loadHTMLString:[htmlString stringByReplacingOccurrencesOfString:@"<!--content-->" withString:contentHtml] baseURL:nil];
                                  [dateFormatter release];
                              } fail:^(NSError *error) {
                                  NSLog(@"error : %@", error);
                                  contentHtml = @"<b>Failed on fetching comments...</b>";
                                  [[self webView] loadHTMLString:[htmlString stringByReplacingOccurrencesOfString:@"<!--content-->" withString:contentHtml] baseURL:nil];  
                              }];
}

@end
