//
//  AppDelegate.swift
//  SwiftTraceOSX
//
//  Created by John Holdsworth on 13/06/2016.
//  Copyright © 2016 John Holdsworth. All rights reserved.
//

import Cocoa
import SwiftTraceX

public protocol P {

    func x()
    func y() -> Float
    func z( d: Int, f: Double, g: Float, h: Double, f1: Double, g1: Float, h1: Double, f2: Double, g2: Float, h2: Double, e: Int )

}

public class TestClass: P {

    let i = 999

    public func x() {
        print( "HERE \(i)" )
    }

    public func y() -> Float {
        print( "HERE2" )
        return -9.0
    }

    public func z( d: Int, f: Double, g: Float, h: Double, f1: Double, g1: Float, h1: Double, f2: Double, g2: Float, h2: Double, e: Int ) {
        print( "HERE \(i) \(d) \(e) \(f) \(g) \(h) \(f1) \(g1) \(h1) \(f2) \(g2) \(h2)" )
    }
    
}


@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!


    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application

        // any inclusions or exlusiona need to come before trace enabled
        //SwiftTrace.include( "Swift.Optiona|TestClass" )

        class MyTracer: SwiftTraceInfo {

            override func trace() -> IMP {
                print( ">> "+symbol )
                return original
            }

        }

        SwiftTrace.tracerClass = MyTracer.self

        self.dynamicType.traceBundle()

        let a: P = TestClass()
        a.x()
        print( a.y() )
        a.x()
        a.z( 88, f: 66, g: 55, h: 44, f1: 66, g1: 55, h1: 44, f2: 66, g2: 55, h2: 44, e: 77 )
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

