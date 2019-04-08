//
//  ViewController.m
//  PickerViewCoverDemo
//
//  Created by l x on 2019/4/2.
//  Copyright © 2019 syn. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) UIImagePickerController *picker;
@property (nonatomic, strong) UIImageView *myPhotoImageView;

@end

@implementation ViewController

- (UIImagePickerController *)picker
{
    if (!_picker) {
        _picker = [[UIImagePickerController alloc]init];
    }
    return _picker;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI {
    self.myPhotoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 670/2, self.view.frame.size.height/2 - 758/2, 670, 758)];
    self.myPhotoImageView.contentMode = UIViewContentModeScaleToFill;
    self.myPhotoImageView.layer.borderWidth = 1;
    self.myPhotoImageView.layer.borderColor = [UIColor lightTextColor].CGColor;
    self.myPhotoImageView.image = [UIImage imageNamed:@"attendance_icon_bg"];
    [self.view addSubview:self.myPhotoImageView];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(self.view.frame.size.width/2 - 50, CGRectGetMinY(self.myPhotoImageView.frame) - 50, 100, 30);
    [button setTitle:@"点击拍照" forState:normal];
    [button setTitleColor:[UIColor redColor] forState:normal];
    button.titleLabel.font = [UIFont systemFontOfSize:18];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];


}

#pragma mark ---- 点击拍照 ----
- (void)buttonClick {
    BOOL isPicker = true;
    //            判断相机是否可用
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        //        _picker.showsCameraControls = NO;//默认是打开的这样才有拍照键，前后摄像头切换的控制，一半设置为NO的时候用于自定义ovelay
        
        UIImage *layImg = [UIImage imageNamed:@"icon_face"];
        
        UIImageView *overLayImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 230/2, self.view.frame.size.height/2 - 340/2, 230, 340)];
        
        overLayImg.image = layImg;
        
        self.picker.cameraOverlayView = overLayImg;//3.0以后可以直接设置
        
        
        isPicker = true;
    }
    
    if (isPicker) {
        [self presentViewController:self.picker animated:YES completion:nil];
    }else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误" message:@"相机不可用" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //    获取图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    ;
    self.myPhotoImageView.image = image;
    
    /*  此处应刷新UI */
    //    获取图片后返回
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//按取消按钮时候的功能
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //    返回
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
