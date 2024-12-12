/*
 * SPDX-FileCopyrightText: 2024 The LineageOS Project
 * SPDX-License-Identifier: Apache-2.0
 */

package org.lineageos.settings.device;

import android.content.Context;
import android.os.Bundle;
import android.util.Log;

import androidx.preference.PreferenceFragment;
import androidx.preference.Preference;
import androidx.preference.ListPreference;

import org.lineageos.tv.OutputModeManager;

import org.lineageos.internal.util.FileUtils;
import org.lineageos.settings.device.R;

import java.io.File;

public class ColorSpaceSettingsFragment extends PreferenceFragment
        implements Preference.OnPreferenceChangeListener {

    private static final String TAG = ColorSpaceSettingsFragment.class.getSimpleName();
    private static final String KEY_HDMI_COLOR_SPACE = "hdmi_color_space";

    private OutputModeManager mOutputModeManager;

    @Override
    public void onCreatePreferences(Bundle savedInstanceState, String rootKey) {
        addPreferencesFromResource(R.xml.colorspace_settings);

        mOutputModeManager = new OutputModeManager();

        ListPreference hdmiColorSpacePreference = findPreference(KEY_HDMI_COLOR_SPACE);
        if (hdmiColorSpacePreference != null) {
            hdmiColorSpacePreference.setOnPreferenceChangeListener(this);
            updateListPreferenceSummary(hdmiColorSpacePreference);
        }
    }

    @Override
    public boolean onPreferenceChange(Preference preference, Object newValue) {
        if (KEY_HDMI_COLOR_SPACE.equals(preference.getKey())) {
            String colorSpace = (String) newValue;

            mOutputModeManager.setDeepColorAttribute(colorSpace);
            // mOutputModeManager.setOutputMode(getCurrentMode());
            Log.e(TAG, "setDeepColorAttribute: " + colorSpace);
            Log.e(TAG, "setOutputMode: " + getCurrentMode());
        }
        return true;
    }

    private String getCurrentMode(){
         return mOutputModeManager.getCurrentOutputMode();
    }

    private void updateListPreferenceSummary(ListPreference preference) {
        Log.e(TAG, "updateListPreferenceSummary");
        Log.e(TAG, "getCurrentOutputMode: " + mOutputModeManager.getCurrentOutputMode());
        Log.e(TAG, "getCurrentColorAttribute: " + mOutputModeManager.getCurrentColorAttribute());
        CharSequence entry = preference.getEntry();
        if (entry != null) {
            preference.setSummary(entry);
        }
    }
}
