// default sw_cc shaders used when the custom override is provided to dark (as a Direct3D 9 Effect file)
//
// IMPORTANT: when modifying this file, do NOT remove or rename any of the supplied techniques

static const float3 LUMINANCE_VECTOR = float3(0.2125, 0.7154, 0.0721);

float g_fGamma;
float g_fSaturation;
float g_fContrast;
float g_fBrightness;
float4 g_fColorFilter;
//float2 g_fScreenSize; // additional available parameter containing the screen width and height in pixels 
//float g_fNoiseTimer; // additional available parameter containing a periodic frame counter in the range [0 1[ that increments 1/60 per frame

// the frame texture
sampler s0 : register(s0);


float4 SatGammaPS(in float2 uv : TEXCOORD0, uniform int bDoSat, uniform int bDoGamma, uniform int bDoContrBright) : COLOR
{
	float4 vColor = tex2D(s0, uv);

	if (bDoSat)
	{
		float lumi = dot(vColor.xyz, LUMINANCE_VECTOR);
		vColor.xyz = lerp(lumi.xxx, vColor.xyz, g_fSaturation) * g_fColorFilter.xyz;
	}
	if (bDoGamma)
	{
		vColor.xyz = pow(vColor.xyz, g_fGamma);
	}
	if (bDoContrBright)
	{
		// old not quite correct contrast formula used in T2 v1.25 / SS2 v2.46 and older
		//vColor.xyz = saturate(vColor.xyz * g_fContrast + g_fBrightness);

		vColor.xyz = saturate((vColor.xyz - 0.5) * g_fContrast + 0.5 + g_fBrightness);
	}

	return vColor;
}


// apply saturation/color filter, brightness/contrast and gamma
technique TeqBrSatGamma
{
	pass P0
	{        
		PixelShader = compile ps_2_0 SatGammaPS(1, 1, 1);
	}
}

// apply brightness/contrast and gamma
technique TeqBrGamma
{
	pass P0
	{        
		PixelShader = compile ps_2_0 SatGammaPS(0, 1, 1);
	}
}

// apply brightness/contrast and saturation/color
technique TeqBrSat
{
	pass P0
	{        
		PixelShader = compile ps_2_0 SatGammaPS(1, 0, 1);
	}
}


// apply saturation/color filter and gamma
technique TeqSatGamma
{
	pass P0
	{        
		PixelShader = compile ps_2_0 SatGammaPS(1, 1, 0);
	}
}

// apply only gamma
technique TeqGamma
{
	pass P0
	{        
		PixelShader = compile ps_2_0 SatGammaPS(0, 1, 0);
	}
}

// apply only brightness/contrast
technique TeqBr
{
	pass P0
	{        
		PixelShader = compile ps_2_0 SatGammaPS(0, 0, 1);
	}
}

// apply only saturation/color
technique TeqSat
{
	pass P0
	{        
		PixelShader = compile ps_2_0 SatGammaPS(1, 0, 0);
	}
}

// plain copy
technique TeqCopy
{
	pass P0
	{        
		PixelShader = compile ps_2_0 SatGammaPS(0, 0, 0);
	}
}
