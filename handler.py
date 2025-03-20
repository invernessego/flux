import os
import torch
from diffusers import FluxPipeline

# Retrieve the token from environment (set via -e when running the container)
hf_token = os.getenv("HUGGINGFACE_TOKEN")

# Download and load the FLUX.1-dev pipeline
pipe = FluxPipeline.from_pretrained(
    "black-forest-labs/FLUX.1-dev", 
    torch_dtype=torch.bfloat16,              # use 16-bit precision to save memory
    use_auth_token=hf_token                 # use your token to access the gated repo
)
pipe.enable_model_cpu_offload()  # offload parts of the model to CPU to reduce GPU VRAM use
if torch.cuda.is_available():
    pipe.to("cuda")  # move the model to GPU for faster inference (if a GPU is present)
