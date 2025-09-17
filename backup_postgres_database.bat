@echo off

:: DECLARAÇÃO E INICIALIZAÇÃO DAS VARIÁVEIS

    ::CONEXÃO COM O BANCO DE DADOS

        :: Dados de conexão com o servidor
        set "host=[ip_host]"
        set "port=[porta]"
        set "user=[user]"

        :: Nome do banco de dados
        set "database=[nome_banco]"
    ::

    :: DATA E HORA

        :: Data
        set "ano=%date:~-4%"
        set "mes=%date:~3,2%"
        set "dia=%date:~0,2%"

        :: Horas
        set "horas=%time:~0,2%"
        set "minutos=%time:~3,2%"
    ::

    :: ARQUIVO DE BACKUP

        :: Caminho do arquivo
        set "backup_path=.\%ano%\%mes%.%ano%"

        :: Nome do arquivo
        set "backup_file_name=%database%_%dia%%mes%%ano%_%horas%%minutos%"
    ::

::

:: CRIAÇÃO DA ESTRUTURA DE DIRETÓRIOS
    
    :: Verificando se a estrutura de diretórios já existe
    if not exist %backup_path% (
        mkdir %backup_path%
    )
::


:: EXECUÇÃO DO PG_DUMP
    
	:: Geração do arquivo de backup no formato plain-text
    @REM pg_dump -h %host% -p %port% -U %user% -d %database% -w -v -F p -f "%backup_path%\%backup_file_name%.sql"

    :: Geração do arquivo de backup no formato custom
    @REM pg_dump -h %host% -p %port% -U %user% -d %database% -w -v -F c -f "%backup_path%\%backup_file_name%.dmp"

    :: Geração do arquivo de backup no formato custom com extensão .backup
	pg_dump -h %host% -p %port% -U %user% -d %database% -v -F c -f "%backup_path%\%backup_file_name%.backup"
::

:: pause
