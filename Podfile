
platform :ios, '11.0'
use_frameworks!

target 'GifWallet' do
  pod 'SDWebImage/GIF'
  pod 'TagListView', '~> 1.0'
  pod 'IQKeyboardManager'
  
  target 'GifWalletTests' do
      pod 'iOSSnapshotTestCase'
  end
end

target 'GifWalletKit' do
    pod 'Async', :git => "git@github.com:CodeCraftersIO/async.git"
    target 'GifWalletKitTests' do
        inherit! :search_paths
    end
end


