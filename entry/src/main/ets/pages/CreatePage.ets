import { promptAction, router } from '@kit.ArkUI';
import { relationalStore } from '@kit.ArkData';
import { BusinessError } from '@kit.BasicServicesKit';
import rdb from "../pages/UserDBUtils";
import picker from '@ohos.file.photoAccessHelper'
const colors: Array<string> = ['#ff6161', '#ffb120', '#7484fc', '#00cee5']

const photoViewPicker = new picker.PhotoViewPicker
const photoSelectOptions = new picker.PhotoSelectOptions()
function getRandomColor():string {
  const randomIndex = Math.floor(Math.random() * colors.length);
  return colors[randomIndex];
}

@Entry
@Component
struct CreateContactsPage {
  @State input_name: string = ''
  @State input_mobile: string = ''
  @State uri: string[] = [];
  @State get_params: object | undefined = undefined
  @State now_id: number = 0
  @State now_img: string = ""
  build() {

    Column() {
      Row() {
        Image($r('app.media.img_back')).width(24)
        Text('新建联系人')
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
          Image(this.now_img? this.now_img :$r("app.media.Default_icon"))
            .width(100)
            .height(100)
            .borderRadius(11111)
            .onClick(() => {
              photoSelectOptions.MIMEType = picker.PhotoViewMIMETypes.IMAGE_TYPE;
              photoSelectOptions.maxSelectNumber = 1;
              photoViewPicker.select(photoSelectOptions)
                .then((photoSelectResult) => {
                  this.uri = photoSelectResult.photoUris; // select返回的uri权限是只读权限，需要将uri写入全局变量@State中即可根据结果集中的uri进行读取文件数据操作。
                  this.now_img = this.uri[0]
                })
                .catch((err: BusinessError) => {
                  console.info('Invoke photoViewPicker.select failed, code is ${err.code},message is ${err.message}');
                })
            })

        Blank()
          .height("2%")

        TextInput({ placeholder: '请输入联系人姓名'})
          .copyOption(CopyOptions.LocalDevice)
          .onChange((value) => {
            this.input_name = value
          })

        TextInput({ placeholder: '请输入手机号' })
          .type(InputType.PhoneNumber)
          .margin({ top: 10 })
          .onChange((value) => {
            this.input_mobile = value
          })

        Button('新建联系人')
          .width('100%')
          .margin({ top: 30 })
          .onClick(() => {
            if (this.input_name == '' || this.input_mobile == '') {
              promptAction.showToast({
                message: '联系人姓名或手机号不能为空'
              })

              return
            }

            if (rdb.getInstance()!== undefined) {
              rdb.getInstance().InsertData(this.input_name, this.input_mobile, this.now_img? this.now_img : "")
                promptAction.showToast({
                  message: '创建成功'
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

      }.alignItems(HorizontalAlign.Center)
      .width('100%')
      .padding(20)
      .margin({ top: 50 })

    }
    .height('100%')
    .width('100%')
  }
}
