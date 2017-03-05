//
//  FMKGLKView.h
//  FMMapKit
//
//  Created by FengMap on 15/6/25.
//  Copyright (c) 2015年 FengMap. All rights reserved.
//

#import <GLKit/GLKit.h>
#import "FMKGeometry.h"

//node
@class FMKNode;
@class FMKModel;
@class FMKFacility;
@class FMKImageMarker;

@class FMKMap;

@class FMKAnimatorEnableController;
@class FMKMapGestureEnableController;


/**
 地图透视模式

 - FMKMAPVIEW_PERSPECTIVE: 地图默认显示模式，3D模式
 - FMKMAPVIEW_ORTHO: 2D模式
 */
typedef NS_ENUM(NSInteger, FMKProjectionMode)
{
    
    FMKMAPVIEW_PERSPECTIVE = 0,
    
    FMKMAPVIEW_ORTHO
};

/**
 *  定义地图中绘制元素的Z值的枚举类型。在地图坐标转屏幕坐标时，需要使用这里面的值。
 */
typedef NS_ENUM(NSInteger, FMKMapCoordZType){
    /**
     *  POI对应的Z值
     */
    FMKMAPCOORDZ_POI = 0,
    /**
     *  标注物在模型上时的Z值
     */
    FMKMAPCOORDZ_POINTIMAGE_MODEL,
    /**
     *  标注物在地面上时的Z值
     */
    FMKMAPCOORDZ_POINTIMAGE_EXTENT,
    /**
     *  公共实施在地面上时的Z值
     */
    FMKMAPCOORDZ_FACILITY,
    /**
     *  模型的Z值
     */
    FMKMAPCOORDZ_MODEL,
    /**
     *  地面的Z值
     */
    FMKMAPCOORDZ_EXTENT,
    /**
     *  线标注物的Z值
     */
    FMKMAPCOORDZ_LINE,
    /**
     *  定位标注物的Z值
     */
    FMKMAPCOORDZ_LOCATION
};

@protocol FMKMapViewDelegate;

/**
 * @brief 地图View
 */
@interface FMKMapView : GLKView

/**
 通过ID初始化地图视图

 @param frame frame
 @param mapID 地图ID
 @param target 地图代理
 @param autoUpgrade 是否自动更新地图数据
					若开启自动更新，则地图在加载过程中会自动加载服务器最新数据
					自动更新也受- (BOOL)fmapHaveNewVersion:回调方法影响
 @return mapView
 */
- (instancetype)initWithFrame:(CGRect)frame
						   ID:(NSString *)mapID
					 delegate:(id<FMKMapViewDelegate>)target
				  autoUpgrade:(BOOL)autoUpgrade;


/**
 *  初始化地图,通过保存在本地的地图数据加载
 *
 *  @param frame    frame
 *  @param dataPath 地图数据存储位置
 *  @param target   地图代理
 */
- (instancetype)initWithFrame:(CGRect)frame
						 path:(NSString *)dataPath
                     delegate:(id<FMKMapViewDelegate>)target;

/**
 *  地图代理
 */
@property (nonatomic,weak) id<FMKMapViewDelegate> mapDelegate;



/**
 通过地图ID切换地图

 该方法会请求并加载新的地图数据，在加载过程中触发相应的回调方法
 地图数据的自动更新受mapView初始化时的autoUpgrade参数和地图数据更新信息回调方法影响
 
 若对应地图不存在，该方法直接下载并加载最新地图数据
 
 @param mapID 地图ID
 */
- (void)transformMapWithID:(NSString *)mapID;

/**
 *  通过地图数据路径切换地图
 *
 *  @param dataPath 地图数据存储路径
 */
- (void)transformMapWithDataPath:(NSString *)dataPath;

/**
 *  当前加载的地图节点
 *  地图节点用于管理层节点等子项
 *  通过该节点可以进行子节点管理
 *  该节点为只读对象，不支持创建
 */
@property (nonatomic, readonly) FMKMap* map;

/**
  是否显示指北针
 */
@property (nonatomic, assign) BOOL showCompass;

/**
 在地图上显示缩放控制控件

 @param offset 偏移位置
 @param show 是否显示
 @param enableSelected 是否允许点击
 */
- (void)showZoomControlWithOffset:(CGPoint)offset
					   enableShow:(BOOL)show
					enableSeleted:(BOOL)enableSelected;

/**
 在地图上显示楼层选择控件

 @param offset 偏移位置
 @param show 是否显示
 @param enableSelected 是否允许点击
 */
- (void)showDisplayGroupViewWithOffset:(CGPoint)offset
							enableShow:(BOOL)show
						 enableSeleted:(BOOL)enableSelected;

/**
 在地图上显示楼层选择控件

 @param offset 偏移位置
 @param show 是否显示
 @param enableSelected 是否允许点击
 */
- (void)showDisplayFloorViewWithOffset:(CGPoint)offset
							enableShow:(BOOL)show
						 enableSeleted:(BOOL)enableSelected;

/**
 在地图上显示3D控件

 @param offset 偏移位置
 @param show 是否显示
 @param enableSelected 是否允许点击
 */
- (void)showEnable3DControlWithOffset:(CGPoint)offset
						   enableShow:(BOOL)show
						enableSeleted:(BOOL)enableSelected;

/**
 在地图上显示单层/多层控件

 @param offset 偏移位置
 @param show 是否显示
 @param enableSelected 是否允许点击
 */
- (void)showSingleGroupOrMultiGroupsControlWithOffset:(CGPoint)offset
										   enableShow:(BOOL)show
										enableSeleted:(BOOL)enableSelected;

/**
 *  显示楼层id的数组
 */
@property (nonatomic, strong) NSArray <NSString *>* displayGroupIDs;

/**
 *  地图当前使用的主题路径
 */
@property (nonatomic, readonly) NSString * currentThemePath;

/**
 *  设置焦点层
 *	
 *	在多楼层情况下，设置焦点层，焦点层透明度设置为当前主题中配置的楼层透明度
 *	非焦点层为半透明状态
 *
 *  @param groupID  焦点层ID
 *  @param animated 在切换焦点层过程中是否使用动效
 */
- (void)setFocusByGroupID:(NSString *)groupID animated:(BOOL)animated;

/**
 *  获取焦点层ID
 *
 *  @return 焦点层楼层ID
 */
- (NSString *)getFocusGroupID;

/**
 *  设置当前地图显示楼层的alpha
 *
 *  @param alphas 楼层alpha，楼层透明度数组与当前显示楼层做匹配
 *	若透明度数组count小于当前显示楼层数，其他显示楼层透明度默认设置为1.0
 */
- (void)setGroupsAlpha:(NSArray <NSNumber*>*)alphas;

/**
 *  取消地图焦点
 */
- (void)cancelFocusFloor;

/**
 *  通过主题ID设置主题
 *
 *  @param themeID 主题ID，请从蜂鸟开发者网站获取
 */
- (void)setThemeWithID:(NSString *)themeID;

/**
 *  设置地图主题
 *
 *  @param path 地图主题数据路径
 */
- (void)setThemeWithLocalPath:(NSString *)path;

/**
 *  是否3D显示
 */
@property (nonatomic,assign) BOOL enable3D;

///设置地图背景色
@property (nonatomic,copy) UIColor* backgroundColor;

///地图地图透视模式 即2D/3D模式
@property (nonatomic,assign) FMKProjectionMode mode;

///地图手势控制器 所有手势开关默认开启
@property (nonatomic,strong) FMKMapGestureEnableController * gestureEnableController;

/**
 *  移动地图
 *
 *  @param startPoint 起点坐标 屏幕坐标
 *  @param endPoint   终点坐标 屏幕坐标
 */
- (void)moveFromStart:(CGPoint)startPoint toEnd:(CGPoint)endPoint;

/**
 将某个地图坐标点移动到屏幕中央

 @param mapPoint 目标点
 @param animated 动效开关
 */
- (void)moveToViewCenterFromMapPoint:(FMKMapPoint)mapPoint animated:(BOOL)animated;

/**
 获取地图视图的中心点

 @return fengmap地图中心点坐标
 */
- (FMKMapPoint)getMapViewCenter;

/**
 *  屏幕坐标转换为地理坐标
 *
 *  @param point 屏幕点坐标
 *
 *  @return 蜂鸟地理坐标，包含楼层ID和地理坐标值
 */
- (FMKGeoCoord)coverPoint:(CGPoint)point;

/**
 *  地理坐标转换为屏幕坐标
 *
 *  @param coord 蜂鸟地图坐标
 *  @param type  该参数为转换坐标时的Z值，Z值影响坐标转化后的y坐标值
 *
 *  @return 返回屏幕点坐标
 */
- (CGPoint)coverCoord:(FMKGeoCoord)coord zType:(FMKMapCoordZType)type;

/**
 * 设置标注图片资源路径，默认为空;
 * 自定义图片存放目录；若设置了该路径，刚添加的图片标注会引用该路径下的资源
 * 若不设置图片将从mainBundle中读取；
 *  @param path 路径
 */
- (void)setImageMarkerResourcePath:(NSString *)path;

/**
 *  更新地图
 */
- (void)updateMap;

/**
 *  清除地图
 */
- (void)clearMapView;

@end

/**
 *  地图的协议方法
 */
@protocol FMKMapViewDelegate <NSObject>

@optional

/*!
 @brief 当地图将要加载
 @param mapView 地图View对象
 */
- (void)mapViewWillStartLoadingMap:(FMKMapView *)mapView;

/*!
 @brief 地图加载完成
 @param mapView 地图View对象
 */
- (void)mapViewDidFinishLoadingMap:(FMKMapView *)mapView;


/*!
 @brief 地图加载失败
 @param mapView 地图View
 @param error 错误信息
 */
- (void)mapViewDidFailLoadingMap:(FMKMapView *)mapView withError:(NSError *)error;

/**
 *  地图更新时
 *
 *  @param mapView mapView
 */
- (void)mapViewDidUpdate:(FMKMapView *)mapView;

#pragma gesture

/**
 *  当单击地图时
 *
 *  @param mapView mapView
 *  @param point   单击点
 */
- (void)mapView:(FMKMapView *)mapView didSingleTapWithPoint:(CGPoint)point;

/**
 *  当双击地图时
 *
 *  @param mapView mapView
 */
- (void)mapView:(FMKMapView *)mapView didDoubleTapWithPoint:(CGPoint)point;

/**
 *  长按地图时
 *
 *  @param mapView mapView
 */
- (void)mapView:(FMKMapView *)mapView didLongPressWithPoint:(CGPoint)point;

/**
 *  当移动地图时
 *
 *  @param mapView mapView
 */
- (void)mapView:(FMKMapView *)mapView didMovedWithPoint:(CGPoint)point;

/**
 *  手势将要触摸屏幕时 识别单击 双击  长按手势
 *
 *  @param tapGestureRecognize 手势
 *  @param mapView             获取手势的mapView
 *
 *  @return 返回YES，地图元素的拾取事件和地图单击事件都会触发;返回NO,优先触发拾取事件
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)tapGestureRecognize shouldTouchMapView:(FMKMapView *)mapView;

#pragma mapData upgrade
/**
 通过地图ID加载地图数据会调用该回调方法，表示是否有新的地图数据版本

 @param haveNewVersion 是否有新的地图数据版本
 @param mapID 地图ID
 @param newVersion 新的地图数据版本号 若无新地图数据，返回旧数据版本号
 @return YES，加载新版本地图数据  NO，加载旧版本地图数据
 */
- (BOOL)fmapHaveNewVersion:(BOOL)haveNewVersion withMapID:(NSString *)mapID newVersion:(NSString *)newVersion;

#pragma control

/**
 缩放组件功能触发

 @param currentZoomLevel 当前地图缩放级别
 */
- (void)zoomInOrZoomOutWithCurrentZoomLevel:(int)currentZoomLevel;

/**
 3D组件功能触发

 @param enable3D 是否允许地图3D显示
 */
- (void)enable3DIsSelected:(BOOL)enable3D;

/**
 楼层选择控件功能触发

 @param focusGroupID 焦点层ID
 @param displayGroupIDs 当前显示的楼层组
 @param enableSingleDisplayGroup 是否是单层显示状态
 */
- (void)currentFocusGroupID:(NSString *)focusGroupID
			displayGroupIDs:(NSArray *)displayGroupIDs
   enableSingleDisplayGroup:(BOOL)enableSingleDisplayGroup;

@end

