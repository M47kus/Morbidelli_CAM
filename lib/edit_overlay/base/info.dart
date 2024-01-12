import '../../load_settings.dart';
import '../../path_privider_lib.dart';

mixin Info {
  void OnTab(ref, id) {
    //set object_id provider to new active id
    ref.read(path_object_id_provider.notifier).set(id);
    ref.watch(show_creator_provider.notifier).set(true);

    //disable directory buttons
    ref.read(path_directory_lock_provider.notifier).set(true);
    if (hide_model_creation_window)
      ref.read(show_model_provider.notifier).set(false);
  }
}
