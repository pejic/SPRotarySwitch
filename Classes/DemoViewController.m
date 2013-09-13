
#import "DemoViewController.h"
#import "SPRotarySwitch.h"

@implementation DemoViewController

@synthesize segmented, label, rotaryKnob;

- (void)viewDidLoad
{
	[super viewDidLoad];

	rotaryKnob.defaultSelectedIndex = 1;
	rotaryKnob.validAngles = [NSArray arrayWithObjects:
				  [NSNumber numberWithFloat: -90.0],
				  [NSNumber numberWithFloat:   0.0],
				  [NSNumber numberWithFloat:  90.0],
				  NULL];
	rotaryKnob.backgroundColor = [UIColor clearColor];
	rotaryKnob.backgroundImage = [UIImage imageNamed:@"Knob Background.png"];
	[rotaryKnob setKnobImage: [UIImage imageNamed:@"Knob.png"]
			forState: UIControlStateNormal];
	[rotaryKnob setKnobImage: [UIImage imageNamed:@"Knob Highlighted.png"]
			forState: UIControlStateHighlighted];
	[rotaryKnob setKnobImage: [UIImage imageNamed:@"Knob Disabled.png"]
			forState: UIControlStateDisabled];
	rotaryKnob.knobImageCenter = CGPointMake(80.0f, 76.0f);
	[rotaryKnob addTarget: self
		       action: @selector(rotaryKnobDidChange)
	     forControlEvents: UIControlEventValueChanged];
}

- (void)viewDidUnload
{
	[super viewDidUnload];
}

- (IBAction)sliderDidChange
{
	int i = segmented.selectedSegmentIndex;
	rotaryKnob.selectedIndex = i;
	label.text = [NSString stringWithFormat:@"%d", i];
}

- (IBAction)rotaryKnobDidChange
{
	int i = rotaryKnob.selectedIndex;
	segmented.selectedSegmentIndex = i;
	label.text = [NSString stringWithFormat:@"%d", i];
}

- (IBAction)toggleEnabled
{
	rotaryKnob.enabled = !rotaryKnob.enabled;
}

- (IBAction)toggleDoubleTap
{
	rotaryKnob.resetsToDefault = !rotaryKnob.resetsToDefault;
}

- (IBAction)goToMinimum
{
	[rotaryKnob setSelectedIndex: 0
			    animated: YES];
}

- (IBAction)goToMaximum
{
	[rotaryKnob setSelectedIndex: 2
			    animated: YES];
}

@end
