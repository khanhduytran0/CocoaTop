#import "THtmlViewController.h"
#import "BackButtonHandler.h"
#import <WebKit/WebKit.h>

@implementation HtmlViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.navigationItem.title = self.pageTitle;
	self.indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	self.indicator.color = [UIColor blackColor];
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.indicator];

	WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectZero];
	webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//	webView.dataDetectorTypes = UIDataDetectorTypeNone;
//	webView.scalesPageToFit = YES;
//	webView.delegate = self;

	[webView loadRequest:[[NSURLRequest alloc] initWithURL:self.url]];
	self.view = webView;
}

- (BOOL)navigationShouldPopOnBackButton
{
    WKWebView *webView = (WKWebView *)self.view;
	if (webView.canGoBack) {
		[webView goBack];
		return NO;
	}
	return YES;
}

- (void)webViewDidStartLoad:(WKWebView *)webView
{
	[self.indicator startAnimating];
}

- (void)webViewDidFinishLoad:(WKWebView *)webView
{
	[self.indicator stopAnimating];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
}

- (id)initWithURL:(NSString *)url title:(NSString *)title;
{
	self = [super init];
	if (self != nil) {
		self.url = [[NSBundle mainBundle] URLForResource:url withExtension:@"html"];
		self.pageTitle = title;
	}
	return self;
}

@end
