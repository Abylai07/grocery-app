package kz.abricoz.market.abricoz_app

import android.app.Application

import com.yandex.mapkit.MapKitFactory

class MainApplication: Application() {
    override fun onCreate() {
        super.onCreate()
        MapKitFactory.setApiKey("63c43aa7-7459-47a2-bdb4-fd1f86ad0255")
    }
}