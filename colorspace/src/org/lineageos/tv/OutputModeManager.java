package org.lineageos.tv;

public class OutputModeManager {
    private static final String TAG = "OutputModeManager";
    
    public static final String ENV_COLORATTRIBUTE = "ubootenv.var.colorattribute";
    public static final String ENV_IS_BEST_MODE = "ubootenv.var.is.bestmode";

    private SystemControlManager mSystemControl;

    public OutputModeManager() {
        mSystemControl = SystemControlManager.getInstance();
    }

    public void setDeepColorAttribute(final String colorValue) {
        mSystemControl.setBootenv(ENV_IS_BEST_MODE, "false");
        mSystemControl.setBootenv(ENV_COLORATTRIBUTE, colorValue);
    }

    public String getCurrentOutputMode() {
        return mSystemControl.getActiveDispMode();
    }

    public String getCurrentColorAttribute() {
       String colorValue = mSystemControl.getDeepColorAttr(getCurrentOutputMode());
       return colorValue;
    }
}