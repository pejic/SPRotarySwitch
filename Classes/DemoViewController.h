
@class SPRotarySwitch;

@interface DemoViewController : UIViewController
{
}

@property (nonatomic, retain) IBOutlet UISegmentedControl* segmented;
@property (nonatomic, retain) IBOutlet UILabel* label;
@property (nonatomic, retain) IBOutlet SPRotarySwitch* rotaryKnob;

- (IBAction)sliderDidChange;
- (IBAction)rotaryKnobDidChange;
- (IBAction)toggleEnabled;
- (IBAction)toggleDoubleTap;
- (IBAction)goToMinimum;
- (IBAction)goToMaximum;

@end
