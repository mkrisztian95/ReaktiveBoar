//
//  VM.swift
//  AlamofireCoolCousinTests
//
//  Created by Peter Ovchinnikov on 8/7/16.
//  Copyright © 2016 Peter Ovchinnikov. All rights reserved.
//

public protocol VMProtocol: class, TypeProviderProtocol { }

open class VM: NSObject, VMProtocol {
    public override init() {
        super.init()
    }

}
