import runpod
import torch
from diffusers import FluxPipeline

# Load the FLUX.1-dev model at startup (to avoid reloading for each request)
pipe = FluxPipeline.from_pretrained(
    "black-forest-labs/FLUX.1-dev", 
    torch_dtype=torch.bfloat16
)
pipe.enable_model_cpu_offload()  # Offload parts of model to CPU to reduce GPU memory use&#8203;:contentReference[oaicite:5]{index=5}
if torch.cuda.is_available():
    pipe.to("cuda")  # Move pipeline to GPU if available for faster inference

# Handler function to process requests
def handler(job):
    # Extract the text prompt from the request payload
    prompt = job["input"].get("prompt")
    if prompt is None or prompt.strip() == "":
        return {"error": "No prompt provided."}
    try:
        # Generate image from the prompt
        result = pipe(prompt, num_inference_steps=50).images[0]  # generate an image
        # Save image to a file (e.g., local filesystem)
        image_path = "/tmp/output.png"
        result.save(image_path)
        # Upload the image to a storage service and get a URL (placeholder example)
        image_url = upload_to_s3(image_path)  # assume this function uploads file and returns a URL
        return {"image_url": image_url}
    except Exception as e:
        # Handle any errors during generation or upload
        return {"error": str(e)}

# Start the RunPod serverless endpoint with this handler
if __name__ == "__main__":
    runpod.serverless.start({"handler": handler})
