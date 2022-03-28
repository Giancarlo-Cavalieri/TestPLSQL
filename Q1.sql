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
	PROCEDURE ValidarCliente (Retorno OUT INTEGER);
	
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
		
		ValidarCliente(retorno_validacao);
        
		IF retorno_validacao > 0 THEN
		
			INSERT INTO TABELA_CLIENTES VALUES (SEQ_ID_TABELA_CLIENTES.NEXTVAL, C.NomeCliente, C.DataNascimento, C.FaturamentoAnual, C.CpfCnpj, C.TipoPessoa);
			COMMIT;
		
		END IF;
		
	END;
	
	PROCEDURE ValidarCliente (Retorno OUT INTEGER) IS
    
    PESSOA_FIS_NULO EXCEPTION;
	PESSOA_JUR_NULO EXCEPTION;
    
    BEGIN
		
		IF C.TipoPessoa = TipoPessoaFisica THEN
		
			Retorno := TipoPessoaFisica;
            
			BEGIN
            
                IF C.NomeCliente IS NULL OR C.DataNascimento IS NULL OR C.CpfCnpj IS NULL THEN
				
                    Retorno := -1;
                    RAISE PESSOA_FIS_NULO;
				
                END IF;
            
            EXCEPTION WHEN PESSOA_FIS_NULO THEN
				
				DBMS_OUTPUT.PUT_LINE('Dados para pessoa física nulo(s), por favor insira Nome, Data de Nascimento e CPF/CNPJ.');
            END;
        END IF;
        
        IF C.TipoPessoa = TipoPessoaJuridica THEN
				
				Retorno := TipoPessoaJuridica;
				
                BEGIN
                
                    IF C.NomeCliente IS NULL OR C.CpfCnpj IS NULL OR C.FaturamentoAnual IS NULL THEN
					
                        Retorno := -1;
                        RAISE PESSOA_JUR_NULO;
				
                    END IF;
                
                EXCEPTION WHEN PESSOA_JUR_NULO THEN
				
                    DBMS_OUTPUT.PUT_LINE('Dados para pessoa jurídica nulo(s), por favor insira Nome, CPF/CNPJ e Faturamento Anual.');
				END;
                
        END IF;
	END;
	
END Cliente;
/