abstract class EnvUrl {
  String getBaseUrl();

  String getLightBaseUrl();

  String getZbrdUrl();
}

/// 日常环境
class GrdEnv extends EnvUrl {
  @override
  String getBaseUrl() => "https://kpicalm.keruyun.com";

  @override
  String getLightBaseUrl() => "https://kpigldlight.keruyun.com";

  @override
  String getZbrdUrl() => "https://gldauth.keruyun.com/";
}

/// 预发环境
class PreReleaseEnv implements EnvUrl {
  @override
  String getBaseUrl() => "https://kpicalm.tongyun0815.com";

  @override
  String getLightBaseUrl() => "https://kpiprelight.tongyun0815.com";

  @override
  String getZbrdUrl() => "https://preauth.tongyun0815.com/";
}

/// 线上环境
class ReleaseEnv implements EnvUrl {
  @override
  String getBaseUrl() => "https://kpicalm4.keruyun.com";

  @override
  String getLightBaseUrl() => "https://kpilight.keruyun.com";

  @override
  String getZbrdUrl() => "https://auth.keruyun.com/";
}

/// 新加坡环境
class SingaporeEnv implements EnvUrl {
  @override
  String getBaseUrl() => "https://kpisgcalm4.keruyun.com";

  @override
  String getLightBaseUrl() => "https://kpisglight.keruyun.com";

  @override
  String getZbrdUrl() => "https://sgauth.keruyun.com/";
}
