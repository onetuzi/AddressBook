# 通讯录应用 (AddressBook)

## 项目简介

这是一个基于 HarmonyOS 开发的通讯录管理应用，使用 ArkTS 语言开发。应用提供了完整的联系人管理功能，包括联系人的增删改查、搜索、分类展示等功能。应用采用关系型数据库存储联系人信息，支持头像设置，并提供了友好的用户界面。

## 功能特性

- ✅ **联系人列表展示**：按首字母分组显示所有联系人
- ✅ **新建联系人**：支持添加姓名、电话号码和头像
- ✅ **查看联系人详情**：查看联系人的完整信息
- ✅ **编辑联系人**：修改已有联系人信息
- ✅ **删除联系人**：移除不需要的联系人
- ✅ **搜索功能**：快速搜索联系人
- ✅ **拼音索引**：支持按拼音首字母快速定位
- ✅ **侧边栏导航**：字母索引快速跳转
- ✅ **头像管理**：支持自定义联系人头像

## 技术栈

- **开发语言**：ArkTS (HarmonyOS 应用开发语言)
- **框架版本**：HarmonyOS SDK 4.0.0(10)
- **数据库**：关系型数据库 (RelationalStore)
- **构建工具**：Hvigor
- **第三方库**：
  - `pinyin-pro` (^3.18.3) - 用于汉字转拼音，实现首字母索引功能
  - `@ohos/hypium` (1.0.11) - 测试框架

## 环境要求

- HarmonyOS SDK 4.0.0(10) 或更高版本
- DevEco Studio (推荐最新版本)
- Node.js 环境
- 支持的设备类型：手机、平板

## 安装和运行

### 1. 克隆项目

```bash
git clone https://github.com/onetuzi/AddressBook.git
cd AddressBook
```

### 2. 安装依赖

```bash
npm install
# 或使用 ohpm
ohpm install
```

### 3. 打开项目

使用 DevEco Studio 打开项目目录。

### 4. 编译运行

1. 在 DevEco Studio 中配置 HarmonyOS SDK
2. 连接 HarmonyOS 设备或启动模拟器
3. 点击"运行"按钮或使用快捷键 `Shift + F10`

## 项目结构

```
AddressBook/
├── AppScope/                      # 应用全局配置
│   ├── app.json5                 # 应用配置文件
│   └── resources/                # 全局资源
│       └── base/
├── entry/                        # 应用主模块
│   ├── src/
│   │   ├── main/                # 主要源代码
│   │   │   ├── ets/            # ArkTS 源代码
│   │   │   │   ├── DataModel/  # 数据模型
│   │   │   │   │   └── DataInfo.ets       # 联系人数据模型定义
│   │   │   │   ├── entryability/          # 应用入口能力
│   │   │   │   │   └── EntryAbility.ets   # 应用启动入口
│   │   │   │   └── pages/                 # 页面文件
│   │   │   │       ├── Index.ets          # 主页面（联系人列表）
│   │   │   │       ├── CreatePage.ets     # 新建联系人页面
│   │   │   │       ├── EditPage.ets       # 编辑联系人页面
│   │   │   │       ├── detailPage.ets     # 联系人详情页面
│   │   │   │       └── UserDBUtils.ets    # 数据库工具类
│   │   │   ├── module.json5               # 模块配置文件
│   │   │   └── resources/                 # 模块资源文件
│   │   │       ├── base/                  # 默认资源
│   │   │       │   ├── element/          # 元素资源（颜色、字符串等）
│   │   │       │   ├── media/            # 媒体资源（图片、图标）
│   │   │       │   └── profile/          # 配置文件
│   │   │       ├── en_US/                # 英文资源
│   │   │       └── zh_CN/                # 中文资源
│   │   └── ohosTest/                     # 测试代码
│   │       └── ets/
│   ├── build-profile.json5               # 构建配置
│   ├── hvigorfile.ts                     # 构建脚本
│   └── oh-package.json5                  # 模块依赖配置
├── hvigor/                               # Hvigor 构建工具配置
├── build-profile.json5                   # 项目构建配置
├── hvigorfile.ts                         # 项目构建脚本
├── oh-package.json5                      # 项目依赖配置
├── oh-package-lock.json5                 # 依赖锁定文件
└── .gitignore                            # Git 忽略配置
```

## 主要功能模块说明

### 1. 数据模型层 (DataModel)

- **DataInfo.ets**：定义联系人数据结构和数据源管理
  - `ListMember` 类：联系人基本信息模型（id、姓名、电话、头像）
  - `ListMemberDataSource` 类：联系人数据源管理，支持数据的增删改查和排序
  - `Contacts` 类：联系人分组数据结构，支持按首字母分组

### 2. 数据库层

- **UserDBUtils.ets**：关系型数据库工具类
  - 数据库初始化和表创建
  - 联系人数据的增删改查操作
  - 提供单例模式访问数据库实例
  - 数据库表结构：
    ```sql
    CREATE TABLE AddressTable (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      mobile TEXT,
      img TEXT
    )
    ```

### 3. 页面层 (Pages)

#### Index.ets - 主页面
- 联系人列表展示，支持按拼音首字母分组
- 右侧字母索引快速定位功能
- 搜索联系人功能
- 点击联系人查看详情
- 支持侧滑删除联系人

#### CreatePage.ets - 新建联系人页面
- 输入联系人姓名和电话
- 选择或拍摄联系人头像
- 数据验证和保存

#### EditPage.ets - 编辑联系人页面
- 加载现有联系人信息
- 修改联系人姓名、电话和头像
- 保存修改后的信息

#### detailPage.ets - 联系人详情页面
- 显示联系人完整信息
- 提供编辑和删除操作入口
- 支持拨打电话（需设备支持）

### 4. 应用入口

- **EntryAbility.ets**：应用生命周期管理
  - 应用启动时初始化数据库
  - 管理应用的前后台切换
  - 资源的创建和销毁

## 核心技术实现

### 拼音排序与索引
应用使用 `pinyin-pro` 库实现中文联系人的拼音转换和排序：
- 自动将联系人姓名转换为拼音
- 按拼音首字母分组显示
- 支持 A-Z 和 # (特殊字符) 的分类

### 数据持久化
使用 HarmonyOS 关系型数据库实现数据持久化：
- 安全级别设置为 S1（基础安全级别）
- 支持事务操作
- 数据自动持久化到本地存储

### 图片选择
集成 HarmonyOS 照片访问助手：
- 支持从相册选择照片
- 支持相机拍摄
- 图片 URI 存储

## 数据库表结构

### AddressTable (联系人表)

| 字段名 | 类型 | 说明 | 约束 |
|--------|------|------|------|
| id | INTEGER | 联系人唯一标识 | 主键、自增 |
| name | TEXT | 联系人姓名 | - |
| mobile | TEXT | 联系人电话号码 | - |
| img | TEXT | 联系人头像 URI | - |

## 开发说明

### 代码规范
- 使用 ArkTS 语言特性
- 遵循 HarmonyOS 开发规范
- 组件化开发，提高代码复用性
- 使用状态管理 (@State) 实现响应式 UI

### 目录说明
- `ets/`：存放所有 ArkTS 源代码
- `resources/`：存放应用资源文件（图片、字符串、颜色等）
- `base/`：默认资源，所有语言环境下都会使用
- `zh_CN/`：简体中文特定资源
- `en_US/`：英文特定资源

### 资源命名规范
- 图片资源：使用小写字母和下划线，如 `img_add.png`
- 字符串资源：使用小写字母和下划线，如 `app_name`
- 颜色资源：语义化命名，如 `start_window_background`

## 许可证

本项目遵循相关开源协议。

## 贡献指南

欢迎提交 Issue 和 Pull Request 来改进这个项目。

## 联系方式

如有问题或建议，请通过 GitHub Issues 联系。

---

**注意**：本应用仅供学习和研究使用。
