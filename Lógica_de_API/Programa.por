programa
{
	inclua biblioteca Texto --> t


	cadeia nomes[10]
	cadeia emails[10]
	cadeia senhas[10]
	inteiro qtd_usuarios = 1
	
	funcao cadastro(inteiro posicao){
		logico email_duplicado
		logico senha_invalida = verdadeiro
		logico email_invalido = verdadeiro
		
		escreva("Digite seu nome: ")
		leia(nomes[posicao])

		enquanto(email_invalido == verdadeiro) {
			email_duplicado = falso
			
			escreva("Digite seu E-Mail: ")
			leia(emails[posicao])
			// Validação de E-Mail
			se (t.posicao_texto("@", emails[posicao], 0) == -1){
				escreva("E-Mail inválido, digite novamente!\n")
			}
			// Valicação de existência de E-Mail
			se (email_invalido == verdadeiro){
				para (inteiro i=0; i < qtd_usuarios; i++) {
					se (emails[posicao] == emails[i]){
						escreva("\nERRO: Este E-Mail já está cadastrado!\n")
						email_duplicado = verdadeiro
						pare
					}
				}
				se (email_duplicado == falso) {
					escreva("\nE-Mail cadastrado com sucesso!\n")
					email_invalido = falso
				}
			}
		}

		// Validação de Senhas
		enquanto(senha_invalida == verdadeiro){
			escreva("Digite sua senha: ")
			leia(senhas[posicao])
			// Verifica a quantidade de caractéres da senha
			se (t.numero_caracteres(senhas[posicao]) < 7) {
				escreva("Senha inválida, deve ter pelo menos 8 caracteres!\n")
			} senao {
				senha_invalida = falso
			}
		}
		escreva("Usuário cadastrado com sucesso!")
		// Adição de usuário
		qtd_usuarios++
	}

	funcao buscaUser() {
		logico program = verdadeiro
		inteiro opcao
		cadeia nome_usuario

		enquanto(program == verdadeiro) {
			escreva("\n1 Buscar todos os usuários\n2 Buscar usuário específico\n0 Voltar\n:")
			leia(opcao)
			// Listagem de todos os usuários
			se (opcao == 1) {
				para (inteiro i=0; i<qtd_usuarios; i++) {
					escreva("Usuário[" + (i+1) +"]: \n" + "nome: " + nomes[i] + "\nE-Mail: " + emails[i] + "\n")
				}
			// Listagem de usuário específico por nome
			} senao se (opcao == 2) {
				escreva("Usuários cadastrados: " + qtd_usuarios + "\nDigite o nome do usuário: ")
				leia(nome_usuario)
				// Validação de usuário existente
				para(inteiro i=0; i<qtd_usuarios; i++) {
					se (nomes[i] == nome_usuario) {
						escreva("Usuário encontrado!\n" + "Nome: " + nomes[i] + "\nE-Mail: " + emails[i])	
					} senao {
						escreva("Usuário não encontrado!")	
					}
				}
			// Voltar ao painel inicial
			} senao se (opcao == 0) {
				escreva("Voltando ao início\n")
				program = falso	
			} senao {
				escreva("ERRO: Digite um valor válido\n")	
			}

			
		} 
	}

	funcao AtualizarEmail() {
		cadeia nome
		cadeia novo_email // Variável para a leitura e validação
		logico nome_encontrado = falso
		
		enquanto(nome_encontrado == falso){
			escreva("Digite o nome do usuário\n: ")
			leia(nome)
			
			logico usuario_existe = falso // Sinalizador de busca no FOR
			
			para (inteiro i=0; i<qtd_usuarios; i++){
				se (nome == nomes[i]) {
					usuario_existe = verdadeiro
					escreva("Usuário encontrado!\n")

					logico email_invalido_local = verdadeiro // Resetar o sinalizador localmente
					
					enquanto(email_invalido_local == verdadeiro) {
						logico email_duplicado = falso
						
						escreva("Digite o novo E-Mail\n: ")
						leia(novo_email) // LER UMA ÚNICA VEZ PARA A VARIÁVEL TEMPORÁRIA 'novo_email'
						
						// 1. Validação de E-Mail (Formato)
						se (t.posicao_texto("@", novo_email, 0) == -1){
							escreva("ERRO: E-Mail inválido, deve conter '@'. Digite novamente!\n")
						} senao {
							
							// 2. Validação de existência de E-Mail (Duplicidade)
							para (inteiro j=0; j < qtd_usuarios; j++) {
								se (j != i) { // Ignora a posição do usuário que está sendo atualizado
									// Compara o NOVO E-MAIL com os E-mails de outros usuários
									se (novo_email == emails[j]){ 
										escreva("\nERRO: Este E-Mail já está cadastrado!\n")
										email_duplicado = verdadeiro
										pare
									}
								}
							}
							
							// 3. Se for válido e não for duplicado, salva e sai do WHILE
							se (email_duplicado == falso) {
								emails[i] = novo_email // ATRIBUIÇÃO AO VETOR SOMENTE AQUI
								escreva("Email alterado com sucesso!\n")
								email_invalido_local = falso // Sai do WHILE
							}
						}
					}
					
					nome_encontrado = verdadeiro // Sai do WHILE principal de busca de nome
					pare // Sai do FOR de busca de nome (i)
				}
			}
			
			// Verifica se o FOR terminou sem sucesso
			se (usuario_existe == falso) {
				escreva("ERRO: Usuário não encontrado! Tente novamente.\n")
			}
		}
	}

	funcao DeletarUser() {
		logico nome_encontrado = falso
		cadeia nome
		inteiro posicao_remover
		
		enquanto(nome_encontrado == falso){
			escreva("Digite o nome do usuário\n: ")
			leia(nome)

			para (inteiro i=0; i<qtd_usuarios; i++){
				se (nome == nomes[i]) {
					escreva("Usuário encontrado!\n")
					posicao_remover = i
					para(inteiro j=posicao_remover; j<qtd_usuarios-1; j++){
						nomes[j] = nomes[j+1]
						emails[j] = emails[j+1]
						senhas[j] = senhas[j+1]
					}
					
					escreva("Usuário removido com sucesso!")
					nome_encontrado = verdadeiro
					pare
				} senao {
					escreva("Usuário não encontrado!")
				}
			}
		}
		qtd_usuarios--
	}
	
	funcao inicio() {

		logico program = verdadeiro
		inteiro opcao
		nomes[0] = "Vinicius"
		emails[0] = "vs17012005santos@gmail.com"
		senhas[0] = "vini123456"
		enquanto(program == verdadeiro) {
			escreva("\nDigite uma das opçoes a baixo: \n1 Cadastrar usuário\n2 Buscar usuários\n3 Atualizar E-Mail de usuário\n4 Excluir usuário\n5 Sair do programa\n: ")
			leia(opcao)

			// Encerrar o loop
			se(opcao == 5){
				program = falso
			// Cadastro de usuários opção 1	
			} senao se (opcao == 1) {
				escreva("-=-=-=-=-=-=-=-=-=-=-\n CADASTRO DE USUÁRIOS \n-=-=-=-=-=-=-=-=-=-=-\n")

				cadastro(qtd_usuarios)

			// Busca de usuários opção 2
			} senao se (opcao == 2) {
				escreva("-=-=-=-=-=-=-=-=-=-=-\n   BUSCA DE USUÁRIOS  \n-=-=-=-=-=-=-=-=-=-=-\n")
				buscaUser()

			// Atualizar E-Mails de Usuários existentes	
			} senao se (opcao == 3) {
				escreva("-=-=-=-=-=-=-=-=-=-=-\n  ATUALIZAR E-MAILS  \n-=-=-=-=-=-=-=-=-=-=-\n")
				AtualizarEmail()

			// Excluír usuários
			} senao se (opcao == 4) {
				escreva("-=-=-=-=-=-=-=-=-=-=-\n  EXCLUIR USUÁRIOS  \n-=-=-=-=-=-=-=-=-=-=-\n")
				DeletarUser()

			// Sair do programa
			} senao {
				escreva("Você deve digitar um valor válido!\n")	
			}
		}
		escreva("Obrigado por utilizar! SAINDO DO PROGRAMA")
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 5142; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */