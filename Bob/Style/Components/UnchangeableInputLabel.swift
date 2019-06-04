import Foundation
import UIKit

class UnchangeableInputLabel : UITextField, UITextFieldDelegate {
    // global variables
    var bottomBorder = UIView()
    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 10, right: 0)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addTarget(self, action: #selector(onFocusIn), for: UIControl.Event.editingDidBegin)
        self.addTarget(self, action: #selector(onFocusOut), for: UIControl.Event.editingDidEndOnExit)
        self.textColor = ColorConstant.Neutral.LIGHT
        self.isUserInteractionEnabled = false
        
    }
    @objc func onFocusIn(textField: UITextField) {
        applyColor(color: ColorConstant.Neutral.LIGHT)
    }
    @objc func onFocusOut(textField: UITextField) {
        applyColor(color: ColorConstant.Neutral.LIGHT)
    }
    
    func applyColor(color: UIColor) {
        bottomBorder.backgroundColor = ColorConstant.Border.BASE
    }
    
    override func awakeFromNib() {
        self.translatesAutoresizingMaskIntoConstraints = false
        applyColor(color: ColorConstant.Neutral.LIGHT)
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bottomBorder)
        bottomBorder.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        bottomBorder.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        bottomBorder.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        bottomBorder.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    @IBInspectable var hasError: Bool = false {
        didSet {
            if (hasError) {
                bottomBorder.backgroundColor = UIColor.red
            } else {
                bottomBorder.backgroundColor = ColorConstant.Neutral.LIGHT
            }
        }
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
