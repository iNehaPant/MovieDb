

import UIKit

class LabelUtility {
    
    class func getLbl(fontName: String, fontSize: CGFloat) -> UILabel  {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.font = UIFont(name: fontName, size: fontSize)
        return lbl
    }
    
}
