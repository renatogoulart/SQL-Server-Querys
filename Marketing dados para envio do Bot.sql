select 
	[dbo].[tb_Valor_Cedido].[ds_Codigo], FORMAT([dbo].[tb_Valor_Cedido].mn_Valor_Cedido ,'C','PT-BR')as [Valor Cedido],[dbo].[tb_Requerente].[ds_Nome],[dbo].[tb_Requerente].nr_Celular_1,
	[dbo].[tb_Usuario].[ds_Nome], [dbo].[tb_Processo].ds_Ordem_Pagamento, [dbo].[tb_Requerente].[id_Nivel_Negociacao], 	[dbo].[tb_Requerente].ds_Cidade, [dbo].[tb_Requerente].ds_Estado,
	[dbo].[tb_Orgao_Devedor].[ds_Nome], [dbo].[tb_Requerente].ds_Email, 	max (([dbo].[tb_Advogado].ds_Nome)) as [nome do adv principal]
	
from 
	[dbo].[tb_Requerente]
inner join 	[dbo].[tb_Processo_Requerente] on [dbo].[tb_Processo_Requerente].id_Requerente = [dbo].[tb_Requerente].id_Requerente 
inner join 	[dbo].[tb_Processo] on 	[dbo].[tb_Processo].id_Processo = [dbo].[tb_Processo_Requerente].id_Processo
inner join 	[dbo].[tb_Valor_Cedido] on 	[dbo].[tb_Valor_Cedido].id_Processo = [dbo].[tb_Processo_Requerente].id_Processo and [dbo].[tb_Valor_Cedido].id_Processo_Requerente = [dbo].[tb_Processo_Requerente].id_Processo_Requerente
inner join 	[dbo].[tb_Usuario] on [dbo].[tb_Usuario].id_Usuario = [dbo].[tb_Processo_Requerente].id_Usuario_Compras
inner join 	[dbo].[tb_Orgao_Devedor] on [dbo].[tb_Orgao_Devedor].id_Orgao_Devedor = [dbo].[tb_Processo].id_Orgao_Devedor
inner join 	[dbo].[tb_Processo_Advogado] on [dbo].[tb_Processo].id_Processo = [dbo].[tb_Processo_Advogado].id_Processo
inner join 	[dbo].[tb_Advogado] on [dbo].[tb_Processo_Advogado].id_Advogado = [dbo].[tb_Advogado].id_Advogado

where 
[dbo].[tb_Processo].id_Status_Processo = 1 and [dbo].[tb_Processo_Requerente].id_Status_Requerente = 1
	and [dbo].[tb_Processo].fl_Ativo = 1 and [dbo].[tb_Processo_Requerente].fl_Ativo = 1 and [dbo].[tb_Valor_Cedido].mn_Valor_Cedido >= 40000 


group by 
	[dbo].[tb_Requerente].[ds_Nome], 	[dbo].[tb_Requerente].ds_Cidade, [dbo].[tb_Requerente].ds_Estado ,[dbo].[tb_Requerente].nr_Celular_1, [dbo].[tb_Requerente].[id_Nivel_Negociacao],
	[dbo].[tb_Valor_Cedido].[ds_Codigo], [dbo].[tb_Valor_Cedido].[mn_Valor_Cedido], 
	[dbo].[tb_Usuario].[ds_Nome],
	[dbo].[tb_Orgao_Devedor].[ds_Nome],
	[dbo].[tb_Processo].ds_Ordem_Pagamento, [dbo].[tb_Processo].ds_Vara, [dbo].[tb_Processo].ds_Vara, [dbo].[tb_Processo].ds_Motivo_Acao,
	[dbo].[tb_Requerente].ds_Email
order by
[dbo].[tb_Valor_Cedido].[ds_Codigo]