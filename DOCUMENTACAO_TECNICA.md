# Documentação Técnica — StudyFlow

**Projeto:** StudyFlow (`study_flow`)  
**Plataforma:** Flutter (multiplataforma)  
**Versão do aplicativo:** 1.0.0+1  
**Escopo desta documentação:** estado implementado após a segunda unidade acadêmica, com integração Firebase (Authentication + Cloud Firestore), arquitetura em camadas, CRUD em tempo real e sistema de notificações.

---

## Sumário

1. [Visão Geral do Sistema](#1-visão-geral-do-sistema)
2. [Arquitetura do Projeto](#2-arquitetura-do-projeto)
3. [Estrutura de Pastas](#3-estrutura-de-pastas)
4. [Firebase Authentication](#4-firebase-authentication)
5. [Cloud Firestore](#5-cloud-firestore)
6. [Campo `criado_por`](#6-campo-criado_por)
7. [CRUD em Tempo Real](#7-crud-em-tempo-real)
8. [Sistema de Notificações](#8-sistema-de-notificações)
9. [Recuperação de Senha](#9-recuperação-de-senha)
10. [Serviços e Repositórios](#10-serviços-e-repositórios)
11. [Injeção de Dependências](#11-injeção-de-dependências)
12. [Segurança](#12-segurança)
13. [Funcionalidades Implementadas](#13-funcionalidades-implementadas)
14. [Tecnologias Utilizadas](#14-tecnologias-utilizadas)
15. [Fluxos Técnicos](#15-fluxos-técnicos)
16. [Gerenciamento de Estado e Navegação](#16-gerenciamento-de-estado-e-navegação)
17. [Models e Serialização](#17-models-e-serialização)
18. [Conclusão Técnica](#18-conclusão-técnica)

---

## 1. Visão Geral do Sistema

O **StudyFlow** é um aplicativo mobile desenvolvido em Flutter voltado à organização de estudos universitários. Após a segunda unidade do projeto, o sistema integra-se ao ecossistema **Firebase**, oferecendo:

- Autenticação institucional restrita ao domínio `@souunit.com.br`;
- Persistência de dados em nuvem via **Cloud Firestore**;
- Operações **CRUD** (Create, Read, Update, Delete) com **atualização em tempo real**;
- Sistema de **notificações** persistidas no Firestore, com badge visual na barra de navegação;
- Dashboard com métricas derivadas dos dados reais de matérias e metas.

O ponto de entrada da aplicação (`main.dart`) inicializa o Firebase antes de montar a interface:

```dart
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
runApp(const AplicacaoEstudoFluxo());
```

O projeto Firebase configurado é `studyflow-44f9c`, com opções geradas em `lib/firebase_options.dart`.

---

## 2. Arquitetura do Projeto

### 2.1 Padrão Arquitetural

O StudyFlow adota uma **arquitetura modular por funcionalidades**, organizada em camadas dentro de `lib/`. Cada módulo funcional (`funcionalidades/`) agrupa, quando aplicável, as subpastas `domain`, `data` e `presentation`, seguindo princípios de **separação de responsabilidades** inspirados em Clean Architecture.

### 2.2 Camadas e Responsabilidades

| Camada | Diretório(s) | Responsabilidade |
|---|---|---|
| **App** | `lib/app/` | Composição da aplicação (`MaterialApp`), shell autenticado (`PaginaPrincipal`) com abas e orquestração de estado compartilhado entre telas. |
| **Coordinator** | `lib/coordinator/` | Navegação centralizada (`CoordenadorNavegacao`), enum de rotas (`RotasNavegacao`) e injeção de dependências (`InjecaoAplicacao`). |
| **Core** | `lib/core/` | Elementos transversais: tema, cores, strings, utilitários, widgets compartilhados e helpers Firebase (`campos_firestore`, `email_usuario_logado`, `mensagem_erro_firestore`). |
| **Domain** | `lib/funcionalidades/**/domain/` e `.../model/` | Entidades de negócio (`Materia`, `MetaEstudo`, `Notificacao`, `EtapaMeta`) com regras derivadas (progresso, tempo relativo) e métodos de serialização Firestore (`fromFirestore`, `toFirestore`). |
| **Data** | `lib/funcionalidades/**/data/` | Serviços de autenticação (`ServicoAutenticacao`), repositórios Firestore e serviço de notificações. Encapsulam acesso a APIs externas (Firebase Auth, Cloud Firestore). |
| **Presentation** | `lib/funcionalidades/**/presentation/` | Telas (`pages`), widgets visuais, formulários, diálogos e integração com `StreamBuilder` para dados reativos. |

### 2.3 Fluxo de Dependências

```
Presentation  →  Data (Repositórios / Serviços)  →  Firebase SDK
      ↓                      ↓
   Domain (Models)         Core (helpers, tema, strings)
      ↓
 Coordinator + App (navegação e composição)
```

- A camada **Presentation** não acessa o Firestore diretamente; delega operações aos repositórios via `injecaoAplicacao`.
- A camada **Data** traduz documentos Firestore em entidades **Domain**.
- A camada **Core** fornece constantes de coleções/campos e utilitários de e-mail do usuário autenticado.
- O **Coordinator** desacopla a navegação da lógica de UI.

### 2.4 Módulos Funcionais

| Módulo | Camadas presentes | Integração Firebase |
|---|---|---|
| `autenticacao` | Data | Firebase Auth, Google Sign-In |
| `boas_vindas` | Presentation | — |
| `login` | Presentation | Via `ServicoAutenticacao` |
| `cadastro` | Presentation | Via `ServicoAutenticacao` |
| `dashboard` | Domain + Presentation | Leitura Firestore (metas, matérias) |
| `materias` | Domain + Data + Presentation | CRUD Firestore |
| `perfil` | Model + Data + Presentation | CRUD Firestore (metas) |
| `notificacoes` | Domain + Data + Presentation | CRUD Firestore + criação automática |
| `configuracoes` | Model + Presentation | Estado local (sem persistência) |

---

## 3. Estrutura de Pastas

### 3.1 Árvore de Diretórios (`lib/`)

```text
lib/
├── main.dart
├── firebase_options.dart
├── app/
│   ├── aplicacao_estudo_fluxo.dart
│   └── pagina_principal.dart
├── coordinator/
│   ├── coordenador_navegacao.dart
│   ├── injetor_aplicacao.dart
│   └── rotas_navegacao.dart
├── core/
│   ├── firebase/
│   │   ├── campos_firestore.dart
│   │   ├── email_usuario_logado.dart
│   │   └── mensagem_erro_firestore.dart
│   ├── strings/
│   │   └── textos_aplicacao.dart
│   ├── theme/
│   │   ├── cores_aplicacao.dart
│   │   └── tema_aplicacao.dart
│   ├── utils/
│   │   ├── dados_usuario_auth.dart
│   │   └── formatador_data.dart
│   └── widgets/
│       ├── barra_navegacao.dart
│       ├── botao_principal.dart
│       ├── cabecalho_logo.dart
│       ├── dialogo_confirmar_sair_conta.dart
│       └── item_navegacao.dart
└── funcionalidades/
    ├── autenticacao/data/
    │   ├── servico_autenticacao.dart
    │   ├── mensagens_erro_autenticacao.dart
    │   ├── entrada_google_web.dart
    │   └── entrada_google_stub.dart
    ├── boas_vindas/presentation/
    ├── cadastro/presentation/
    ├── configuracoes/
    │   ├── model/configuracoes_usuario.dart
    │   └── presentation/
    ├── dashboard/
    │   ├── domain/calculo_dashboard.dart
    │   └── presentation/
    ├── login/presentation/
    ├── materias/
    │   ├── domain/materia.dart
    │   ├── data/repositorio_materias_firestore.dart
    │   └── presentation/
    ├── notificacoes/
    │   ├── domain/models/notificacao.dart
    │   ├── data/
    │   │   ├── repositorio_notificacoes_firestore.dart
    │   │   ├── servico_notificacoes.dart
    │   │   └── notificacoes_iniciais.dart
    │   └── presentation/
    └── perfil/
        ├── model/meta_estudo.dart
        ├── data/repositorio_metas_firestore.dart
        └── presentation/
```

### 3.2 Arquivos de Configuração Firebase (raiz do projeto)

| Arquivo | Finalidade |
|---|---|
| `firebase.json` | Configuração do FlutterFire CLI e mapeamento de plataformas |
| `firestore.rules` | Regras de segurança do Cloud Firestore |
| `.firebaserc` | Identificação do projeto Firebase |
| `android/app/google-services.json` | Configuração Android |

---

## 4. Firebase Authentication

### 4.1 Visão Geral

A autenticação é centralizada na classe `ServicoAutenticacao` (`lib/funcionalidades/autenticacao/data/servico_autenticacao.dart`), que encapsula o `FirebaseAuth` e o `GoogleSignIn`.

### 4.2 Métodos de Autenticação Implementados

| Método | Descrição | Classe/Método |
|---|---|---|
| Login com e-mail e senha | `signInWithEmailAndPassword` | `ServicoAutenticacao.entrarComEmail()` |
| Cadastro com e-mail e senha | `createUserWithEmailAndPassword` + `updateDisplayName` | `ServicoAutenticacao.cadastrarComEmail()` |
| Login com Google | Popup (Web) ou fluxo nativo (Android/iOS/macOS) | `ServicoAutenticacao.entrarComGoogle()` |
| Recuperação de senha | `sendPasswordResetEmail` | `ServicoAutenticacao.enviarEmailRedefinicaoSenha()` |
| Logout | `signOut` do Auth e do Google | `ServicoAutenticacao.sair()` |

### 4.3 Validação do Domínio Institucional

O domínio permitido é definido pela constante:

```dart
const dominioInstitucional = '@souunit.com.br';
```

A função `emailPermitido(String? email)` verifica se o e-mail termina com `@souunit.com.br` (comparação case-insensitive após `trim`).

**Pontos de validação:**

1. **Cadastro:** validação antecipada em `PaginaCadastro._validarFormulario()` e em `ServicoAutenticacao.cadastrarComEmail()` antes de criar a conta.
2. **Login (e-mail/senha e Google):** após autenticação bem-sucedida, `_validarDominioOuDeslogar()` verifica o e-mail do `User`. Se o domínio não for permitido, executa logout automático (`signOut` do Firebase Auth e do Google Sign-In) e lança `DominioNaoPermitidoException`.
3. **Recuperação de senha:** `enviarEmailRedefinicaoSenha()` rejeita e-mails fora do domínio antes de chamar o Firebase.

### 4.4 Login com Google — Detalhes de Implementação

| Plataforma | Mecanismo | Arquivo |
|---|---|---|
| Web | `signInWithPopup(GoogleAuthProvider())` | `entrada_google_web.dart` |
| Android / iOS / macOS | `GoogleSignIn.signIn()` + `signInWithCredential` | `servico_autenticacao.dart` |
| Windows / Linux | Indisponível (`googleSignInDisponivel = false`) | Botão Google oculto na UI |

O `clientId` web está configurado em `idClienteWebGoogle` para autenticação em navegador.

**Exceções tratadas:**

- `DominioNaoPermitidoException` — conta fora do domínio institucional;
- `LoginCanceladoException` — usuário fechou o popup ou cancelou o fluxo Google;
- `GoogleSignInIndisponivelException` — plataforma sem suporte;
- `FirebaseAuthException` — mapeada por `mensagens_erro_autenticacao.dart`;
- `PlatformException` — erros nativos do Google Sign-In.

### 4.5 Telas de Autenticação

| Tela | Arquivo | Integração |
|---|---|---|
| `PaginaLogin` | `login/presentation/pages/pagina_login.dart` | Chama `entrarComEmail` e `entrarComGoogle` via `injecaoAplicacao` |
| `PaginaCadastro` | `cadastro/presentation/pages/pagina_cadastro.dart` | Chama `cadastrarComEmail` com nome do usuário |
| `PaginaRecuperarSenha` | `login/presentation/pages/pagina_recuperar_senha.dart` | Chama `enviarEmailRedefinicaoSenha` |

### 4.6 Fluxo Completo de Autenticação (Login com E-mail)

```
Usuário preenche e-mail e senha (PaginaLogin)
        │
        ▼
ServicoAutenticacao.entrarComEmail(email, senha)
        │
        ▼
FirebaseAuth.signInWithEmailAndPassword()
        │
        ▼
_validarDominioOuDeslogar(user)
        │
        ├── E-mail @souunit.com.br → retorna User autenticado
        │
        └── E-mail inválido → signOut() + DominioNaoPermitidoException
                │
                ▼
        SnackBar: "Apenas contas @souunit.com.br são permitidas."
        │
        ▼ (sucesso)
CoordenadorNavegacao.mostrarDashboard() → PaginaPrincipal
```

### 4.7 Observação sobre Logout na UI

O fluxo de saída da conta em `PaginaPrincipal` chama `CoordenadorNavegacao.sairConta()`, que substitui a rota atual por `PaginaLogin`. O método `ServicoAutenticacao.sair()` existe e encerra a sessão Firebase/Google, porém **não é invocado automaticamente** pelo coordenador no estado atual do código. A sessão Firebase pode permanecer ativa até nova tentativa de login.

---

## 5. Cloud Firestore

### 5.1 Coleções do Projeto

O arquivo `lib/core/firebase/campos_firestore.dart` define as constantes de coleções:

| Constante | Nome da Coleção | Repositório no App | Regras Firestore |
|---|---|---|---|
| `colecaoMaterias` | `materias` | `RepositorioMateriasFirestore` | Sim |
| `colecaoMetas` | `metas` | `RepositorioMetasFirestore` | Sim |
| `colecaoNotificacoes` | `notificacoes` | `RepositorioNotificacoesFirestore` | Sim |
| `colecaoSessoesEstudo` | `sessoes_estudo` | **Não implementado** | Sim (preparado) |

### 5.2 Coleção `materias`

**Finalidade:** armazenar as disciplinas/matérias de estudo do usuário autenticado.

| Campo | Tipo | Obrigatório | Finalidade |
|---|---|---|---|
| `nome` | `string` | Sim | Nome da matéria |
| `horas_estudadas` | `number` | Não (default 0) | Horas acumuladas de estudo |
| `progresso_percentual` | `number` | Não (default 0) | Progresso de 0 a 100 |
| `criado_por` | `string` | Sim | E-mail do usuário autenticado (Firebase Auth) |
| `criado_em` | `timestamp` | Sim (na criação) | Data/hora de criação (server timestamp) |

**Relacionamento com o usuário:** consultas filtram por `criado_por == email do usuário logado`.

**ID do documento:** gerado automaticamente pelo Firestore (`CollectionReference.add()`).

### 5.3 Coleção `metas`

**Finalidade:** armazenar metas de estudo com etapas, prazo e status de conclusão.

| Campo | Tipo | Obrigatório | Finalidade |
|---|---|---|---|
| `titulo` | `string` | Sim | Título da meta |
| `descricao` | `string` | Não | Descrição detalhada |
| `prazo` | `timestamp` | Sim | Data limite da meta |
| `concluida` | `boolean` | Não (default false) | Indica se a meta foi finalizada |
| `etapas` | `array` de `map` | Não | Lista de etapas (`id`, `texto`, `concluida`) |
| `criado_por` | `string` | Sim | E-mail do usuário autenticado |
| `criado_em` | `timestamp` | Sim (na criação) | Data/hora de criação |

**Subestrutura `etapas`:**

| Campo | Tipo | Finalidade |
|---|---|---|
| `id` | `string` | Identificador único da etapa |
| `texto` | `string` | Descrição da etapa |
| `concluida` | `boolean` | Status de conclusão da etapa |

### 5.4 Coleção `notificacoes`

**Finalidade:** persistir notificações geradas por eventos do app (CRUD de matérias/metas) e lembretes periódicos.

| Campo | Tipo | Obrigatório | Finalidade |
|---|---|---|---|
| `tipo` | `string` | Sim | Categoriza a notificação (ex.: `materia_criada`, `meta_concluida`, `lembrete_foco`) |
| `titulo` | `string` | Sim | Título exibido na UI |
| `descricao` | `string` | Não | Corpo da mensagem |
| `emoji_icone` | `string` | Não | Emoji do ícone lateral |
| `cor_fundo_icone` | `number` (ARGB32) | Não | Cor de fundo do ícone |
| `emoji_titulo` | `string` | Não | Emoji prefixo do título |
| `lida` | `boolean` | Não (default false) | Indica se o usuário marcou como lida |
| `criado_por` | `string` | Sim | E-mail do usuário autenticado |
| `criado_em` | `timestamp` | Sim (na criação) | Momento da notificação |

### 5.5 Coleção `sessoes_estudo`

**Estado atual:** a coleção possui **regras de segurança** em `firestore.rules` (mesmo padrão de `criado_por`), e a constante `colecaoSessoesEstudo` está definida em `campos_firestore.dart`. Porém, **não há repositório, serviço ou tela** que persista ou leia sessões de estudo no código Dart. O dashboard exibe valores fixos (`0h`, `0 sessões`) para métricas de sessão.

---

## 6. Campo `criado_por`

### 6.1 Definição

```dart
const String campoCriadoPor = 'criado_por';
```

Definido em `lib/core/firebase/campos_firestore.dart` como campo obrigatório em todo documento CRUD vinculado ao usuário.

### 6.2 Como é Obtido

O e-mail é extraído da sessão Firebase Auth:

```dart
String exigirEmailUsuarioLogado() {
  final email = injecaoAplicacao.servicoAutenticacao.usuarioAtual?.email;
  // Retorna e-mail trimado ou lança StateError se não autenticado
}
```

Implementado em `lib/core/firebase/email_usuario_logado.dart`.

### 6.3 Onde é Utilizado

| Operação | Momento de gravação | Repositório |
|---|---|---|
| Criar matéria | `add()` com `criado_por: email` | `RepositorioMateriasFirestore.criar()` |
| Criar meta | `add()` com `criado_por: email` | `RepositorioMetasFirestore.criar()` |
| Criar notificação | `add()` com `criado_por: email` | `RepositorioNotificacoesFirestore.criar()` |
| Leitura (todas as coleções) | Filtro `where('criado_por', isEqualTo: email)` | Todos os repositórios |
| Validação no parse | `fromFirestore()` exige `criado_por` não vazio | `Materia`, `MetaEstudo` |

### 6.4 Relação com Firebase Auth

O valor de `criado_por` corresponde ao `User.email` retornado pelo Firebase Authentication após login válido no domínio institucional. As **Firestore Security Rules** comparam `resource.data.criado_por` com `request.auth.token.email`, garantindo que cada usuário acesse apenas seus próprios documentos.

### 6.5 Importância para Rastreabilidade

- **Isolamento de dados:** cada registro é vinculado ao proprietário;
- **Auditoria:** o campo `criado_em` complementa a rastreabilidade temporal;
- **Consultas eficientes:** filtro por `criado_por` nas queries do cliente;
- **Conformidade acadêmica:** atende ao requisito de associar dados ao usuário autenticado.

### 6.6 Atendimento aos Requisitos da Atividade

O campo `criado_por` implementa o vínculo obrigatório entre dados persistidos e identidade do usuário logado, tanto na camada de aplicação (gravação e filtro) quanto na camada de infraestrutura (regras Firestore), impedindo leitura, alteração ou exclusão de documentos de terceiros.

---

## 7. CRUD em Tempo Real

### 7.1 Mecanismo Técnico

O Cloud Firestore oferece listeners reativos via `CollectionReference.snapshots()`, que retornam um `Stream<QuerySnapshot>`. A camada Presentation consome esses streams com `StreamBuilder`, reconstruindo a UI automaticamente a cada mudança no banco.

### 7.2 Operações por Entidade

#### Matérias (`RepositorioMateriasFirestore`)

| Operação | Método | Firestore API | Tela |
|---|---|---|---|
| **Create** | `criar(Materia)` | `collection.add({...})` | `ConteudoMaterias._abrirNovaMateria()` |
| **Read** | `observarMaterias()` | `where(criado_por).snapshots()` | `ConteudoMaterias` (StreamBuilder) |
| **Update** | `atualizar(Materia)` | `doc(id).update({...})` | `ConteudoMaterias._abrirEditarMateria()` |
| **Delete** | `excluir(String id)` | `doc(id).delete()` | `ConteudoMaterias._excluirMateria()` |

#### Metas (`RepositorioMetasFirestore`)

| Operação | Método | Firestore API | Tela |
|---|---|---|---|
| **Create** | `criar(MetaEstudo)` | `collection.add({...})` | `ConteudoPerfil._aoNovaMeta()` |
| **Read** | `observarMetas()` | `where(criado_por).snapshots()` | `ConteudoPerfil`, `ConteudoDashboard` |
| **Update** | `atualizar(MetaEstudo)` | `doc(id).update({...})` | Edição, toggle de etapas, conclusão |
| **Delete** | `excluir(String id)` | `doc(id).delete()` | Exclusão de meta ativa/concluída |

#### Notificações (`RepositorioNotificacoesFirestore`)

| Operação | Método | Firestore API | Tela/Serviço |
|---|---|---|---|
| **Create** | `criar(Notificacao)` | `collection.add({...})` | `ServicoNotificacoes` |
| **Read** | `observarNotificacoes()` | `where(criado_por).snapshots()` | `NotificationsPage` |
| **Update** | `marcarComoLida(String id)` | `doc(id).update({lida: true})` | `NotificationsPage._marcarComoLida()` |
| **Delete** | `excluir(String id)` | `doc(id).delete()` | `NotificationsPage._remover()` |

### 7.3 Conceitos Reativos

| Conceito | Papel no StudyFlow |
|---|---|
| **`snapshots()`** | Método Firestore que emite eventos a cada alteração na coleção consultada |
| **`Stream<T>`** | Tipo Dart retornado pelos repositórios após mapear snapshots em listas de entidades |
| **`StreamBuilder`** | Widget Flutter que escuta o stream e reconstrói a árvore de widgets em cada emissão |
| **Atualização em tempo real** | Alterações em um dispositivo ou aba refletem automaticamente na UI sem refresh manual |

### 7.4 Exemplo de Cadeia Reativa (Matérias)

```
Firestore (coleção materias)
        │ snapshots()
        ▼
RepositorioMateriasFirestore.observarMaterias()
        │ Stream<List<Materia>>
        ▼
StreamBuilder em ConteudoMaterias
        │ builder reconstrói lista de CardMateria
        ▼
UI atualizada instantaneamente
```

### 7.5 Tratamento de Erros

Erros de permissão e conexão são traduzidos por `mensagemErroFirestore()` em `lib/core/firebase/mensagem_erro_firestore.dart`, exibidos via `SnackBar` nas telas de matérias e perfil.

---

## 8. Sistema de Notificações

### 8.1 Componentes e Responsabilidades

| Componente | Arquivo | Responsabilidade |
|---|---|---|
| **`Notificacao`** (model) | `notificacoes/domain/models/notificacao.dart` | Entidade com serialização Firestore, getter `tempoRelativo` e método `copyWith` |
| **`RepositorioNotificacoesFirestore`** | `notificacoes/data/repositorio_notificacoes_firestore.dart` | CRUD, streams de listagem e badge (`observarTemNaoLidas`), limpeza de mocks |
| **`ServicoNotificacoes`** | `notificacoes/data/servico_notificacoes.dart` | Criação semântica de notificações por tipo de evento |
| **`NotificationsPage`** | `notificacoes/presentation/pages/notifications_page.dart` | UI com StreamBuilder, timer de lembrete, ações de leitura/exclusão |
| **`CardNotificacao`** | `notificacoes/presentation/widgets/card_notificacao.dart` | Card visual com estados lida/não lida |
| **`CabecalhoNotificacoes`** | `notificacoes/presentation/widgets/cabecalho_notificacoes.dart` | Título e contador de não lidas |

### 8.2 Fluxo Tela → Serviço → Repositório → Firestore

```
ConteudoMaterias / ConteudoPerfil (evento CRUD)
        │
        ▼
ServicoNotificacoes.notificarMateriaCriada() [ou método equivalente]
        │ Monta objeto Notificacao com tipo, título, emojis
        ▼
RepositorioNotificacoesFirestore.criar(notificacao)
        │ add({ ...toFirestore(), criado_por, criado_em })
        ▼
Cloud Firestore (coleção notificacoes)
        │ snapshots() emite novo estado
        ▼
NotificationsPage (StreamBuilder) + BarraNavegacao (badge)
```

### 8.3 Tipos de Notificação Automática

| Método do Serviço | Tipo (`tipo`) | Disparado por |
|---|---|---|
| `notificarMateriaCriada` | `materia_criada` | Criação de matéria |
| `notificarMateriaAtualizada` | `materia_atualizada` | Edição de matéria |
| `notificarMateriaRemovida` | `materia_removida` | Exclusão de matéria |
| `notificarMetaCriada` | `meta_criada` | Criação de meta |
| `notificarMetaAtualizada` | `meta_atualizada` | Edição de meta |
| `notificarMetaRemovida` | `meta_removida` | Exclusão de meta |
| `notificarMetaConcluida` | `meta_concluida` | Conclusão de meta |
| `notificarFoco` | `lembrete_foco` | Timer periódico (3 min) na tela de notificações |

### 8.4 Marcação como Lida e Exclusão

- **Marcar como lida:** toque em "✓ Marcar como lida" no `CardNotificacao` → `RepositorioNotificacoesFirestore.marcarComoLida(id)` → `update({lida: true})`.
- **Exclusão:** ícone de lixeira → `RepositorioNotificacoesFirestore.excluir(id)` → `delete()`.

### 8.5 Badge de Notificações Não Lidas

`PaginaPrincipal` utiliza:

```dart
StreamBuilder<bool>(
  stream: injecaoAplicacao.repositorioNotificacoes.observarTemNaoLidas(),
  builder: (context, snapshot) => BarraNavegacao(
    temNotificacoesNaoLidas: snapshot.data ?? false,
    ...
  ),
)
```

O stream consulta documentos com `lida == false` e emite `true` se houver ao menos um.

### 8.6 Indicadores Visuais

| Estado | Comportamento visual (`CardNotificacao`) |
|---|---|
| Não lida | Fundo pêssego, borda laranja, bolinha laranja, link "Marcar como lida" |
| Lida | Fundo branco, borda neutra, sem bolinha, sem link de leitura |

O `CabecalhoNotificacoes` exibe subtítulo dinâmico: "Nenhuma não lida", "1 não lida" ou "N não lidas".

### 8.7 Limpeza de Dados Legados

`RepositorioNotificacoesFirestore.limparNotificacoesMockadas()` remove documentos sem campo `tipo` ou com `tipo` vazio, herdados de versões anteriores com seed local. Executado silenciosamente no `initState` de `NotificationsPage`.

### 8.8 Timer de Lembrete de Foco

`NotificationsPage` agenda `Timer.periodic(Duration(minutes: 3))` que chama `ServicoNotificacoes.notificarFoco()`, gerando notificações de engajamento com mensagens rotativas.

---

## 9. Recuperação de Senha

### 9.1 Tela

**Widget:** `PaginaRecuperarSenha`  
**Arquivo:** `lib/funcionalidades/login/presentation/pages/pagina_recuperar_senha.dart`  
**Acesso:** link "Esqueceu sua senha?" em `PaginaLogin` → `CoordenadorNavegacao.mostrarRecuperarSenha()`

### 9.2 Fluxo de Envio

1. Usuário informa e-mail institucional;
2. Validação de campo vazio;
3. Chamada a `ServicoAutenticacao.enviarEmailRedefinicaoSenha(email)`;
4. Validação de domínio (`@souunit.com.br`) no serviço;
5. Firebase Auth envia e-mail de redefinição via `sendPasswordResetEmail`;
6. UI alterna para tela de sucesso (`_enviado = true`) com ícone e botão "Voltar ao login".

### 9.3 Integração com Firebase Auth

Utiliza exclusivamente a API `FirebaseAuth.sendPasswordResetEmail`. Não há backend customizado.

### 9.4 Validação de Domínio

E-mails fora de `@souunit.com.br` lançam `DominioNaoPermitidoException`, exibindo o texto de `TextosAplicacao.recuperarSenhaAvisoDominio`.

### 9.5 Tratamento de Erros

| Código Firebase | Mensagem ao usuário |
|---|---|
| `user-not-found` | "Não encontramos uma conta com este e-mail." |
| `invalid-email` | "E-mail inválido." |
| `too-many-requests` | "Muitas tentativas. Aguarde e tente novamente." |
| `network-request-failed` | "Sem conexão. Verifique sua internet." |
| Outros | "Não foi possível enviar o link. Tente novamente." |

Mapeamento em `mensagemErroRedefinicaoSenha()` (`mensagens_erro_autenticacao.dart`).

### 9.6 Card de Segurança

A tela exibe um card informativo (`recuperarSenhaSegurancaTitulo` / `recuperarSenhaSegurancaTexto`) orientando o usuário sobre o processo seguro de redefinição.

---

## 10. Serviços e Repositórios

### 10.1 `ServicoAutenticacao`

| Aspecto | Detalhe |
|---|---|
| **Arquivo** | `funcionalidades/autenticacao/data/servico_autenticacao.dart` |
| **Dependências** | `FirebaseAuth`, `GoogleSignIn` |
| **Responsabilidades** | Login, cadastro, Google Sign-In, recuperação de senha, validação de domínio, logout |
| **Stream** | `mudancasUsuario` (`authStateChanges`) |
| **Interações** | Consumido por telas de login/cadastro/recuperação via `injecaoAplicacao` |

### 10.2 `ServicoNotificacoes`

| Aspecto | Detalhe |
|---|---|
| **Arquivo** | `funcionalidades/notificacoes/data/servico_notificacoes.dart` |
| **Dependência** | `RepositorioNotificacoesFirestore` |
| **Responsabilidades** | Encapsular regras de negócio para criação de notificações por evento |
| **Interações** | Chamado por `ConteudoMaterias`, `ConteudoPerfil` e `NotificationsPage` (timer) |

### 10.3 `RepositorioMateriasFirestore`

| Aspecto | Detalhe |
|---|---|
| **Arquivo** | `funcionalidades/materias/data/repositorio_materias_firestore.dart` |
| **Coleção** | `materias` |
| **Métodos** | `observarMaterias`, `criar`, `atualizar`, `excluir` |
| **Interações** | `ConteudoMaterias`, `ConteudoDashboard` (contagem) |

### 10.4 `RepositorioMetasFirestore`

| Aspecto | Detalhe |
|---|---|
| **Arquivo** | `funcionalidades/perfil/data/repositorio_metas_firestore.dart` |
| **Coleção** | `metas` |
| **Métodos** | `observarMetas`, `criar`, `atualizar`, `excluir` |
| **Interações** | `ConteudoPerfil`, `ConteudoDashboard` (próxima meta, contagem) |

### 10.5 `RepositorioNotificacoesFirestore`

| Aspecto | Detalhe |
|---|---|
| **Arquivo** | `funcionalidades/notificacoes/data/repositorio_notificacoes_firestore.dart` |
| **Coleção** | `notificacoes` |
| **Métodos** | `observarNotificacoes`, `observarTemNaoLidas`, `criar`, `marcarComoLida`, `excluir`, `limparNotificacoesMockadas` |
| **Interações** | `NotificationsPage`, `PaginaPrincipal` (badge), `ServicoNotificacoes` |

### 10.6 Diagrama de Interação

```
┌─────────────────────┐     ┌──────────────────────────┐
│  PaginaLogin        │────▶│  ServicoAutenticacao     │────▶ Firebase Auth
│  PaginaCadastro     │     └──────────────────────────┘
│  PaginaRecuperarSenha│
└─────────────────────┘

┌─────────────────────┐     ┌──────────────────────────┐     ┌─────────────┐
│  ConteudoMaterias   │────▶│ RepositorioMaterias      │────▶│  Firestore  │
│  ConteudoPerfil     │     │ RepositorioMetas         │     │  materias   │
│  ConteudoDashboard  │     │ RepositorioNotificacoes  │     │  metas      │
│  NotificationsPage  │     └──────────────────────────┘     │  notificacoes│
└─────────┬───────────┘              ▲                        └─────────────┘
          │                          │
          └──────────────────────────┤
                                     │
                          ┌──────────┴───────────┐
                          │ ServicoNotificacoes  │
                          └──────────────────────┘
```

---

## 11. Injeção de Dependências

### 11.1 Classe `InjecaoAplicacao`

**Arquivo:** `lib/coordinator/injetor_aplicacao.dart`

```dart
final injecaoAplicacao = InjecaoAplicacao();

final class InjecaoAplicacao {
  final CoordenadorNavegacao coordenador = CoordenadorNavegacao();
  final ServicoAutenticacao servicoAutenticacao = ServicoAutenticacao();
  final RepositorioMetasFirestore repositorioMetas = RepositorioMetasFirestore();
  final RepositorioMateriasFirestore repositorioMaterias = RepositorioMateriasFirestore();
  final RepositorioNotificacoesFirestore repositorioNotificacoes = RepositorioNotificacoesFirestore();
  late final ServicoNotificacoes servicoNotificacoes = ServicoNotificacoes(repositorioNotificacoes);
}
```

### 11.2 Objetivo

Centralizar a criação e o compartilhamento de instâncias únicas (singleton implícito via `final injecaoAplicacao`) de serviços e repositórios, evitando instanciação dispersa nas telas.

### 11.3 Instâncias Compartilhadas

| Propriedade | Tipo | Escopo |
|---|---|---|
| `coordenador` | `CoordenadorNavegacao` | Navegação global |
| `servicoAutenticacao` | `ServicoAutenticacao` | Autenticação |
| `repositorioMetas` | `RepositorioMetasFirestore` | Persistência de metas |
| `repositorioMaterias` | `RepositorioMateriasFirestore` | Persistência de matérias |
| `repositorioNotificacoes` | `RepositorioNotificacoesFirestore` | Persistência de notificações |
| `servicoNotificacoes` | `ServicoNotificacoes` | Criação de notificações (depende do repositório) |

### 11.4 Benefícios da Centralização

- **Ponto único de configuração** para substituição em testes (construtores aceitam dependências opcionais);
- **Consistência:** todas as telas acessam a mesma instância de repositório;
- **Baixo acoplamento:** telas dependem de abstrações estáveis registradas no injetor;
- **Manutenibilidade:** adição de novos serviços requer alteração em um único arquivo.

---

## 12. Segurança

### 12.1 Firebase Authentication

- Identidade verificada pelo Firebase antes de qualquer operação Firestore;
- Restrição de domínio `@souunit.com.br` na camada de aplicação;
- Logout automático (`_validarDominioOuDeslogar`) para contas autenticadas fora do domínio;
- Mensagens de erro padronizadas sem exposição de detalhes internos em produção.

### 12.2 Regras de Domínio Institucional

Implementadas em `ServicoAutenticacao` e reforçadas na UI de cadastro e recuperação de senha. Usuários com contas Google ou e-mail de outros domínios são bloqueados após autenticação.

### 12.3 Campo `criado_por`

Garante vínculo documento ↔ usuário na gravação e nas consultas. Impede que o cliente liste dados de outros usuários (filtro `where`).

### 12.4 Firestore Security Rules

Arquivo: `firestore.rules`

Padrão aplicado a `materias`, `metas`, `sessoes_estudo` e `notificacoes`:

| Operação | Regra |
|---|---|
| **read** | `request.auth != null` AND `resource.data.criado_por == request.auth.token.email` |
| **create** | `request.auth != null` AND `request.resource.data.criado_por == request.auth.token.email` |
| **update** | Autenticado + `criado_por` inalterado + pertence ao usuário |
| **delete** | Autenticado + documento pertence ao usuário |

### 12.5 Controle de Acesso aos Dados

| Camada | Mecanismo |
|---|---|
| Cliente (Dart) | Filtro `where(criado_por, isEqualTo: email)` + `exigirEmailUsuarioLogado()` |
| Servidor (Firestore Rules) | Validação de `request.auth.token.email` vs `criado_por` |
| Serviço de notificações | Bloqueio adicional se e-mail não termina com `@souunit.com.br` |

### 12.6 Tratamento de Permissão Negada

Código `permission-denied` do Firestore é traduzido para: *"Não foi possível concluir a ação. Entre novamente na sua conta."*

---

## 13. Funcionalidades Implementadas

| Funcionalidade | Status | Tecnologia Utilizada |
|---|---|---|
| Login com e-mail e senha | ✅ Implementado | Firebase Auth |
| Cadastro de conta | ✅ Implementado | Firebase Auth |
| Google Sign-In | ✅ Implementado (Web, Android, iOS, macOS) | Firebase Auth + `google_sign_in` |
| Validação domínio `@souunit.com.br` | ✅ Implementado | `ServicoAutenticacao.emailPermitido()` |
| Logout automático (domínio inválido) | ✅ Implementado | `_validarDominioOuDeslogar()` |
| Recuperação de senha | ✅ Implementado | Firebase Auth `sendPasswordResetEmail` |
| CRUD de Matérias | ✅ Implementado | Cloud Firestore + StreamBuilder |
| CRUD de Metas | ✅ Implementado | Cloud Firestore + StreamBuilder |
| Sistema de Notificações | ✅ Implementado | Firestore + `ServicoNotificacoes` |
| Badge de notificações não lidas | ✅ Implementado | `observarTemNaoLidas()` + `StreamBuilder` |
| Dashboard | ✅ Parcial | Firestore (metas/matrías); sessões com valores fixos |
| Atualização em tempo real | ✅ Implementado | `snapshots()` + `StreamBuilder` |
| Cloud Firestore | ✅ Implementado | `cloud_firestore` ^6.5.0 |
| Firebase Auth | ✅ Implementado | `firebase_auth` ^6.5.2 |
| Tela de Configurações | ⚠️ UI apenas | Estado local, dados mockados, sem persistência |
| Sessões de estudo (timer) | ❌ Não implementado | Aba índice 2 exibe "em breve" |
| Login Apple / Facebook | ❌ Não implementado | Botões exibem "funcionalidade em breve" |
| Coleção `sessoes_estudo` | ⚠️ Regras apenas | Sem repositório ou UI |
| Logout com `signOut` Firebase | ⚠️ Parcial | `ServicoAutenticacao.sair()` existe; coordenador só navega |

---

## 14. Tecnologias Utilizadas

### 14.1 Dependências de Runtime (`pubspec.yaml`)

| Pacote | Versão | Finalidade |
|---|---|---|
| `flutter` | SDK | Framework UI multiplataforma |
| `cupertino_icons` | ^1.0.8 | Ícones estilo iOS (disponível, uso limitado) |
| `google_fonts` | ^6.2.1 | Tipografia Nunito (`construirTemaAplicacao`) |
| `firebase_core` | ^4.10.0 | Inicialização do Firebase |
| `firebase_auth` | ^6.5.2 | Autenticação de usuários |
| `google_sign_in` | ^6.2.2 | Login social com Google |
| `cloud_firestore` | ^6.5.0 | Banco de dados NoSQL em nuvem |

### 14.2 Dependências de Desenvolvimento

| Pacote | Versão | Finalidade |
|---|---|---|
| `flutter_test` | SDK | Framework de testes |
| `flutter_lints` | ^6.0.0 | Regras de análise estática |

### 14.3 Ambiente

| Item | Valor |
|---|---|
| SDK Dart | ^3.10.8 |
| Material Design | 3 (`useMaterial3: true`) |
| Projeto Firebase | `studyflow-44f9c` |

### 14.4 Assets

| Caminho | Uso |
|---|---|
| `assets/logo/logo-studyflow.png` | Logo em `CabecalhoLogo` |

---

## 15. Fluxos Técnicos

### 15.1 Fluxo de Login

```
┌──────────────┐
│ PaginaBoas   │
│ Vindas       │
└──────┬───────┘
       │ "Já tenho conta"
       ▼
┌──────────────┐     e-mail + senha      ┌─────────────────────┐
│ PaginaLogin  │ ──────────────────────▶ │ ServicoAutenticacao │
└──────┬───────┘                         │ .entrarComEmail()   │
       │                                 └──────────┬──────────┘
       │ Google (se disponível)                     │
       │ ──────────────────────────────────────────▶│ .entrarComGoogle()
       │                                            ▼
       │                                 ┌─────────────────────┐
       │                                 │ Firebase Auth       │
       │                                 └──────────┬──────────┘
       │                                            │
       │                                 ┌──────────▼──────────┐
       │                                 │ _validarDominio     │
       │                                 │ OuDeslogar()        │
       │                                 └──────────┬──────────┘
       │                          ┌─────────────────┼─────────────────┐
       │                          ▼                 ▼                 ▼
       │                    [domínio OK]    [domínio inválido]   [erro Auth]
       │                          │                 │                 │
       │                          │            signOut()         SnackBar
       │                          │            SnackBar erro
       ▼                          ▼
┌──────────────┐          ┌──────────────┐
│ PaginaLogin  │          │ PaginaPrincipal │
│ (erro)       │          │ (Dashboard)     │
└──────────────┘          └─────────────────┘
```

### 15.2 Fluxo de Recuperação de Senha

```
PaginaLogin
    │ link "Esqueceu sua senha?"
    ▼
PaginaRecuperarSenha
    │ usuário informa e-mail
    ▼
ServicoAutenticacao.enviarEmailRedefinicaoSenha()
    │
    ├── e-mail vazio → SnackBar erro
    ├── domínio inválido → DominioNaoPermitidoException → SnackBar
    ├── FirebaseAuthException → mensagemErroRedefinicaoSenha()
    └── sucesso → tela de confirmação (_enviado = true)
                      │
                      ▼
              Botão "Voltar ao login" → coordenador.voltar()
```

### 15.3 Fluxo de Criação de Notificação

```
Evento na UI (ex.: matéria criada)
        │
        ▼
ConteudoMaterias._abrirNovaMateria()
        │ repositorioMaterias.criar()
        ▼
ServicoNotificacoes.notificarMateriaCriada(nome)
        │ valida domínio do e-mail
        │ monta Notificacao(tipo: 'materia_criada', ...)
        ▼
RepositorioNotificacoesFirestore.criar()
        │ add({ campos..., criado_por, criado_em })
        ▼
Firestore: coleção notificacoes
        │ snapshots() propaga mudança
        ▼
NotificationsPage atualiza lista
PaginaPrincipal atualiza badge (observarTemNaoLidas)
```

### 15.4 Fluxo de Persistência no Firestore

```
┌─────────────┐    toFirestore()    ┌──────────────┐    add/update/delete    ┌───────────┐
│ Entidade    │ ──────────────────▶ │ Repositório  │ ──────────────────────▶ │ Firestore │
│ Domain      │                     │ Data         │  + criado_por           │           │
│ (Materia,   │ ◀────────────────── │              │  + criado_em (create)   │           │
│  Meta,      │   fromFirestore()   └──────────────┘                         └───────────┘
│  Notificacao)│
└─────────────┘
```

### 15.5 Fluxo de Atualização em Tempo Real

```
                    ┌─────────────────────────────────────┐
                    │         Cloud Firestore             │
                    │  (alteração em qualquer cliente)    │
                    └─────────────────┬───────────────────┘
                                      │ snapshots()
                                      ▼
                    ┌─────────────────────────────────────┐
                    │  Repositório.observar*()            │
                    │  .map(_mapearDocumentos)            │
                    │  → Stream<List<Entidade>>           │
                    └─────────────────┬───────────────────┘
                                      │
          ┌───────────────────────────┼───────────────────────────┐
          ▼                           ▼                           ▼
   StreamBuilder              StreamBuilder               StreamBuilder
   ConteudoMaterias           ConteudoPerfil              NotificationsPage
          │                           │                           │
          ▼                           ▼                           ▼
   Lista de cards              Metas ativas/concluídas      Cards de notificação
```

---

## 16. Gerenciamento de Estado e Navegação

### 16.1 Padrão de Estado

- **StatefulWidget + setState** para formulários, flags de carregamento e estado local de UI;
- **StreamBuilder** para dados provenientes do Firestore (padrão reativo);
- **Injeção via `injecaoAplicacao`** para serviços e repositórios compartilhados.

### 16.2 Navegação

| Componente | Responsabilidade |
|---|---|
| `CoordenadorNavegacao` | `mostrarLogin`, `mostrarCadastro`, `mostrarDashboard`, `mostrarRecuperarSenha`, `mostrarConfiguracoes`, `sairConta`, `voltar` |
| `RotasNavegacao` | Enum: `/`, `/login`, `/cadastro`, `/dashboard`, `/configuracoes`, `/recuperar-senha` |
| `EscopoCoordenadorNavegacao` | `InheritedWidget` que disponibiliza o coordenador via `context.coordenador` |
| `PaginaPrincipal` | `IndexedStack` com 5 abas: Dashboard (0), Matérias (1), Em breve (2), Notificações (3), Perfil (4) |

### 16.3 Integração Dashboard ↔ Perfil

`ConteudoDashboard` expõe callback `aoVerMeta` → `PaginaPrincipal._irParaMetasNoPerfil()` troca para aba Perfil e executa `ConteudoPerfilEstado.irParaMetas()` via `GlobalKey`, fazendo scroll até a seção de metas.

---

## 17. Models e Serialização

### 17.1 Entidades com Firestore

| Model | Arquivo | Serialização |
|---|---|---|
| `Materia` | `materias/domain/materia.dart` | `fromFirestore`, `toFirestore`, `copyWith` |
| `MetaEstudo` | `perfil/model/meta_estudo.dart` | `fromFirestore`, `toFirestore`, `copyWith` |
| `EtapaMeta` | `perfil/model/meta_estudo.dart` | `fromMap`, `toMap`, `copyWith` |
| `Notificacao` | `notificacoes/domain/models/notificacao.dart` | `fromFirestore`, `toFirestore`, `copyWith` |

### 17.2 Entidades sem Persistência

| Model | Arquivo | Observação |
|---|---|---|
| `ConfiguracoesUsuario` | `configuracoes/model/configuracoes_usuario.dart` | Modelo definido, não integrado ao Firestore |
| `ResultadoFormularioMateria` | `dialogo_formulario_materia.dart` | DTO de retorno de diálogo |

### 17.3 Funções Auxiliares Legadas

`notificacoes/data/notificacoes_iniciais.dart` contém apenas `contarNotificacoesNaoLidas()` e `temNotificacoesNaoLidas()` — helpers para listas em memória. O seed local de notificações foi substituído pela persistência Firestore.

---

## 18. Conclusão Técnica

O **StudyFlow**, em seu estado atual após a segunda unidade, representa uma evolução significativa de um protótipo com dados locais para uma aplicação com **backend em nuvem** e **autenticação institucional**.

### Arquitetura Adotada

A organização em camadas (**Presentation**, **Data**, **Domain**) dentro de módulos funcionais proporciona separação clara de responsabilidades. O módulo **Coordinator** centraliza navegação e injeção de dependências, enquanto o **Core** concentra recursos transversais.

### Integração com Firebase

A dupla **Firebase Authentication** + **Cloud Firestore** constitui a espinha dorsal de persistência e identidade. A autenticação restringe o acesso ao domínio `@souunit.com.br`, e o Firestore armazena matérias, metas e notificações com isolamento por usuário.

### Benefícios da Separação em Camadas

- Telas desacopladas da API Firebase;
- Repositórios testáveis com injeção de `FirebaseFirestore` mock;
- Models com serialização encapsulada;
- Evolução incremental (ex.: implementar `sessoes_estudo`) sem reestruturar a UI.

### Serviços e Repositórios

O padrão **Serviço de domínio** (`ServicoNotificacoes`, `ServicoAutenticacao`) + **Repositório de dados** (`Repositorio*Firestore`) separa regras de negócio do acesso a dados, facilitando manutenção e extensão.

### Persistência em Nuvem

Todos os dados críticos de matérias, metas e notificações são persistidos no Firestore com campos de rastreabilidade (`criado_por`, `criado_em`), atendendo requisitos acadêmicos de vinculação usuário-dado.

### Atualização em Tempo Real

O uso de `snapshots()`, `Stream` e `StreamBuilder` garante sincronização automática da interface com o estado do banco, eliminando necessidade de polling manual e melhorando a experiência do usuário.

### Segurança dos Dados

A combinação de validação de domínio na aplicação, campo `criado_por` nas gravações, filtros nas consultas e **Firestore Security Rules** forma uma estratégia de defesa em camadas que protege os dados de cada estudante institucional.

### Perspectivas de Evolução

Com base exclusivamente no código existente, os próximos passos naturais incluem: implementar repositório de `sessoes_estudo`, integrar `PaginaConfiguracoes` ao Firestore ou Auth, invocar `ServicoAutenticacao.sair()` no fluxo de logout e completar métricas do dashboard com dados reais de sessão.

---

*Documentação gerada com base exclusiva no código-fonte em `lib/`, `pubspec.yaml`, `firestore.rules` e arquivos de configuração Firebase do projeto StudyFlow.*
