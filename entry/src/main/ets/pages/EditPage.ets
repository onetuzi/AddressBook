import { promptAction, router } from '@kit.ArkUI';
import rdb from "../pages/UserDBUtils";
import picker from '@ohos.file.photoAccessHelper'
import { BusinessError } from '@kit.BasicServicesKit';

const colors: Array<string> = ['#ff6161', '#ffb120', '#7484fc', '#00cee5']

function getRandomColor():string {
  const randomIndex = Math.floor(Math.random() * colors.length);
  return colors[randomIndex];
}
const photoViewPicker = new picker.PhotoViewPicker
const photoSelectOptions = new picker.PhotoSelectOptions()

@Entry
@Component
struct CreateContactsPage {
  @State uri: string[] = [];
  @State get_params: object | undefined = undefined
  @State input_name: string = ""
  @State input_mobile: string = ""
  @State now_id: number = 0
  @State now_img: string = ""
  aboutToAppear(): void {
    this.get_params = router.getParams()
    const name: string = this.get_params['name'];
    this.input_name = name
    const mobile: string = this.get_params['mobile'];
    this.input_mobile = mobile
    const id: number = this.get_params['id'];
    this.now_id = id
    const img: string = this.get_params['img'];
    this.now_img = img
    console.log(`Received parameters: id = ${name}, age = ${mobile}`);
  }

  build() {

    Column() {
      Row() {
        Image($r('app.media.img_back')).width(24)
        Text('编辑联系人')
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


      Column({space: 10}) {
        if(this.now_img != ""){
          Image(this.now_img)
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
        }else{
          Text(this.input_name.substring(0, 1))
            .width(100)
            .height(100)
            .borderRadius(11111)
            .fontColor('#ffffff')
            .backgroundColor(colors[Math.floor(Math.random() * colors.length)])
            .textAlign(TextAlign.Center)
            .fontSize(50)
            .fontWeight(600)
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
        }


        Blank()

        TextInput({ placeholder: this.input_name})
          .copyOption(CopyOptions.LocalDevice)
          .onChange((value) => {
            this.input_name = value
          })

        TextInput({ placeholder: this.input_mobile })
          .type(InputType.PhoneNumber)
          .margin({ top: 10 })
          .onChange((value) => {
            this.input_mobile = value
          })

        Button('修改联系人')
          .width('100%')
          .fontColor("#FFFFFF")
          .margin({ top: 30 })
          .onClick(() => {
            if (this.input_name == '' || this.input_mobile == '') {
              promptAction.showToast({
                message: '联系人姓名或手机号不能为空'
              })

              return
            }

            if (rdb.getInstance()!== undefined) {
              rdb.getInstance().UpdateData(this.input_name, this.input_mobile, this.uri[0]? this.uri[0]: "", this.now_id)
                promptAction.showToast({
                  message: '修改成功'
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

      }.alignItems(HorizontalAlign.Center)
      .width('100%')
      .padding(20)
      .margin({ top: 50 })

    }
    .height('100%')
    .width('100%')
  }
}
