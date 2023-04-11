//
//  FModMusicListViewController.swift
//  FModDemo
//
//  Created by joker on 2018/11/28.
//  Copyright © 2018 joker. All rights reserved.
//

import UIKit

class FModMusicListViewController: UIViewController {

    let player = FModCapsule()
    
    var musicListView: UITableView?
    
    var store: [MusicInfo]? = FModMusicStore.findAllMusic()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        configTitle()
        configMusicList()
    }
    
    func configTitle() {
        if let bundleName = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String {
            self.title = bundleName
        }
    }
    
    func configMusicList() {
        
        guard store != nil else {
            playDemoMusicFile()
            return
        }
        
        musicListView = UITableView.init(frame: self.view.bounds, style: .plain)
        musicListView?.register(FModMusicCell.self, forCellReuseIdentifier: FModMusicCell.reuseIdentifier)
        musicListView?.delegate = self
        musicListView?.dataSource = self
        musicListView?.rowHeight = 40
        self.view.addSubview(musicListView!)
    }
        
    func playDemoMusicFile() {
        let testFilePath = Bundle.main.path(forResource: "test", ofType: "xm")
        player.playStream(withFilePath: testFilePath)
    }

    @IBAction func jumpToSelectedRow(_ sender: UIBarButtonItem) {
        if let indexPath = self.musicListView?.indexPathForSelectedRow {
            self.musicListView?.scrollToRow(at: indexPath, at: .middle, animated: true)
        }
    }
}

extension FModMusicListViewController: UITableViewDelegate {
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let musicInfo = store?[indexPath.row], let cell = tableView.cellForRow(at: indexPath) as? FModMusicCell {
            
            musicInfo.isSelected = true
            
            let filePath = musicInfo.fileURL.path
            if player.isSame(as: filePath as String) {
                if player.isPlaying() {
                    player.pause()
                } else if player.isPaused() {
                    player.play()
                } else {
                    player.playStream(withFilePath: filePath);
                }
            } else{
                player.playStream(withFilePath: filePath);
            }
            
            updateCell(cell: cell, indexPath: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let musicInfo = store?[indexPath.row], let cell = tableView.cellForRow(at: indexPath) as? FModMusicCell {
            musicInfo.isSelected = false
            updateCell(cell: cell, indexPath: indexPath)
        }
    }
}

extension FModMusicListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FModMusicCell.reuseIdentifier, for: indexPath) as! FModMusicCell

        updateCell(cell: cell, indexPath: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store?.count ?? 0
    }
    
    func updateCell(cell: FModMusicCell, indexPath: IndexPath) {
        if let musicInfo = store?[indexPath.row] {
            
            cell.name.text = musicInfo.fileURL.lastPathComponent
            
            guard canPlay(musicInfo) else {
                cell.updatePlayStatus(.unavailable)
                return
            }

            cell.updatePlayStatus()
            if musicInfo.isSelected && player.isSame(as: musicInfo.fileURL.path as String) {
                if player.isPlaying() {
                    cell.updatePlayStatus(.play)
                } else if player.isPaused() {
                    cell.updatePlayStatus(.pause)
                }
            }
        }
    }
    
    func canPlay(_ musicInfo: MusicInfo) -> Bool {
        
        guard musicInfo.canPlay else {
            return false
        }
        
        let filePath = musicInfo.fileURL.path
        guard player.canPlay(filePath) else {
            musicInfo.canPlay = false
            return false
        }
        
        return true
    }
}
