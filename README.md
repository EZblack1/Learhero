# Learhero

Aplicativo educacional gamificado feito em Flutter. A interface está em português e inclui tela inicial, criação de herói, painel principal, aula com quiz, tela de vitória, ranking e perfil.

## Onde está o código

O projeto Flutter fica dentro da pasta:

```powershell
learnhero_flutter
```

Entre nessa pasta antes de rodar qualquer comando:

```powershell
cd learnhero_flutter
```

## Requisitos

Instale antes de começar:

- Flutter SDK
- Dart, já incluído no Flutter
- Git
- Android Studio ou VS Code, se quiser rodar no emulador/celular
- Google Chrome, se quiser rodar no navegador

Confira se o Flutter está funcionando:

```powershell
flutter doctor
```

Se aparecer algum problema, siga as instruções mostradas pelo próprio `flutter doctor`.

## Instalar dependências

Dentro da pasta `learnhero_flutter`, rode:

```powershell
flutter pub get
```

## Rodar no navegador

```powershell
flutter run -d chrome
```

Se quiser usar um servidor web local com porta fixa:

```powershell
flutter run -d web-server --web-hostname 127.0.0.1 --web-port 5190
```

Depois abra:

```text
http://127.0.0.1:5190/
```

## Rodar no Android

Conecte um celular com depuração USB ativa ou abra um emulador Android. Depois rode:

```powershell
flutter devices
flutter run
```

Se houver mais de um dispositivo, escolha um pelo ID:

```powershell
flutter run -d ID_DO_DISPOSITIVO
```

## Verificar se está tudo certo

Rode a análise do código:

```powershell
flutter analyze
```

Rode os testes:

```powershell
flutter test
```

Gerar build para Web:

```powershell
flutter build web
```

O resultado fica em:

```powershell
learnhero_flutter\build\web
```

## Comandos rápidos

```powershell
cd learnhero_flutter
flutter pub get
flutter run -d chrome
```

## Observação

A pasta `LearnHero Mobile App UI` contém o projeto original em React/Vite que serviu como referência. A versão adaptada para Flutter é a pasta `learnhero_flutter`.
