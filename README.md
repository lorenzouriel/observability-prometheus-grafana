# Subindo um Serviço de Observabilidade e Monitoria com Prometheus e Grafana
Eu adicionei todos os arquivos que utilizei na pasta `/src`. Você pode clonar o repositório e iniciar com os comandos abaixo.

## Resumo dos Arquivos:
- **Vagrantfile**: Configuração para criar e provisionar a VM com Vagrant.
- **provision.sh**: Script de provisionamento para instalar e configurar Docker na VM.
- **prometheus.yml**: Arquivo de configuração do Prometheus para definir as fontes de scrape.
- **node_exporter-1.3.0.linux-amd64.tar.gz**: Binário do Node Exporter para monitorar a máquina.

## Subindo a VM
Para iniciar a VM, use o comando:
```sh
vagrant up
```

## Acessando a VM
Sincronize e adicione os arquivos na pasta do servidor:
```sh
vagrant rsync
```

## Configuração do Node Exporter
1. Extraia os arquivos do tar:
```sh
tar -xvf node_exporter-1.3.0.linux-amd64.tar.gz
```

2. Mova os arquivos para o diretório `/opt/`:
```sh
tar -xvf node_exporter-1.3.0.linux-amd64.tar.gz
```

3. Navegue para a pasta do node_exporter:
```sh
cd /opt/node_exporter-1.3.0.linux-amd64
```

4. Execute o node exporter em background (para não travar o cmd):
```sh
nohup ./node_exporter &
```

5. Verifique os logs do nohup:
```sh
tail -f nohup.out`
```

### Testando a Conexão do Node Exporter (Opcional)
Para instalar telnet, se necessário, e testar a conexão do node exporter:
```sh
yum install telnet -y
telnet 192.168.1.6 9100
```

##  Configuração do Prometheus
Suba o Prometheus via Docker:
```sh
docker run -d -p 9090:9090 -v /vagrant/prometheus.yml:/etc/prometheus/prometheus.yml prom/prometheus
```

### Acessando as Interfaces
- Acesse a UI do Prometheus em: `http://192.168.1.6:9090`
- Acesse o node exporter em: `http://192.168.1.6:9100/metrics`

## Configuração do Grafana
1. Suba a imagem do Grafana:
```sh
docker run -d -p 3000:3000 --name grafana grafana/grafana:latest
```

2. Verifique se o Docker e o Prometheus estão no ar:
```sh
docker ps
```

3. Acesse a interface do Grafana:
    - URL: `http://192.168.1.3:3000`
    - Login padrão: `admin`
    - Senha padrão: `admin`

4. Configure a fonte de dados no Grafana:
    - Vá em **Data Sources** -> **Add data source** -> **Prometheus**
    - Em **Connection** -> **URL**, adicione: `http://192.168.1.6:9090`
    - Clique em `Save & Test`

5. Importando um Dashboard pré-configurado para o Node Exporter:
    - Acesse os dashboard nesse [repositório] e o `.json` que utilizei [aqui].
    - Copie o conteúdo do arquivo `.json` do dashboard.
    - No Grafana, vá em **Dashboards** ->  **Create Dashboard** -> **Import**.
    - Cole o conteúdo do `.json` no campo **Import**.
    - Selecione a fonte de dados **Prometheus** configurada anteriormente.
    - Clique em **Import**.

6. Seu Dashboard estará disponível e configurado.
    - ![dashboard](/image/dashboard-grafana.png)


## Arquitetura
- Eu fiz um artigo dando mais detalhes desse projeto, você pode [acessar aqui](https://lorenzouriel.github.io/posts/observability-prometheus-grafana/).