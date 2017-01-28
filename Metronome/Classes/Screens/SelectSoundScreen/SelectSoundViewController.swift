//
//  Created by Pawel Scibek on 24/09/16.
//  Copyright © 2016 Pawel Scibek. All rights reserved.
//

import UIKit

class SelectSoundViewController: UITableViewController {
    private let viewModel: SelectSoundViewModel
    
    struct Constants {
        static let cellReuseIdentifier = "CellReuseIdentifier"
    }
    
    init(withViewModel viewModel: SelectSoundViewModel) {
        self.viewModel = viewModel
        super.init(style: .Plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Select sound"
        tableView.registerClass(SelectSoundCell.self, forCellReuseIdentifier: Constants.cellReuseIdentifier)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItemsForSection(section)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let soundSample = viewModel.soundSampleForIndexPath(indexPath)
        
        let cell = tableView.dequeueReusableCellWithIdentifier(Constants.cellReuseIdentifier, forIndexPath: indexPath) as! SelectSoundCell
        cell.bindWithSoundSample(soundSample)
        cell.markAsCurrent(viewModel.isSoundSampleCurentlySelected(soundSample))
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let newSoundSample = viewModel.soundSampleForIndexPath(indexPath)
        viewModel.setSoundSampleToAudioEngine(newSoundSample)
        
        tableView.reloadData()
    }
}

extension SelectSoundCell {
    func bindWithSoundSample(soundSample: SoundSample) {
        self.textLabel?.text = soundSample.name
    }
}