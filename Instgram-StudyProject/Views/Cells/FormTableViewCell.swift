//
//  FormTableViewCell.swift
//  Instgram-StudyProject
//
//  Created by Mina Hany on 27/02/2022.
//

import UIKit
protocol FormTableViewCellDelegate: AnyObject {
    func formTableViewCell(_ cell: FormTableViewCell,didUpdateField updateModel: EditProfileModel)
}

class FormTableViewCell: UITableViewCell, UITextFieldDelegate {

    static let identifier = "FormTableViewCell"
    
    private var model : EditProfileModel?
    public weak var delegate: FormTableViewCellDelegate?
    private let formLabel : UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        
        
        return label
    }()
    
    private let field : UITextField = {
        let field = UITextField()
        field.returnKeyType = .done
        return field
    }()
    
            
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        clipsToBounds = true
        contentView.addSubview(formLabel)
        contentView.addSubview(field)
        field.delegate = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //Assign Frames
        formLabel.frame = CGRect(x: 5, y: 0, width: contentView.width/3, height: contentView.height)
        field.frame = CGRect(x: formLabel.right + 5, y: 0, width: contentView.width-10-formLabel.width, height: contentView.height)
    }
    override func prepareForReuse(){
        super.prepareForReuse()
        
        field.text = nil
        formLabel.text = nil
        field.placeholder = nil
    }
    
    public func configureCell(with model: EditProfileModel){
        self.model = model
        formLabel.text = model.label
        field.placeholder = model.placeHolder
        field.text = model.value
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        model?.value = textField.text
        guard let model = model else {
            return true
        }
        delegate?.formTableViewCell(self, didUpdateField: model)
        print("Value is ", model.value)
        textField.resignFirstResponder()
        
        return true
    }
    
        
}
