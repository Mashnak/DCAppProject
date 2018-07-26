// Author: Timur Bahadir

part of 'app.dart';

/// All HTTP-Requests will be sent to this address.
const String BASE_URL = "http://192.168.99.100:8080";

/// Information about the currently logged in user.
/// [null] if no user is logged in, otherwise a valid [ProfileData].
ProfileData loggedInUser;
