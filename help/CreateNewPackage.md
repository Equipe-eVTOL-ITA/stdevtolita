# Criar um novo pacote de ROS2

Dentro da pasta src:

```bash
# para pacotes cpp
ros2 pkg create --build-type ament_cmake --node-name meu_node meu_pacote_cpp

# para pacotes python:
ros2 pkg create --build-type ament_python --node-name meu_node meu_pacote_py
```

Todos eles são no esquema de "fill the blank". Ou seja, estão esperando para serem editados!