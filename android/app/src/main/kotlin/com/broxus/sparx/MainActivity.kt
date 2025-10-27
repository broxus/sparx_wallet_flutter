package com.broxus.sparx.app

import android.os.Bundle
import io.flutter.embedding.android.FlutterFragmentActivity

class MainActivity: FlutterFragmentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        try {
            window.decorView.filterTouchesWhenObscured = true
        } catch (e: Exception) {}
    }
}
