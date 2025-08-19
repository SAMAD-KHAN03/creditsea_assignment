import 'dart:convert';
import 'package:flutter/foundation.dart'; // for debugPrint
import 'package:http/http.dart' as http;

class EmailOtpService {
  static String? _generatedOtp;

  /// Generate a random 6-digit OTP
  static String _generateOtp() {
    final now = DateTime.now().millisecondsSinceEpoch;
    return (100000 + (now % 900000)).toString();
  }

  /// Send OTP email using Brevo API
  static Future<bool> sendOtp(String email) async {
    final otp = _generateOtp();
    _generatedOtp = otp;

    try {
      final url = Uri.parse("https://api.brevo.com/v3/smtp/email");

      debugPrint("📨 Sending OTP $otp to $email ...");

      final response = await http.post(
        url,
        headers: {
          "accept": "application/json",
          "api-key":
              "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", // ⚠️ test only
          "content-type": "application/json",
        },
        body: jsonEncode({
          "sender": {"name": "Test App", "email": "noreply@yourapp.com"},
          "to": [
            {"email": email},
          ],
          "subject": "Your OTP Code",
          "htmlContent": "<p>Your OTP is <b>$otp</b></p>",
        }),
      );

      debugPrint("✅ Brevo response: ${response.statusCode}");
      debugPrint("📩 Brevo body: ${response.body}");

      if (response.statusCode == 201) {
        debugPrint("🎉 OTP sent successfully to $email");
        return true;
      } else {
        debugPrint("⚠️ Failed to send OTP. Response: ${response.body}");
        return false;
      }
    } catch (e, stack) {
      debugPrint("❌ Exception while sending OTP: $e");
      debugPrint("🪲 Stack trace: $stack");
      return false;
    }
  }

  /// Verify if the OTP entered is correct
  static bool verifyOtp(String enteredOtp) {
    debugPrint(
      "🔍 Verifying OTP. Entered: $enteredOtp | Expected: $_generatedOtp",
    );
    return enteredOtp == _generatedOtp;
  }

  /// Reset stored OTP (optional)
  static void resetOtp() {
    _generatedOtp = null;
    debugPrint("♻️ OTP reset");
  }
}
