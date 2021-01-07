//
//  StringExt.swift
//  ChiaExtDemo
//
//  Created by Chia on 2021/1/3.
//

import Foundation
import CryptoKit
import CommonCrypto

extension String {
    //  MARK:   MD5
    var MD5: String {
        let data = Data(self.utf8)
        if #available(iOS 13.0, *) {
            let computed = Insecure.MD5.hash(data: data)
            return computed.map { String(format: "%02hhx", $0) }.joined()
        } else {
            let hash = data.withUnsafeBytes { (bytes: UnsafeRawBufferPointer) -> [UInt8] in
                var hash = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
                CC_MD5(bytes.baseAddress, CC_LONG(data.count), &hash)
                return hash
            }
            return hash.map { String(format: "%02x", $0) }.joined()
        }
    }
    
    //  uppercases only the first letter
    var capitalizedFirst: String {
        guard let firstLetter = self.first else { return "" }
        return firstLetter.uppercased() + self.dropFirst()
    }
    
    //  subscript
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
    
    //  remove a prefix if it exists
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else {
            return self
        }
        return String(self.dropFirst(prefix.count))
    }
    
    //  remove a suffix if it exists
    func deletingSuffix(_ suffix: String) -> String {
        guard self.hasSuffix(suffix) else {
            return self
        }
        return String(self.dropLast(suffix.count))
    }
    
    //  check whether any string in array exists in input string
    func containsAny(of array: [String]) -> Bool {
        for item in array {
            if self.contains(item) {
                return true
            }
        }
        return false
    }
}
