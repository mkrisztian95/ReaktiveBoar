//
//  BoarError.swift
//  ReaktiveBoar
//
//  Created by Peter Ovchinnikov on 3/14/19.
//  Copyright © 2019 Peter Ovchinnikov. All rights reserved.
//

struct BoarError {

}

extension BoarError {
    public static let Domain = "app.timon.reaktiveboar"

    public static func err(_ code: Int, userInfo: [String: Any]? = nil) -> NSError {
        return NSError(domain: self.Domain, code: code, userInfo: userInfo)
    }
    public static let noTopControllerCode: Int    = 90002
    public static let noTopController: NSError = err(noTopControllerCode,
                                                     userInfo: ["Message": "No top conroller found"])

    public static let noNavigationControllerCode: Int    = 90003
    public static let noNavigationController: NSError = err(noNavigationControllerCode,
                                                            userInfo: ["Message": "No navigation conroller found"])
}
