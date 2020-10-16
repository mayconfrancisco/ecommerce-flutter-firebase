flutter create --org <br.com.meupacote> -a java -i objc --androidx <nome_projeto>


pubspec.yaml:

    flutter_staggered_grid_view: ^0.3.0
    cloud_firestore: ^0.12.9
    carousel_pro: ^1.0.0
    transparent_image: ^1.0.0
    scoped_model: ^1.0.1
    firebase_auth: ^0.11.1+12
    url_launcher: ^5.1.1


build.gradle:

    classpath 'com.android.tools.build:gradle:3.3.0'
    classpath 'com.google.gms:google-services:4.3.0'


Migrar para AndroidX




Configurar projeto no FIREBASE
ANDROID: basta seguir o painel de configuração do proprio firebase
iOS: Pode ser mais simples configurar conforme a aula 127 do cioffi - baixa o plist, cola na pasta Runner, abre o XCode e da um Mouse lado direito na pasta Runner e Add files to project, seleciona o arquivo plist, garanta que ele esta flagado no checkbox e da um Add.
Em seguida ajusta o info.plist com o seguinte trecho de codigo bem no final antes do fechamento da tag Dict:

<!-- Google Sign-in Section -->
<!-- Copiar esse item e substituir o REVERSED_CLIENT_ID que veio no GoogleService-Info.plist -->
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleTypeRole</key>
        <string>Editor</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <!-- Copied from GoogleService-Info.plist key REVERSED_CLIENT_ID -->
            <string>com.googleusercontent.apps.324790123371-0nbn15nhcm8uiqdc0u8up1t9v5cj08bh</string>
        </array>
    </dict>
</array>

