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
    
    lazy var info: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(systemName: "info.circle")
        return imageView
    }()
    
    static let reuseIdentifier = String(describing: FModMusicCell.self)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.status)
        self.contentView.addSubview(self.name)
        self.contentView.addSubview(self.info)
        
        self.status.snp.makeConstraints { make in
            make.top.left.equalTo(self.contentView).offset(10)
            make.bottom.equalTo(self.contentView).offset(-10)
            make.width.equalTo(self.status.snp.height)
        }
        
        self.name.snp.makeConstraints { make in
            make.top.bottom.equalTo(self.contentView)
            make.right.equalTo(self.info.snp.left).offset(-5)
            make.left.equalTo(self.status.snp.right).offset(5)
        }
        
        self.info.snp.makeConstraints { make in
            make.top.equalTo(self.contentView).offset(10)
            make.right.bottom.equalTo(self.contentView).offset(-10)
            make.width.equalTo(self.info.snp.height)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        
        self.isUserInteractionEnabled = true
        self.selectionStyle = .default
        
        self.name.textColor = .label
        self.status.tintColor = tintColor
        
        switch status {
        case .pause:
            self.status.image = UIImage(systemName: "pause")
            self.status.tintColor = .systemBlue
            self.name.textColor = .systemBlue
        case .play:
            self.status.image = UIImage(systemName: "play")
            self.status.tintColor = .systemBlue
            self.name.textColor = .systemBlue
        case .unavailable:
            self.status.image = UIImage(systemName: "play.slash")
            self.status.tintColor = .gray
            self.name.textColor = .gray
            self.isUserInteractionEnabled = false
            self.selectionStyle = .none
        case .reset:
            self.status.image = nil
        }
    }
}
