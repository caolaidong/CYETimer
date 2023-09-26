# CYETimer
基于GCD DispatchSource封装的一个轻量级定时器，无循环引用问题，无RunLoop切换不同模式Timer定时器不准确问题，支持指定线程执行任务，线程安全。
## Usage


### 定时器重复执行任务
~~~swift
//after：2秒后执行定时任务
//repeatIntervale：每1秒执行一次
//queue：globalQueue
func repeatButtonClick() {
        
        var count = 6
        var timerId: String? = ""
        
        timerId = CYETimer.repeatTask(after: 2,repeatIntervale: 1,queue: .global()) {
            
            count = count - 1
            
            if count == 0{
                //定时器销毁
                CYETimer.cancelTask(timerId: timerId)
                
            }
        }
    }
~~~
### 定时器单次执行任务
~~~swift
//1秒后mainQueue执行定时任务，自动销毁定时器
//内部处理定时器销毁
CYETimer.task(after: 1,queue: .main, task: {
            
})
~~~
### 定时器销毁
~~~swift
CYETimer.cancelTask(timerId: timerId)
~~~

### 销毁所有定时器
~~~swift
CYETimer.cancelAllTask()
~~~

## Installation

CocoaPods:

~~~
pod 'CYETimer'
~~~
