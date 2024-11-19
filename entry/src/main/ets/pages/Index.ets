import { BusinessError, Callback } from '@kit.BasicServicesKit'
import { Contacts, ListMember, ListMemberDataSource } from "../DataModel/DataInfo"
import { router } from '@kit.ArkUI'
import rs from '@ohos.data.relationalStore'
import rdb from './UserDBUtils'
const colors: Array<string> = ['#ff6161', '#ffb120', '#7484fc', '#00cee5']
@Entry
@Component
struct Index {
  @State ListCt: ListMemberDataSource = new ListMemberDataSource()
  @State letters: string[] = ['※', 'A','B','C','D','E','F','H','I','G','K','L','M','N', 'O','P','Q','R','S','T','U','V','W','X','Y','Z','#']
  private listScroller: Scroller = new Scroller();
  @State selectedIndex: number = 0;

onPageShow(){
    setTimeout(() => {
      console.error('--------------', `aboutToAppear 2000 `)
      this.ListCt.SetArr(rdb.getInstance().RequestData())
    }, 2000)
  }

  build() {
    Column() {
      Text('通讯录').width('100%').padding({ left: 16, top: 20, bottom: 10}).fontSize(20).fontWeight(500)
      RelativeContainer() {
        Stack({ alignContent: Alignment.End }) {
          Column() {
            List({ scroller: this.listScroller }) {
              LazyForEach(this.ListCt, (item: Contacts, index: number) => {
                ListItem() {

                    Column() {

                      // if (index == 0 || item.index != item.index){
                      //   Text(item.index).width('100%').fontColor('#333333').fontSize(14).backgroundColor("#EAEAEA").padding({
                      //     top:5,bottom:5,left:15
                      //   })
                      // }

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
                      .width('100%')

                      Blank().backgroundColor('#f5f5f5').height(1).margin(10)
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
              router.pushUrl({
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

