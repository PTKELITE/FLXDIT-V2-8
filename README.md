================================================================================
README FLXDIT V2-8 (03-08-2026)
================================================================================
* link: https://github.com/PTKELITE/FLXDIT-V2-8

Bem-vindo ao FLXDIT V2-8! Este projeto é focado em fornecer um ambiente totalmente otimizado e automatizado para rodar FLUX 2 KLEIN 9B GGUF & LTX-VIDEO 2.3 CLIP LOADER UNCENSORED XXXTENSION V.2.8 diretamente no RunPod com workflows personalizados.

Este ambiente suporta fluxos de trabalho avançados, incluindo SFW, NSFW, Inpainting, Image-to-Image (I2I) e I2I + Image Reference.

--------------------------------------------------------------------------------
APOIE O PROJETO
--------------------------------------------------------------------------------
* Deploy Rápido no RunPod (Template Oficial): 
  PLAY AND RUN V2.8 (https://console.runpod.io/deploy?template=xbnsy24tdh&ref=aoxe4vh4) 

* Link de Afiliado: 
  Ganhe bônus ao criar sua conta usando meu link de indicação ref=aoxe4vh4 (https://runpod.io?ref=aoxe4vh4) .

--------------------------------------------------------------------------------
RECURSOS E AUTOMAÇÃO
--------------------------------------------------------------------------------
Não é mais necessário substituir chaves manualmente ou fazer instalações complexas passo a passo. O script all-in-one faz todo o trabalho pesado para você. Ao executá-lo, o script irá:

* Atualizar e compilar a versão mais recente e estática do FFmpeg (64-bit).
* Instalar o ComfyUI-GGUF e seus requisitos.
* Clonar automaticamente os custom nodes necessários (Crystools, Easy-Use, rgthree, etc.).
* Baixar massivamente modelos FLUX 2 e LTX, VAEs, Text Encoders (Gemma 3 12B) e LoRAs diretamente do Hugging Face e CivitAI/CivitAI Red.
* Configurar e importar fluxos de trabalho (arquivos JSON e imagens de template).
* Encerrar processos anteriores do ComfyUI e reiniciar o ambiente de forma limpa.

Nota de Armazenamento: A execução completa do ambiente requer aproximadamente 91GB de espaço.

--------------------------------------------------------------------------------
COMO INSTALAR (SCRIPT AUTOMÁTICO)
--------------------------------------------------------------------------------
Para instalar, basta abrir o Jupyter Terminal do seu Pod no RunPod e colar o código abaixo. Este comando irá baixar e executar o script portátil diretamente do repositório GitHub.

cd /workspace && \
rm -f "FLXDIT V2-8.bash" && \
wget -q --show-progress -O "FLXDIT V2-8.bash" "https://raw.githubusercontent.com/PTKELITE/FLXDIT-V2-8/refs/heads/main/FLXDIT%20V2-8.bash" && \
sed -i -e 's/\r$//' "FLXDIT V2-8.bash" && \
chmod +x "FLXDIT V2-8.bash" && \
./"FLXDIT V2-8.bash"


BAIXE O ARQUIVO E FAÇA A SUBSTITUIÇÃO DE PALAVRAS CHAVES PELAS KEYS DO CIVITAI HF E O ARQUIVO QUE VC PODE UPAR NO DRIVE E COLOCAR NA AUTOMAÇÃO GDOWN CHAMADO "FLXDIT V2-8.bash" ONDE TERA O SCRIPT COM SEUS CODS ALTERADOS COMO AS KEYS


cd /workspace && \
$(which python3) -m pip install -q gdown > /dev/null && \
rm -f "FLXDIT V2-8.bash" && \
$(which python3) -m gdown -q IDGDRIVE -O "FLXDIT V2-8.bash" && \
cd /workspace && \
sed -i -e 's/\r$//' "FLXDIT V2-8.bash" && \
chmod +x "FLXDIT V2-8.bash" && \
./"FLXDIT V2-8.bash"

--------------------------------------------------------------------------------
BUGS CONHECIDOS
--------------------------------------------------------------------------------
* Visualização ao vivo (Live Preview): O método latent2rgb foi injetado nas configurações, porém apresenta instabilidades. Por favor, selecione manualmente a opção latent2rgb na interface do ComfyUI para que a pré-visualização da geração em tempo real funcione corretamente.

--------------------------------------------------------------------------------
AUTORES
--------------------------------------------------------------------------------
...((ELITE))...

Oficialmente lançado para a comunidade.
