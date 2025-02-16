package com.example.architecturedemo

import android.annotation.SuppressLint
import android.app.Application
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.location.Location
import android.location.LocationListener
import android.location.LocationManager
import android.net.Uri
import android.os.Bundle
import android.widget.Toast
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Button
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.ViewModel
import com.example.architecturedemo.ui.theme.ArchitectureDemoTheme
import androidx.lifecycle.viewmodel.compose.viewModel
import kotlinx.coroutines.flow.MutableStateFlow


class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Tarkistetaan, onko meillä oikeuksia käyttää laitteen sijaintia
        // Jos ei ole, pyydetään käyttäjältä oikeudet
        if( checkSelfPermission( android.Manifest.permission.ACCESS_FINE_LOCATION ) != PackageManager.PERMISSION_GRANTED
            && checkSelfPermission( android.Manifest.permission.ACCESS_COARSE_LOCATION ) != PackageManager.PERMISSION_GRANTED) {
            requestPermissions(arrayOf(android.Manifest.permission.ACCESS_FINE_LOCATION, android.Manifest.permission.ACCESS_COARSE_LOCATION), 0);
        }

        // Toast
        Toast.makeText(this, "Creating Activity", Toast.LENGTH_SHORT).show();
        enableEdgeToEdge()
        setContent {
            ArchitectureDemoTheme {
                Hello();
            }
        }
    }
    override fun onStart() {
        super.onStart();
        // Show Toast message
        Toast.makeText(this, "Activity: OnStart!", Toast.LENGTH_SHORT).show();
    }
    override fun onResume() {
        super.onResume();
        Toast.makeText(this, "Activity: OnResume!", Toast.LENGTH_SHORT).show();
    }
    override fun onPause() {
        super.onPause();
        Toast.makeText(this, "Activity: OnPause!", Toast.LENGTH_SHORT).show();
    }
    override fun onStop() {
        super.onStop();
        Toast.makeText(this, "Activity: OnStop!", Toast.LENGTH_SHORT).show();
    }
    override fun onDestroy() {
        super.onDestroy();
        Toast.makeText(this, "Activity: OnDestroy!", Toast.LENGTH_SHORT).show();
    }
}

@SuppressLint("UnusedMaterial3ScaffoldPaddingParameter")
@Preview(showBackground = true)
@Composable
fun Hello( locationViewModel: LocationViewModel = viewModel() ) {
    val gpsCoordinates = locationViewModel.locationData.collectAsState()
    val context = LocalContext.current;

    // Simple Column with 2 text fields for latitude and longitude and a button to open a map
    Column (Modifier
        .fillMaxSize()
        .padding(16.dp)) {
        Text(text = "Latitude: ${gpsCoordinates.value.first}", modifier = Modifier.padding(10.dp))
        Text(text = "Longitude: ${gpsCoordinates.value.second}", modifier = Modifier.padding(10.dp))
        Button(onClick = {
            // Käynnistetään kartat
            val openMapsIntent = Intent(Intent.ACTION_VIEW, Uri.parse("geo:${gpsCoordinates.value.first}, ${gpsCoordinates.value.second}"))
            try {
                context.startActivity(openMapsIntent);
            }
            catch (e: Exception) {
                Toast.makeText(context, "No map application found!", Toast.LENGTH_SHORT).show();
            }

        }) {
            Text(text = "Open Map", modifier = Modifier.padding(10.dp))
        }
    }
}

// Android viewmodel which connects to Location service
class LocationViewModel( application: Application) : AndroidViewModel( application), LocationListener {

    // Provide latitude and longitude to the UI
    private val gpsCoordinates = Pair(0.0, 0.0)
    val locationData = MutableStateFlow( gpsCoordinates)

    val locationManager = application.getSystemService( Context.LOCATION_SERVICE ) as android.location.LocationManager;

    init {
        // Aloitetaan suoraan paikannuksen kuuntelu kun viewModel käynnistetään
        startListeningLocationUpdates();
    }

    @SuppressLint("MissingPermissions")
    fun startListeningLocationUpdates() {
        try{
            locationManager.requestLocationUpdates(LocationManager.FUSED_PROVIDER, 0, 0f, this)
        }
        catch (securityException: SecurityException ) {
            Toast.makeText(getApplication(), "No permissions to access location!", Toast.LENGTH_SHORT).show();
        }
    }

    override fun onLocationChanged(p0: Location) {
        // Location changed
        Toast.makeText(getApplication(), "Location changed: ${p0.latitude}, ${p0.longitude}", Toast.LENGTH_SHORT).show();
        locationData.value = Pair(p0.latitude, p0.longitude)
    }
}
