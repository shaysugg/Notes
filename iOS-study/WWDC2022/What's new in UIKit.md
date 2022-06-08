## New Features
* Navigation Bars new styles: browsers and editor
* Find and Replace texts
* edit menu based on text input: `UIEditMeenuInteraction`
* powerful Tile menu

## New Components
* UIClendarView as a stand-alone component rather than UIDatePicker
* UIPageControl
* UIPasteControl

## Improvements
* More Customizable Sheets
* SFSymbols 
	* colors configuration
	ex: `UImage.SymbolConfiguration.preferringMonochrome()`
	*  variable value:
	ex: `UIImage(systemName: "wifi", variableValue: 0.6)`
* `invalidateIntrinsicConrenerSize()` for resizing cells again
* `var selfSizingInvalidation` property for cells which determine when they should get resize.

## SwiftUI and UIKit
* writing swiftUi inside of cell with `cell.conrenrConfiguration = UIHostingConfiguration { //swiftUI code ... }`

## Deprications
* **UIDevice** properties got deprecated
* * **Deprecated UIScreen**, instead use `UIScesne` and `TraitCollection`

[Original Video 🎥](https://developer.apple.com/videos/play/wwdc2022/10068/)
