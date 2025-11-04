# Clonei esse repositório. E agora?

# 1. Chamar os submódulos

Rode o script submodules.sh

# 2. Crie o seu pacote ROS2

Siga o tutorial em CreateNewPackage.md

# 3. Altere os arquivos .sh de acordo com o seu projeto

## build.sh

```bash
PACKAGES=("coloque aqui, em lista, o nome dos pacotes a serem compilados")
```

## simulate.sh

```bash
case $1 in
    NOME_DA_MISSAO) 
        PX4_GZ_MODEL_POSE="0.0, 0.0, 0.05, 0.0, 0.0, 0.0"
        PX4_SIM_MODEL=x500_simulation
        ;;
esac
```

# 4. Altere o tasks.json do vscode

```json
"inputs": [
        {
            "id" : "sim_world",
            "description": "Choose World to launch from",
            "type": "pickString",
            "options": [
                "NOME_DO_MUNDO",
            ],
            "default": "sae1"
        },
        {
            "id" : "buildFolder",
            "description": "Which targets to build?",
            "type": "pickString",
            "options": [
                "all",
                "dependencies",
                "custom_msgs",
                "NOME DO PACOTE"
            ],
            "default": "all"
        },
]
```