//
//  StringExt.swift
//  ChiaExtDemo
//
//  Created by Chia on 2021/1/3.
//

import Foundation
import CommonCrypto

extension String {
    //  MARK:   MD5加密
//    var md5: String {
//        let data = Data(self.utf8)
//        let hash = data.withUnsafeBytes { (bytes: UnsafeRawBufferPointer) -> [UInt8] in
//            var hash = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
//            if #available(iOS 13.0, *) {
//                CC_SHA256(bytes.baseAddress, CC_LONG(data.count), &hash)
//            } else {
//                CC_MD5(bytes.baseAddress, CC_LONG(data.count), &hash)
//            }
//            return hash
//        }
//        return hash.map { String(format: "%02x", $0) }.joined()
//    }
}
