import os
# --- Estruturas de Dados Iniciais ---
usuarios = {}
categorias = {}
produtos = {}

# --- Contadores para IDs Auto-Incrementais ---
next_usuario_id = 1
next_categoria_id = 1
next_produto_id = 1

# --- Funções Auxiliares ---

def limpar_tela():
    """Limpa o console para melhor legibilidade."""
    os.system('cls' if os.name == 'nt' else 'clear')

def input_seguro_int(prompt):
    """Garante que o input do usuário seja um número inteiro válido."""
    while True:
        try:
            valor = input(prompt)
            return int(valor)
        except ValueError:
            print("Erro: Por favor, digite um número inteiro válido.")

def input_seguro_float(prompt):
    """Garante que o input do usuário seja um número float (preço) válido."""
    while True:
        try:
            valor = input(prompt)
            # Substitui vírgula por ponto para aceitar ambos os formatos
            return float(valor.replace(',', '.'))
        except ValueError:
            print("Erro: Por favor, digite um número válido (ex: 19.99).")

# --- CRUD Usuário ---

def cadastrar_usuario():
    """Simula: POST /usuarios"""
    global next_usuario_id
    print("--- CADASTRAR USUÁRIO ---")
    nome = input("Digite o nome: ")
    email = input("Digite o email: ")
    senha = input("Digite a senha: ")

    # Regra: Validação de e-mail já existente
    email_existe = False
    for user in usuarios.values():
        if user['email'] == email:
            email_existe = True
            break

    if email_existe:
        print("\nErro: Este e-mail já está cadastrado.")
        return

    # Regra: Verificação de campos obrigatórios
    if nome and email and senha:
        novo_usuario = {
            'id': next_usuario_id,
            'nome': nome,
            'email': email,
            'senha': senha # Em um app real, faríamos o HASH da senha aqui
        }
        usuarios[next_usuario_id] = novo_usuario
        print(f"\nUsuário cadastrado com sucesso! ID: {next_usuario_id}")
        next_usuario_id += 1
    else:
        print("\nErro: todos os campos são obrigatórios.")

def listar_usuarios():
    """Simula: GET /usuarios"""
    print("--- LISTA DE USUÁRIOS ---")
    if not usuarios:
        print("Nenhum usuário cadastrado.")
        return

    for user in usuarios.values():
        print(f"ID: {user['id']} | Nome: {user['nome']} | Email: {user['email']}")
    print("---------------------------")

def atualizar_usuario():
    """Simula: PUT /usuarios/{id}"""
    print("--- ATUALIZAR USUÁRIO ---")
    id_usuario = input_seguro_int("Digite o ID do usuário para atualizar: ")

    if id_usuario in usuarios:
        novo_nome = input(f"Digite o novo nome (Atual: {usuarios[id_usuario]['nome']}): ")
        novo_email = input(f"Digite o novo email (Atual: {usuarios[id_usuario]['email']}): ")

        # Validação de campos (Python considera string vazia como 'False')
        if novo_nome and novo_email:
            # Em um app real, validaríamos se o novo_email já existe
            usuarios[id_usuario]['nome'] = novo_nome
            usuarios[id_usuario]['email'] = novo_email
            print("\nUsuário atualizado com sucesso!")
        else:
            print("\nErro: Nome e Email não podem ser vazios.")
    else:
        print("\nUsuário não encontrado.")

def deletar_usuario():
    """Simula: DELETE /usuarios/{id}"""
    print("--- DELETAR USUÁRIO ---")
    id_usuario = input_seguro_int("Digite o ID do usuário para excluir: ")

    if id_usuario in usuarios:
        del usuarios[id_usuario]
        print("\nUsuário deletado com sucesso!")
        # Nota: A exclusão em dicionário é mais simples que o "shift" de vetores
    else:
        print("\nUsuário não encontrado.")

# --- CRUD Categoria (Requisito 1) ---

def cadastrar_categoria():
    """Cadastra uma nova categoria."""
    global next_categoria_id
    print("--- CADASTRAR CATEGORIA ---")
    nome = input("Digite o nome da categoria: ")
    descricao = input("Digite a descrição: ")

    # Regra: O nome e a descrição não podem ser vazios.
    if nome and descricao:
        nova_categoria = {
            'id': next_categoria_id,
            'nome': nome,
            'descricao': descricao
        }
        categorias[next_categoria_id] = nova_categoria
        print(f"\nCategoria cadastrada com sucesso! ID: {next_categoria_id}")
        next_categoria_id += 1
    else:
        print("\nErro: Nome e Descrição são obrigatórios.")

def listar_categorias(mostrar_cabecalho=True):
    """
    Lista todas as categorias cadastradas.
    Retorna True se houver categorias, False caso contrário.
    """
    if mostrar_cabecalho:
        print("--- LISTA DE CATEGORIAS ---")
        
    if not categorias:
        if mostrar_cabecalho:
            print("Nenhuma categoria cadastrada.")
        return False # Retorna False se estiver vazio

    for cat in categorias.values():
        print(f"ID: {cat['id']} | Nome: {cat['nome']} | Descrição: {cat['descricao']}")
    
    if mostrar_cabecalho:
        print("-----------------------------")
    return True # Retorna True se listou algo

def atualizar_categoria():
    """Atualiza uma categoria existente."""
    print("--- ATUALIZAR CATEGORIA ---")
    id_cat = input_seguro_int("Digite o ID da categoria para atualizar: ")

    if id_cat in categorias:
        novo_nome = input(f"Digite o novo nome (Atual: {categorias[id_cat]['nome']}): ")
        nova_desc = input(f"Digite a nova descrição (Atual: {categorias[id_cat]['descricao']}): ")

        if novo_nome and nova_desc:
            categorias[id_cat]['nome'] = novo_nome
            categorias[id_cat]['descricao'] = nova_desc
            print("\nCategoria atualizada com sucesso!")
        else:
            print("\nErro: Nome e Descrição são obrigatórios.")
    else:
        print("\nCategoria não encontrada.")

def deletar_categoria():
    """Deleta uma categoria, se não estiver em uso."""
    print("--- DELETAR CATEGORIA ---")
    id_cat = input_seguro_int("Digite o ID da categoria para excluir: ")

    if id_cat not in categorias:
        print("\nCategoria não encontrada.")
        return

    # Regra: Verificar se a categoria está sendo usada por algum produto
    em_uso = False
    for prod in produtos.values():
        if prod['id_categoria'] == id_cat:
            em_uso = True
            break
            
    if em_uso:
        print("\nErro: Esta categoria está sendo usada por um ou mais produtos e não pode ser excluída.")
        print(">> Justificativa: A exclusão é barrada para manter a integridade dos dados e evitar que produtos fiquem 'órfãos'.")
    else:
        del categorias[id_cat]
        print("\nCategoria deletada com sucesso!")

# --- CRUD Produto (Requisito 2) ---

def cadastrar_produto():
    """Cadastra um novo produto."""
    global next_produto_id
    print("--- CADASTRAR PRODUTO ---")

    # Regra: Produto precisa de categoria.
    if not categorias:
        print("\nErro: Nenhuma categoria cadastrada. Cadastre uma categoria primeiro.")
        return

    nome = input("Digite o nome do produto: ")

    # Regra: O preço deve ser maior que zero.
    preco = 0.0
    while preco <= 0:
        preco = input_seguro_float("Digite o preço unitário (ex: 19.99): ")
        if preco <= 0:
            print("Erro: O preço deve ser maior que zero.")

    print("\nCategorias disponíveis:")
    listar_categorias(mostrar_cabecalho=False) # Reutiliza a função
    print("-----------------------------")
    
    id_cat = input_seguro_int("Digite o ID da categoria do produto: ")

    # Regra: O produto precisa estar sempre vinculado a uma categoria existente.
    if id_cat not in categorias:
        print("\nErro: ID de categoria inválido ou inexistente.")
        return

    # Validação extra: nome
    if not nome:
        print("\nErro: O nome do produto é obrigatório.")
        return

    # Tudo certo, cadastrar
    novo_produto = {
        'id': next_produto_id,
        'nome': nome,
        'preco': preco,
        'id_categoria': id_cat
    }
    produtos[next_produto_id] = novo_produto
    print(f"\nProduto cadastrado com sucesso! ID: {next_produto_id}")
    next_produto_id += 1

def listar_produtos():
    """Lista todos os produtos cadastrados."""
    print("--- LISTA DE PRODUTOS ---")
    if not produtos:
        print("Nenhum produto cadastrado.")
        return

    for prod in produtos.values():
        # Busca o nome da categoria (simulando um "JOIN")
        id_cat_do_produto = prod['id_categoria']
        
        # .get() é seguro caso a categoria tenha sido deletada (embora nossa regra impeça)
        categoria_obj = categorias.get(id_cat_do_produto)
        
        if categoria_obj:
            nome_categoria = categoria_obj['nome']
        else:
            # Isso não deve acontecer devido à nossa trava em deletar_categoria
            nome_categoria = "CATEGORIA INVÁLIDA" 
            
        print(f"ID: {prod['id']} | Nome: {prod['nome']}")
        # Formata o preço para 2 casas decimais (ex: 19.90)
        print(f"  Preço: R$ {prod['preco']:.2f} | Categoria: (ID {id_cat_do_produto}) {nome_categoria}")
        print("-----------------------------")

def atualizar_produto():
    """Atualiza um produto existente."""
    print("--- ATUALIZAR PRODUTO ---")
    id_prod = input_seguro_int("Digite o ID do produto para atualizar: ")

    if id_prod in produtos:
        produto_atual = produtos[id_prod]
        
        novo_nome = input(f"Digite o novo nome (Atual: {produto_atual['nome']}): ")
        
        novo_preco = 0.0
        while novo_preco <= 0:
            novo_preco = input_seguro_float(f"Digite o novo preço (Atual: {produto_atual['preco']:.2f}): ")
            if novo_preco <= 0:
                print("Erro: O preço deve ser maior que zero.")

        print("\nCategorias disponíveis:")
        listar_categorias(mostrar_cabecalho=False)
        print("-----------------------------")
        novo_id_cat = input_seguro_int(f"Digite o novo ID da categoria (Atual: {produto_atual['id_categoria']}): ")

        # Validações
        if not novo_nome:
            print("\nErro: O nome é obrigatório.")
            return
        if novo_id_cat not in categorias:
            print("\nErro: ID de categoria inválido.")
            return

        # Atualiza
        produtos[id_prod]['nome'] = novo_nome
        produtos[id_prod]['preco'] = novo_preco
        produtos[id_prod]['id_categoria'] = novo_id_cat
        print("\nProduto atualizado com sucesso!")
    else:
        print("\nProduto não encontrado.")

def deletar_produto():
    """Deleta um produto existente."""
    print("--- DELETAR PRODUTO ---")
    id_prod = input_seguro_int("Digite o ID do produto para excluir: ")

    if id_prod in produtos:
        del produtos[id_prod]
        print("\nProduto deletado com sucesso!")
    else:
        print("\nProduto não encontrado.")

# --- Menu Principal ---

def menu_principal():
    """Exibe o menu principal e gerencia o loop do programa."""
    while True:
        print("\n======= API BACKEND EM PYTHON =======")
        print("--- USUÁRIOS ---")
        print(" 1 - Cadastrar Usuário (POST)")
        print(" 2 - Listar Usuários (GET)")
        print(" 3 - Atualizar Usuário (PUT)")
        print(" 4 - Deletar Usuário (DELETE)")
        print("--- CATEGORIAS ---")
        print(" 5 - Cadastrar Categoria")
        print(" 6 - Listar Categorias")
        print(" 7 - Atualizar Categoria")
        print(" 8 - Deletar Categoria")
        print("--- PRODUTOS ---")
        print(" 9 - Cadastrar Produto")
        print(" 10 - Listar Produtos")
        print(" 11 - Atualizar Produto")
        print(" 12 - Deletar Produto")
        print("--- GERAL ---")
        print(" 0 - Sair")
        print("=======================================")
        
        opcao = input_seguro_int("Escolha uma opção: ")
        limpar_tela()

        if opcao == 1:
            cadastrar_usuario()
        elif opcao == 2:
            listar_usuarios()
        elif opcao == 3:
            atualizar_usuario()
        elif opcao == 4:
            deletar_usuario()
        elif opcao == 5:
            cadastrar_categoria()
        elif opcao == 6:
            listar_categorias()
        elif opcao == 7:
            atualizar_categoria()
        elif opcao == 8:
            deletar_categoria()
        elif opcao == 9:
            cadastrar_produto()
        elif opcao == 10:
            listar_produtos()
        elif opcao == 11:
            atualizar_produto()
        elif opcao == 12:
            deletar_produto()
        elif opcao == 0:
            print("Encerrando API...")
            break
        else:
            print("Opção inválida! Tente novamente.")
            
        # Pausa para o usuário ler a saída
        if opcao != 0:
            input("\nPressione Enter para continuar...")
            limpar_tela()

# --- Ponto de Entrada do Script ---
if __name__ == "__main__":
    menu_principal()