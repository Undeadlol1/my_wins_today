import 'package:my_wins_today/entities/Win.dart';
import 'package:my_wins_today/DTOs/win_create_dto.dart';
import 'package:my_wins_today/repositories/create_win_repository.dart';

Future<Win> createWin(WinCreateDTO winDTO) async {
  try {
    return await createWinRepository(winDTO);
  } on Exception catch (error) {
    throw error;
  }
}
