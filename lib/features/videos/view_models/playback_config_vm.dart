import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktokclonepractice/features/videos/models/playback_config_model.dart';
import 'package:tiktokclonepractice/features/videos/repos/playback_config_rep.dart';

//////////////////////////////////////////////////////////////////
///RiverPod
class PlaybackConfigViewModel extends Notifier<PlaybackConfigModel> {
  final PlaybackConfigRepository _repository;

  PlaybackConfigViewModel(this._repository);

  void setMuted(bool value) {
    _repository.setMuted(value);
    state = PlaybackConfigModel(
      muted: value,
      autoplay: state.autoplay,
    );
  }

  void setAutoplay(bool value) {
    _repository.setAutoplay(value);
    state = PlaybackConfigModel(muted: state.muted, autoplay: value);
  }

  @override
  PlaybackConfigModel build() {
    return PlaybackConfigModel(
      muted: _repository.isMuted(),
      autoplay: _repository.isAutoplay(),
    );
  }
}

final playbackConfigProvider =
    NotifierProvider<PlaybackConfigViewModel, PlaybackConfigModel>(
  () => throw UnimplementedError(),
);



//////////////////////////////////////////////////////////////////
///MVVM
// class PlaybackConfigViewModel extends ChangeNotifier {
//   final PlaybackConfigRepository _repository;
//   late final PlaybackConfigModel _model = PlaybackConfigModel(
//     muted: _repository.isMuted(),
//     autoplay: _repository.isAutoplay(),
//   );

//   PlaybackConfigViewModel(this._repository);

//   bool get muted => _model.muted;
//   bool get autoplay => _model.autoplay;

//   void setMuted(bool value) {
//     _repository.setMuted(value);
//     _model.muted = value;
//     notifyListeners();
//   }

//   void setAutoplay(bool value) {
//     _repository.setAutoplay(value);
//     _model.autoplay = value;
//     notifyListeners();
//   }
// }
//////////////////////////////////////////////////////////////////