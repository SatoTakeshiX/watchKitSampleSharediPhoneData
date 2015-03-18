# watchKitSampleSharediPhoneData
iPhoneとAppleWatchのデータのやり取りサンプルアプリ
AppleWatchのボタンタップ回数をiPhoneへ送り、iPhoneからは画像データを送信。AppleWatchにその画像を表示させる。

## WatchKit App側コード
WatchKit Extension上で```WKInterfaceController#openParentApplication:reply:```を実行することで、iPhoneアプリとWatchKitAppのデータのやり取りができます。
第一引数にNSDictionary型でiPhoneアプリへ渡すデータを書きます。
第二引数のreplyブロックでiPhoneから渡されたデータがreplyInfoに入ります。

InterfaceController.m
```objective-c
- (IBAction)sendToiPhone {
    self.count ++;
    [WKInterfaceController openParentApplication:@{
                                                   //watchからiPhoneへ送るデータ
                                                  @"watchValue":[[NSNumber alloc] initWithInteger:self.count]
                                                  }
                                           reply:^(NSDictionary *replyInfo, NSError *error){
                                               
                                                      //iPhoneからwatchへ送られたデータ
                                                      NSData *nekoData = replyInfo[@"nekoImage"];
                                               
                                                      //iPhoneからNSDataで送れば画像が出る。
                                                      [self.watchImage setImageData:nekoData];
                                               

                                                  }];
}

```

## iPhoneアプリ側の処理
AppDelegate.mで```UIApplicationDelegate#application:handleWatchKitExtensionRequest:reply:```を実装します。
watchAppからのデータはuserInfoに入ってます。
iPhoneからWatchAppへデータを渡す際はreplyオブジェクトに設定します。

```objective-c
- (void)application:(UIApplication *)application handleWatchKitExtensionRequest:(NSDictionary *)userInfo reply:(void(^)(NSDictionary *replyInfo))reply
{
    //watchからのデータはuserInfoに入っている。
    NSNumber *watchCount = [userInfo valueForKey:@"watchValue"];
    
    //watchからのデータをiPhoneの画面に表示させる。
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    ViewController *vc = (ViewController *)appDelegate.window.rootViewController;
    vc.watchCountLabel.text = [NSString stringWithFormat:@"アップルウォッチでのカウントは%ld回", [watchCount integerValue]];
    
    //iPhoneからwatchへ画像データを送る。
    UIImage *nekoImage = [UIImage imageNamed:@"neko"];
    NSData *nekoData = [[NSData alloc] initWithData:UIImagePNGRepresentation(nekoImage)];
    reply(
          @{
            @"iPhoneData":@(1),
            @"nekoImage":nekoData//UIImageオブジェクトをそのまま送ると送信が失敗してしまう。NSDataに直して送る。
            }
    );
}
```

## WatchAppにiPhoneから画像データを送る方法
UIImageオブジェクトをそのままNSDictonaryにして渡しても送れません。
UIImageはNSDataに変換して送りましょう。
iPhone側の処理は以下です。

```objective-c
    //iPhoneからwatchへ画像データを送る。
    UIImage *nekoImage = [UIImage imageNamed:@"neko"];
    NSData *nekoData = [[NSData alloc] initWithData:UIImagePNGRepresentation(nekoImage)];
```

WatchApp側ではNSDataからUIImageに変換して画像表示しましょう
```objective-c
                                                      //iPhoneからwatchへ送られたデータ
                                                      NSData *nekoData = replyInfo[@"nekoImage"];
                                               
                                                      //iPhoneからNSDataで送れば画像が出る。
                                                      [self.watchImage setImageData:nekoData];

```

## 画像について
©Clara S.
http://www.flickr.com/photos/pictureclara/7196979364/in/photostream/


