package admob;

import flash.Lib;

class AD {
	public static var LEFT : Int = 0;
	public static var RIGHT : Int = -1;
	public static var TOP : Int = 0;
	public static var BOTTOM : Int = -1;
	
	public static var BANNER : Int = 0;
	public static var SMART_BANNER_PORTRAIT : Int = 1;
	public static var SMART_BANNER_LANDSCAPE : Int = 2;
	
	private static var admobID : String;
	private static var originX : Int = 0;
	private static var originY : Int = 0;
	private static var bannerSize : Int = 0;
	private static var testMode : Bool = false;
	
	#if android
	private static var _initAd_func : Dynamic;
	private static var _hideAd_func : Dynamic;
	private static var _showAd_func : Dynamic;
	
	public static function init(id : String, x : Int = 0, y : Int = 0, size : Int = 0, test : Bool = false) {
		admobID = id;
		originX = x;
		originY = y;
		bannerSize = size;
		testMode = test;
		
		// on android screen aspect doesn't matter
		if (bannerSize == SMART_BANNER_LANDSCAPE) bannerSize = SMART_BANNER_PORTRAIT;
		
		// call API
		if (_initAd_func == null) {
			_initAd_func = openfl.utils.JNI.createStaticMethod("org.haxe.lime.GameActivity", "initAd",
				"(Ljava/lang/String;IIIZ)V", true);
		}

		var args = new Array<Dynamic>();
		args.push(admobID);
		args.push(originX);
		args.push(originY);
		args.push(bannerSize);
		args.push(testMode);
		_initAd_func(args);
	}
	
	public static function show() : Void {
		if (_showAd_func == null) {
			_showAd_func = openfl.utils.JNI.createStaticMethod("org.haxe.lime.GameActivity", "showAd", "()V", true);
		}
		
		_showAd_func(new Array<Dynamic>());
	}
	
	public static function hide() : Void {
		if (_hideAd_func == null) {
			_hideAd_func = openfl.utils.JNI.createStaticMethod("org.haxe.lime.GameActivity", "hideAd", "()V", true);
		}
		
		_hideAd_func(new Array<Dynamic>());
	}

	public static function refresh() : Void {
	}
	
	#elseif ios
	public static function init(id : String, x : Int = 0, y : Int = 0, size : Int = 0, test : Bool = false) {
		admobID = id;
		originX = x;
		originY = y;
		bannerSize = size;
		testMode = test;
		
		admob_ad_init(admobID, originX, originY, bannerSize, testMode);
	}
	
	public static function show() : Void {
		admob_ad_show();
	}
	
	public static function hide() : Void {
		admob_ad_hide();
	}
	
	public static function refresh() : Void {
		admob_ad_refresh();
	}
	
	private static var admob_ad_init = flash.Lib.load("admob", "admob_ad_init", 5);
	private static var admob_ad_show = flash.Lib.load("admob", "admob_ad_show", 0);
	private static var admob_ad_hide = flash.Lib.load("admob", "admob_ad_hide", 0);
	private static var admob_ad_refresh = flash.Lib.load("admob", "admob_ad_refresh", 0);
	
	#else
	public static function init(id : String, x : Int = 0, y : Int = 0, size : Int = 0, test : Bool = false) {
	}
	public static function show() : Void {
	}
	public static function hide() : Void {
	}
	public static function refresh() : Void {
	}
	#end
}
