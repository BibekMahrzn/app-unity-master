using UnityEngine;

[ExecuteInEditMode]
[AddComponentMenu("Colorful/Bleach Bypass")]
public class CC_BleachBypass : CC_Base
{
	public float amount = 1.0f;

	void OnRenderImage(RenderTexture source, RenderTexture destination)
	{
		material.SetFloat("_amount", amount);
		Graphics.Blit(source, destination, material);
	}
}
