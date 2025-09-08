:: Criado em: 08/09/2025
:: Autor: João Alóca
:: Email: joao.aloca@outlook.com


@echo off

:: Dados de conexão
set "host=[hostname]"
set "port=[porta]"
set "user=[usuario]"
set "database=[nome_do_banco_de_dados]"

:: Nome do arquivo de saída
set "nome_arquivo=%database%"

:: Variáveis para a data e hora
set "data_completa=%date%"
set "hora_completa=%time%"

:: Variáveis para o dia, mês e ano
set "ano=%data_completa:~-4%"
set "mes=%data_completa:~3,2%"
set "dia=%data_completa:~0,2%"

:: Variáveis para as horas e minutos
set "horas=%hora_completa:~0,2%"
set "minutos=%hora_completa:~3,2%"

:: Variável para a mensagem de finalização
set "mensagem_sucesso=Backup finalizado com sucesso!"

:: Criação dos diretórios para separação dos arquivos de backup por ano e competência
mkdir .\%ano%\%mes%-%ano%\

:: Geração do arquivo de backup via pg_dump no formato plain-text
pg_dump -h %host% -p %port% -U %user% -d %database% -w -v -F p -f .\%ano%\%mes%-%ano%\%nome_arquivo%_%dia%%mes%%ano%_%horas%%minutos%.sql

:: Geração do arquivo de backup via pg_dump no formato custom
pg_dump -h %host% -p %port% -U %user% -d %database% -w -v -F c -f .\%ano%\%mes%-%ano%\%nome_arquivo%_%dia%%mes%%ano%_%horas%%minutos%.dmp

:: Exibição da mensagem de término do backup
echo %mensagem_sucesso%

:: pause