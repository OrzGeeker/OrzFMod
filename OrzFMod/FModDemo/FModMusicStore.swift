//
//  FModMusicStore.swift
//  FModDemo
//
//  Created by joker on 2021/7/3.
//  Copyright © 2021 joker. All rights reserved.
//

import Foundation

struct FModMusicStore {
    
    static private let documentDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString
    
    static let musicStoreDir = FModMusicStore.documentDir.appendingPathComponent("musics") as NSString
    static func findAllMusic() -> [MusicInfo]? {
        let fileManager = FileManager.default
        if let allObjects = fileManager.enumerator(atPath: FModMusicStore.musicStoreDir as String)?.allObjects {
            
            var ret = [MusicInfo]()
            
            for obj in allObjects {
                let path = musicStoreDir.appendingPathComponent(obj as! String)
                
                var isDir: ObjCBool = false
                if fileManager.fileExists(atPath: path, isDirectory: &isDir), !isDir.boolValue {
                    let url = URL.init(fileURLWithPath: path)
                    ret.append(MusicInfo(fileURL: url))
                }
            }
            
            return ret
        }
        
        return nil
    }
}

struct MusicInfo {
    let fileURL: URL
}

class OrzFileSysNode {
    
    enum NodeType {
        case directory
        case file
    }
    
    let type: NodeType
    
    let parent: OrzFileSysNode?
    let children: [OrzFileSysNode]?
    
    
    init(_ type: NodeType = .file,
         parent: OrzFileSysNode? = nil,
         children: [OrzFileSysNode]? = nil) {
        
        self.type = type
        self.parent = parent
        self.children = children
    }
}






