//
//  FModMusicListViewController.swift
//  FModDemo
//
//  Created by joker on 2018/11/28.
//  Copyright © 2018 joker. All rights reserved.
//

import UIKit
import OrzFMod

class FModMusicListViewController: UIViewController {

    let player = FModCapsule()
    
    var musicListView: UITableView?
    
    let store: [MusicInfo]? = FModMusicStore.findAllMusic()
        
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
        musicListView?.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        musicListView?.delegate = self
        musicListView?.dataSource = self
        self.view.addSubview(musicListView!)
    }
    
    func playDemoMusicFile() {
        let testFilePath = Bundle.main.path(forResource: "test", ofType: "xm")
        player.playStream(withFilePath: testFilePath)
    }

}

extension FModMusicListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let music = store?[indexPath.row] {
            player.playStream(withFilePath: music.fileURL.path)
        }
    }
}

extension FModMusicListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let musicInfo = store?[indexPath.row] {
            cell.textLabel?.text = musicInfo.fileURL.lastPathComponent
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store?.count ?? 0
    }
}
