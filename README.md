# 多重代理的实现

我们知道OC中调用一个方法都会转为objc_msgSend()来进行消息发送。

那么objc_msgSend()会做什么事情呢？（这里只说实例对象方法，类方法是一样的道理）。

### 第一阶段，消息发送
* 先会根据isa指针找到类对象（实例对象方法、成员属性都存放在类对象里的），去类对象method_cache里面找方法缓存，没找到的话去method_list找方法实现，如果还没找到，就会去父类的类对象里面找（这个过程中只要找到方法实现都会放到cache里面），直到找到NSObject对象。

### 第二阶段，动态解析
* 第一阶段找完都没找到的话，就会调用下面这两个方法，可以在这里面添加方法的实现，一旦添加了对应方法的实现就会又重复一次消息发送阶段。

 * resolveInstanceMethod   与resolveClassMethod  在这两个方法里面可以添加方法实现。
 
 ### 第三阶段，消息转发（多重代理就是在这搞事情）
 * 第二阶段还是没解决问题的话，最后一次补救机会就在这里了。会调用三个方法：
 ```
 - (id)forwardingTargetForSelector:(SEL)aSelector   //可以在这里面返回一个实现了该selector的对象，一旦有返回就不会再调用下面两个方法
 
 - (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector  //selector的方法签名
 
- (void)forwardInvocation:(NSInvocation *)anInvocation  //invocation里面可以设定target，selector（也就是之前没有实现的那个方法由我们设定的哪个target的selector去实现了，也就是消息转发）

```
## 多重代码实现

* ZYDelegateProxys类里面利用消息转发机制，NSPointerArray数组弱持有Port对象，然后将vc里面的tableView、scrollVIew、textView的Delegate都设置为proxys实例对象，让delegate的所有方法由proxys进行分发。
