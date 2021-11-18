import 'env_urls.dart';

enum EnvEnum { gld, pre, release, singapore }

EnvUrl getEnvUrl(EnvEnum env) {
  switch (env) {
    case EnvEnum.gld:
      return GrdEnv();
    case EnvEnum.pre:
      return PreReleaseEnv();
    case EnvEnum.release:
      return ReleaseEnv();
    case EnvEnum.singapore:
      return SingaporeEnv();
    default:
      return GrdEnv();
  }
}
