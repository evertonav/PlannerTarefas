# Qual o objetivo?
O objetivo desse projeto é dar a possibilidade de visualizar as tarefas feitas no dia, podendo assim apresentar por exemplo na reunião diária do scrum.

# Como configurar?
Você apenas precisa ter o FireBird 2.5 instalado na máquina e no arquivo "Planner/Win32/Debug/Configuracao.ini" as seguintes configurações:
CAMINHO=C:\Planner\BancoDados //Esse é o caminho onde fica o banco de dados, 
NOME=BANCODADOS.FDB //Esse é o nome do banco de dados,
QUAL_BANCO=0 //Esse é qual banco será utilizado, tem a possibilidade de escolher FireBird ou PostGres(0=FireBird, 1=PostGres).

Depois de configurar o caminho do banco, apenas coloque o "Planner/Win32/Debug/PlannerTrabalho.exe" e o "Planner/CadastroTarefas/Win32/Debug/CadastroTarefas.exe" 
na mesma pasta que o "Configuração.ini".

# Como usar?
Você cadastra as tarefas no "Planner/CadastroTarefas/Win32/Debug/CadastroTarefas.exe" 
![image](https://user-images.githubusercontent.com/60330947/178983460-ae3a17f2-3ae6-42a3-89ab-95fb29afed58.png)

e visualiza no "C:\Planner\Win32\Debug\PlannerTrabalho.exe"
![image](https://user-images.githubusercontent.com/60330947/178984096-1d4bdf52-c903-4779-8d36-e4a1b16e2c8b.png)

