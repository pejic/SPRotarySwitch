SPRotarySwitch

This control imitates a rotary switch (a rotary knob that snaps to a set of
angles).  The control can replace static UISegmentedControls where a square
shape fits the layout better.

HOW TO USE:

Copy MHRotaryKnob.h, MHRotaryKnob.m, SPRotarySwitch.h, and SPRotarySwitch.m
into your project. Add QuartzCore to your target's frameworks.

You have to provide the images for the knob and the background. The demo project
includes a few basic images but you probably want to use graphics that suit your
app's look-and-feel better. 

(The demo project also includes Knob.xcf and Knob.blend, which are the GIMP and
Blender source files respectively.)

If you want to do more fancy drawing, then you can easily modify the
MHRotaryKnob class. Its -valueDidChangeFrom:to:animated: method is invoked
whenever the value changes.  In the default implementation it simply rotates
the knob image. You can change or override this method to do custom drawing.

SYSTEM REQUIREMENTS:

iOS 3.0 or higher
