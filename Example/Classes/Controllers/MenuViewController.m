//
// MenuViewController.m
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


#import "MenuViewController.h"
#import "TableCommentsViewController.h"
#import "WebCommentsViewController.h"
#import "PostCommentViewController.h"

@interface MenuViewController (PrivateMethod)
- (void)openWebView;
- (void)openTableView;
- (void)openPostComment;
@end

@implementation MenuViewController

#pragma mark - View lifecycle

- (void)dealloc {
    [threadIdentifier release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Disquser";
    [self.tabBarController.tabBar setTintColor:[UIColor blackColor]];
    [self.tableView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    
    // get comments using thread identifier (also can use thread ID or link)
    threadIdentifier = [@"54 http://toogeekforpunk.com/?p=54" retain];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"View Comments";
    } else if (section == 1) {
        return @"Post a Comment";
    }
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    } else if (section == 1) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    // Configure the cell...
    if (section == 0) {
        if (row == 0) {
            cell.textLabel.text = @"Web View (custom css)";
        } else if (row == 1) {
            cell.textLabel.text = @"Table View";
        }
    } if (section == 1) {
        cell.textLabel.text = @"Post a comment";
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 1) {
        return 100.0;
    }
    return 0.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 1) {
        UIImageView *imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 100.0)] autorelease];
        [imageView setImage:[UIImage imageNamed:@"disqus-logo.png"]];
        [imageView setContentMode:UIViewContentModeCenter];
        
        return imageView;
    }
    
    return nil;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if (section == 0) {
        if (row == 0) {
            [self openWebView];
        } else if (row == 1) {
            [self openTableView];
        }
    } if (section == 1) {
        [self openPostComment];
    }
}

#pragma mark - Class Methods

- (void)openWebView {
    WebCommentsViewController *webCommentsViewController = [[[WebCommentsViewController alloc] init] autorelease];
    webCommentsViewController.title = @"Web View";
    webCommentsViewController.threadIdentifier = threadIdentifier;
    [self.navigationController pushViewController:webCommentsViewController animated:YES];
}

- (void)openTableView {
    TableCommentsViewController *tableCommentsViewController = [[[TableCommentsViewController alloc] init] autorelease];
    tableCommentsViewController.title = @"Table View";
    tableCommentsViewController.threadIdentifier = threadIdentifier;
    [self.navigationController pushViewController:tableCommentsViewController animated:YES];    
}

- (void)openPostComment {
    PostCommentViewController *postCommentViewController = [[[PostCommentViewController alloc] init] autorelease];
    postCommentViewController.title = @"Post a Comment";
    postCommentViewController.threadIdentifier = threadIdentifier;
    UINavigationController *navigationController = [[[UINavigationController alloc] initWithRootViewController:postCommentViewController] autorelease];
    
    [self presentModalViewController:navigationController animated:YES];
}


@end
