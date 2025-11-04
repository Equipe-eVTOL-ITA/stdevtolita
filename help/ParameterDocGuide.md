# Como Documentar Parâmetros no ROS2

## 1. O Problema

À medida que nossos projetos crescem, o número de parâmetros nos arquivos `.yaml` aumenta. Após alguns meses, fica difícil lembrar o que cada parâmetro faz, quais são seus limites ou suas unidades.

## 2. A Solução: `ParameterDescriptor`

Para resolver isso, adotaremos a abordagem idiomática do ROS2: **a documentação de um parâmetro deve viver *dentro* do nó (C++/Python) que o declara**, não no arquivo `.yaml`.

O arquivo `.yaml` deve conter apenas os **valores** que sobrescrevem os padrões.

Usamos a struct `rcl_interfaces::msg::ParameterDescriptor` no momento da declaração (`declare_parameter`) para fornecer metadados, incluindo:
* `description`: A explicação em texto do que o parâmetro faz.
* `type`: O tipo de dado esperado (ex: `PARAMETER_DOUBLE`).
* `floating_point_range` / `integer_range`: Validação automática de limites (mínimo e máximo).
* `read_only`: Se o parâmetro pode ser alterado em tempo de execução.

## 3. Como Implementar (Exemplos em C++)

Sempre inclua os cabeçalhos necessários no topo do seu arquivo `.cpp`:

```cpp
#include "rcl_interfaces/msg/parameter_descriptor.hpp"
#include "rcl_interfaces/msg/floating_point_range.hpp"
#include "rcl_interfaces/msg/integer_range.hpp"
```

### Descrição com validação de intervalo:
```cpp
// Declara um parâmetro booleano com descrição
this->declare_parameter("at_home", false, 
    rcl_interfaces::msg::ParameterDescriptor{
        .description = "Flag que indica se o drone está atualmente na posição home.",
        .type = rclcpp::ParameterType::PARAMETER_BOOLEAN
    }
);

// Declara um parâmetro de checkpoint
this->declare_parameter("checkpoint_1_espera_janela", true, 
    rcl_interfaces::msg::ParameterDescriptor{
        .description = "Se verdadeiro (true), o drone deve aguardar "
                       "a passagem pela janela neste checkpoint.",
        .type = rclcpp::ParameterType::PARAMETER_BOOLEAN
    }
);
```

### Parâmetro apenas para leitura
```cpp
// Declara um parâmetro que não pode ser alterado em execução
this->declare_parameter("known_base_radius", 1.5, 
    rcl_interfaces::msg::ParameterDescriptor{
        .description = "Raio conhecido (em metros) da base de pouso.",
        .type = rclcpp::ParameterType::PARAMETER_DOUBLE,
        .read_only = true // Impede o uso de 'ros2 param set'
    }
);
```

## Por que fazer isso?

1. Documentação ativa e introspectiva:

Qualquer pessoa (incluindo você daqui a 6 meses) pode descobrir o que um parâmetro faz pelo terminal.

```bash
ros2 param describe /fase4_fsm max_vertical_velocity
```

Saída:

```text
Parameter 'max_vertical_velocity':
  Type: double
  Description: 'Velocidade vertical máxima (m/s) durante o voo normal.'
  Constraints:
    From 0.1 to 2.0
```

2. Validação automática:

Se alguém (ou um arquivo .yaml antigo) tentar definir max_vertical_velocity: 5.0, o ROS2 irá automaticamente emitir um aviso no log informando que o valor está fora do range definido (0.1 a 2.0), prevenindo bugs.

3. Arquivos .yaml limpos

4. Manutenção simplificada

A documentação está colada na lógica que a utiliza. Se você refatorar o código e um parâmetro mudar, você verá a descrição e a validação ali mesmo e será lembrado de atualizá-la.