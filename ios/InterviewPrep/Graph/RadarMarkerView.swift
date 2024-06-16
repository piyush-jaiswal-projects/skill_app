//
//  RadarMarkerView.swift
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
@objc(InterviewPrep_RadarMarkerView)
open class RadarMarkerView: MarkerView
{
    @IBOutlet var label: UILabel?
    
    open override func awakeFromNib()
    {
        self.offset.x = -self.frame.size.width / 2.0
        self.offset.y = -self.frame.size.height - 7.0
    }
    
    open override func refreshContent(entry: ChartDataEntry, highlight: Highlight)
    {
        label?.text = String.init(format: "%d %%", Int(round(entry.y)))
        layoutIfNeeded()
    }
}

