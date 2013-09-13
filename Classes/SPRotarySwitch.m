/*
 * Copyright (c) 2011 Slobodan Pejic
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
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

-(NSArray*) validAngles
{
	return (validAngles);
}

-(void) setValidAngles: (NSArray*) va
{
	validAngles = va;
	[self updateMinMax];
	[self setSelectedIndex: 0];
	[self setDefaultSelectedIndex: [self defaultSelectedIndex]];
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

-(int) defaultSelectedIndex
{
	return (defaultSelectedIndex);
}

-(void) setDefaultSelectedIndex: (int) ind
{
	defaultSelectedIndex = ind;
	float angle = [[validAngles objectAtIndex: ind] floatValue];
	[knob setDefaultValue: angle]; // Note angle is value by design
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

-(BOOL) resetsToDefault
{
	return ([knob resetsToDefault]);
}

-(void) setResetsToDefault: (BOOL) rtd
{
	[knob setResetsToDefault: rtd];
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
