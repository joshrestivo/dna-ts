package cas_group.com.dnamobile;

import android.content.Context;
import android.content.Intent;
import android.graphics.Typeface;
import android.support.multidex.MultiDex;
import android.support.multidex.MultiDexApplication;



import java.lang.reflect.Field;

import cas_group.com.dnamobile.service.GPSTracker;
import cas_group.com.dnamobile.service.LocationService;


public class DNAApplication extends MultiDexApplication {
    public static Context context;

    public static Context getAppContext() {
        return DNAApplication.context;
    }

    @Override
    public void onCreate() {
        super.onCreate();

        DNAApplication.context = getApplicationContext();
        DNAApplication.overrideFont(getApplicationContext(), "SERIF", "fonts/Muli/Muli.ttf"); // font from assets: "assets/fonts/Roboto-Regular.ttf


    }

    @Override
    protected void attachBaseContext(Context base) {
        super.attachBaseContext(base);
        MultiDex.install(base);
    }

    public static boolean isActivityVisible() {
        return _activityVisible;
    }

    public static void activityResumed() {
        _activityVisible = true;
//        GcmBroadcastReceiver.showBadgeCount(0);
    }

    public static void overrideFont(Context context, String defaultFontNameToOverride, String customFontFileNameInAssets) {
        try {
            final Typeface customFontTypeface = Typeface.createFromAsset(context.getAssets(), customFontFileNameInAssets);

            final Field defaultFontTypefaceField = Typeface.class.getDeclaredField(defaultFontNameToOverride);
            defaultFontTypefaceField.setAccessible(true);
            defaultFontTypefaceField.set(null, customFontTypeface);
        } catch (Exception e) {
        }
    }

    public static void activityPaused() {
        _activityVisible = false;
    }

    private static boolean _activityVisible;
}

