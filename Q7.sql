BEGIN

    
	Cliente.AdicionarCliente('Ryan Yuri Almada', to_date('18/05/1975','dd/mm/yyyy'), 0,      '953.731.960-10',   1);
	Cliente.AdicionarCliente('Marcos Carlos Eduardo', TO_DATE('25/12/1982','DD/MM/YYYY'), 0, '936.373.310-63', 1);
	Cliente.AdicionarCliente('Nicolas e Márcio Alimentos ME', Null, 500000, '52.863.067/0001-53', 2);
	Cliente.AdicionarCliente('Hadassa e Theo Comercio de Bebidas LTDA', Null, 1405000,  '67.022.821/0001-08', 2);
	Cliente.AdicionarCliente('Tiago Cauê César', TO_DATE('10/02/1995','DD/MM/YYYY'), 0, '614.579.220-53', 1);

END;
/