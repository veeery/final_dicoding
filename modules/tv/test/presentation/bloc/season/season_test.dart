import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_season_detail.dart';
import 'package:tv/presentation/bloc/detail_season/season_detail_bloc.dart';
import 'package:tv/presentation/bloc/detail_tv_series/detail_tv_series_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'season_test.mocks.dart';

@GenerateMocks([
  GetSeasonDetail,
])
void main() {
  late SeasonDetailBloc seasonDetailBloc;
  late MockGetSeasonDetail mockGetSeasonDetail;
  const tId = 1;
  const tSeasonNumber = 1;

  setUp(() {
    mockGetSeasonDetail = MockGetSeasonDetail();
    seasonDetailBloc = SeasonDetailBloc(getSeasonDetail: mockGetSeasonDetail);
  });

  test('initial state should be empty', () {
    expect(seasonDetailBloc.state, SeasonDetailEmpty());
  });

  blocTest<SeasonDetailBloc, SeasonDetailState>(
    'Should emit [Loading, Loaded]',
    build: () {
      when(mockGetSeasonDetail.execute(id: tId, seasonNumber: tSeasonNumber))
          .thenAnswer((realInvocation) async => const Right(tSeasonDetail));
      return seasonDetailBloc;
    },
    expect: () => [
      SeasonDetailLoading(),
      SeasonDetailLoaded(result: tSeasonDetail),
    ],
    act: (bloc) => bloc.add(const FetchSeasonDetail(id: tId, seasonNumber: tSeasonNumber)),
    verify: (bloc) => [
      verify(mockGetSeasonDetail.execute(id: tId, seasonNumber: tSeasonNumber)),
      const FetchSeasonDetail(id: tId, seasonNumber: tSeasonNumber).props,
    ],
  );

  blocTest<SeasonDetailBloc, SeasonDetailState>(
    'Should emit [Loading, Error]',
    build: () {
      when(mockGetSeasonDetail.execute(id: tId, seasonNumber: tSeasonNumber))
          .thenAnswer((realInvocation) async => Left(ServerFailure()));
      return seasonDetailBloc;
    },
    expect: () => [
      SeasonDetailLoading(),
      SeasonDetailError(message: 'Server Failure'),
    ],
    act: (bloc) => bloc.add(const FetchSeasonDetail(id: tId, seasonNumber: tSeasonNumber)),
    verify: (bloc) => [
      verify(mockGetSeasonDetail.execute(id: tId, seasonNumber: tSeasonNumber)),
      const FetchSeasonDetail(id: tId, seasonNumber: tSeasonNumber).props,
    ],
  );
}
