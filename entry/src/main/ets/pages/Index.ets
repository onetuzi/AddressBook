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
  @State letters: string[] = ['A','B','C','D','E','F','H','I','G','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','#']
  @State flag: number = 0
  @State ListArray: Array<ListMember> = []
  private listScroller: Scroller = new Scroller()
  @State selectedIndex: number = 0
  onPageShow(): void {
    setTimeout(() => {
      console.error('--------------', `aboutToAppear 2000 `);
      rdb.getInstance().RequestData().then((result) => {
        this.ListCt.SetArr(result)
      })
    }, 100)
  }

  build() {
    Column() {
      Text('通讯录').width('100%').padding({ left: 16, top: 20, bottom: 10}).fontSize(20).fontWeight(500)
      RelativeContainer() {
        Stack({ alignContent: Alignment.End }) {
          Column() {
            List({ scroller: this.listScroller }) {
              LazyForEach(this.ListCt,(item: Contacts, index: number) => {
                  ListItem() {
                    Scroll() {
                      Row() {
                        Column() {
                          if (index == 0 || item.index != this.ListCt.getData(index - 1).index) {
                            Text(item.index)
                              .width('100%')
                              .fontColor('#333333')
                              .fontSize(14)
                              .backgroundColor("#EAEAEA")
                              .padding({ top: 10, bottom: 10, left: 15 })
                          }

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

                          Blank()
                            .backgroundColor('#f5f5f5')
                            .height(index + 1 < this.ListCt.totalCount() &&
                              item.index == this.ListCt.getData(index + 1).index ? 1 : 0)
                            .margin(5)
                        }
                        Button() {
                          Text('删除')
                        }
                        .width(100).height(65)
                      }
                      .width("100%")
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
              this.listScroller.scrollToIndex(index)
              for (let i = 0 ; i < this.ListCt.totalCount(); i++){
                if (Number(this.ListCt.getData(i).index) == index){
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

