# Imitation

####在block中调用tableView的reloadData方法，需加入到GCD中，即更新UI需放在主线程中
```
dispatch_async(dispatch_get_main_queue(), ^{
                [self.hostTableView reloadData];<
            });
```

####在这里需要用下边的方法设定Alpha值,第一种方法会使子视图的Alpha值和父视图的一样.<br>

```
//    //self.backgroundColor = [UIColor colorWithRed:(40/255.0f) green:(40/255.0f) blue:(40/255.0f) alpha:1.0f];
//    _shadowView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent: 0.4]; 
```

####accessoryType 和accessoryType可以设置附件，添加图片，按钮等

```
cell.accessoryType = UITableViewCellAccessoryCheckmark;
```
