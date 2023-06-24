FROM adoptopenjdk:latest

RUN apt-get update && apt-get install -y git zip unzip
RUN curl -s "https://get.sdkman.io" | bash
RUN bash -c "source $HOME/.sdkman/bin/sdkman-init.sh && sdk install gradle"

WORKDIR /app

# Configurações do Git
RUN git config --global user.name "${USER_GIT}"
RUN git config --global user.email "${EMAIL_GIT}"

# Verifica se o diretório /app está vazio
RUN if [ ! -d /app ]; then \
      git clone https://github.com/Narvane/web-flux-studies.git .; \
    fi

# Verifica se os arquivos/diretórios existem antes de copiá-los e executar o comando
RUN if [ -f ./gradlew ] && [ -f ./build.gradle ] && [ -d .gradle ]; then \
      cp -R .gradle /root/.gradle; \
      cp build.gradle .; \
      cp gradlew .; \
      ./gradlew dependencies; \
fi

CMD ["sleep", "infinity"]