package kz.abricoz.market.abricoz_app

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import  androidx.annotation.NonNull
import com.yandex.mapkit.MapKitFactory

class MainActivity : FlutterActivity() {

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        MapKitFactory.setApiKey("63c43aa7-7459-47a2-bdb4-fd1f86ad0255")
        super.configureFlutterEngine(flutterEngine)
    }
}
