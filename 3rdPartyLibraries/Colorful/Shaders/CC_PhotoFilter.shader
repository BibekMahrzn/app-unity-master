Shader "Hidden/CC_PhotoFilter"
{
	Properties
	{
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_rgb ("Levels", Color) = (1, 0.5, 0.2)
		_density ("Density", Range(0.0, 1.0)) = 0.35
	}

	SubShader
	{
		Pass
		{
			ZTest Always Cull Off ZWrite Off
			Fog { Mode off }
			
			CGPROGRAM

				#pragma vertex vert_img
				#pragma fragment frag
				#pragma fragmentoption ARB_precision_hint_fastest 
				#include "UnityCG.cginc"
				#include "Colorful.cginc"

				sampler2D _MainTex;
				fixed4 _rgb;
				fixed _density;

				fixed4 frag(v2f_img i):COLOR
				{
					fixed4 color = tex2D(_MainTex, i.uv);

					fixed lum = luminance(color.rgb);
					fixed4 filter = _rgb;
					filter = lerp(fixed4(0.0, 0.0, 0.0, 0.0), filter, saturate(lum * 2.0));
					filter = lerp(filter, fixed4(1.0, 1.0, 1.0, 1.0), saturate(lum - 0.5) * 2.0);
					filter = lerp(color, filter, saturate(lum * _density));
					filter.a = color.a;

					return filter;
				}

			ENDCG
		}
	}

	FallBack off
}
