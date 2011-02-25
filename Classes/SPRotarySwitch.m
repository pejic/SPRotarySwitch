
#import "SPRotarySwitch.h"
#include <math.h>

@interface SPRotarySwitch (Private)
-(void) initCommon;
-(void) updateMinMax;
-(int) nearestIndex;
-(void) knobChanged;
-(void) triggerSignals;
@end

@implementation SPRotarySwitch (Private)
-(void) initCommon
{
	CGSize size = self.frame.size;
	CGRect knobFrame = CGRectMake(0, 0, size.width, size.height);
	knob = [[MHRotaryKnob alloc] initWithFrame: knobFrame];
	[self addSubview: knob];
	knob.continuous = NO;
	[knob addTarget: self
		 action: @selector(knobChanged)
       forControlEvents: UIControlEventValueChanged];
	validAngles = NULL;
	[self updateMinMax];
}
-(void) updateMinMax
{
	float min = INFINITY;
	float max = -INFINITY;
	if (!validAngles || [validAngles count] == 0) {
		min = -10;
		max = 10;
		// Note: min must not equal max
	}
	else {
		for (NSNumber* angObj in validAngles) {
			float ang = [angObj floatValue];
			if (ang < min) {
				min = ang;
			}
			if (ang > max) {
				max = ang;
			}
		}
	}

	knob.minimumAngle = min;
	knob.maximumAngle = max;
	knob.minimumValue = min;
	knob.maximumValue = max;
}
-(int) nearestIndex
{
	int ni = -1;
	float angle = knob.value; // Note: value is angle by design
				  // (see updateMinMax)
	float diffMin = INFINITY;
	int i = 0;
	for (NSNumber* angObj in validAngles) {
		float ang = [angObj floatValue];
		float diff = abs(ang - angle);
		if (diffMin > diff) {
			ni = i;
			diffMin = diff;
		}
		i++;
	}
	return (ni);
}
-(void) knobChanged
{
	[self setSelectedIndex: [self selectedIndex]
		      animated: YES];
	[self triggerSignals];
}
-(void) triggerSignals
{
	[self sendActionsForControlEvents: UIControlEventValueChanged];
}
@end

@implementation SPRotarySwitch


-(id) initWithFrame: (CGRect) frame
{
	self = [super initWithFrame: frame];
	if (self)
	{
		[self initCommon];
	}
	return (self);
}

-(id) initWithCoder: (NSCoder*) aDecoder
{
	self = [super initWithCoder: aDecoder];
	if (self)
	{
		[self initCommon];
	}
	return (self);
}

-(void) dealloc
{
	[knob release];
	[validAngles release];
	[super dealloc];
}

-(NSArray*) validAngles
{
	return (validAngles);
}

-(void) setValidAngles: (NSArray*) va
{
	[va retain];
	[validAngles release];
	validAngles = va;
	[self updateMinMax];
	[self setSelectedIndex: 0];
}

-(int) selectedIndex
{
	return ([self nearestIndex]);
}

-(void) setSelectedIndex: (int) ind
{
	[self setSelectedIndex: ind
		      animated: NO];
}

/*!
 * Allows animating of setting the selectedIndex.
 */
-(void) setSelectedIndex: (int) ind
		animated: (BOOL) animated
{
	int i = [self selectedIndex];
	NSArray* va = self.validAngles;
	if (ind >= [va count] || ind < 0) {
		return;
	}
	NSNumber* angObj = [va objectAtIndex: ind];
	[knob setValue: [angObj floatValue]
	      animated: animated];
	if (i != ind) {
		[self triggerSignals];
	}
}

/* ==== Delegated methods follow ==== */

-(void) setEnabled: (BOOL) en
{
	[super setEnabled: en];
	[knob setEnabled: en];
}

-(UIImage*) backgroundImage
{
	return ([knob backgroundImage]);
}

-(void) setBackgroundImage: (UIImage*) bi
{
	[knob setBackgroundImage: bi];
}

-(UIImage*) currentKnobImage
{
	return ([knob currentKnobImage]);
}

-(CGPoint) knobImageCenter
{
	return ([knob knobImageCenter]);
}

-(void) setKnobImageCenter: (CGPoint) cgp
{
	[knob setKnobImageCenter: cgp];
}

-(void) setKnobImage: (UIImage*) image
	    forState: (UIControlState) state
{
	[knob setKnobImage: image
		  forState: state];
}

/*!
 * Returns the thumb image associated with the specified control state.
 */
-(UIImage*) knobImageForState: (UIControlState) state
{
	return ([knob knobImageForState: state]);
}


@end
