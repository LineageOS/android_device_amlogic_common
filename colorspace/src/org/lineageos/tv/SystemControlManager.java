package org.lineageos.tv;

import android.util.Log;
import android.os.HwBinder;
import android.os.RemoteException;

import java.util.NoSuchElementException;

import vendor.amlogic.hardware.systemcontrol.V1_1.ISystemControl;
import vendor.amlogic.hardware.systemcontrol.V1_0.Result;

public class SystemControlManager {
    private static final String TAG = "SystemControlManager";
    private static final int SYSTEM_CONTROL_DEATH_COOKIE = 1000;

    private final Object mLock = new Object();
    private ISystemControl mProxy = null;

    private SystemControlManager() {
        connectToProxy();
    }

    public static SystemControlManager getInstance() {
        return InstanceHolder.INSTANCE;
    }

    public void setBootenv(String prop, String val) {
        synchronized (mLock) {
            try {
                mProxy.setBootEnv(prop, val);
            } catch (RemoteException e) {
                Log.e(TAG, "setBootenv:" + e);
            }
        }
    }

    public String getActiveDispMode() {
        synchronized (mLock) {
            Mutable<String> resultVal = new Mutable<>();
            try {
                mProxy.getActiveDispMode((int ret, String v) -> {
                                if (Result.OK == ret) {
                                    resultVal.value = v;
                                }
                            });
                return resultVal.value;
            } catch (RemoteException e) {
                Log.e(TAG, "getActiveDispMode:" + e);
            }
        }
        return "";
    }

    public String getDeepColorAttr(String mode) {
        synchronized (mLock) {
            Mutable<String> resultVal = new Mutable<>();
            try {
                mProxy.getDeepColorAttr(mode, (int ret, String v) -> {
                                if (Result.OK == ret) {
                                    resultVal.value = v;
                                }
                            });
                return resultVal.value;
            } catch (RemoteException e) {
                Log.e(TAG, "getDeepColorAttr:" + e);
            }
        }
        return "";
    }

    private void connectToProxy() {
        synchronized (mLock) {
            if (mProxy != null) {
                return;
            }

            try {
                mProxy = ISystemControl.getService();
                mProxy.linkToDeath(new DeathRecipient(), SYSTEM_CONTROL_DEATH_COOKIE);
            } catch (NoSuchElementException e) {
                Log.e(TAG, "connectToProxy: system control service not found."
                        + " Did the service fail to start?", e);
            } catch (RemoteException e) {
                Log.e(TAG, "connectToProxy: system control service not responding", e);
            }
        }
    }

    final class DeathRecipient implements HwBinder.DeathRecipient {
        DeathRecipient() {
        }

        @Override
        public void serviceDied(long cookie) {
            if (SYSTEM_CONTROL_DEATH_COOKIE == cookie) {
                Log.e(TAG, "system control service died cookie: " + cookie);
                synchronized (mLock) {
                    mProxy = null;
                }
            }
        }
    }

    private static class InstanceHolder {
        private static final SystemControlManager INSTANCE = new SystemControlManager();
    }

    private static class Mutable<E> {
        public E value;

        Mutable() {
            value = null;
        }

        Mutable(E value) {
            this.value = value;
        }
    }
}