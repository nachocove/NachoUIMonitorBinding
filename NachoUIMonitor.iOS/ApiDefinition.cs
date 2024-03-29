﻿using System;
using System.Drawing;

using ObjCRuntime;
using Foundation;
using UIKit;

namespace NachoUIMonitorBinding
{
	// The first step to creating a binding is to add your native library ("libNativeLibrary.a")
	// to the project by right-clicking (or Control-clicking) the folder containing this source
	// file and clicking "Add files..." and then simply select the native library (or libraries)
	// that you want to bind.
	//
	// When you do that, you'll notice that MonoDevelop generates a code-behind file for each
	// native library which will contain a [LinkWith] attribute. MonoDevelop auto-detects the
	// architectures that the native library supports and fills in that information for you,
	// however, it cannot auto-detect any Frameworks or other system libraries that the
	// native library may depend on, so you'll need to fill in that information yourself.
	//
	// Once you've done that, you're ready to move on to binding the API...
	//
	//
	// Here is where you'd define your API definition for the native Objective-C library.
	//
	// For example, to bind the following Objective-C class:
	//
	//     @interface Widget : NSObject {
	//     }
	//
	// The C# binding would look like this:
	//
	//     [BaseType (typeof (NSObject))]
	//     interface Widget {
	//     }
	//
	// To bind Objective-C properties, such as:
	//
	//     @property (nonatomic, readwrite, assign) CGPoint center;
	//
	// You would add a property definition in the C# interface like so:
	//
	//     [Export ("center")]
	//     PointF Center { get; set; }
	//
	// To bind an Objective-C method, such as:
	//
	//     -(void) doSomething:(NSObject *)object atIndex:(NSInteger)index;
	//
	// You would add a method definition to the C# interface like so:
	//
	//     [Export ("doSomething:atIndex:")]
	//     void DoSomething (NSObject object, int index);
	//
	// Objective-C "constructors" such as:
	//
	//     -(id)initWithElmo:(ElmoMuppet *)elmo;
	//
	// Can be bound as:
	//
	//     [Export ("initWithElmo:")]
	//     IntPtr Constructor (ElmoMuppet elmo);
	//
	// For more information, see http://docs.xamarin.com/ios/advanced_topics/binding_objective-c_libraries
	//
	public delegate void UIButtonCallback (string description);

    public delegate void UISegmentedControlCallback (string description, int index);

    public delegate void UISwitchCallback (string description, string onOff);

    public delegate void UIDatePickerCallback (string description, string date);

    public delegate void UITextFieldCallback (string description);

    public delegate void UIPageControlCallback (string description, int page);

    public delegate void UIAlertViewCallback (string description, int index);

    public delegate void UIActionSheetCallback (string description, int index);

    public delegate void UITapGestureRecognizerCallback (string description, int numTouches,
        PointF point1, PointF point2, PointF point3);

    public delegate void UITableViewCallback (string description, string operation);

    [BaseType (typeof (NSObject))]
    interface NachoUIMonitor
    {
        [Static, Export ("setupUIButton:")]
        void SetupUIButton (UIButtonCallback callback);

        [Static, Export ("setupUISegmentedControl:")]
        void SetupUISegmentedControl (UISegmentedControlCallback callback);

        [Static, Export ("setupUISwitch:")]
        void SetupUISwitch (UISwitchCallback callback);

        [Static, Export ("setupUIDatePicker:")]
        void SetupUIDatePicker (UIDatePickerCallback callback);

        [Static, Export ("setupUITextField:")]
        void SetupUITextField (UITextFieldCallback callback);

        [Static, Export ("setupUIPageControl:")]
        void SetupUIPageControl (UIPageControlCallback callback);

        [Static, Export ("setupUIAlertView:")]
        void SetupUIAlertView (UIAlertViewCallback callback);

        [Static, Export ("setupUIActionSheet:")]
        void SetupUIActionSheet (UIActionSheetCallback callback);

        [Static, Export ("setupUITapGestureRecognizer:")]
        void SetupUITapGestureRecognizer (UITapGestureRecognizerCallback callback);

        [Static, Export ("setupUITableView:")]
        void SetupUITableView (UITableViewCallback callback);
    }
}

