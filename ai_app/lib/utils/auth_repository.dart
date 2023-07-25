import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepositoryImpl {
  Future<String?> signInWithGoogle();
  Future<void> signOut();
}

class GoogleAuthRepository implements AuthRepositoryImpl {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  GoogleAuthRepository()
      : _firebaseAuth = FirebaseAuth.instance,
        _googleSignIn = GoogleSignIn();

  @override
  Future<String?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      return null;
    }
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    UserCredential userCredential =
        await _firebaseAuth.signInWithCredential(credential);

    return userCredential.user?.email;
  }

  @override
  Future<void> signOut() async {
    Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }
}

class AppleAuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String?> signInWithApple() async {
    final appleProvider = AppleAuthProvider();
    final User? user =
        (await FirebaseAuth.instance.signInWithProvider(appleProvider)).user;

    return user?.email;
  }
}
