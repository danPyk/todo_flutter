
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_flutter/core/errors.dart';
import 'package:todo_flutter/domain/auth/i_auth_facade.dart';
import 'package:todo_flutter/injection.dart';



extension FirestoreX on FirebaseFirestore {
  Future<DocumentReference> userDocument() async {
    final userOption = await getIt<IAuthFacade>().getSignedInUser();
    final user = userOption.getOrElse(() => throw NotAuthenticatedError());
    return FirebaseFirestore.instance
        .collection('users')
        .doc(user.id.getOrCrash());
  }
}
///extension used to not pass everywhere raw string

extension DocumentReferenceX on DocumentReference {
  CollectionReference get noteCollection => collection('notes');
}
