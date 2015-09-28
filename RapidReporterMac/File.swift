/*

Copyright 2015 Skyscanner Ltd

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this
file except in compliance with the License. You may obtain a copy of the License at
http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under
the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF
ANY KIND, either express or implied. See the License for the specificlanguage governing
permissions and limitations under the License.

*/

import Foundation

class File {
    
    class func exists (path: String) -> Bool {
        return NSFileManager().fileExistsAtPath(path)
    }
    
    class func read (path: String, encoding: NSStringEncoding = NSUTF8StringEncoding) -> String? {
        if File.exists(path) {
            return try? String(contentsOfFile: path, encoding: encoding)
        }
        return nil
    }
    
    class func write (path: String, content: String, encoding: NSStringEncoding = NSUTF8StringEncoding) -> Bool {
        do {
            try content.writeToFile(path, atomically: true, encoding: encoding)
            return true
        } catch _ {
            return false
        }
    }
    
    class func appendToFile(path: String, content: String) {
        let newLineAndContent = "\n" + content
        if let outputStream = NSOutputStream(toFileAtPath: path, append: true) {
            outputStream.open()
            outputStream.write(newLineAndContent, maxLength:newLineAndContent.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
            outputStream.close()
        } else {
            print("Unable to open file")
        }
    }
}