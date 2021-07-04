# OrzFMod

A Swift Capsule of FMod Audio Framework

FMod Offical Site: <https://www.fmod.com>

# Usage

## CocoaPods

In you `Podfile`, add my private podspec repo OrzGeeker, and use my pods

```
source 'https://github.com/OrzGeeker/Specs.git'
pod 'OrzFMod'
```

## Swift Package Manager

```swift
.package(url: "https://github.com/OrzGeeker/OrzFMod.git", .branch("master"))
```


Now you can use my FMod Swift Capsule!


# Example for play a test.xm music file

```swift
import UIKit
import OrzFMod

class ViewController: UIViewController {
  
    var player = FModCapsule()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let FModResBundle = Bundle(for: FModCapsule.self);
        player.playStream(withFilePath: FModResBundle.path(forResource: "test", ofType: "xm"))
    }
}
```

# Mod音乐文件下载地址: [KeyGen Music](http://keygenmusic.net/)
