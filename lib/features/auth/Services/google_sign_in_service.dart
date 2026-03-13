import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Result of a Google Sign-In attempt.
class GoogleSignInResult {
  const GoogleSignInResult({
    this.user,
    this.idToken,
    this.error,
  });

  final User? user;
  final String? idToken;
  final String? error;

  bool get isSuccess => user != null && error == null;
}

/// Handles Google Sign-In and linking with Firebase Auth.
class GoogleSignInService {
  GoogleSignInService._();

  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
  );

  /// Signs in with Google and then signs in to Firebase with the Google credential.
  /// Clears any existing Google/Firebase session first so the account picker is shown.
  /// Returns [GoogleSignInResult] with [User] and optional [idToken] on success.
  static Future<GoogleSignInResult> signIn() async {
    try {
      await signOut();
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account == null) {
        return const GoogleSignInResult(
          error: 'Google sign-in was cancelled',
        );
      }

      final GoogleSignInAuthentication auth = await account.authentication;
      final String? idToken = auth.idToken;
      final String? accessToken = auth.accessToken;

      if (idToken == null) {
        return const GoogleSignInResult(
          error: 'Failed to get Google ID token',
        );
      }

      final credential = GoogleAuthProvider.credential(
        idToken: idToken,
        accessToken: accessToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user == null) {
        return const GoogleSignInResult(
          error: 'Firebase sign-in did not return a user',
        );
      }

      return GoogleSignInResult(
        user: user,
        idToken: idToken,
      );
    } on FirebaseAuthException catch (e) {
      return GoogleSignInResult(
        error: e.message ?? e.code,
      );
    } catch (e) {
      return GoogleSignInResult(
        error: e.toString(),
      );
    }
  }

  /// Signs out from Google and Firebase.
  static Future<void> signOut() async {
    await _googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
  }

  /// Returns the current Firebase user if signed in via Google (or any method).
  static User? get currentFirebaseUser => FirebaseAuth.instance.currentUser;
}
