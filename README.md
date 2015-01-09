# TimerRetainCycleDemo
对Timer的RetainCycle加深理解。使用NSTimer，加入runloop之后，必须invalid。对于非repeat的Timer，会自动invalid；
而对于repeat的Timer，则必须手动invalid。

关于NSTimer中添加weakTarget的理解，不管是加入strong target和weak target，在Timer被加入runloop之后，都会将target retain一次。
以下是weakTarget的做法，实际上只是拐了个弯进行替换了，将invalid的放在内部执行。
http://stackoverflow.com/questions/16821736/weak-reference-to-nstimer-target-to-prevent-retain-cycle
https://github.com/YuAo/NSTimer-WeakTarget/tree/master/NSTimer%2BWeakTarget
