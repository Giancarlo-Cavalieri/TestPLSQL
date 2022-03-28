CREATE OR REPLACE PACKAGE Cliente IS

	TYPE cli IS RECORD (NomeCliente    		VARCHAR2(140),
						DataNascimento  	DATE,
						FaturamentoAnual    NUMBER,
						CpfCnpj     		VARCHAR2(12),
						TipoPessoa			INTEGER);
	TYPE tab_cli IS TABLE OF cli
    INDEX BY BINARY_INTEGER;
	
	TipoPessoaFisica 	CONSTANT NUMBER := 1;
	TipoPessoaJuridica 	CONSTANT NUMBER := 2;
	
	PROCEDURE AdicionarCliente (Nome VARCHAR2, Nascimento DATE, Faturamento NUMBER, Cpf_Cnpj VARCHAR2, Tipo INTEGER);
	
END Cliente;
/

CREATE OR REPLACE PACKAGE BODY Cliente IS
	
	C cli;
	
	PROCEDURE AdicionarCliente (Nome 		VARCHAR2, 
	                            Nascimento 	DATE, 
								Faturamento NUMBER, 
								Cpf_Cnpj 	VARCHAR2, 
								Tipo 		INTEGER) IS
    
        retorno_validacao number;
        
    BEGIN
	
		C.NomeCliente := Nome;
		C.DataNascimento := Nascimento;
		C.FaturamentoAnual := Faturamento;
		C.CpfCnpj := Cpf_Cnpj;
		C.TipoPessoa := Tipo;
        
		INSERT INTO TABELA_CLIENTES VALUES (SEQ_ID_TABELA_CLIENTES.NEXTVAL, C.NomeCliente, C.DataNascimento, C.FaturamentoAnual, C.CpfCnpj, C.TipoPessoa);
		COMMIT;
		
		
	END;
END Cliente;
/