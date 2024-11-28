package com.example.deviceapidemo

import android.Manifest
import android.app.Application
import android.content.Context
import android.content.pm.PackageManager
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import android.location.Location
import android.location.LocationListener
import android.location.LocationManager
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.activity.result.contract.ActivityResultContracts
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
import com.example.deviceapidemo.ui.theme.DeviceApiDemoTheme
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Button
import androidx.compose.material3.Text
import androidx.compose.runtime.Applier
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.unit.dp
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewmodel.compose.viewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow


class MainActivity : ComponentActivity() {

    // Kysytään lupaa paikkatietoon kun sovellus käynnistyy

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // Tutkitaan onko permissio lokaatiolle olemassa (käyttäjän lupa)
        // Jos ei ole, pyydetään lupa

        if ( ContextCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
            // Tällä aktiviteetilla ei ole lupaa lokaatioon, joten pyydetään lupa
            ActivityCompat.requestPermissions(this, arrayOf(Manifest.permission.ACCESS_FINE_LOCATION), 0);
        }

        enableEdgeToEdge()
        setContent {
            DeviceApiDemoTheme {
                LocationScreen();
            }
        }
    }
}

@Composable
fun SensorScreen(sensorViewModel: SensorViewModel = viewModel()) {

    val sensorData = sensorViewModel.accelerometerData.collectAsState();

    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp), horizontalAlignment = Alignment.CenterHorizontally, verticalArrangement = Arrangement.Center
    ) {
        Text("Sensor X: ${sensorData.value.first}")
        Spacer(modifier = Modifier.height(8.dp))
        Text("Sensor Y: ${sensorData.value.second}")
        Spacer(modifier = Modifier.height(8.dp))
        Text("Sensor Z: ${sensorData.value.third}")
        Spacer(modifier = Modifier.height(8.dp))
        Button(onClick = { sensorViewModel.startListening()}) {
            Text("Start Sensors")
        }
    }
}

// 1. Perus ViewModel tilanteisiin, joissa ei tarvita aktiviteetin ulkopuolisia yhteyksiä Contextin kautta
// Esim. SensorManager tai LocationManager tai data store
// 2. AndroidViewModel tilanteisiin, joissa tarvitaan contextin kautta yhteyksiä ulos
// Context tulee ViewModeliin sisälle

class SensorViewModel( application: Application) : AndroidViewModel(application), SensorEventListener {
    private val sensorManager = application.getSystemService(Context.SENSOR_SERVICE) as SensorManager;
    private val accelerometer = sensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER);

    // Luodaan state ja stateflow, joka tarjoaa data käyttöliittymälle
    private val _accelerometerData = MutableStateFlow(Triple(0f, 0f, 0f))
    val accelerometerData: StateFlow<Triple<Float, Float, Float>> = _accelerometerData

    /*init {
        // Käynnistetään kiihtyvyysanturien lukeminen
        if(accelerometer != null) {
            sensorManager.registerListener(this, accelerometer, SensorManager.SENSOR_DELAY_NORMAL)
        }
    } */

    fun startListening() {
        // Käynnistetään kiihtyvyysanturien lukeminen
        if(accelerometer != null) {
        sensorManager.registerListener(this, accelerometer, SensorManager.SENSOR_DELAY_NORMAL)
        }
    }

    override fun onSensorChanged(event: SensorEvent?) {
        // Tänne tulee sensor eventit ja uudet kiihtyvyysanturien lukemat
        event?.let {
            // Event on, tehdään jotain (lohko suoritetaan, jos event on eri kuin null)
            if(it.sensor.type == Sensor.TYPE_ACCELEROMETER) {
                _accelerometerData.value = Triple(it.values[0], it.values[1], it.values[2])
            }
        }
    }

    override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {

    }
}

@Composable
fun LocationScreen(locationViewModel: LocationViewModel = viewModel()) {
    val locationData = locationViewModel.locationData.collectAsState()

    Column(modifier = Modifier.fillMaxSize().padding(16.dp), horizontalAlignment = Alignment.CenterHorizontally, verticalArrangement = Arrangement.Center) {
        Text("Latitude: ${locationData.value.latitude}")
        Spacer(modifier = Modifier.height(8.dp))
        Text("Longitude: ${locationData.value.longitude}")
        Spacer(modifier = Modifier.height(8.dp))
        Button(onClick = { locationViewModel.startListening()}) {
            Text("Get Location")
        }
    }
}

data class LocationData(val latitude : Double, val longitude : Double);

class LocationViewModel( application: Application) : AndroidViewModel(application), LocationListener {
    private val locationManager = application.getSystemService(Context.LOCATION_SERVICE) as LocationManager;
    private val _locationData = MutableStateFlow(LocationData(0.0, 0.0));
    val locationData : StateFlow<LocationData> = _locationData;

   /* init {
        startLocationUpdates(); // Aloitetaan sijainnin kuunteleminen
    } */

    fun startListening() {
        startLocationUpdates(); // Aloitetaan sijainnin kuunteleminen
    }

    private fun startLocationUpdates() {
        if (ActivityCompat.checkSelfPermission(
                getApplication(),
                Manifest.permission.ACCESS_FINE_LOCATION
            ) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(
                getApplication(),
                Manifest.permission.ACCESS_COARSE_LOCATION
            ) != PackageManager.PERMISSION_GRANTED
        ) {
            // Ei permissioita, joten emme hae lokaatiota. Pyydetään oikeuksia tässä.
            // Permissio dialogia ei voida aukaista tässä, koska tämä on viewModel eikä UI-komponentti
            return
        }
        locationManager.requestLocationUpdates(LocationManager.GPS_PROVIDER, 0, 0f, this);
        val lastKnownLocation = locationManager.getLastKnownLocation(LocationManager.GPS_PROVIDER);
        if (lastKnownLocation != null) {
            _locationData.value = LocationData(lastKnownLocation.latitude, lastKnownLocation.longitude);
        }
    }

    override fun onLocationChanged(location: Location) {
        // Luetaan location ja lisätään flowhun
        _locationData.value = LocationData(location.latitude, location.longitude);
    }
}