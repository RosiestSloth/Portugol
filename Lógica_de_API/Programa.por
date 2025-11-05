programa
{
	inclua biblioteca Texto --> t


	cadeia nomes[10]
	cadeia emails[10]
	cadeia senhas[10]
	inteiro qtd_usuarios = 1
	logico senha_invalida = verdadeiro
	logico email_invalido = verdadeiro
	
	funcao cadastro(inteiro posicao){
		escreva("Digite seu nome: ")
		leia(nomes[posicao])

		enquanto(email_invalido == verdadeiro) {
			escreva("Digite seu E-Mail: ")
			leia(emails[posicao])

			se (t.posicao_texto("@", emails[posicao], 0) == -1){
				escreva("E-Mail inválido, digite novamente!\n")	
			} senao {
				escreva("E-Mail cadastrado com sucesso!\n")
				email_invalido = falso	
			}
		}
		
		enquanto(senha_invalida == verdadeiro){
			escreva("Digite sua senha: ")
			leia(senhas[posicao])

			se (t.numero_caracteres(senhas[posicao]) <= 8) {
				escreva("Senha inválida, deve ter pelo menos 8 caracteres!\n")
			} senao {
				escreva("Senha cadastrada com sucesso!\n")
				senha_invalida = falso
			}
		}
		escreva("Usuário cadastrado com sucesso!")
		qtd_usuarios++
	}

	funcao busca_User() {
		logico program = verdadeiro
		inteiro opcao
		inteiro num_usuario
		
		enquanto(program == verdadeiro) {
			escreva("1 Listar todos os usuários\n2 Listar usuário específico\n0 Voltar\n:")
			leia(opcao)
			se (opcao == 1) {
				para (inteiro i=0; i<qtd_usuarios; i++) {
					escreva("Usuário[" + i +"]: \n" + "nome: " + nomes[i] + "\nE-Mail: " + emails[i] + "\n")
				}
			} senao se (opcao == 2) {
				escreva("Usuários cadastrados: " + qtd_usuarios + "\nDigite um número da quantidade de usuários cadastrados: ")
				leia(num_usuario)

				se (num_usuario > qtd_usuarios e num_usuario < 0) {
					escreva("ERRO: Digite um valor válido!\n")
				} senao {
					escreva("Nome: " + nomes[num_usuario] + "\nE-Mail: " + emails[num_usuario] + "\n")	
				}
			} senao se (opcao == 0) {
				escreva("Voltando ao início\n")
				program = falso	
			} senao {
				escreva("ERRO: Digite um valor válido\n")	
			}

			
		} 
	}
	
	funcao inicio() {

		logico program = verdadeiro
		inteiro opcao
		nomes[0] = "Vinicius"
		emails[0] = "email@gmail.com"
		senhas[0] = "vini123456"
		enquanto(program == verdadeiro) {
			escreva("Digite uma das opçoes a baixo: \n1 Cadastrar usuário\n2 Buscar usuários\n3 Atualizar E-Mail de usuário\n4 Excluir usuário\n5 Sair do programa\n: ")
			leia(opcao)

			// Encerrar o loop
			se(opcao == 5){
				program = falso
			// Cadastro de usuários opção 1	
			} senao se (opcao == 1) {
				escreva("-=-=-=-=-=-=-=-=-=-=-\n CADASTRO DE USUÁRIOS \n-=-=-=-=-=-=-=-=-=-=-\n")

				cadastro(qtd_usuarios+1)

			// Busca de usuários opção 2
			} senao se (opcao == 2) {
				escreva("-=-=-=-=-=-=-=-=-=-=-\n   BUSCA DE USUÁRIOS  \n-=-=-=-=-=-=-=-=-=-=-\n")
				busca_User()
			} senao se (opcao == 3) {
				escreva("-=-=-=-=-=-=-=-=-=-=-\n  ATUALIZAR E-MAILS  \n-=-=-=-=-=-=-=-=-=-=-\n")	
			} senao se (opcao == 4) {
				escreva("-=-=-=-=-=-=-=-=-=-=-\n  EXCLUIR USUÁRIOS  \n-=-=-=-=-=-=-=-=-=-=-\n")	
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
 * @POSICAO-CURSOR = 1502; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */