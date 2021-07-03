//
//  FModMusicCell.swift
//  FModDemo
//
//  Created by joker on 2021/7/3.
//  Copyright © 2021 joker. All rights reserved.
//

import UIKit
import SnapKit

class FModMusicCell: UITableViewCell {
    
    lazy var status: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var name: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    
    static let reuseIdentifier = String(describing: FModMusicCell.self)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.status)
        self.contentView.addSubview(self.name)
        
        self.status.snp.makeConstraints { make in
            make.top.left.equalTo(self.contentView).offset(10)
            make.bottom.equalTo(self.contentView).offset(-10)
            make.width.equalTo(self.status.snp.height)
        }
        
        self.name.snp.makeConstraints { make in
            make.right.top.bottom.equalTo(self.contentView)
            make.left.equalTo(self.status.snp.right).offset(5)
            make.height.equalTo(40)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        updatePlayStatus(.reset)
    }
}

extension FModMusicCell {
    enum MusicPlayStatus {
        case reset
        case play
        case pause
        case unavailable
    }
    func updatePlayStatus(_ status: MusicPlayStatus = .reset) {
        switch status {
        case .pause:
            self.status.image = UIImage(systemName: "play")
        case .play:
            self.status.image = UIImage(systemName: "pause")
        case .unavailable:
            self.status.image = UIImage(systemName: "play.slash")
        case .reset:
            self.status.image = nil
        }
    }
}