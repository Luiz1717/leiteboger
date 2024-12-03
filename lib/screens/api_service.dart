import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://localhost:3000/api/cadastro/leite',
  ));

  // Função para enviar o cadastro
  Future<void> enviarCadastro(Map<String, dynamic> dados) async {
    try {
      // Envia os dados com uma solicitação POST
      final response = await _dio.post('/leite', data: dados);

      // Verifique se o status da resposta é 200 (OK)
      if (response.statusCode == 200) {
        print('Cadastro enviado com sucesso!');
      } else {
        print('Erro no cadastro: ${response.statusCode}');
      }
    } catch (e) {
      // Em caso de erro, exibe a mensagem
      print('Erro ao enviar cadastro: $e');
    }
  }
}


