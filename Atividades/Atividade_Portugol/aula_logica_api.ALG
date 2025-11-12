algoritmo "api_backend_crud_completo_visualg"
// Disciplina   : Desenvolvimento de API Backend (Simulação em Portugol)
// Professor    : Vinícius Siqueira
// Descrição    : CRUD de usuários, categorias e produtos em camadas
// Autor(a)     : Vinícius Siqueira / Vinicius Santos 2310071
// Data atual   : 10/11/2025

var
   // "Banco de dados" - USUÁRIOS
   ids        : vetor[1..100] de inteiro
   nomes      : vetor[1..100] de caractere
   emails     : vetor[1..100] de caractere
   senhas     : vetor[1..100] de caractere
   qtdUsuarios: inteiro

   // "Banco de dados" - CATEGORIAS (Requisito 1)
   ids_categoria         : vetor[1..100] de inteiro
   nomes_categoria       : vetor[1..100] de caractere
   descricoes_categoria  : vetor[1..100] de caractere
   qtdCategorias         : inteiro

   // "Banco de dados" - PRODUTOS (Requisito 2)
   ids_produto           : vetor[1..100] de inteiro
   nomes_produto         : vetor[1..100] de caractere
   precos_unitario       : vetor[1..100] de real
   ids_categoria_produto : vetor[1..100] de inteiro // Chave estrangeira
   qtdProdutos           : inteiro

   // Controle do Menu
   opcao      : inteiro

// ====== CRUD USUÁRIO ======
procedimento cadastrarUsuario()
var
   nome : caractere
   email : caractere
   senha : caractere
   i : inteiro
   emailExiste : logico
inicio
   escreval("Digite o nome:")
   leia(nome)
   escreval("Digite o email:")
   leia(email)
   escreval("Digite a senha:")
   leia(senha)

   // --- Validação de e-mail já existente ---
   emailExiste <- falso
   para i de 1 ate qtdUsuarios faca
      se emails[i] = email entao
         emailExiste <- verdadeiro
         interrompa
      fimse
   fimpara

   se emailExiste = verdadeiro entao
      escreval("Erro: este e-mail já está cadastrado.")
   senao
      // Verificação de campos obrigatórios
      se (compr(nome) > 0) e (compr(email) > 0) e (compr(senha) > 0) entao
         qtdUsuarios <- qtdUsuarios + 1
         ids[qtdUsuarios]    <- qtdUsuarios
         nomes[qtdUsuarios]  <- nome
         emails[qtdUsuarios] <- email
         senhas[qtdUsuarios] <- senha
         escreval("Usuário cadastrado com sucesso!")
      senao
         escreval("Erro: todos os campos são obrigatórios.")
      fimse
   fimse
fimprocedimento

procedimento listarUsuarios()
var i : inteiro
inicio
   se qtdUsuarios = 0 entao
      escreval("Nenhum usuário cadastrado.")
   senao
      para i de 1 ate qtdUsuarios faca
         escreval("ID: ", ids[i], " | Nome: ", nomes[i], " | Email: ", emails[i])
      fimpara
   fimse
fimprocedimento

procedimento atualizarUsuario()
var
   id : inteiro
   novoNome : caractere
   novoEmail : caractere
inicio
   escreval("Digite o ID do usuário para atualizar:")
   leia(id)

   se (id >= 1) e (id <= qtdUsuarios) entao
      escreval("Digite o novo nome:")
      leia(novoNome)
      escreval("Digite o novo email:")
      leia(novoEmail)

      nomes[id]  <- novoNome
      emails[id] <- novoEmail
      escreval("Usuário atualizado com sucesso!")
   senao
      escreval("Usuário não encontrado.")
   fimse
fimprocedimento

procedimento deletarUsuario()
var id, i : inteiro
inicio
   escreval("Digite o ID do usuário para excluir:")
   leia(id)
   se (id >= 1) e (id <= qtdUsuarios) entao
      // shift
      para i de id ate qtdUsuarios - 1 faca
         nomes[i]  <- nomes[i + 1]
         emails[i] <- emails[i + 1]
         senhas[i] <- senhas[i + 1]
      fimpara
      qtdUsuarios <- qtdUsuarios - 1
      // reindexa IDs
      para i de 1 ate qtdUsuarios faca
         ids[i] <- i
      fimpara
      escreval("Usuário deletado com sucesso!")
   senao
      escreval("Usuário não encontrado.")
   fimse
fimprocedimento

// ====== CRUD CATEGORIA (Requisito 1) ======
procedimento cadastrarCategoria()
var
   nome, descricao : caractere
inicio
   escreval("--- CADASTRAR CATEGORIA ---")
   escreval("Digite o nome da categoria:")
   leia(nome)
   escreval("Digite a descrição:")
   leia(descricao)

   // Regra: O nome e a descrição não podem ser vazios.
   se (compr(nome) > 0) e (compr(descricao) > 0) entao
      qtdCategorias <- qtdCategorias + 1
      ids_categoria[qtdCategorias]    <- qtdCategorias
      nomes_categoria[qtdCategorias]  <- nome
      descricoes_categoria[qtdCategorias] <- descricao
      escreval("Categoria cadastrada com sucesso! ID: ", qtdCategorias)
   senao
      escreval("Erro: Nome e Descrição são obrigatórios.")
   fimse
fimprocedimento

procedimento listarCategorias()
var i : inteiro
inicio
   se qtdCategorias = 0 entao
      escreval("Nenhuma categoria cadastrada.")
   senao
      escreval("--- LISTA DE CATEGORIAS ---")
      para i de 1 ate qtdCategorias faca
         escreval("ID: ", ids_categoria[i], " | Nome: ", nomes_categoria[i], " | Descrição: ", descricoes_categoria[i])
      fimpara
      escreval("-----------------------------")
   fimse
fimprocedimento

procedimento atualizarCategoria()
var
   id : inteiro
   novoNome, novaDesc : caractere
inicio
   escreval("--- ATUALIZAR CATEGORIA ---")
   escreval("Digite o ID da categoria para atualizar:")
   leia(id)

   // Valida se ID existe
   se (id >= 1) e (id <= qtdCategorias) entao
      escreval("Digite o novo nome (Atual: ", nomes_categoria[id], "):")
      leia(novoNome)
      escreval("Digite a nova descrição (Atual: ", descricoes_categoria[id], "):")
      leia(novaDesc)

      // Regra: O nome e a descrição não podem ser vazios.
      se (compr(novoNome) > 0) e (compr(novaDesc) > 0) entao
         nomes_categoria[id]  <- novoNome
         descricoes_categoria[id] <- novaDesc
         escreval("Categoria atualizada com sucesso!")
      senao
         escreval("Erro: Nome e Descrição são obrigatórios.")
      fimse
   senao
      escreval("Categoria não encontrada.")
   fimse
fimprocedimento

procedimento deletarCategoria()
var
   id, i : inteiro
   emUso : logico
inicio
   escreval("--- DELETAR CATEGORIA ---")
   escreval("Digite o ID da categoria para excluir:")
   leia(id)

   // Valida se ID existe
   se (id >= 1) e (id <= qtdCategorias) entao
      // Verificar produtos vinculados.
      emUso <- falso
      para i de 1 ate qtdProdutos faca
         se ids_categoria_produto[i] = id entao
            emUso <- verdadeiro
            interrompa
         fimse
      fimpara

      se emUso = verdadeiro entao
         escreval("Erro: Esta categoria está sendo usada por um ou mais produtos e não pode ser excluída.")
         escreval(">> Justificativa: evitar produtos 'órfãos' de categoria.")
      senao
         // shift
         para i de id ate qtdCategorias - 1 faca
            nomes_categoria[i]  <- nomes_categoria[i + 1]
            descricoes_categoria[i] <- descricoes_categoria[i + 1]
         fimpara
         qtdCategorias <- qtdCategorias - 1

         // reindexa IDs de categoria
         para i de 1 ate qtdCategorias faca
            ids_categoria[i] <- i
         fimpara

         // Ajusta chave estrangeira dos produtos (se > antigo ID, decrementa)
         para i de 1 ate qtdProdutos faca
            se ids_categoria_produto[i] > id entao
               ids_categoria_produto[i] <- ids_categoria_produto[i] - 1
            fimse
         fimpara

         escreval("Categoria deletada com sucesso! IDs reajustados.")
      fimse
   senao
      escreval("Categoria não encontrada.")
   fimse
fimprocedimento

// ====== CRUD PRODUTO (Requisito 2) ======
procedimento cadastrarProduto()
var
   nome : caractere
   preco : real
   id_cat : inteiro
inicio
   escreval("--- CADASTRAR PRODUTO ---")

   se qtdCategorias = 0 entao
      escreval("Erro: Nenhuma categoria cadastrada. Cadastre uma categoria primeiro.")
   senao
      escreval("Digite o nome do produto:")
      leia(nome)
      escreval("Digite o preço unitário (ex: 19.99):")
      leia(preco)

      escreval("Categorias disponíveis:")
      listarCategorias()
      escreval("Digite o ID da categoria do produto:")
      leia(id_cat)

      se preco <= 0 entao
         escreval("Erro: O preço deve ser maior que zero.")
      senao
         se (id_cat < 1) ou (id_cat > qtdCategorias) entao
            escreval("Erro: ID de categoria inválido ou inexistente.")
         senao
            se compr(nome) = 0 entao
               escreval("Erro: O nome do produto é obrigatório.")
            senao
               qtdProdutos <- qtdProdutos + 1
               ids_produto[qtdProdutos]           <- qtdProdutos
               nomes_produto[qtdProdutos]         <- nome
               precos_unitario[qtdProdutos]       <- preco
               ids_categoria_produto[qtdProdutos] <- id_cat
               escreval("Produto cadastrado com sucesso! ID: ", qtdProdutos)
            fimse
         fimse
      fimse
   fimse
fimprocedimento

procedimento listarProdutos()
var
   i : inteiro
   nome_cat_produto : caractere
   id_cat_do_produto : inteiro
inicio
   se qtdProdutos = 0 entao
      escreval("Nenhum produto cadastrado.")
   senao
      escreval("--- LISTA DE PRODUTOS ---")
      para i de 1 ate qtdProdutos faca
         id_cat_do_produto <- ids_categoria_produto[i]
         nome_cat_produto <- nomes_categoria[id_cat_do_produto]

         escreval("ID: ", ids_produto[i], " | Nome: ", nomes_produto[i])
         escreval("  Preço: R$ ", precos_unitario[i], " | Categoria: (ID ", id_cat_do_produto, ") ", nome_cat_produto)
         escreval("-----------------------------")
      fimpara
   fimse
fimprocedimento

procedimento atualizarProduto()
var
   id, id_cat : inteiro
   novoNome : caractere
   novoPreco : real
inicio
   escreval("--- ATUALIZAR PRODUTO ---")
   escreval("Digite o ID do produto para atualizar:")
   leia(id)

   se (id >= 1) e (id <= qtdProdutos) entao
      escreval("Digite o novo nome (Atual: ", nomes_produto[id], "):")
      leia(novoNome)
      escreval("Digite o novo preço (Atual: ", precos_unitario[id], "):")
      leia(novoPreco)

      escreval("Categorias disponíveis:")
      listarCategorias()
      escreval("Digite o novo ID da categoria (Atual: ", ids_categoria_produto[id], "):")
      leia(id_cat)

      se novoPreco <= 0 entao
         escreval("Erro: O preço deve ser maior que zero.")
      senao
         se (id_cat < 1) ou (id_cat > qtdCategorias) entao
            escreval("Erro: ID de categoria inválido.")
         senao
            se compr(novoNome) = 0 entao
               escreval("Erro: O nome é obrigatório.")
            senao
               nomes_produto[id]           <- novoNome
               precos_unitario[id]         <- novoPreco
               ids_categoria_produto[id]   <- id_cat
               escreval("Produto atualizado com sucesso!")
            fimse
         fimse
      fimse
   senao
      escreval("Produto não encontrado.")
   fimse
fimprocedimento

procedimento deletarProduto()
var id, i : inteiro
inicio
   escreval("--- DELETAR PRODUTO ---")
   escreval("Digite o ID do produto para excluir:")
   leia(id)

   se (id >= 1) e (id <= qtdProdutos) entao
      // shift
      para i de id ate qtdProdutos - 1 faca
         nomes_produto[i]         <- nomes_produto[i + 1]
         precos_unitario[i]       <- precos_unitario[i + 1]
         ids_categoria_produto[i] <- ids_categoria_produto[i + 1]
      fimpara
      qtdProdutos <- qtdProdutos - 1
      // reindexa IDs
      para i de 1 ate qtdProdutos faca
         ids_produto[i] <- i
      fimpara
      escreval("Produto deletado com sucesso!")
   senao
      escreval("Produto não encontrado.")
   fimse
fimprocedimento


// ====== MENU PRINCIPAL ======
inicio
   // Inicializa contadores
   qtdUsuarios <- 0
   qtdCategorias <- 0
   qtdProdutos <- 0

   repita
      escreval("")
      escreval("======= API BACKEND EM PORTUGOL =======")
      escreval("--- USUÁRIOS ---")
      escreval("1 - Cadastrar Usuário (POST)")
      escreval("2 - Listar Usuários (GET)")
      escreval("3 - Atualizar Usuário (PUT)")
      escreval("4 - Deletar Usuário (DELETE)")
      escreval("--- CATEGORIAS ---")
      escreval("5 - Cadastrar Categoria")
      escreval("6 - Listar Categorias")
      escreval("7 - Atualizar Categoria")
      escreval("8 - Deletar Categoria")
      escreval("--- PRODUTOS ---")
      escreval("9 - Cadastrar Produto")
      escreval("10 - Listar Produtos")
      escreval("11 - Atualizar Produto")
      escreval("12 - Deletar Produto")
      escreval("--- GERAL ---")
      escreval("0 - Sair")
      escreval("=======================================")
      escreva("Escolha uma opção: ")
      leia(opcao)
      limpatela // Limpa a tela para melhor visualização

      escolha opcao
         // Usuário
         caso 1
            cadastrarUsuario()
         caso 2
            listarUsuarios()
         caso 3
            atualizarUsuario()
         caso 4
            deletarUsuario()

         // Categoria
         caso 5
            cadastrarCategoria()
         caso 6
            listarCategorias()
         caso 7
            atualizarCategoria()
         caso 8
            deletarCategoria()

         // Produto
         caso 9
            cadastrarProduto()
         caso 10
            listarProdutos()
         caso 11
            atualizarProduto()
         caso 12
            deletarProduto()

         // Saída
         caso 0
            escreval("Encerrando API...")

         // Inválido
         outrocaso
            escreval("Opção inválida!")
      fimescolha
   ate opcao = 0
fimalgoritmo
