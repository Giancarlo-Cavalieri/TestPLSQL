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
	
END Cliente;
/