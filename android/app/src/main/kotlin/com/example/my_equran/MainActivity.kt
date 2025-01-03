package com.example.my_equran

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.Context
import android.net.ConnectivityManager
import android.net.NetworkInfo
import androidx.biometric.BiometricManager.Authenticators.BIOMETRIC_STRONG
import androidx.biometric.BiometricManager.Authenticators.DEVICE_CREDENTIAL
import androidx.biometric.BiometricPrompt
import androidx.biometric.BiometricPrompt.AUTHENTICATION_RESULT_TYPE_UNKNOWN
import androidx.core.content.ContextCompat
import androidx.fragment.app.FragmentActivity

class MainActivity : FlutterFragmentActivity() {
    private val CHANNEL = "com.equran.app/native"
    private val FINGERPRINT_METHOD_CHANNEL = "fingerprint-auth"
    private val NETWORK_STATUS_METHOD_CHANNEL = "isNetworkOnline"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                FINGERPRINT_METHOD_CHANNEL -> fingerprintAuth(result)
                NETWORK_STATUS_METHOD_CHANNEL -> result.success(isInternetAvailable())
                else -> result.notImplemented()
            }
        }
    }

    private fun fingerprintAuth(result: MethodChannel.Result) {
        var resultSent = false;
        val executor = ContextCompat.getMainExecutor(this)
        val biometricPrompt = BiometricPrompt(
            this as FragmentActivity, executor,
            object : BiometricPrompt.AuthenticationCallback() {
                override fun onAuthenticationError(
                    errorCode: Int,
                    errString: CharSequence
                ) {
                    super.onAuthenticationError(errorCode, errString)
                    if (errorCode != 10 && !resultSent) {
                        result.error("AUTHFAILED", errString.toString(), null)
                        resultSent = true;
                    }
                }

                override fun onAuthenticationSucceeded(
                    authResult: BiometricPrompt.AuthenticationResult
                ) {
                    super.onAuthenticationSucceeded(authResult)
                    if (!resultSent) {
                        result.success(true)
                        resultSent = true;
                    }
                }

                override fun onAuthenticationFailed() {
                    super.onAuthenticationFailed()
                    if (!resultSent) {
                        result.error("AUTHFAILED", "Authentication failed", null)
                        resultSent = true;
                    }
                }
            })

        val promptInfoBuilder = BiometricPrompt.PromptInfo.Builder()
            .setTitle("Biometric Authentication")
            .setSubtitle("Use your fingerprint to authenticate")
            .setConfirmationRequired(false)

        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.R) {
            promptInfoBuilder.setAllowedAuthenticators(BIOMETRIC_STRONG or DEVICE_CREDENTIAL)
        } else {
            promptInfoBuilder.setDeviceCredentialAllowed(true)
        }
        val promptInfo = promptInfoBuilder.build()

        biometricPrompt.authenticate(promptInfo)
    }
    private fun isInternetAvailable(): Boolean {
        val connectivityManager =
            getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
        val activeNetwork: NetworkInfo? = connectivityManager.activeNetworkInfo
        return activeNetwork != null && activeNetwork.isConnected
    }
}
