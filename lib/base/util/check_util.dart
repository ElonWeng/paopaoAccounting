class CheckUtil {
    //检查邮箱账号是否合法
    static bool isValidEmail(String email) {
      final RegExp emailRegex = RegExp(
        r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
      );
      return emailRegex.hasMatch(email);
    }

    //判断当前是什么环境
    static bool isRelease(){
      const bool inProduction =
      bool.fromEnvironment('dart.vm.product');
      return inProduction;
    }
}
