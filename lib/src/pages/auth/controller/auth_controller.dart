import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quitanda/src/constants/storage_keys.dart';
import 'package:quitanda/src/models/user_model.dart';
import 'package:quitanda/src/pages/auth/repository/auth_repository.dart';
import 'package:quitanda/src/pages/auth/result/auth_result.dart';
import 'package:quitanda/src/routes/app_pages.dart';
import 'package:quitanda/src/services/utils_services.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  AuthRepository authRepository = AuthRepository();
  final utilsServices = UtilsServices();

  UserModel user = UserModel();

  //Ao inciar a aplicação o "onInit" irá verificar se existe um token com a chamada da função validateToken
  //visto que no meu arquivo main a instância do AuthController é chamado
  @override
  void onInit() {
    super.onInit();

    validateToken();
  }

  void saveTokenAndProceedToBase() {
    //salva o token
    utilsServices.saveLocalData(
      key: StorageKeys.token,
      data: user.token!,
    );

    //vai para a base da aplicação
    Get.offAllNamed(PagesRoutes.baseRoute);
  }

  Future<void> changePassword({
    BuildContext? context,
    required String currentPassword,
    required String newPassword,
  }) async {
    isLoading.value = true;

    final result = await authRepository.changePassword(
      email: user.email!,
      currentPassword: currentPassword,
      newPassword: newPassword,
      token: user.token!,
    );

    isLoading.value = false;

    if (result) {
      //Mensagem
      // ignore: use_build_context_synchronously
      utilsServices.showCustomToast(
        message: 'A senha foi atualizado com sucesso! Você será redirecionado!',
        context: context,
      );

      //logout
      signOut();
    } else {
      // ignore: use_build_context_synchronously
      utilsServices.showCustomToast(
        message: 'A senha atual está incorreta',
        isError: true,
        context: context,
      );
    }
  }

  //controlador da regra de negócio do TOKEN
  Future<void> validateToken() async {
    //Recupera o token salvo
    String? token = await utilsServices.getLocalData(key: StorageKeys.token);

    //verifica se existe um token salvo, senão envia para a tela de login
    if (token == null) {
      Get.offAllNamed(PagesRoutes.signInRoute);
      return;
    }

    //se existir verifica se esse token é válido com o backend
    AuthResult result = await authRepository.validateToken(token);

    //aqui verifica se foi sucesso ou deu erro
    result.when(
      success: (user) {
        this.user = user;

        saveTokenAndProceedToBase();
      },
      error: (message) {
        //chama a regra de negócio do Logout
        signOut();
      },
    );
  }

  //controlador da regra de negócio de Logout
  Future<void> signOut() async {
    //Zerar o user
    user = UserModel();
    //remover o token localmente
    utilsServices.removeLocalData(key: StorageKeys.token);
    //ir para o login
    Get.offAllNamed(PagesRoutes.signInRoute);
  }

  //controlador da regra de negócio de Login
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;
    AuthResult result =
        await authRepository.signIn(email: email, password: password);

    isLoading.value = false;

    result.when(
      success: (user) {
        //seta o usuario em uma instancia de um usuario
        this.user = user;

        saveTokenAndProceedToBase();
      },
      error: (message) {
        //mostra um tost de erro
        utilsServices.showCustomToast(
          message: message,
          context: Get.context!,
          isError: true,
        );
      },
    );
  }

  //controlador da regra de negócio de cadastro de um usuario
  Future<void> singUp() async {
    isLoading.value = true;
    AuthResult result = await authRepository.signUp(user);
    isLoading.value = false;

    result.when(
      success: (user) {
        this.user = user;

        saveTokenAndProceedToBase();
      },
      error: (message) {
        //mostra um tost de erro
        utilsServices.showCustomToast(
          message: message,
          context: Get.context!,
          isError: true,
        );
      },
    );
  }

  //controlador da regra de negócio para recuperação de senha
  Future<void> resetPassword(String email) async {
    await authRepository.resetPassword(email);
  }
}
