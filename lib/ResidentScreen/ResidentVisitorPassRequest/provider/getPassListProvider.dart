import 'package:property_association_or_resident/Core/AuthService/AuthServiceProvider.dart';
import 'package:riverpod/riverpod.dart';

import '../../Model/getPassListResModel.dart';

final getPassListProvider = FutureProvider.autoDispose<GetPassListResModel>((
  ref,
) async {
  final service = ref.read(authServiceProvider);
  return await service.getPass();
});
