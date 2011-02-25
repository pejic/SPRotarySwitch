
@class DemoViewController;

@interface DemoAppDelegate : NSObject <UIApplicationDelegate>
{
	UIWindow* window;
	UIViewController* viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow* window;
@property (nonatomic, retain) IBOutlet UIViewController* viewController;

@end
