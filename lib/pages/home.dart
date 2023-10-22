import 'package:flutter/material.dart';
import '../controller/listaP.dart';
import '../controller/moldListaP.dart';

class MyHomePage extends StatefulWidget {
  // classe MyHomePage estendendo a Statefull..
  const MyHomePage(
      {super.key,
      required this.title}); //construtor da classe requerindo o titulo como parametro
  final String title; //atributo da classe
  @override //método de sobrescrita
  State<MyHomePage> createState() =>
      _MyHomePageState(); //Cria uma instância do estado associada a um widget personalizado(tela)
}

class _MyHomePageState extends State<MyHomePage> {
  //classe onde sera construido a tela e esta estendendo State
  final List<Listas> listaTarefas = []; // lista criada para receber as tarefas

  final TextEditingController listaControler =
      TextEditingController(); //controlador do campo de texto textfield
  late int veriTrim; //variavel que vai receber a validação dos dados

  void onDelete(Listas listas) {
    //função para deletar
    setState(() {
      // responsável por atualizar a tela
      listaTarefas.remove(listas); // responsável por remover o item da lista
    });
    print(
        "Item deletado"); // mostra no console quando a função delete for executada
  }

  verificar() {
    //função para verificar se o conteúdo digitado é maior que 3 caracteres e não é espaço em branco ou vazio
    String veri =
        listaControler.text; // pega o texto que foi digitado no Textfield
    veriTrim = veri.trim().length;
    // trim().length tem a função de remover todos os espaços e retornar a quantidade de caracteres restantes

    if (veri == "" || veriTrim < 4) {
      //faz a verificação se o conteúdo digitado é maior que 3 caracteres e não é espaço em branco ou vazio
      showDialog(
          //caso a verificação seja verdadeira vai retornar o contexto atual da tela que é o alertdialog()
          context: context,
          builder: (context) {
            return const AlertDialog();
          });

      return false; // retorna falso deixando de executar o restante do cod.
    }
    salvarArquivos(); //Caso o if seja falso significa que o texto informado é valido então ele executa a função salvar
  }

  salvarArquivos() async {
    //função que serve para salvar as informações na variavel lista
    String text =
        listaControler.text; //pega o texto que foi digitado no Textfield
    setState(() {
      //atualiza o estado da tela
      Listas newListas = Listas(
        title: text, //passando a variável text que recebe o texto do textField
        dateTime: DateTime.now(), //passando a hora atual
      ); //adiciona na variável newListas do tipo Listas(classe) passando os atributos requeridos (title, dateTime)
      listaTarefas.add(newListas);
      //adiciona dentro da variavel listaTarefas o conteudo que foi atribuido a variavel newListas
    });
    print(
        "Arquivo salvo"); //mostra no console que o arquivo foi adicionado na variável
  }

  @override //método de sobrescrita
  Widget build(BuildContext context) {
    //carregamento do build no contexto atual
    return Scaffold(
      // retornando o scaffold que é uma estrutura de layout (AppBar, Body, FloatingActionButton, Drawer, BottomNavigationBar)
      appBar: AppBar(
        // criação da appbar
        backgroundColor: const Color.fromARGB(
            255, 146, 230, 104), //definição de cor da appbar
        title: Text(
          widget.title,
          style: TextStyle(fontSize: 25, color: Colors.amber[900]),
        ), //recebendo o titulo por parâmetro, quando chama a classe MyHomePage la dentro do arquivo main.dart
      ),
      body: Column(
        //body é o corpo do scaffold, que recebe uma coluna
        children: <Widget>[
          //children é o filho da coluna
          Expanded(
              /*é usado para criar layouts flexíveis e é útil 
          quando você deseja que um ou mais filhos ocupem o espaço adicional disponível em um determinado eixo.*/
              child: Padding(
            //child é o filho do expanded que ta recebendo o padding, que tem a função de criar um espaçamento
            padding: EdgeInsets.fromLTRB(15, 0, 15,
                85), //espaçamento criado de forma individual entre cada posição (left, top, right, bottom)
            child: ListView(children: [
              //o filho do padding é o listView que exibe uma lista rolável na tela
              for (Listas lista in listaTarefas)
                //for each serve para percorrer uma lista de elementos -
                //Lista é o tipo da variavel (lista), o in vamos percorrer elementos dentro da listaTarefas
                ListaPadrao(
                  //classe ListaPadrao passando lista e onDelete por parâmetro
                  listas: lista, //obtida no for each
                  onDelete: onDelete, //função criada la no inicio
                ),
            ]),
          )),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .centerFloat, //posicionamento do botão na tela
      floatingActionButton: FloatingActionButton.extended(
        //criação do botão flutuante
        onPressed: () {
          //função quando pressionado
          showDialog(
              /*utilizada para criar pop-ups, caixas de diálogo de confirmação, 
          notificações e outros tipos de interações com o usuário.*/
              context:
                  context, //é uma referência ao contexto no qual o diálogo será exibido.
              builder: (context) {
                //O parâmetro builder é uma função que cria o conteúdo do diálogo.
                //Nesse caso, ele recebe o contexto como argumento e retorna um widget que representa o conteúdo do diálogo
                return AlertDialog(
                  //retorno do alertdialog que contém as partes do diálogo, como título, conteúdo e ações (botões).
                  title: const Text("Adicionar tarefas"),
                  content: TextField(
                    // textfield para escrever o texto
                    controller: listaControler,
                    decoration: const InputDecoration(
                      labelText: "Tarefas",
                      hintText: "Ex.: Estudar flutter",
                    ),
                    onChanged: (text) {},
                  ),
                  actions: <Widget>[
                    TextButton(
                      //botão para enviar as informações escritas no textfield
                      onPressed: () {
                        verificar();
                        listaControler.clear();
                        Navigator.pop(context);
                      },
                      child: Text("Enviar"),
                    ),
                    TextButton(
                        //botão para cancelar as informações escritas no textfield e retornar a tela principal
                        onPressed: () => Navigator.pop(
                            context), //Navigator tem a função de retornar ao contexto anterior
                        child: Text("Cancelar"))
                  ],
                );
              });
        },
        //Configurações do botão
        backgroundColor: Color.fromARGB(47, 77, 255, 0),
        elevation: 20,
        tooltip: 'Increment',
        icon: const Icon(Icons.alarm_add_outlined),
        label: const Text("Adicionar"),
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
