//
//  XYMarkerView.swift
//  Demo2
//
//  Created by Amit Gupta on 12/01/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

import Foundation
import Charts
#if canImport(UIKit)
    import UIKit
#endif
@objc(InterviewPrep_XYMarkerView)
open class XYMarkerView: BalloonMarker
{
    @objc open var xAxisValueFormatter: IAxisValueFormatter?
    fileprivate var yFormatter = NumberFormatter()
    
    @objc public init(color: UIColor, font: UIFont, textColor: UIColor, insets: UIEdgeInsets,
                xAxisValueFormatter: IAxisValueFormatter)
    {
        super.init(color: color, font: font, textColor: textColor, insets: insets)
        self.xAxisValueFormatter = xAxisValueFormatter
        yFormatter.minimumFractionDigits = 1
        yFormatter.maximumFractionDigits = 1
    }
    
    open override func refreshContent(entry: ChartDataEntry, highlight: Highlight)
    {
        //"x: " + xAxisValueFormatter!.stringForValue(entry.x, axis: nil)  +
        setLabel(yFormatter.string(from: NSNumber(floatLiteral: entry.y))! + "%")
    }
    
}

