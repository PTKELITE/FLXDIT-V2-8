#FLXDIT V2-8 27-07-2026 01-39 OK!

#--------------- roda e executa all-in-one 27-07-2026 (SIZE ~91GB) OK
if false; then

cd /workspace && \
$(which python3) -m pip install -q gdown > /dev/null && \
rm -f "FLXDIT V2-8.bash" && \
$(which python3) -m gdown -q 11ov-qI4Zq-bvKRbt8mzuS9t2ELhK41JD -O "FLXDIT V2-8.bash" && \
cd /workspace && \
sed -i -e 's/\r$//' "FLXDIT V2-8.bash" && \
chmod +x "FLXDIT V2-8.bash" && \
./"FLXDIT V2-8.bash"

fi


#------------CODIGO DE EXECUÇÃO TESTADO 18/07/2026 10:45 --------------------------------------------------
# ==========================================
# FUNÇÃO AUXILIAR DE VALIDAÇÃO
# ==========================================
check_status() {
    if [ $? -eq 0 ]; then
        echo -e "[\e[32m OK \e[0m] $1 concluído com sucesso."
    else
        echo -e "[\e[31mERRO\e[0m] Falha em: $1. Verifique os logs acima."
        exit 1
    fi
}

echo -e "\n\e[34m=== INICIANDO CONFIGURAÇÃO COMPLETA DO AMBIENTE COMFYUI ===\e[0m\n"

# FFMPG UPDATE -----------------------------
# 1. Baixa a versão estática compilada mais recente (64-bit)
ffmpeg -version && \
cd /tmp && \
wget -q --show-progress https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz && \

# 2. Despacta os arquivos
tar -xf ffmpeg-release-amd64-static.tar.xz && \

# 3. Move os executáveis para o diretório do sistema
cp ffmpeg-*-amd64-static/ffmpeg /usr/local/bin/ && \
cp ffmpeg-*-amd64-static/ffprobe /usr/local/bin/ && \

# 4. Garante permissão de execução e limpa arquivos temporários
chmod +x /usr/local/bin/ffmpeg /usr/local/bin/ffprobe && \
rm -rf ffmpeg-* && \

# 5. Confirma a nova versão
ffmpeg -version

# INICIANDO ESTRUTURA BASE 1 ------------------------------------

# 1. Configuração e Correção Definitiva do ComfyUI-GGUF
echo "-> Configurando ComfyUI-GGUF..."
cd /workspace/runpod-slim/ComfyUI/custom_nodes && \
git clone https://github.com/city96/ComfyUI-GGUF.git &> /dev/null && \
cd ComfyUI-GGUF && \
$(which python3) -m pip install --upgrade pip &> /dev/null && \
$(which python3) -m pip install -r requirements.txt &> /dev/null && \
$(which python3) -m pip install gguf &> /dev/null
check_status "Instalação do ComfyUI-GGUF e dependências"

# 2. Instalação dos Demais Custom Nodes e suas Dependências
echo "-> Clonando demais Custom Nodes..."
cd /workspace/runpod-slim/ComfyUI/custom_nodes && \
#git clone https://github.com/kaibioinfo/ComfyUI_AdvancedRefluxControl.git &> /dev/null && \
#git clone https://github.com/Fannovel16/comfyui_controlnet_aux.git &> /dev/null && \
#git clone https://github.com/space-nuko/ComfyUI-OpenPose-Editor.git &> /dev/null && \
git clone https://github.com/rgthree/rgthree-comfy.git &> /dev/null && \
git clone https://github.com/yolain/ComfyUI-Easy-Use.git &> /dev/null && \
git clone https://github.com/BigStationW/ComfyUi-Scale-Image-to-Total-Pixels-Advanced.git &> /dev/null && \
git clone https://github.com/BigStationW/ComfyUi-TextEncodeEditAdvanced.git &> /dev/null && \
#testes ------------
#git clone https://github.com/yanokusnir-ai/one-node-flux-2-klein.git &> /dev/null && \
#git clone https://github.com/lquesada/ComfyUI-Inpaint-CropAndStitch.git &> /dev/null && \
#-----------------------

git clone https://github.com/crystian/ComfyUI-Crystools.git &> /dev/null
check_status "Clonagem dos repositórios"

echo "-> Instalando dependências do Crystools..."
cd /workspace/runpod-slim/ComfyUI/custom_nodes/ComfyUI-Crystools && \
$(which python3) -m pip install -r requirements.txt &> /dev/null
check_status "Dependências do Crystools"

# 3. Injeção de Configurações (Modo Dev e Latent2RGB)
echo "-> Injetando configurações (DevMode/Preview)..."
mkdir -p /workspace/runpod-slim/ComfyUI/user/default && \
cat <<EOF > /workspace/runpod-slim/ComfyUI/user/default/comfy.settings.json
{
  "Comfy.DevMode": true,
  "Comfy.LivePreviewMethod": "latent2rgb"
}
EOF
check_status "Configurações comfy.settings.json"

# 4. Criação de Pastas e Arquivos de Suporte
echo "-> Criando estruturas de texto/encoders..."
mkdir -p /workspace/runpod-slim/ComfyUI/models/text_encoders && \
touch /workspace/runpod-slim/ComfyUI/models/text_encoders/qwen_3_8b_fp8mixed.safetensors #&& \
#echo "-> Criando estruturas de LORAS NONE..."
#mkdir -p /workspace/runpod-slim/ComfyUI/models/loras && \
#touch /workspace/runpod-slim/ComfyUI/models/loras/none.safetensors
check_status "Criação de arquivos de suporte"


# 5. Download de Workflows (Imagem com JSON embutido) via GitHub Raw
echo "-> Baixando Workflows..."
mkdir -p /workspace/runpod-slim/ComfyUI/user/default/workflows && \
cd /workspace/runpod-slim/ComfyUI/user/default/workflows && \
wget -q --show-progress -O "LTX23XDIT V1.json" "https://raw.githubusercontent.com/PTKELITE/LTX23XDIT/refs/heads/main/WORKFLOWS/LTX23XDIT%20V1.json" && \
wget -q --show-progress -O "LTX23XDIT V1.1.json" "https://raw.githubusercontent.com/PTKELITE/LTX23XDIT/refs/heads/main/WORKFLOWS/LTX23XDIT%20V1.1.json"
check_status "Download do arquivo JSON"


# 6. Download de Imagens na Pasta Input
echo "-> Baixando Imagens de Input..."
mkdir -p /workspace/runpod-slim/ComfyUI/input && \
cd /workspace/runpod-slim/ComfyUI/input && \
wget -q --show-progress -O "FLUX KLEIN2 XXX I2I V2.5.png" "https://raw.githubusercontent.com/PTKELITE/F2K9BXDIT/refs/heads/main/TEMPLATES/NSFW/F2K920_00079_%20VERSAO%20V2.6%20OFC%2012-07-2026-15-40_00052.png"
$(which python3) -m gdown -q 16JkOI9SQZgGWOftGcbLVCr7v0V5FBUKD -O "FLUX KLEIN2 XXX I2I V2.5.png"
check_status "Download da imagem inicial"

# 7. Download de Workflows (Imagem com JSON embutido) via GitHub Raw
echo "-> Baixando Workflows..."
mkdir -p /workspace/runpod-slim/ComfyUI/user/default/workflows && \
cd /workspace/runpod-slim/ComfyUI/user/default/workflows && \
wget -q --show-progress -O "FLUX KLEIN2 XXX I2I V2.5.json" "https://raw.githubusercontent.com/PTKELITE/F2K9BXDIT/refs/heads/main/TEMPLATES/NSFW/JSON/F2K920_00079_%20VERSAO%20V2.5%20OFC%2012-07-2026-14-20.json"
check_status "Download do arquivo JSON"

# 8. Download de Imagens na Pasta Input
echo "-> Baixando Imagens de Input..."
mkdir -p /workspace/runpod-slim/ComfyUI/input && \
cd /workspace/runpod-slim/ComfyUI/input && \
wget -q --show-progress -O "FLUX KLEIN2 XXX I2I V2.5.png" "https://raw.githubusercontent.com/PTKELITE/F2K9BXDIT/refs/heads/main/TEMPLATES/NSFW/F2K920_00079_%20VERSAO%20V2.6%20OFC%2012-07-2026-15-40_00052.png"
$(which python3) -m gdown -q 16JkOI9SQZgGWOftGcbLVCr7v0V5FBUKD -O "FLUX KLEIN2 XXX I2I V2.5.png"
check_status "Download da imagem inicial"


# 9. Downloads do Hugging Face (Modelos, VAE, Text Encoder e LoRA)
echo "-> Baixando Modelos LTX, VAE, CLIP e LoRAs do Hugging Face..."

mkdir -p /workspace/runpod-slim/ComfyUI/models/loras && \
mkdir -p /workspace/runpod-slim/ComfyUI/models/latent_upscale_models && \
mkdir -p /workspace/runpod-slim/ComfyUI/models/text_encoders && \
mkdir -p /workspace/runpod-slim/ComfyUI/models/unet && \

#loras hf
wget -q --show-progress --header="Authorization: Bearer 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" -O /workspace/runpod-slim/ComfyUI/models/loras/gemma-3-12b-it-abliterated_lora_rank64_bf16.safetensors "https://huggingface.co/Comfy-Org/ltx-2/resolve/main/split_files/loras/gemma-3-12b-it-abliterated_lora_rank64_bf16.safetensors" && \
wget -q --show-progress --header="Authorization: Bearer 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" -O /workspace/runpod-slim/ComfyUI/models/loras/ltx_2.3_22b_distilled_1.1_lora_dynamic_fro09_avg_rank_111_bf16.safetensors "https://huggingface.co/Comfy-Org/ltx-2.3/resolve/main/split_files/loras/ltx_2.3_22b_distilled_1.1_lora_dynamic_fro09_avg_rank_111_bf16.safetensors" && \

#latent_upscale_models
wget -q --show-progress --header="Authorization: Bearer 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" -O /workspace/runpod-slim/ComfyUI/models/latent_upscale_models/ltx-2.3-spatial-upscaler-x2-1.1.safetensors "https://huggingface.co/Lightricks/LTX-2.3/resolve/main/ltx-2.3-spatial-upscaler-x2-1.1.safetensors" && \

# Baixando text_encoder Gemma 3 12B
wget -q --show-progress --header="Authorization: Bearer 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" -O /workspace/runpod-slim/ComfyUI/models/text_encoders/gemma_3_12B_it_fp4_mixed.safetensors "https://huggingface.co/Comfy-Org/ltx-2/resolve/main/split_files/text_encoders/gemma_3_12B_it_fp4_mixed.safetensors"
check_status "Downloads do LTX Hugging Face"

# 7. Downloads do Hugging Face (Modelos, VAE, Text Encoder e LoRA)
echo "-> Baixando Modelos FLUX, VAE, CLIP e LoRAs do Hugging Face..."
mkdir -p /workspace/runpod-slim/ComfyUI/models/unet && \
mkdir -p /workspace/runpod-slim/ComfyUI/models/clip && \
mkdir -p /workspace/runpod-slim/ComfyUI/models/vae && \
mkdir -p /workspace/runpod-slim/ComfyUI/models/loras && \
wget -q --show-progress --header="Authorization: Bearer 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" -O /workspace/runpod-slim/ComfyUI/models/unet/flux-2-klein-9b-Q4_K_M.gguf "https://huggingface.co/unsloth/FLUX.2-klein-9B-GGUF/resolve/main/flux-2-klein-9b-Q4_K_M.gguf" && \
wget -q --show-progress --header="Authorization: Bearer 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" -O /workspace/runpod-slim/ComfyUI/models/vae/flux2-vae.safetensors "https://huggingface.co/Comfy-Org/flux2-dev/resolve/main/split_files/vae/flux2-vae.safetensors" && \
wget -q --show-progress --header="Authorization: Bearer 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" -O /workspace/runpod-slim/ComfyUI/models/clip/flux2-klein-9b-uncensored-q4_k_m.gguf "https://huggingface.co/ponpoke/flux2-klein-9b-uncensored-text-encoder/resolve/main/flux2-klein-9b-uncensored-q4_k_m.gguf?download=true" && \
wget -q --show-progress --header="Authorization: Bearer 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" -O /workspace/runpod-slim/ComfyUI/models/loras/Flux2-Klein-9B-consistency-V2.safetensors "https://huggingface.co/dx8152/Flux2-Klein-9B-Consistency/resolve/main/Flux2-Klein-9B-consistency-V2.safetensors"
wget -q --show-progress --header="Authorization: Bearer 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" -O /workspace/runpod-slim/ComfyUI/models/loras/refcontrol_v2_poses.safetensors "https://huggingface.co/thedeoxen/refcontrol-FLUX.2-klein-9B-reference-pose-lora/resolve/main/refcontrol_v2_poses.safetensors"
wget -q --show-progress --header="Authorization: Bearer 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" -O /workspace/runpod-slim/ComfyUI/models/loras/bfs_head_v1_flux-klein_9b_step3500_rank128.safetensors "https://huggingface.co/Alissonerdx/BFS-Best-Face-Swap/resolve/main/bfs_head_v1_flux-klein_9b_step3500_rank128.safetensors"



check_status "Downloads do FLUX Hugging Face"


# 10. Downloads LTX em Massa do CivitAI e CivitAI Red
echo "-> Baixando modelos do LTX CivitAI..."

#checkpoints civitai
wget -O /workspace/runpod-slim/ComfyUI/models/checkpoints/sulphur2Base_dev.safetensors "https://civitai.red/api/download/models/2921800?fileId=2802695&token=b98b3cd501efd7c435da4f32f2384efb" && \
wget -O /workspace/runpod-slim/ComfyUI/models/unet/ltx23DISTILLEDGGUF_q5km.gguf "https://civitai.com/api/download/models/2800384?fileId=2686486&token=b98b3cd501efd7c435da4f32f2384efb" && \


#LoRAs civitai
wget -O /workspace/runpod-slim/ComfyUI/models/loras/LTX2.3_Crisp_Enhance.safetensors "https://civitai.red/api/download/models/2849716?fileId=2735885&token=b98b3cd501efd7c435da4f32f2384efb" && \
wget -O /workspace/runpod-slim/ComfyUI/models/loras/LTX2-i2v-OralSuite.safetensors "https://civitai.red/api/download/models/2632394?fileId=2520223&token=b98b3cd501efd7c435da4f32f2384efb" && \
wget -O /workspace/runpod-slim/ComfyUI/models/loras/LTX23-GalaxyAce.safetensors "https://civitai.red/api/download/models/2808759?fileId=2694576&token=b98b3cd501efd7c435da4f32f2384efb" && \
wget -O /workspace/runpod-slim/ComfyUI/models/loras/LTX2.3_CREAMPIE_ANIMATION-V0.1.safetensors "https://civitai.red/api/download/models/2871469?fileId=2753679&token=b98b3cd501efd7c435da4f32f2384efb" && \
wget -O /workspace/runpod-slim/ComfyUI/models/loras/DR34ML4Y_LT3X_V3.safetensors "https://civitai.red/api/download/models/3082662?fileId=2961952&token=b98b3cd501efd7c435da4f32f2384efb" && \



#ggufs
#wget -O /workspace/runpod-slim/ComfyUI/models/unet/pGGUFSNOFSSexNudesAndOther_v14Distilled.gguf "https://civitai.red/api/download/models/3004133?fileId=2884234&token=b98b3cd501efd7c435da4f32f2384efb" && \
#wget -O /workspace/runpod-slim/ComfyUI/models/unet/pGGUFPornmaster_v4Turbo.gguf "https://civitai.red/api/download/models/3049513?fileId=2928328&token=b98b3cd501efd7c435da4f32f2384efb" && \


check_status "Downloads do LTX CIVITAI"

# 11. Downloads FLUX em Massa do CivitAI e CivitAI Red 
echo "-> Baixando modelos do FLUX CivitAI..."
#blowjob 
wget -O /workspace/runpod-slim/ComfyUI/models/loras/BLOWJOB_V2_flux_klein.safetensors "https://civitai.com/api/download/models/2981570?fileId=2861093&token=b98b3cd501efd7c435da4f32f2384efb" && \
wget -O /workspace/runpod-slim/ComfyUI/models/loras/KLEIN-Unchained-V2.safetensors "https://civitai.red/api/download/models/2753532?fileId=2639950&token=b98b3cd501efd7c435da4f32f2384efb" && \
# gera muito rosto wget -O /workspace/runpod-slim/ComfyUI/models/loras/klein-deepthroat-v2-5epoc-k3nk.safetensors #"https://civitai.red/api/download/models/2832958?fileId=2719117&token=b98b3cd501efd7c435da4f32f2384efb" && \
# 404 wget -O /workspace/runpod-slim/ComfyUI/models/loras/REALISTIC_SKIN_quality_epoch_10.safetensors "https://civitai.com/api/download/models/2968520?fileId=2850313&token=b98b3cd501efd7c435da4f32f2384efb" && \
wget -O /workspace/runpod-slim/ComfyUI/models/loras/pusfix-klein.safetensors "https://civitai.red/api/download/models/2754309?fileId=2640775&token=b98b3cd501efd7c435da4f32f2384efb" && \
#wget -O /workspace/runpod-slim/ComfyUI/models/loras/PornMaster_innie_pussy_flux-2-klein-9b_V1.safetensors "https://civitai.red/api/download/models/2714532?fileId=2600226&token=b98b3cd501efd7c435da4f32f2384efb" && \
#wget -O /workspace/runpod-slim/ComfyUI/models/loras/NaturalBeautyFLUX2Klein9BNudity_v2.safetensors "https://civitai.red/api/download/models/2972296?fileId=2851866&token=b98b3cd501efd7c435da4f32f2384efb" && \
#wget -O /workspace/runpod-slim/ComfyUI/models/loras/Flux_Klein_-_NSFW_v2.safetensors "https://civitai.red/api/download/models/2677698?fileId=2564503&token=b98b3cd501efd7c435da4f32f2384efb" && \
wget -O /workspace/runpod-slim/ComfyUI/models/loras/pussydiffusion-f2-klein-9b_v2.safetensors "https://civitai.red/api/download/models/2960754?fileId=2840079&token=b98b3cd501efd7c435da4f32f2384efb" && \
wget -O /workspace/runpod-slim/ComfyUI/models/loras/pussydiffusion-shaved_innie-f2-klein-9b_v1.safetensors "https://civitai.red/api/download/models/2960776?fileId=2840093&token=b98b3cd501efd7c435da4f32f2384efb" && \
wget -q --show-progress -O /workspace/runpod-slim/ComfyUI/models/loras/klein_slider_anatomy.safetensors "https://civitai.com/api/download/models/2615554?fileId=2502989&token=b98b3cd501efd7c435da4f32f2384efb"
#wget -O /workspace/runpod-slim/ComfyUI/models/loras/razzz_nude_woman_klein_v1.safetensors "https://civitai.red/api/download/models/2652080?fileId=2539871&token=b98b3cd501efd7c435da4f32f2384efb" && \
wget -O /workspace/runpod-slim/ComfyUI/models/loras/klein_snofs_v1_4.safetensors "https://civitai.red/api/download/models/2960556?fileId=2839878&token=b98b3cd501efd7c435da4f32f2384efb" && \
#wget -O /workspace/runpod-slim/ComfyUI/models/loras/SEXGOD_ImprovedNudity_Klein9b_v4.safetensors "https://civitai.red/api/download/models/2929301?fileId=2808122&token=b98b3cd501efd7c435da4f32f2384efb" && \
wget -O /workspace/runpod-slim/ComfyUI/models/loras/lenovo_flux_klein9b.safetensors "https://civitai.com/api/download/models/2682771?fileId=2569291&token=b98b3cd501efd7c435da4f32f2384efb" && \
#wget -O /workspace/runpod-slim/ComfyUI/models/loras/pussymix_datass.safetensors "https://civitai.red/api/download/models/2653139?fileId=2540956&token=b98b3cd501efd7c435da4f32f2384efb" && \
wget -O /workspace/runpod-slim/ComfyUI/models/loras/mombod-f2k9b-final-v2.safetensors "https://civitai.red/api/download/models/3023676?fileId=2902410&token=b98b3cd501efd7c435da4f32f2384efb" && \
wget -O /workspace/runpod-slim/ComfyUI/models/loras/KLEIN-Unchained-V2.safetensors  "https://civitai.red/api/download/models/2753532?fileId=2639950&token=b98b3cd501efd7c435da4f32f2384efb" && \

#ggufs
wget -O /workspace/runpod-slim/ComfyUI/models/unet/pGGUFSNOFSSexNudesAndOther_v14Distilled.gguf "https://civitai.red/api/download/models/3004133?fileId=2884234&token=b98b3cd501efd7c435da4f32f2384efb" && \
#wget -O /workspace/runpod-slim/ComfyUI/models/unet/pGGUFPornmaster_v4Turbo.gguf "https://civitai.red/api/download/models/3049513?fileId=2928328&token=b98b3cd501efd7c435da4f32f2384efb" && \


check_status "Downloads do FLUX CIVITAI"

# 12. Reinicialização Automática do Processo KILL do ComfyUI
echo "-> Encerrando processos anteriores do ComfyUI para aplicar alterações..."
(pkill -f main.py || pkill -f ComfyUI) || true
echo -e "[\e[32m OK \e[0m] Processos encerrados com sucesso."

echo -e "\n\e[32m=== AMBIENTE TOTALMENTE CONFIGURADO E PRONTO! RESTART TO POD AND EXECUTE COMFY. ===\e[0m\n"











#text area -----------------

#comando par ignorar cod ou trecho abre "if false; then" e feche o final do cod ou texto com "fi"
if false; then
#DOWNLOADS POS SO RODAR NO TERMINAL -----------------


# setup_completo (ltx23 V1).sh
#OU TESTES
# setup_completo (ltx23 V1 TESTES 25-07-2026 11-00).bash
#https://drive.google.com/file/d/19_UtR_N2MKrMPjDuXGEZ8hgkhxIYcvH8/view?usp=drive_link

MOVERMODELOS GGUFS OU OUTROS
mv /workspace/runpod-slim/ComfyUI/models/checkpoints/ltx23DISTILLEDGGUF_q5km.gguf* /workspace/runpod-slim/ComfyUI/models/unet/


wget --header="Authorization: Bearer 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" \
-O /workspace/runpod-slim/ComfyUI/models/loras/bfs_head_v1_flux-klein_9b_step3500_rank128.safetensors \
"https://huggingface.co/Alissonerdx/BFS-Best-Face-Swap/resolve/main/bfs_head_v1_flux-klein_9b_step3500_rank128.safetensors" && \

wget -O /workspace/runpod-slim/ComfyUI/models/loras/KLEIN-Unchained-V2.safetensors "https://civitai.red/api/download/models/2753532?fileId=2639950&token=b98b3cd501efd7c435da4f32f2384efb" && \

#wget -O /workspace/runpod-slim/ComfyUI/models/loras/klein-deepthroat-v2-5epoc-k3nk.safetensors "https://civitai.red/api/download/models/2832958?fileId=2719117&token=b98b3cd501efd7c435da4f32f2384efb" #&& \



#instalação de arquivo de scriptv2-5
#Para instalar o gdown (ferramenta excelente para baixar arquivos grandes do Google Drive direto pelo terminal) no seu ambiente, basta rodar o comando abaixo no terminal:

Bash
$(which python3) -m pip install --upgrade gdown

cd /workspace && \
rm -f "setup_completo (V2-5).sh" && \
gdown 1nBYzId_PQMdr4NAYJUJSzjp-hNAzK7sD -O "setup_completo (V2-5).sh" && \
chmod +x "setup_completo (V2-5).sh" && \
./"setup_completo (V2-5).sh"



: #ASSIM QUE INICIAR O RUNPOD ABRA O LINK DO TERMINAL JUPYTER E COLE OS COMANDOS ABAIXO COM AS TECLAS DE ATALHO NO TECLADO SEM USO DE MOUSE APENAS CTRL+V (DE PREFERENCIAS A TELCAS DE ATALHO COMO CTRL+S PARA SALVAR ARUQUIVOS COMO O ABAIXO).
#CRIE UM NOVO ARQUIVO DE TEXTO E RENOMEIE O NOME + EXTENÇÃO DO ARQUIVO EXATAMENTE COMO ESTA A SEGUIR:
#   NOME DO ARQUIVO:  
# setup_completo (V2-5).sh

# ABRA UM NOVO TERMINAL E RODE O COMANDO ABAIXO PARA EXECUTAR O COD.
# RODAR O ARQUIVO SH: bash ../setup_completo.sh ou bash ../setup_completo (V2-5).sh

# COMANDO UTIL PARA MOVER ARQUIVOS PARA PASTAS 
# mv ComfyUI/models/checkpoints/*.safetensors ComfyUI/models/unet/

fi
