#!/bin/bash
echo "Bem vindo ao Instalador do Animix :)"
    sleep 3
echo "Vamos começar ?"

    sleep 5
echo "Primeiro, vamos fazer algumas atualizações..."
sudo apt update && sudo apt update

echo "Gostaria de instalar uma interface gráfica ? (s/n)"
read inst
if [ \"$inst\" == \"s\" ];
then
sudo apt-get install xrdp lxde-core lxde tigervnc-standalone-server -y
else 
    sleep 5
echo "Certo, vamos continuar!"
fi

    sleep 3
echo "Vamos fazer a instalação dos containers!"

sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
sudo docker pull mysql:8.0
sudo docker run -d -p 3306:3306 --name AnimixDocker -e "MYSQL_DATABASE=animix" -e "MYSQL_ROOT_PASSWORD=urubu100" mysql:8.0
sudo docker exec -it AnimixDocker mysql --protocol tcp -u root -p -B -N -e "

    use animix;

CREATE TABLE studio(
	idStudio int primary key auto_increment,
	nomeEmpresa varchar(45),
	email varchar(45),
	senha varchar(45),
	logradouro varchar(45),
	telefone varchar(45),
	CNPJ varchar(45)
);

CREATE TABLE maquinas(
	idMaquina int primary key auto_increment,
	fkStudio int,
	disco varchar(45),
	discoIdeal decimal(5, 2) NULL,
	memoria varchar(45),
	memoriaIdeal decimal(5, 2) NULL,
	processador varchar(45),
	processamentoIdeal decimal(5, 2) NULL,
	sistema varchar(45),
	monitoraDisco bit,
	monitoraMemoria bit,
	monitoraProcessador bit,
	monitoraTemperatura bit,
	temperaturaIdeal decimal(5, 2) NULL,
	quantidadeDiscos bit,
	situacao bit,
	arquitetura varchar(45),
	fabricante varchar(45),
	permissoes varchar(45),
	inicializado varchar(45)
);

CREATE TABLE dados(
	idDado int primary key auto_increment,
	fkMaquina int,
	usoCpu decimal(5, 2) NULL,
	usoMemoria decimal(5, 2) NULL,
	temperatura decimal(5, 2) NULL,
	qtdProcessos int,
	qtdServicos int,
	dataColeta varchar(45),
	momento time,
	isCritico bit NULL,
	comment varchar(200) NULL,
	leitura decimal(5, 2) NULL,
	escrita decimal(5, 2) NULL,
	usoDisco decimal(5, 2) NULL
);

CREATE TABLE funcionario(
	idFuncionario int primary key auto_increment,
	cargo varchar(45),
	nome varchar(45),
	email varchar(45),
	senha varchar(45),
	fkStudio int
);
"
echo "Agora, vamos instalar o Container que conterá o java para executar uma aplicação Animix :)"
    sleep 3


if [ $? -eq 0 ];
then
echo "java instalado"
sudo apt install default-jre -y
    sleep 3
git clone https://github.com/alecostx/animix-data-collection.git
git clone https://github.com/Lykked/animix-data-colection-CLI.git

sudo docker build -t dockerfile .
sudo docker run -d -t --rm --name containerjava dockerfile


else
echo "java nao instalado"
echo "gostaria de instalar o java em sua Máquina Virtual? (s/n)"
read inst
if [ \"$inst\" == \"s\" ];
then
sudo apt install default-jre -y
git clone https://github.com/alecostx/animix-data-collection.git
git clone https://github.com/Lykked/animix-data-colection-CLI.git

sudo docker build -t dockerfile .
sudo docker run -d -t --name containerjava dockerfile

fi
fi