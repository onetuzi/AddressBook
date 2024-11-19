import { promptAction, router } from '@kit.ArkUI';
import rdb from "../pages/UserDBUtils";
const colors: Array<string> = ['#ff6161', '#ffb120', '#7484fc', '#00cee5']

function getRandomColor():string {
  const randomIndex = Math.floor(Math.random() * colors.length);
  return colors[randomIndex];
}

@Entry
@Component
struct CreateContactsPage {
  @State get_params: object | undefined = undefined
  @State input_name: string = ""
  @State input_mobile: string = ""
  @State now_id: number = 0
  aboutToAppear(): void {
    this.get_params = router.getParams()
    const name: string = this.get_params['name'];
    this.input_name = name
    const mobile: string = this.get_params['mobile'];
    this.input_mobile = mobile
    const id: number = this.get_params['id'];
    this.now_id = id
    console.log(`det.Received parameters: id = ${name}, age = ${mobile}`);
  }

  build() {

    Column() {
      Row() {
        Image($r('app.media.img_back')).width(24)
        Text('查看联系人')
          .padding({ left: 16 })
          .fontSize(18)
          .fontWeight(500)
      }
      .width('100%')
      .padding({ left: 16 })
      .onClick(() => {
        router.pushUrl({
          url: 'pages/Index'
        })
      })


      Column() {
        Text(this.input_name.substring(0, 1))
          .width(100)
          .height(100)
          .borderRadius(11111)
          .fontColor('#ffffff')
          .backgroundColor(colors[Math.floor(Math.random() * colors.length)])
          .textAlign(TextAlign.Center)
          .fontSize(50)
          .fontWeight(600)

        Text(this.input_name)
          .fontSize(30)
          .padding({top: 20})

        Text(this.input_mobile)
          .fontSize(20)

        Button('编辑联系人')
          .width('100%')
          .fontColor("#FFFFFF")
          .margin({ top: 30 })
          .onClick(() => {
            router.replaceUrl({
              url: "pages/EditPage",
              params: {
                name: this.input_name,
                mobile: this.input_mobile,
                id: this.now_id
              }
            })
          })

        Button('删除联系人')
          .width('100%')
          .margin({ top: 10 })
          .backgroundColor("#ffd03f3f")
          .fontColor("#FFFFFF")
          .onClick(() => {

            if (rdb.getInstance()!== undefined) {
              rdb.getInstance().DeleteData(this.now_id as number)
              promptAction.showToast({
                message: '删除成功'
              })
              router.replaceUrl({
                url: 'pages/Index',
                params: {
                  result_code: 200
                }
              })
            } else {
              console.error('------------', `Failed store is undefined`);
            }

          })

      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .padding(20)
      .margin({ top: 50 })

    }
    .height('100%')
    .width('100%')
  }
}
