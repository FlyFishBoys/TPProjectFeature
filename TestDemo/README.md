# mvvm demo

 1.  结构  -  Config （配置） 、Class (视图控制器类) 、 Core (网络请求) 、Unit (调用中心)

  2. class  结构  View （UI）、Model（数据模型）、ViewModel(负责UI显示、事件交互、业务处理、网络请求) 、ViewController (负责界面跳转、不同ViewModel 之间的交互，viewModel 之间不直接交互，因为级别相同) 、 PageTurn (跳转该界面的传参) 、 DataRequest (业务的网络请求)
  3. Unit   结构  NetworkManagerCenter (网络请求中心)  、 PageControllerCenter (视图控制器的调用) 、 CommonUnitCenter (常用方法调用)



