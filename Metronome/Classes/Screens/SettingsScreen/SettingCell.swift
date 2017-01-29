//
//  Created by Pawel Scibek on 24/09/16.
//  Copyright © 2016 Pawel Scibek. All rights reserved.
//

import UIKit

typealias SwitchActionClosure = (_ newValue: Bool, _ cell: SettingCell) -> ()

enum SettingsCellAction {
    case switchStateDidChange(Bool)
    case didTap
}

protocol SettingCellActionDelegate: class {
    func settingCell(cell: SettingCell, didPerform action: SettingsCellAction)
}

final class SettingCell: UITableViewCell {
    weak var delegate: SettingCellActionDelegate?
    
    var settingItemKind: SettingItemKind!
    
	lazy var titleLabel: UILabel = {
		let label = UILabel()
		return label
	}()
	
	lazy var switchButton: UISwitch = {
		let switchButton = UISwitch()
        switchButton.addTarget(self, action: #selector(SettingCell.switchButtonDidChangeState(_:)), for: .valueChanged)
		return switchButton
	}()
	
	var showSwitchButton: Bool {
		set { switchButton.isHidden = !newValue }
		get { return !switchButton.isHidden }
	}
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: .default, reuseIdentifier: reuseIdentifier)
		
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SettingCell.cellDidTap(_:)))
        contentView.addGestureRecognizer(tapGestureRecognizer)
        
		contentView.addSubview(titleLabel)
		contentView.addSubview(switchButton)
		
		setupCustomConstraints()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	fileprivate func setupCustomConstraints() {
		titleLabel.snp.makeConstraints { make in
			make.centerY.equalTo(contentView)
			make.leading.equalTo(contentView.snp.leadingMargin)
		}
		
		switchButton.snp.makeConstraints { make in
			make.centerY.equalTo(contentView)
			make.trailing.equalTo(contentView.snp.trailingMargin)
			make.leading.equalTo(titleLabel.snp.trailing)
		}
	}
	
	@objc private func switchButtonDidChangeState(_ sender: UISwitch) {
        delegate?.settingCell(cell: self, didPerform: .switchStateDidChange(sender.isOn))
	}
    
    @objc private func cellDidTap(_ sender: UIGestureRecognizer) {
        delegate?.settingCell(cell: self, didPerform: .didTap)
    }
}
