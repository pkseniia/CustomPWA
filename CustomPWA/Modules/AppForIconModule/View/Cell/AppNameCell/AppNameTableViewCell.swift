//
//  AppNameTableViewCell.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 08.11.2020.
//

import UIKit

class AppNameTableViewCell: UITableViewCell {

    @IBOutlet weak var nameTextField: UITextField! {
        didSet {
            checkForPlaceholder(textLabel?.text == "")
        }
    }

    private var textFieldCallback: TextFieldCallback?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addDoneButtonOnKeyboard()
    }
    
    private func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: Constants.Buttons.done,
                                                    style: .done, target: self,
                                                    action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        nameTextField.inputAccessoryView = doneToolbar
        nameTextField.delegate = self
    }
    
    @objc private func doneButtonAction() {
        textFieldCallback?(nameTextField.text)
        nameTextField.resignFirstResponder()
    }
    
    private func checkForPlaceholder(_ value: Bool) {
        if value {
            self.nameTextField.placeholder = Constants.AppForIcon.chooseApplication
        }
    }
}

extension AppNameTableViewCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        textFieldCallback?(string)
        return true
    }
}

extension AppNameTableViewCell: CellRenewable {

    func shouldUpdateCell(withObject object: CellObjectConfigurable) {
        guard let cellObject = object as? AppNameTableViewCellObject else { return }
        let attributes = Attributes.main(with: Fonts.light.of(size: 17), color: .named(.textColor))
        let placeholder = NSAttributedString(string: cellObject.cellTitle, attributes: attributes)
        self.nameTextField.attributedPlaceholder = placeholder
        self.textFieldCallback = cellObject.textFieldAction
    }
}

