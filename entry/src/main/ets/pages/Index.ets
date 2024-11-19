import { BusinessError, Callback } from '@kit.BasicServicesKit'
import { ListMember, ListMemberDataSource, Contacts } from "../DataModel/DataInfo"
import { router } from '@kit.ArkUI'
import rs from '@ohos.data.relationalStore'
import rdb from './UserDBUtils'
const colors: Array<string> = ['#ff6161', '#ffb120', '#7484fc', '#00cee5']
@Entry
@Component
struct Index {
  @State ListCt: ListMemberDataSource = new ListMemberDataSource()
  @State letters: string[] = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','#']
  @State flag: number = 0
  @State ListArray: Array<ListMember> = []
  private listScroller: Scroller = new Scroller()
  @State selectedIndex: number = 0
  @State Search_Content: string = ""
  private openBarData: Contacts | undefined = undefined
  private downX = 0
  private barWidth = 100
  onPageShow(): void {
    setTimeout(() => {
      console.error('--------------', `aboutToAppear 2000 `);
      rdb.getInstance().RequestData().then((result) => {
        this.ListCt.SetArr(result)
      })
    }, 100)

    // rdb.getInstance().InsertData("卢本伟", "13057492369", "")
    // rdb.getInstance().InsertData("钱七", "13812345678", "")
    // rdb.getInstance().InsertData("孙八", "13987654321", "")
    // rdb.getInstance().InsertData("李九", "13098765432", "")
    // rdb.getInstance().InsertData("周十", "13123456789", "")
    // rdb.getInstance().InsertData("吴十一", "13234567890", "")
    // rdb.getInstance().InsertData("郑十二", "13345678901", "")
    // rdb.getInstance().InsertData("王十三", "13456789012", "")
    // rdb.getInstance().InsertData("冯十四", "13567890123", "")
    // rdb.getInstance().InsertData("陈十五", "13678901234", "")
    // rdb.getInstance().InsertData("褚十六", "13789012345", "")
    // rdb.getInstance().InsertData("卫十七", "13890123456", "")
    // rdb.getInstance().InsertData("蒋十八", "13901234567", "")
    // rdb.getInstance().InsertData("沈十九", "13012345678", "")
    // rdb.getInstance().InsertData("韩二十", "13134567890", "")
    // rdb.getInstance().InsertData("杨二十一", "13245678901", "")
    // rdb.getInstance().InsertData("朱二十二", "13356789012", "")
    // rdb.getInstance().InsertData("秦二十三", "13467890123", "")
    // rdb.getInstance().InsertData("尤二十四", "13578901234", "")
    // rdb.getInstance().InsertData("许二十五", "13689012345", "")
    // rdb.getInstance().InsertData("何二十六", "13790123456", "")
    // rdb.getInstance().InsertData("吕二十七", "13801234567", "")
    // rdb.getInstance().InsertData("施二十八", "13912345678", "")
    // rdb.getInstance().InsertData("张二十九", "13023456789", "")
    // rdb.getInstance().InsertData("孔三十", "13134567890", "")
    // rdb.getInstance().InsertData("曹三十一", "13245678901", "")
    // rdb.getInstance().InsertData("严三十二", "13356789012", "")
    // rdb.getInstance().InsertData("华三十三", "13467890123", "")
    // rdb.getInstance().InsertData("金三十四", "13578901234", "")
    // rdb.getInstance().InsertData("魏三十五", "13689012345", "")
    // rdb.getInstance().InsertData("陶三十六", "13790123456", "")
    // rdb.getInstance().InsertData("姜三十七", "13801234567", "")
    // rdb.getInstance().InsertData("赵三十八", "13912345678", "")
    // rdb.getInstance().InsertData("钱三十九", "13023456789", "")
    // rdb.getInstance().InsertData("孙四十", "13134567890", "")
    // rdb.getInstance().InsertData("李四十一", "13245678901", "")
    // rdb.getInstance().InsertData("周四十二", "13356789012", "")
    // rdb.getInstance().InsertData("吴四十三", "13467890123", "")
    // rdb.getInstance().InsertData("郑四十四", "13578901234", "")
    // rdb.getInstance().InsertData("王四十五", "13689012345", "")
    // rdb.getInstance().InsertData("冯四十六", "13790123456", "")
    // rdb.getInstance().InsertData("陈四十七", "13801234567", "")
    // rdb.getInstance().InsertData("褚四十八", "13912345678", "")
    // rdb.getInstance().InsertData("卫四十九", "13023456789", "")
    // rdb.getInstance().InsertData("蒋五十", "13134567890", "")
    // rdb.getInstance().InsertData("沈五十一", "13245678901", "")
    // rdb.getInstance().InsertData("韩五十二", "13356789012", "")
    // rdb.getInstance().InsertData("杨五十三", "13467890123", "")
    // rdb.getInstance().InsertData("朱五十四", "13578901234", "")
    // rdb.getInstance().InsertData("秦五十五", "13689012345", "")
    // rdb.getInstance().InsertData("尤五十六", "13790123456", "")
    // rdb.getInstance().InsertData("许五十七", "13801234567", "")
    // rdb.getInstance().InsertData("何五十八", "13912345678", "")
    // rdb.getInstance().InsertData("吕五十九", "13023456789", "")
    // rdb.getInstance().InsertData("施六十", "13134567890", "")
    // rdb.getInstance().InsertData("张六十一", "13245678901", "")
    // rdb.getInstance().InsertData("孔六十二", "13356789012", "")
    // rdb.getInstance().InsertData("曹六十三", "13467890123", "")
    // rdb.getInstance().InsertData("严六十四", "13578901234", "")
    // rdb.getInstance().InsertData("华六十五", "13689012345", "")
    // rdb.getInstance().InsertData("金六十六", "13790123456", "")
    // rdb.getInstance().InsertData("魏六十七", "13801234567", "")
    // rdb.getInstance().InsertData("陶六十八", "13912345678", "")
    // rdb.getInstance().InsertData("姜六十九", "13023456789", "")
    // rdb.getInstance().InsertData("卢七十", "13134567890", "")
    // rdb.getInstance().InsertData("本伟七十一", "13245678901", "")
    // rdb.getInstance().InsertData("钱七十二", "13356789012", "")
    // rdb.getInstance().InsertData("孙七十三", "13467890123", "")
    // rdb.getInstance().InsertData("李七十四", "13578901234", "")
    // rdb.getInstance().InsertData("周七十五", "13689012345", "")
    // rdb.getInstance().InsertData("吴七十六", "13790123456", "")
    // rdb.getInstance().InsertData("郑七十七", "13801234567", "")
    // rdb.getInstance().InsertData("王七十八", "13912345678", "")
    // rdb.getInstance().InsertData("冯七十九", "13023456789", "")
    // rdb.getInstance().InsertData("陈八十", "13134567890", "")

  }

  build() {
    Column() {
      Text('通讯录').width('100%').padding({ left: 16, top: 20, bottom: 10}).fontSize(20).fontWeight(500)
      RelativeContainer() {
        Stack({ alignContent: Alignment.End }) {
          Column() {
            List({ scroller: this.listScroller }) {
              ListItem(){
                Search({placeholder: "请输入搜索内容"})
                  .padding({left:5, right:5})
                  .onChange((result) => {
                    this.Search_Content = result
                  })
                  .onSubmit(() => {
                      rdb.getInstance().queryData(this.Search_Content).then((result) => {
                        for(let i = 0; i < this.ListCt.totalCount(); i++){
                          if(this.ListCt.getData(i).data.id == result){
                            this.listScroller.scrollToIndex(i)
                          }
                        }
                      })
                  })
              }
              LazyForEach(this.ListCt,(item: Contacts, index: number) => {
                ListItem() {
                  Column(){
                    if (index == 0 || item.index != this.ListCt.getData(index - 1).index) {
                      Text(item.index)
                        .width('100%')
                        .fontColor('#333333')
                        .fontSize(14)
                        .backgroundColor("#EAEAEA")
                        .padding({ top: 10, bottom: 10, left: 15 })
                    }

                  Scroll(item.Scroller) {
                    Row() {
                      Column() {
                        Row({ space: 10 }) {
                          Column() {
                            Text(item.data.name.substring(0, 1))
                              .width(44)
                              .height(44)
                              .borderRadius(22)
                              .fontColor('#ffffff')
                              .backgroundColor(colors[Math.floor(Math.random() * colors.length)])
                              .textAlign(TextAlign.Center)
                              .fontSize(20)
                              .fontWeight(600)
                          }
                          .padding({ left: 10 })

                          Column() {
                            Text(item.data.name)
                            Text(item.data.mobile).fontColor('#999999').fontSize(14).margin({ top: 6 })

                          }
                          .alignItems(HorizontalAlign.Start)
                        }
                        .padding({ top: 10 })
                        .width('100%')

                      }
                      .onClick(() => {
                        router.replaceUrl({
                          url: "pages/detailPage",
                          params: {
                            name: item.data.name,
                            mobile: item.data.mobile,
                            id: item.data.id
                          }
                        })
                      })
                      .width("100%")

                      Button() {
                        Text('编辑')
                      }
                      .onClick(() => {
                        router.replaceUrl({
                          url: "pages/EditPage",
                          params: {
                            name: item.data.name,
                            mobile: item.data.mobile,
                            id: item.data.id
                          }
                        })
                          .catch((err: BusinessError) => {
                            console.error(`pushUrl failed, code is ${err.code}, message is ${err.message}`);
                          })
                      })
                      .type(ButtonType.Normal)
                      .width(this.barWidth)
                      .height(65)
                      .fontColor("#FFFFFF")
                      .backgroundColor("#e9ffb129")

                    }

                  }
                    .scrollBar(BarState.Off)
                    .scrollable(ScrollDirection.Horizontal)
                  .onTouch((event: TouchEvent) => { // 触摸事件
                    // 判断是否有打开删除组件，有则关闭
                    if (item.Scroller != null && this.openBarData != item) {
                      this.openBarData?.Scroller.scrollTo({ xOffset: 0, yOffset: 0,
                        animation: { duration: 100, curve: Curve.Linear } })
                    }

                    // 根据触摸类型判断
                    switch (event.type) {
                      case TouchType.Down: // 触摸按下
                        // 记录按下的x轴坐标
                        this.downX = event.touches[0].x
                        break
                      case TouchType.Up: // 触摸抬起
                        // 触摸抬起，根据x轴总偏移量，判断是否打开
                        let xOffset = event.touches[0].x - this.downX
                        // 防止消费点击事件
                        if (xOffset == 0) {
                          return
                        }
                        // 滑到x轴的位置
                        let toxOffset = 0
                        // 开启删除的对象置为null
                        this.openBarData = undefined;
                        // 偏移量超过删除按钮一半且左滑，设置打开
                        if (Math.abs(xOffset) > vp2px(this.barWidth) / 4 && xOffset < 0) {
                          // 删除布局宽度
                          toxOffset = vp2px(this.barWidth)
                          this.openBarData = item
                        }
                        // 滑动指定位置，设置动画
                        item.Scroller.scrollTo({
                          xOffset: toxOffset, yOffset: 0,
                          animation: { duration: 300, curve: Curve.Linear }
                        })
                        // 重置按下的x轴坐标
                        this.downX = 0
                        break
                    }
                     })
                    Blank()
                      .backgroundColor('#f5f5f5')
                      .height(index + 1 < this.ListCt.totalCount() &&
                        item.index == this.ListCt.getData(index + 1).index ? 1 : 0)
                      .margin(5)
                }
              }
              })
            }


          }

          AlphabetIndexer({ arrayValue: this.letters, selected: 0 })
            .color(Color.Black)
            .selectedColor(0xFFFFFF)
            .popupColor(0xFFFAF0)
            .selectedBackgroundColor('rgb(1,196,194)')
            .popupBackground(0xD2B48C)
            .usingPopup(true)
            .selectedFont({ size: 13, weight: FontWeight.Bolder })
            .popupFont({ size: 30, weight: FontWeight.Bolder })
            .itemSize(25)
            .alignStyle(IndexerAlign.Left)// 弹出框在索引条左侧弹出
            .onSelect((index: number) => {
              console.info(this.letters[index] + ' Selected!', index)
              for (let i = 0 ; i < this.ListCt.totalCount(); i++){
                if (this.ListCt.getData(i).index == this.letters[index]){
                  this.listScroller.scrollToIndex(i)//滚动到索引位置
                  break ;
                }
              }
            })
            .onPopupSelect((index: number) => {
              console.info('onPopupSelected:' + index)
            })
            .selected(this.selectedIndex)
        }

          Image($r('app.media.img_add'))
            .width(58)
            .fillColor('#44bf02')
            .alignRules({
              bottom: { anchor: '__container__', align: VerticalAlign.Bottom },
              right: { anchor: '__container__', align: HorizontalAlign.End }
            })
            .margin({ right: 30, bottom: 60 })
            .onClick(() => {
              router.replaceUrl({
                url: "pages/CreatePage"
              })
                .catch((err: BusinessError) => {
                console.error(`pushUrl failed, code is ${err.code}, message is ${err.message}`);
              })
            })

      }

    }
  }
}

