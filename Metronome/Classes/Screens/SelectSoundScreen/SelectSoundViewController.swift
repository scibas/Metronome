//
//  Created by Pawel Scibek on 24/09/16.
//  Copyright © 2016 Pawel Scibek. All rights reserved.
//

import UIKit

class SelectSoundViewController: UITableViewController {
    fileprivate let viewModel: SelectSoundViewModel
    
    struct Constants {
        static let cellReuseIdentifier = "CellReuseIdentifier"
    }
    
    init(withViewModel viewModel: SelectSoundViewModel) {
        self.viewModel = viewModel
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Select sound"
        tableView.register(SelectSoundCell.self, forCellReuseIdentifier: Constants.cellReuseIdentifier)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItemsForSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let soundSample = viewModel.soundSampleForIndexPath(indexPath)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellReuseIdentifier, for: indexPath) as! SelectSoundCell
        cell.bindWithSoundSample(soundSample)
        cell.markAsCurrent(viewModel.isSoundSampleCurentlySelected(soundSample))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let newSoundSample = viewModel.soundSampleForIndexPath(indexPath)
        viewModel.setSoundSampleToAudioEngine(newSoundSample)
        
        tableView.reloadData()
    }
}

extension SelectSoundCell {
    func bindWithSoundSample(_ soundSample: SoundSample) {
        self.textLabel?.text = soundSample.name
    }
}
