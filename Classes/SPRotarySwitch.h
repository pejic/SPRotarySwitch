/*!
 * \file SPRotarySwitch.h
 *
 * \brief UIControl subclass containing MHRotaryKnob that imitates a rotary
 * knob switch which jumps to certain positions with no in between positions.
 *
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

#import "MHRotaryKnob.h"

/*!
 * The rotary switch control is identical to the rotary knob, but snaps to a
 * set of degrees.  One can use this as an alternative (not source compatible)
 * to the \c UISegmentedControl class.  The developer provides the valid angles
 * to which the control will snap to.
 *
 * The operation of this control is identical to the MHRotaryKnob except that
 * the control automatically snaps to the nearest valid angle.  A notification
 * is sent whenever the selected index of the angle changes.
 *
 * This class needs the QuartzCore framework.
 *
 * \author Slobodan Pejic <slobo972@gmail.com>
 */
@interface SPRotarySwitch : UIControl
{
	MHRotaryKnob* knob;
	NSArray* validAngles; ///Angles to which the control snaps to.
}

/*! The angles to which the control snaps to. An array of NSNumbers. Setting
 * this variable automatically sets the minimum and maximum values. Angles
 * should be from -180 to 180 in degrees. */
@property (nonatomic, retain) NSArray* validAngles;

/*! The index in validAngles of the current selected angle. */
@property (nonatomic, assign) int selectedIndex;

/*!
 * Allows animating of setting the selectedIndex.
 */
-(void) setSelectedIndex: (int) ind
		animated: (BOOL) animated;

/* The following methods are delegated to MHRotaryKnob. */

/*! The image that is drawn behind the knob. May be nil. */
@property (nonatomic, retain) UIImage* backgroundImage;

/*! The image currently being used to draw the knob. */
@property (nonatomic, retain, readonly) UIImage* currentKnobImage;

/*! For positioning the knob image. */
@property (nonatomic, assign) CGPoint knobImageCenter;

/*!
 * Assigns a knob image to the specified control states.
 * 
 * This image should have its position indicator at the top. The knob image is
 * rotated when the control's value changes, so it's best to make it perfectly
 * round.
 */
-(void) setKnobImage: (UIImage*) image
	    forState: (UIControlState) state;

/*!
 * Returns the thumb image associated with the specified control state.
 */
-(UIImage*) knobImageForState: (UIControlState) state;

@end
