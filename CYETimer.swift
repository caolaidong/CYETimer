//
//  CYETimer.swift
//  SwiftCaolaidong
//
//  Created by 曹来东 on 2023/9/5.
//

import UIKit

extension CYETimer {
    @discardableResult
    open class func task(after: TimeInterval = 0, queue: DispatchQueue = .main, task: @escaping () -> Void) -> String? {
        executeTask(after: after, repeats: false, queue: queue, task: task)
    }
    
    @discardableResult
    open class func repeatTask(after: TimeInterval = 0, repeatInterval: TimeInterval = 1, queue: DispatchQueue = .main, task: @escaping () -> Void) -> String? {
        executeTask(after: after, repeats: true, repeatInterval: repeatInterval, queue: queue, task: task)
    }
    
    open class func cancelTask(timerId: String?) {
        guard let timerId = timerId, !timerId.isEmpty else { return }
        queue.async {
            if var timer = timers_[timerId] {
                timer?.cancel()
                timer = nil
                timers_.removeValue(forKey: timerId)
            }
        }
    }
    
    open class func cancelAllTask() {
        for timerId in timers_.keys {
            cancelTask(timerId: timerId)
        }
    }
}
open class CYETimer {
    private static let queue = DispatchQueue(label: "com.CYE.timer.queue")
    private static var timers_: [String: DispatchSourceTimer?] = [:]
    
    @discardableResult
    fileprivate class func executeTask(after: TimeInterval = 0, repeats: Bool = false, repeatInterval: TimeInterval = 1, queue: DispatchQueue = .main, task: @escaping () -> Void) -> String? {
        let inAfter = after < 0 ? 0 : after
        let timer = DispatchSource.makeTimerSource(queue: queue)
        let interval = repeats ? repeatInterval : .infinity
        timer.schedule(deadline: .now() + inAfter, repeating: interval, leeway: .nanoseconds(0))
        let timerId = UUID().uuidString
        timer.setEventHandler {
            task()
            if !repeats {
                cancelTask(timerId: timerId)
            }
        }
        timer.resume()
        queue.async {
            timers_[timerId] = timer
        }
        return timerId
    }
    
    
}
