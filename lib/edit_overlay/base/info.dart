import '../../load_settings.dart';
import '../../path_privider_lib.dart';

mixin Info {
  void onTab(ref, id) {
    //set object_id provider to new active id
    ref.read(pathObjectIdProvider.notifier).set(id);
    ref.watch(showCreatorProvider.notifier).set(true);

    //disable directory buttons
    ref.read(pathDirectoryLockProvider.notifier).set(true);
    if (hideModelInCreation) {
      ref.read(showModelProvider.notifier).set(false);
    }
  }
}
