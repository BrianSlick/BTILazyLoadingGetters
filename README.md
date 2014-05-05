# BTILazyLoadingGetters
by **Brian Slick**

Personal: [@BrianSlick](http://twitter.com/BrianSlick) | [Clinging To Ideas](http://clingingtoideas.blogspot.com) (blog)  
Business: [@BriTerIdeas](http://twitter.com/BriTerIdeas) | [briterideas.com](http://briterideas.com)


## What is BTILazyLoadingGetters?

**A project for making an Automator action that creates lazy-loading getters from @property declarations**

Given this input:

```
@property (nonatomic, strong) NSMutableArray *array;
```     
Get this output:

```
- (NSMutableArray *)array
{
    if (_array == nil)
    {
         _array = [[NSMutableArray alloc] init];
    }
    return _array;
}
``` 
     
The project builds an Automator action.

Also included is a testing app, with a few unit tests, since testing Automator actions in Automator is really annoying.


## Usage

1. Highlight a list of @properties
2. Select the appropriate service from the Xcode -> Services menu
3. Place cursor wherever you would like these getters to go
4. Paste
5. There is no step 5.


## Installation

- Acquire this project by the usual means
- Build the Action.  If a Mac app launches, you built the wrong thing
- Reveal the product in the Finder
- The .action file needs to be placed in ~/Library/Automator
- Launch Automator, and create a new Workflow using the Service template
- The settings at the top should be "text", "any application" (or limit to Xcode if you prefer), and the "Output replaces selected text" checkbox should be OFF
- Locate the custom action in the list. It might be in the "Recently Added" smart group.  Drag it into the workflow
- Locate the "Copy To Clipboard" action, and drag it to the workflow after the custom one
- Save. Give it a name you'll recognize, such as "Copy Getters To Clipboard"

This action will be available in the Services menu any time you have a text selection

Misc tip: During development I frequently found that Automator and/or the Services menu would cache previous states of the action.  Quitting Automator and sometimes Xcode, and sometimes creating an entirely new workflow, would help to see the newest code. FYI in case you modify the code and want to try it out.


## Discussion of output

The instance variable convention assumes that you are auto-synthesizing your properties, and not otherwise explicitly declaring instance variables. Thus, it follows Apple's convention. I'm not personally a fan of underscored names, but if Apple is going to standardize, I guess I'm willing to play ball. The code can easily be tailored to other styles.

No getters will be generated for primitive types (BOOL, int, etc), or for id. I won't pretend to have done exhaustive research on all of the possible types that this might apply to, so if you are encountering something routinely, please let me know and/or modify the list of ignored types in code. Primitive types will simply be ignored, so you can highlight your entire list of @properties and getters will only be generated for object types.

Since auto-synthesized readonly properties do not create instance variables, the output will helpfully include a compiler #warning reminding you of this fact.


## Why did you create this?

I will make getters like these pretty routinely for mutable NS(Mutable)Array, NS(Mutable)Dictionary, and NS(Mutable)Set properties.  Just got tired of typing it all over and over again.


## Getting the code

BTILazyLoadingGetters can be cloned from its git repository on GitHub. You can find the repository here: [http://github.com/BriTerIdeas/BTILazyLoadingGetters](http://github.com/BriTerIdeas/BTILazyLoadingGetters)


## Requirements and supported OS versions

- Tested on Mavericks.  Not sure how far back it will work.  Previous version worked fine on Mountain Lion.
- Current build target is Mavericks, which uses ARC.  If building for anything older, you have to use garbage collection.


## License

BTILazyLoadingGetters is distributed freely.  Use it or modify it in any way you see fit.


## Saying Thank You

If you find this code useful, then any of the following would really make me happy:

- I have an app: [SlickShopper](https://itunes.apple.com/us/app/slickshopper-2/id434077651?mt=8). Buy a copy. Tell friends and family about how great it is so they'll buy copies too.  Seriously, I'm lucky to sell one copy a week.  You could literally make my month!
- I do contract development: [BriTer Ideas LLC](http://www.briterideas.com/services.shtml). Hire me. Or if you know of anyone else looking for a developer, I'd appreciate a referral.
- A shout out on Twitter never hurt anybody.
- I will graciously accept a [PayPal](http://bit.ly/AW4Cc) donation.


## Bugs and feature requests

There is very little support offered with this code.  I am always interested in better ways of doing things, so I'll be happy to consider feature requests.  (Note, "consider" doesn't mean I will do anything).

To ask questions about or otherwise discuss this project, please post in [this thread](http://iphonedevsdk.com/forum/iphone-sdk-development/112883-free-utility-for-lazy-loading-getters.html).

(This README has been adapted from [MGWordCounter](https://github.com/mattgemmell/MGWordCounter) by Matt Gemmell)
