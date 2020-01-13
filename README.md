# OpenFile



> 一个 macOS 上的菜单栏快捷启动 App（这么叫不知道有没有不妥），写这个 App 主要是解决自己的一个痛点，之前一直使用 [EasyFinder](https://www.easyfinderapp.com/) 这款 App，奈何一直觉得不好看（个人观点），并且拖进去之后不支持自定义名称，一些可能名称相似（甚至相同）的就不太好分辨，然后发现了 [Dropzone 3](https://aptonic.com/) 这款 App，用的时候可以添加 App 和移动和复制到目标文件夹，但是不支持直接拖动一个文件进去（可以通过一点小手段添加），只能拖动到临时文件一栏，但是临时文件一栏也不支持自定义名称，只能也抛弃了。

* 支持自定义快捷键唤出
* 支持开机自启

## 主页面

* App 主页面就一个简单的流式布局，添加的路径会展示在主页面

![](https://raw.githubusercontent.com/nlnlnull/Figurebed/master/image-20191231135250582.png)



## 添加&删除

![](https://raw.githubusercontent.com/nlnlnull/Figurebed/master/addd.gif)



## 拖动排序

![](https://raw.githubusercontent.com/nlnlnull/Figurebed/master/sort.gif)



## 自定义显示名称

![](https://raw.githubusercontent.com/nlnlnull/Figurebed/master/customName.gif)



## 安装（命令行）

1. 首先安装 [brew-tap](https://github.com/Bigwig-Club/homebrew-brew)

   `brew tap bigwig-club/brew`

2. 安装成功后安装 `OpenFile`

   `brew cask install bigwig-club/brew/openfile`

3. 查看 `OpenFile` 信息

   `brew cask info bigwig-club/brew/openfile`

4. 卸载 `OpenFile` 

   `brew cask zap bigwig-club/brew/openfile`

## 安装（手动下载 Zip）

[Releases](https://github.com/nlnlnull/OpenFile/releases)