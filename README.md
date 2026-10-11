# ⚙️ Gerenciador de Serviços

> Script em Bash para gerenciar serviços do **systemd** de forma interativa, com interface colorida em terminal. Exibe o status (Ativo/Inativo) e o estado no boot (enabled/disabled) de cada serviço e permite iniciar, parar, reiniciar, habilitar e desabilitar diretamente pelo menu.

![Versão](https://img.shields.io/badge/versão-3.1-blue?style=for-the-badge)
![Plataforma](https://img.shields.io/badge/plataforma-Linux-333?style=for-the-badge&logo=linux&logoColor=white)
![Shell](https://img.shields.io/badge/shell-bash-4EAA25?style=for-the-badge&logo=gnubash&logoColor=white)
![Systemd](https://img.shields.io/badge/systemd-gerenciado-000?style=for-the-badge&logo=systemd&logoColor=white)
![Licença](https://img.shields.io/badge/licença-MIT-green?style=for-the-badge)

---

> [!NOTE]
> O **Gerenciador de Serviços** centraliza o controle dos principais serviços do systemd em um único menu interativo. Em vez de digitar `sudo systemctl start/stop/restart/enable/disable` para cada serviço, você navega por um menu numerado e executa as ações com poucos toques.
>
> O script foi pensado para ser iniciado automaticamente no login via XFCE, abrindo em uma janela do `qterminal`, mas também pode ser executado manualmente em qualquer terminal.

---

## 📋 Índice

- [Sobre o Projeto](#-sobre-o-projeto)
- [Funcionalidades](#-funcionalidades)
- [Serviços Gerenciados](#-serviços-gerenciados)
- [Tecnologias Utilizadas](#-tecnologias-utilizadas)
- [Pré-requisitos](#-pré-requisitos)
- [Estrutura do Projeto](#-estrutura-do-projeto)
- [Configuração e Execução](#️-configuração-e-execução)
- [Uso](#-uso)
- [Autostart](#-autostart)
- [Licença](#-licença)
- [Autor](#-autor)

---

## 🔍 Sobre o Projeto

O **Gerenciador de Serviços** é um script Bash que centraliza o controle dos principais serviços do systemd em um único menu interativo. Ele foi criado para facilitar o dia a dia em ambientes Linux (testado no Kali), reduzindo a necessidade de comandos longos e repetitivos.

O script:

- ✅ Exibe o **status atual** (Ativo/Inativo) de cada serviço
- ✅ Exibe o **estado no boot** (enabled/disabled)
- ✅ Permite **iniciar**, **parar**, **reiniciar**, **habilitar** e **desabilitar** serviços
- ✅ Mostra **status detalhado** e **logs recentes** via `journalctl`
- ✅ Detecta automaticamente o nome real do `php-fpm` (ex: `php8.3-fpm`)
- ✅ Possui **autostart** via `.desktop` no XFCE

---

## ✨ Funcionalidades

- ✅ Exibe o **status atual** (Ativo / Inativo) de cada serviço
- ✅ Exibe o **estado no boot** (enabled / disabled) de cada serviço
- ✅ **Iniciar** serviço (`systemctl start`)
- ✅ **Parar** serviço (`systemctl stop`)
- ✅ **Reiniciar** serviço (`systemctl restart`)
- ✅ **Habilitar no boot** (`systemctl enable`)
- ✅ **Desabilitar no boot** (`systemctl disable`)
- ✅ **Ver status detalhado** (`systemctl status --no-pager`)
- ✅ **Ver logs recentes** (`journalctl -u <serviço> -n 30`)
- ✅ Detecção automática do nome real do `php-fpm`
- ✅ Interface colorida com alinhamento de colunas corrigido
- ✅ Autostart via `.desktop` no XFCE

---

## 📦 Serviços Gerenciados

| # | Serviço | Descrição |
|---|---------|-----------|
| 1 | `apache2` | Servidor web Apache |
| 2 | `mysql` | Banco de dados MySQL |
| 3 | `ssh` | Servidor OpenSSH |
| 4 | `NetworkManager` | Gerenciador de rede |
| 5 | `postgresql` | Banco de dados PostgreSQL |
| 6 | `tor` | Rede Tor |
| 7 | `openvpn` | Cliente/servidor OpenVPN |
| 8 | `docker` | Plataforma de containers |
| 9 | `bluetooth` | Serviço Bluetooth |
| 10 | `cups` | Servidor de impressão |
| 11 | `ufw` | Firewall Uncomplicated Firewall |
| 12 | `nginx` | Servidor web Nginx |
| 13 | `mongod` | Banco de dados MongoDB |
| 14 | `smbd` | Serviço Samba |
| 15 | `dnsmasq` | Servidor DNS/DHCP |
| 16 | `cloudflared` | Cloudflare Tunnel |

> [!TIP]
> Para adicionar ou remover serviços, basta editar o array `servicos` no topo do script.

---

## 🛠 Tecnologias Utilizadas

| Tecnologia | Função |
|------------|--------|
| **Bash** | Linguagem de script do projeto |
| **systemd** | Gerenciamento dos serviços (`systemctl`) |
| **journalctl** | Leitura de logs dos serviços |
| **qterminal** | Terminal usado no autostart (XFCE) |

---

## 📦 Pré-requisitos

- **Sistema operacional:** Linux com systemd (testado em **Kali Linux**)
- **Shell:** Bash 4+
- **Terminal:** qualquer um (recomendado `qterminal` para autostart no XFCE)

---

## 📁 Estrutura do Projeto

```text
Ferramentas/Gerenciadores/
├── Gerenciador_Servicos.sh          # Script principal
├── README.md                        # Este arquivo
├── LICENSE
```

O arquivo de autostart fica fora do projeto, em:

```text
~/.config/autostart/
└── gerenciador-servicos.desktop     # Atalho de inicialização do XFCE
```

> [!NOTE]
> O arquivo `.desktop` deve ser criado **com o usuário comum** (sem `sudo`), para que o XFCE o leia no login.

---

## ⚙️ Configuração e Execução

### 1️⃣ Baixar ou clonar o projeto

```bash
mkdir -p ~/Ferramentas/Gerenciadores
cd ~/Ferramentas/Gerenciadores
```

Coloque o arquivo `Gerenciador_Servicos.sh` neste diretório.

### 2️⃣ Tornar executável

```bash
chmod +x ~/Ferramentas/Gerenciadores/Gerenciador_Servicos.sh
```

### 3️⃣ Rodar manualmente (primeiro teste)

```bash
~/Ferramentas/Gerenciadores/Gerenciador_Servicos.sh
```

O menu deve abrir no terminal atual.

### 4️⃣ (Opcional) Criar o autostart

Para iniciar automaticamente no login do XFCE:

```bash
nano ~/.config/autostart/gerenciador-servicos.desktop
```

Conteúdo:

```ini
[Desktop Entry]
Name=Gerenciador de Serviços
Comment=Inicia o Gerenciador de Serviços no terminal
Exec=qterminal -e bash /home/jaison/Ferramentas/Gerenciadores/Gerenciador_Servicos.sh
Type=Application
X-GNOME-Autostart-enabled=true
```

> [!IMPORTANT]
> Crie o arquivo **sem `sudo`**, com o usuário comum. O caminho no `Exec` deve apontar para o local real do script. Ajuste `/home/jaison/...` para o seu caminho, se necessário.

### 5️⃣ Verificar se o autostart está correto

```bash
ls -la ~/.config/autostart/gerenciador-servicos.desktop
grep Exec ~/.config/autostart/gerenciador-servicos.desktop
```

---

## 📡 Uso

Ao executar o script, o menu principal é exibido:
<p align="center">
  <img src="COLE_AQUI_O_LINK_DA_IMAGEM_DO_SUBMENU" width="800"/>
  <br>
  <em>Menu principal do gerenciador de  serviços</em>
</p>

```

### Navegação

- Digite o **número do serviço** e pressione ENTER para abrir o submenu.
- Digite `0` para sair.

### Submenu de serviço

<p align="center">
  <img src="COLE_AQUI_O_LINK_DA_IMAGEM_DO_SUBMENU" width="800"/>
  <br>
  <em>Submenu de ações de um serviço</em>
</p>
```

---

## 🚀 Autostart

Para que o Gerenciador de Serviços abra automaticamente ao fazer login no XFCE, crie o arquivo `.desktop` descrito acima em `~/.config/autostart/`.

> [!TIP]
> Se quiser testar sem reiniciar a sessão, execute manualmente:
> ```bash
> qterminal -e bash ~/Ferramentas/Gerenciadores/Gerenciador_Servicos.sh
> ```

---

## 📄 Licença

Este projeto está sob a licença **MIT**. Consulte o arquivo `LICENSE` para mais detalhes.

---

## 👨‍💻 Autor

**Jaison**

- 🐙 GitHub: [@jaison](https://github.com/jaison)
- 📦 Projeto: [Gerenciador de Serviços](https://github.com/jaison/gerenciador-servicos)

<p align="center">
  <sub>💻 Built by <a href="https://github.com/jaison">Jaison</a> — Linux & Tools 🔧</sub>
</p>
