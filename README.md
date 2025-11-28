# DEP-11 for debs

本仓库为 APT 仓库支持 AppStream 提供分段的 DEP-11 信息，使之能在 GNOME Software、KDE Plasma Discover 等应用商店中显示。

这是 [wcbing APT Repo](https://github.com/wcbing/wcbing-apt-repo) 的一部分，当然，您也可将其用于其他仓库。欢迎您参与。

> DEP-11 is a YAML implementation of the AppStream catalog specification, which is primarily used by Debian and its derivatives.  
> DEP-11 是 AppStream 目录规范的 YAML 实现，主要用于 Debian 及其衍生产品。

## 参考资料

### Catalog Metadata 文档

- [AppStream Catalog XML](https://www.freedesktop.org/software/appstream/docs/chap-CatalogData.html)  
AppStream 官方格式，有更详细的字段解释，用于对照查询。
- [AppStream Catalog YAML](https://www.freedesktop.org/software/appstream/docs/sect-AppStream-YAML.html)  
Debian 使用的 AppStream 格式，也就是本仓库使用的格式。

### Metadata 参考来源

- 部分应用内置，位置见上方规范。
- [Flathub](https://github.com/flathub)  
样例：[腾讯会议](https://github.com/flathub/com.tencent.wemeet/blob/master/com.tencent.wemeet.metainfo.xml)。添加新应用时可先参考 Flathub，尤其是应用 ID （详见“注意事项 - ID”）。值得注意的是，Flathub 上的信息有时会与原作者有一些差异，如分类、说明；此外其有些图片托管在 Github 上，访问可能受限，所以不建议完全照抄。

大部分 Metadata 都使用 XML 格式，你可以使用类似 `appstreamcli convert --format yaml ./xml/com.tencent.wemeet.metainfo.xml yaml/com.tencent.wemeet.yaml` 的命令将其  XML 转换为 YAML 格式。

## 注意事项

因为这些信息大多与架构无关的通用信息，如果应用支持多个架构，建议非 amd64 架构的使用软链接链接到 amd64 目录下。

### ID
因为现在商店内国产软件的评论、评分等大多都是 Flathub 用户提供的，为保持这些信息兼容，建议 ID 与 Flathub 保持一致。

但是请注意，有些应用自带 metainfo 或 appdata（尤其是 Chromium 衍生或基于 Electron 的应用），所以其可能已经有一些评论。如果 Flathub 应用与其官方使用的 ID 不同，请使用其官方的 ID，毕竟我们本身就是“分发”官网原生包文件（的链接）。

Flathub 不像 AppStream 规范推荐的那样使用全小写 ID，因为改为全小写仍可正常显示评论、评分等，建议将 ID 改为全小写（比较奇特的是 QQ 和 QQ音乐，不改在“全部应用程序”中显示不出来）。

### Icon
不太想托管图片，所以建议使用在线（Remote）图标，但是在 Discover 上显示不出来，正在考虑中。

### Screeshots
不强制要求 16:9，截图最好来自官网。

### 本地化（中文）

AppStream 的 YAML 规范中没找到详细解释，XML 规范中使用 XML 原生语法 `xml:lang=`，那应该是 BCP 47。在 System Locale: `LANG=zh_CN.UTF-8` 情况下测试得出这几种常见的“中文”表示支持如下表，正在考虑国内软件直接使用的 zh 字段。

|                | `zh` | `zh-CN` | `zh_CN` | `zh-Hans` |
| -------------: | :--: | :-----: | :-----: | :-------: |
| 样例（Example） | [net.eudic.dict](https://github.com/flathub/net.eudic.dict/blob/master/net.eudic.dict.metainfo.xml#L6) | [com.qq.QQmusic](https://github.com/flathub/com.qq.QQmusic/blob/master/com.qq.QQmusic.metainfo.xml#L10) | [com.github.gmg137.netease-cloud-music-gtk](https://github.com/flathub/com.github.gmg137.netease-cloud-music-gtk/blob/master/com.github.gmg137.netease-cloud-music-gtk.metainfo.xml#L36) | [com.tencent.wemeet](https://github.com/flathub/com.tencent.wemeet/blob/master/com.tencent.wemeet.metainfo.xml#L6) |
| GNOME Software | ✔️ | ❌ | ✔️ (Only XML) | ❌ |
|   KDE Discover | ✔️ | ✔️ | ❌ | ❌ |
|    Flathub Web | ✔️ | ✔️ | ✔️ | ✔️ |
|    Flatpak CLI | ✔️ | ✔️ | ❌ | ❌ |

> `zh_CN` 不是符合 BCP 47 规范的语言标签。

> ✔️ 意味着支持该语言标签，可以显示中文；❌ 意味着不支持该语言标签，会回落显示 `C` 字段中的内容。

可以看出 GNOME Software 支持有些异常，已经提了 [issue](https://gitlab.gnome.org/GNOME/gnome-software/-/issues/2920)

Flathub 中还有两个 `zh-cn` 这样不合法表示（“QQ音乐”我接手改了，就剩“网易云音乐”了），在几个平台都都无法展现。此外 Debian 仓库中还有一些更详细的 `zh-Hans-CN`，几个平台也是不支持。
