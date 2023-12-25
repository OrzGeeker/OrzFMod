# OrzFMod

A Swift Capsule of FMod Audio Framework

FMod Offical Site: <https://www.fmod.com>

# Usage

## Swift Package Manager

```swift
.package(url: "https://github.com/OrzGeeker/OrzFMod.git", .upToNextMajor("0.0.2"))
```

Now you can use my FMod Swift Capsule!


# Example for play a test music

```swift
import UIKit
import FModAPI

class ViewController: UIViewController {
  
    let player = FModCapsule()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        player.playDemoMusic()
    }
}
```
