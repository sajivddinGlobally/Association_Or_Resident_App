import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:property_association_or_resident/Core/AuthService/AuthServiceProvider.dart';
import 'package:property_association_or_resident/GuardScreen/Model/historyRecordsModel.dart';

final historyRecordsProvider =
    FutureProvider.autoDispose<HistoryRecordsResModel>((ref) async {
      final service = ref.read(authServiceProvider);
      return await service.historyRecordsData();
    });
