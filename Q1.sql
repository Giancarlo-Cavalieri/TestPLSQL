CREATE OR REPLACE PACKAGE Cliente IS

	TYPE cli IS RECORD (NomeCliente    		VARCHAR2(140),
						DataNascimento  	DATE,
						FaturamentoAnual    NUMBER,
						CpfCnpj     		VARCHAR2(40),
						TipoPessoa			INTEGER);
	TYPE tab_cli IS TABLE OF cli
    INDEX BY BINARY_INTEGER;
	
	TipoPessoaFisica 	CONSTANT NUMBER := 1;
	TipoPessoaJuridica 	CONSTANT NUMBER := 2;
	
	PROCEDURE AdicionarCliente (Nome VARCHAR2, Nascimento DATE, Faturamento NUMBER, Cpf_Cnpj VARCHAR2, Tipo INTEGER);
	PROCEDURE ValidarCliente (Retorno OUT INTEGER);
	PROCEDURE RetornarClientes (Ordenacao INTEGER);
	
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
	
	PROCEDURE RetornarClientes (Ordenacao INTEGER) IS


	CURSOR cli_1 IS
	
		SELECT ID, NOME, DATA_NASC, FATURAMENTO_ANUAL, CPF_CNPJ, TIPO_PESSOA
		  FROM TABELA_CLIENTES;
	
	CURSOR cli_2 IS
	
		SELECT ID, NOME, DATA_NASC, FATURAMENTO_ANUAL, CPF_CNPJ, TIPO_PESSOA
		  FROM TABELA_CLIENTES
		 ORDER BY NOME;
	
	CURSOR cli_3 IS
	
		SELECT ID, NOME, DATA_NASC, FATURAMENTO_ANUAL, CPF_CNPJ, TIPO_PESSOA
		  FROM TABELA_CLIENTES
		 ORDER BY FATURAMENTO_ANUAL;
	
	CURSOR cli_4 IS
	
		SELECT ID, NOME, DATA_NASC, FATURAMENTO_ANUAL, CPF_CNPJ, TIPO_PESSOA
		  FROM TABELA_CLIENTES
		 ORDER BY NOME, FATURAMENTO_ANUAL;
		 
	c1 cli_1%ROWTYPE;
	c2 cli_2%ROWTYPE;
	c3 cli_3%ROWTYPE;
	c4 cli_4%ROWTYPE;
	
	    
	BEGIN
	
		IF Ordenacao = 1 THEN
		
			OPEN cli_1;

			LOOP
				FETCH cli_1 INTO c1;
					IF cli_1%NOTFOUND THEN
						EXIT;
					END IF;
				
				dbms_output.put_line(c1.ID || ' - ' || c1.NOME || ' - ' || c1.DATA_NASC || ' - ' || c1.FATURAMENTO_ANUAL || ' - ' || c1.CPF_CNPJ || ' - ' || c1.TIPO_PESSOA);
				
			END LOOP;
			
			CLOSE cli_1;
		
		END IF;
		
		IF Ordenacao = 2 THEN
		
			OPEN cli_2;

			LOOP
				FETCH cli_2 INTO c2;
					IF cli_2%NOTFOUND THEN
						EXIT;
					END IF;
				
				dbms_output.put_line(c2.ID || ' - ' || c2.NOME || ' - ' || c2.DATA_NASC || ' - ' || c2.FATURAMENTO_ANUAL || ' - ' || c2.CPF_CNPJ || ' - ' || c2.TIPO_PESSOA);
				
			END LOOP;
			
			CLOSE cli_2;
		
		END IF;
		
		IF Ordenacao = 3 THEN
		
			OPEN cli_3;

			LOOP
				FETCH cli_3 INTO c3;
					IF cli_3%NOTFOUND THEN
						EXIT;
					END IF;
				
				dbms_output.put_line(c3.ID || ' - ' || c3.NOME || ' - ' || c3.DATA_NASC || ' - ' || c3.FATURAMENTO_ANUAL || ' - ' || c3.CPF_CNPJ || ' - ' || c3.TIPO_PESSOA);
				
			END LOOP;
			
			CLOSE cli_3;
		
		END IF;
		
		IF Ordenacao = 4 THEN
		
			OPEN cli_4;

			LOOP
				FETCH cli_4 INTO c4;
					IF cli_4%NOTFOUND THEN
						EXIT;
					END IF;
				
				dbms_output.put_line(c4.ID || ' - ' || c4.NOME || ' - ' || c4.DATA_NASC || ' - ' || c4.FATURAMENTO_ANUAL || ' - ' || c4.CPF_CNPJ || ' - ' || c4.TIPO_PESSOA);
				
			END LOOP;
			
			CLOSE cli_4;		
		
		END IF;
	
	END ;	
	
END Cliente;
/