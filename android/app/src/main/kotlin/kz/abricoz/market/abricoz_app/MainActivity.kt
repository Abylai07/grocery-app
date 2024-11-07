package kz.abricoz.market.abricoz_app

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import com.yandex.mapkit.MapKitFactory

class MainActivity : FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        MapKitFactory.setApiKey("63c43aa7-7459-47a2-bdb4-fd1f86ad0255")
        super.onCreate(savedInstanceState)
    }
}