//
//  Created by Pawel Scibek on 24/09/16.
//  Copyright © 2016 Pawel Scibek. All rights reserved.
//

import UIKit

typealias SwitchActionClosure = (_ newValue: Bool, _ cell: SettingCell) -> ()

final class SettingCell: UITableViewCell {
    var switchButtonActionClosure: SwitchActionClosure?
    
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
		
		contentView.addSubview(titleLabel)
		contentView.addSubview(switchButton)
		
		setupCustomConstraints()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	fileprivate func setupCustomConstraints() {
		titleLabel.snp_makeConstraints { make in
			make.centerY.equalTo(contentView)
			make.leading.equalTo(contentView.snp_leadingMargin)
		}
		
		switchButton.snp_makeConstraints { make in
			make.centerY.equalTo(contentView)
			make.trailing.equalTo(contentView.snp_trailingMargin)
			make.leading.equalTo(titleLabel.snp_trailing)
		}
	}
	
	@objc fileprivate func switchButtonDidChangeState(_ sender: UISwitch) {
        switchButtonActionClosure?(sender.isOn, self)
	}
}
