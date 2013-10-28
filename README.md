uiview-hierarchical-drawing
===========================

This is a category on UIView, which directly calls `drawRect` hierarchically. This allows you to use *any* `UIGraphicsContext`, and in particular PDF contexts. 
The benefit: Beautiful, crystal clear rendering.

Usage
-----
```objective-c
#import "UIView+HierarchicalDrawing.h"

CGSize pageSize = CGSizeMake(842.4,597.6);
NSMutableData *pdfData = [NSMutableData data];
UIGraphicsBeginPDFContextToData(pdfData, CGRectMake(0, 0, pageSize.width, pageSize.height), documentInfoDict);
UIGraphicsBeginPDFPage();
CGContextRef pdfContext = UIGraphicsGetCurrentContext();
CGContextSetInterpolationQuality(pdfContext, kCGInterpolationHigh);

[theView drawHierarchy];

UIGraphicsEndPDFContext();
// use pdfData
```

Example
-------
Below are two examples of rendering into a PDF context. One uses `UIView+HierarchicalDrawing` with `drawHierarchy`, the other `-[CALayer renderInContext:]` with a `contentScaleFactor` of `2` on the view.

- Using UIView+HierarchicalDrawing:
![hierarchical](http://mruegenberg.github.io/uiview-hierarchical-drawing/hierarchical.png)

- `renderInContext`:
![renderInContext](http://mruegenberg.github.io/uiview-hierarchical-drawing/renderincontext.png)

Known issues
----------
There are some possible problems with custom patterns as view backgrounds.

License
-------
MIT. See `LICENSE`.