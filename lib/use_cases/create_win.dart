import 'package:my_wins_today/entities/Win.dart';
import 'package:my_wins_today/DTOs/win_create_dto.dart';
import 'package:my_wins_today/repositories/create_win_repository.dart';

Future<Win> createWin(WinCreateDTO winPayload) async {
  try {
    return await createWinRepository(winPayload);
  } on Exception catch (error) {
    throw error;
  }
}
